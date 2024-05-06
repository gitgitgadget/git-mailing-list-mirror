Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF94EB2B
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994819; cv=none; b=qCxB2TWyCsMn5m+Fm3RynEXju3ekUIJzzZFd+Y+Gey3h8w17R+QZIbNMt4otznFuHv+zOPKnnkUbuRqtYTTSEGb9I6vZ5cu/pgM+06aEG3stu25h+FH0O+14pnwj9wcE6TrACrhRdAq0Vs9KmYjBp/fEoCeYq5/4z3vF47lPuGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994819; c=relaxed/simple;
	bh=uEGHc2A/bu6QFR62qqiJ5V1RzBgW+oSmyGU5ARDXdVw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+uci4VrRLa2Xrw0gIQPc8l4Wb8DzOfw+A/ss3/Ag8bLtNUEpGX9XA31WKInc2M7x01twCqHuk2owHTwiubsygMqUVsxz4OdVfZNOqJon/wtYwVjxRPjRIl+ZgvuaY+QUrDGk62E1NFtfv7h1i2mSes8elCPOdnyqcilfXhcOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFS+NhAQ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFS+NhAQ"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-23d16b9bca7so825905fac.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714994817; x=1715599617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=k85DLqaqSR1BhhWQlstR6hNiyY/KwuhjbHfTjrMJFT0=;
        b=RFS+NhAQYaGVC70UVRy0gPWAXW8q7Edm/IcJeSWXHrQZRodIWneoF4lIhBByFz3ogB
         WT1yNvou7v9xHTAbpUdsJ3RJWJAZJJKUzU9vqsXuCkJE+GzFQed3982Buw/OxG8tJI8e
         ykVPWTh4URbNX7ftVWJQDSwf+DudN60O//wYowtU+6nWYCNf6kGwGyojU5x+foN7IP3P
         rBl8bHmUFKICwOBlBdT2pBVL3zs67p02hwVXtuXqIzadMYsEB6j1o12hpget02ES64lG
         VV9vKzGDpLapEkxoyT3hRTYqo5vFWm0nWVTvUA0ZMNtYyrF4KTwRlK+gacGYccMhH4yJ
         qijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714994817; x=1715599617;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k85DLqaqSR1BhhWQlstR6hNiyY/KwuhjbHfTjrMJFT0=;
        b=bcCueSUTOtT3g/556S9aG6Yj0jczv9G+/KG6GeMRkAnbMevNSeovkXRfYAeoruChSC
         ZjDtv4wHdWHPO2mgKa78x0QS4RL2hfubtc54SCUI5/YNRBY8huzKSoRza94liyxxnY6l
         OfMegZeIsbeLQyxs1NCuCc2+dvfNhas5QwfifAtedq9nm3AW484Va1/ip26m8JjVXuWB
         RCkBkX6nz42J0riJZcrN6NH37hR2ey+bMa9JZd38xB5BA529akHrqIUxqZwySSzNU7HC
         u9j3EYvdcdq78cdcpNFGZTWCrs3hZ4FBk+a80AbqT/NE1lVuWKzOGNVYOwg08BKyE+ka
         8qLA==
X-Gm-Message-State: AOJu0YxuBRS9tya1kpqT5sFGdO+PYSocWymSrzmyte2inwXsTtg6oec7
	ibxhyCmPCA4LJNhm+PQAQRannddErZa35ClvDaMRe9oLKrS/indIVOdMtW5ICWBJia5L9Xe4+Ue
	dNgoOFhXXcST6EEjBBx6K4LaUUCQ=
X-Google-Smtp-Source: AGHT+IFn+YPvU3OkChg8DmYoJ5+5pLXwYElMhAozQ1s2TZMfVRZIA0yqkmp4HijfghNDnPGiMjGmPryeGWp4h4r0RXw=
X-Received: by 2002:a05:6870:b418:b0:233:ac4c:43a5 with SMTP id
 x24-20020a056870b41800b00233ac4c43a5mr11447741oap.22.1714994816722; Mon, 06
 May 2024 04:26:56 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 6 May 2024 04:26:55 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ZjiNr-PUue2_mJGr@tanuki>
References: <cover.1709724089.git.ps@pks.im> <cover.1714730169.git.ps@pks.im>
 <b3f3c3ba6ab33d269f7a707eae1456c87cdfeddb.1714730170.git.ps@pks.im>
 <CAOLa=ZSNbZPByO9QyeAGaR1pWXMB7ge_GF7M5fydxP-cse-X3g@mail.gmail.com> <ZjiNr-PUue2_mJGr@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 6 May 2024 04:26:55 -0700
