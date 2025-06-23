Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83169275855
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704580; cv=none; b=mtn7u7Jic+xsd1HX+DmmnWk+NL/iXhOKZIapTQcZizc3XdKoaRbyl4mAGWv+rsdNxjb5M4Y8EZaJOp7XNdApOMy92piXrx07QJ+uFJ9vo0iZcQXRSDzUpYViYTg6H6H9wiFZgb+E4CFVDKbu1lphTOQ7OJlGGIOeUXU5SpJAdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704580; c=relaxed/simple;
	bh=rle7dAs7A+u+VXmndqrqOgLiQU6ukkthKd7ek6z5lfk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=j5o8yw5C252r4jHHRFmMw97+vNmTrs5pN7qSJba3L32usggtG2u7PM5HQ8lv84gddxshAONpbKInQM8lp55Cd5dKg318cJeJHgI10UeJ6dxqw1OAhMaGdlwmjhyUibSRxVvryNJbusrrwjKxFiW/NsLuITRzlQWZEsSOf5OPKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+GJkxR8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+GJkxR8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-311ef4fb43dso3523426a91.3
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 11:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750704577; x=1751309377; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBMc4g1lPgDQR2NkEunJUFco7HcmEnoOeNGTYBNMMSE=;
        b=Q+GJkxR8fWAqOKPtDD1Bhso4Ks3r3KoE5VWWDosernPO4D7Tgfl1m5jvqe3z1q5Pf3
         uZ+Cq0LXzKIm+o60/obu5zYk+RC2rpYoN0sPyH8vEuIS8psnAvEutqBXGxlE0pMU3Mzj
         ms20j0FNNAzloRy2PYOof9oeZD2/BI2SISoqlITKAIcl/Ol1pcoeqCujhlC/G8GLXge+
         yWe1mSaJiRvI2mFeu4q/xmab5Usy/YgR/F0Umj4pk0AgTnhsUYKmAHYMxnrsd38ZxP0B
         nxiHKlpM9/4dAt40xdYz8kva1DENp412tu//MfdMeevOfc72CAK6ts7vd5AoF0S0WBGG
         XKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704577; x=1751309377;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBMc4g1lPgDQR2NkEunJUFco7HcmEnoOeNGTYBNMMSE=;
        b=pkB5aFJRybrNb77656SAWiGC0TaGkYFW3OqTH3tCb7KCH8Y8SsPJd/nMB6aHVwSHuh
         Y8aUqlmHporudhZn/owjUM14lKuPA1b2nGJMpwGGH0GYDqnXoOHh3ugJs7MkPFy0zYF9
         6S/iyXR47eLcoSUqF7is7PaR43tAIfYnUh0eS4zg4mMtL9wDmiEGTf1oy3r5x1ZNNdEG
         cATttfK5jY2VyHc1z+TCNrokiwghJ/8cPBKgCULNwAk1eWN+hPlg6dGxKB+gKR7u3o1d
         oNYwEpQUMnovUHALjmusIovpUdKDb+N4xcOGHxZNFzbxdAVJDAWQ0sIotY5rYsnGySgY
         Mn6g==
X-Gm-Message-State: AOJu0YztWu6nXnrCo8d4f5zFPqDIMKIr+oh/py27YsW2hORPDgx0gA/h
	7S6F0YSbKuWb4ZNIW5xSnI6R9zcxbnjeY7Z9CfOiYSPTBY4BNJX/OVsM
X-Gm-Gg: ASbGncs9iLcO+B7E9PID61otuE++aRPTWUTEtJXo6LuqMIwMs0eGLajhs4SIc/Ni2HE
	pbjWocyA/fbrleM2lDSB78hcVoFx5uK8254XIMQAqIDnkNHeKZdm79ZBWOS7/cpCQbU+bB+wQ7W
	UkG9IFrfKWyQS3ev5TaORAzGSIQeCd9u59AYeD54F5sGAmLqyw305oWr4kfBV2Zpi3RySx2HWbV
	XQ9MFqD+OuKTaZulmHQZodKiNJz4D/Ov2NI6qs6UH1JDNwlR8+oTsO2JBVWJin1BhMrxO4IIzUi
	ItMTz/0aVymrDN0RiraNJussz3Vnzgu1QU9W+rhjJHvN7/kI6Zx+OboltJL6zuSuCltbP4m9jYQ
	pb+oGNL1bgg20sfwZMtSTI00=