Message-ID: <CAOLa=ZRSM6=qFgzMMh=yEK+jPPGknaPHG7u5ah5OZ24ZdSG1cA@mail.gmail.com>
Subject: Re: [PATCH v4 07/14] builtin/config: introduce "list" subcommand
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, 
	Taylor Blau <me@ttaylorr.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: multipart/mixed; boundary="000000000000d7dbbb0617c7580c"

--000000000000d7dbbb0617c7580c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, May 03, 2024 at 06:08:57AM -0700, Karthik Nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>>
>> > While git-config(1) has several modes, those modes are not exposed with
>> > subcommands but instead by specifying e.g. `--unset` or `--list`. This
>>
>> s/specifying/specifying flags/ perhaps?
>>
>> > user interface is not really in line with how our more modern commands
>> > work, where it is a lot more customary to say e.g. `git remote list`.
>>
>> Tangent: I totally agree with the patch, but it would be nice to have a
>> 'DesigningCommands' document which would highlight UX do's and don'ts.
>> It would be nice to add that as reference in discussions.
>
> I agree that we should have that discussion, but feel like it should be
> part of a separate patch series. If I were to adopt that into this
> series I very much think that the resulting discussions would take quite
> a while to settle.
>
> I'll start the discussion soonish in a separate thread.
>

Ofcourse, not part of this series. I was merely using this patch to
bring up that topic. Thanks, will stay tuned.

> [snip]
>> > @@ -2590,7 +2608,7 @@ test_expect_success '--fixed-value uses exact string matching' '
>> >  	test_cmp expect actual &&
>> >
>> >  	git config --file=config --fixed-value --replace-all fixed.test bogus "$META" &&
>> > -	git config --file=config --list >actual &&
>> > +	git config ${mode_prefix}list --file=config >actual &&
>> >  	cat >expect <<-EOF &&
>> >  	fixed.test=bogus
>> >  	fixed.test=bogus
>> > @@ -2751,4 +2769,6 @@ test_expect_success 'specifying multiple modes causes failure' '
>> >  	test_cmp expect err
>> >  '
>> >
>> > +done
>> > +
>> >
>> Nit: Wouldn't it be better if the tests are indented here? That way you
>> know it's part of a loop.
>
> We would basically have to reindent 2500 lines of code. I don't think
> that'd be a helpful to reviewers :)
>
> Patrick

Fair enough.

Karthik

--000000000000d7dbbb0617c7580c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: f5a997dc513b8a8d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1ZNHZuNFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMjIyREFDUjhZaGQ4YnFaUGdZSnpidzYrQTZvS2NTLwpQeFJ0Y2kwVFJL
dGc0L0lXeUw2bTdxc1AyZVJYcDZOMHFEYjJWbUY3R25pVExqeU83dytoejg0Tlo4KzY5eS9iCnRC
VEJQNHJNNXlGMjNsSlUycEljRHBXcy8yRWcwbnhmSXkwZ3J5SXhzYWFZellLTmlmVGxuSVA3MFRl
QitQSm0KeU5iTCtqdVhSRWRPYlBSWjE0TnVhajJaQmM1TkhoSnRQbitpY0ZPMzdlTjJTTkZTOWxS
d3p5NGtIMGFXd2JnYwpqMTlBOHNCRUFuc0VaNXlkRDRDV3RVV0xteld1cWl2MjFNM1JSS0YrOXpu
cXZFKzc1WVlEcmlScXpneE9aWHdYCldBdzJrdENXYU1iRmJCMG8zclptbVpXWjZDUStGL3FYWkZm
QnB0KzdpMHdRNFZnU212MkhXS0Y4OVdCeVd0cTcKOWNjcmgwbVJEV3pDQ3RrYlRXQTY2WlJ5dUow
YlZ3dHZPb3E0VzVMOFRKVTlNVTNHZUl4S21qbk9PTVFHZjdXbgo4TW5EdEw2VzJTTXdYdWxQRWdj
USsrSDBsWnVxQnFzd2phMklsNVZkOTFYQnRweUxpZ0x0ZnQ0OHpEVDZiRUxBCmxHM2tWcGFYbm1K
bEpTRUxWKzNaZStzVm1UdHlST291Q1k2R3JGZz0KPUY1VjYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d7dbbb0617c7580c--