X-Google-Smtp-Source: AGHT+IGzgg3jIgBZ9QS3ufw8pcDNqgUeL1/2y7WLhXpegRVhPHTvQ6+LoK2KkGhKMrkt7nCsMiuIBQ==
X-Received: by 2002:a17:90b:2f0d:b0:311:9c9a:58c5 with SMTP id 98e67ed59e1d1-3159d643c15mr25415365a91.12.1750704576464;
        Mon, 23 Jun 2025 11:49:36 -0700 (PDT)
Received: from smtpclient.apple ([191.181.56.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a226ddcsm11420975a91.1.2025.06.23.11.49.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jun 2025 11:49:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH v2 0/7] repo-info: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com>
Date: Mon, 23 Jun 2025 15:49:20 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com,
 ben.knoble@gmail.com,
 gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <652FDA35-C20D-4F27-A22A-025CA08EB013@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250619225751.99699-1-lucasseikioshiro@gmail.com>
 <af27af92-73d5-4f0a-84f4-9c91de6ab6e6@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Hi Lucas

Hi, Phillip, thanks for joining this discussion!

> I think using an output format generated by 'printf("%s\n%s\0", key,
> value)' would be easier to parse. This format matches that used by =
'git
> config --list -z'.

Thanks for your suggestion! However, this still breaks in the corner =
case=20
mentioned by Junio in=20
https://lore.kernel.org/git/xmqqikl3mtx2.fsf@gitster.g/:
when a value contains a LF, which would be possible to have in the (yet =
to be
implemented) path values.

> I've not seen any discussion of how paths are going to be encoded in =
the
> JSON output. As I understand it some JSON decoders only accept utf8 =
input
> but the paths reported by git are arbitrary NUL terminated byte =
sequences.
> How is one expected to parse the output for a non utf8 encoded path =
using
> rust's JSON decoding for example?

By now, I'm directly using the jw_* functions, which format strings =
using the
function append_quoted_string, introduced in 75459410ed (json_writer: =
new
routines to create JSON data, 2018-07-13). It was also discussed when =
that
function was introduced:

"""
    We say "JSON-like" because we do not enforce the Unicode (usually =
UTF-8)
    requirement on string fields.  Internally, Git does not necessarily =
have
    Unicode/UTF-8 data for most fields, so it is currently unclear the =
best
    way to enforce that requirement.  For example, on Linux pathnames =
can
    contain arbitrary 8-bit character data, so a command like "status" =
would
    not know how to encode the reported pathnames.  We may want to =
revisit
    this (or double encode such strings) in the future.
"""

So, it looks like that "the future" is soon :-). In this RFC, I'm not =
handling
paths yet, and I can't propose a proper solution by now as I honestly =
know
very little about UTF-8 encoding...=20

The first solution that I can think of is to check if the sequence is a =
valid
UTF-8 bytestring, aborting the entire command if it's not, which would =
be
better than just guess the charset and re-encode it as UTF-8. However,
I don't know how hard it would be to do.

> On the subject of paths do you plan to support the equivalent of "git
> rev-parse --git-path"?

Hmmmm... In the way that it works under rev-parse, no, as it may bloat =
this
command with other things that aren't exactly metadata.

> I'm not sure what the future plans for this command are but when I'm
> scripting around git it would be nice to be able to a single process =
that I
> could query for the things currently returned by "git rev-parse", "git =
var"
> and "git config"

My concern here is that this main motivation for this new command is =
that
rev-parse has too many responsibilities. Giving too many =
responsibilities to
this new command may turn it into a new rev-parse and create a XKCD 927 =
[1]
situation

>=20
> Best Wishes
>=20
> Phillip
>=20

Thanks again for bringing more light to this discussion! These first =
patches
are only outputting hardcoded strings from Git, and dealing with Unicode =
is
something that I'll really need to think about how to solve.

[1] https://xkcd.com/927/=
