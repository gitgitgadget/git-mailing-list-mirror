Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24125221F1C
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 08:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204189; cv=pass; b=tLbfpXrkhg/xm5qGCbQEQFaxfEn/jgz/OAhOKifw9oNPaNskS0EdFMkUlPlbmiGWNanF9lCkTbrFtOi6AraEitpxGTnSsRM8cFWj1ZdWfDjvM3oPbkM4hwY1dD/O7lhv8lLVC2iMw5ao/Ls7vmkGHdLnkU15srjFJUV2ybm9kjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204189; c=relaxed/simple;
	bh=9PxwvY5TdAbVqDNnKTCPcqjgSd0ayamuZA5GZHI6Jtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L0rg+LfYAya4VeY6JW8nyaYoJqbIpDXbuVsX3XpfA1rba+OuEpV13WClVerPsrrF4ytyMeGaHXpbVA5okAoRycSB84zavw4UTos00oQ7YsR2CeVHXh+ZCqHaaIX+n+cNs2y0Bn2iaKr90ZO21TR7FYguxG/V+DwOR2l8PYX2yMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5ojGds2; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5ojGds2"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12a71ade78cso2059989c88.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 01:16:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775204187; cv=none;
        d=google.com; s=arc-20240605;
        b=FX17i04xbWpVRhG4S8Fh24isJAIpjToTSxv9YKqKazZof4AC4avZJL8A7CoiQGPIL7
         okN6crFEr/63cF0FUqWY8lP2kaU07EauoHlrDrVhvLfsgLRlJUK4AKDcVRKcQovSCIOR
         KQbkFdkljvL3yfC2c8UGelFWjOUrMBfC8xX2lh2uPcbrnZTpAOqYueEeurSlAwRhcPjm
         j66q3LOlmAip3Bq7ukKh3k5WmFLiszrSOEEHZR2Jn70w+bEc7Gdz7+XYoC7zNFr744T9
         ttqvJLT8+G6blLnlzswwcp6xiL8SOcMcRTFpfphHWJOdnidIDBoCDtlElgl5yxR2esI+
         +TnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lT5yzHTwnRGJ56vQvZDx1axFPPOVf/phimQ/f5IWFEo=;
        fh=9YIIsTdqbn/IOwcwD19p2Nqg09YwnvZKB8q0RTDKXEQ=;
        b=SZz6iLfV0UTEPtYnivzZKVSJghjlAb4jsAhTF7+XJYMCf6hYqzyo/kwBlutwNjw68G
         EzdANObBtCZMLqjsnWUokH5ZBHVBpPraaCOv9JtEknWSJFK/0Wyzb9EkzD8Ig0pzrROr
         ZcoGcmNKzoQvYoXBz4n/TFiec3REGRalGc8oMO4uNDuMRkCXOAWYaDexaW8VmCJXNH20
         Mh2TImdI6LvCC9lhyx3Pe9frGPjvW0fiL2k8ewp2k8G3cdyzYFFpVM7Jq0x+FkJd5yDJ
         2toTtjKpOQd019AcS2AJ02rp323/GcgrH2e68XcLayG+5vniAyY6HZCeclT8iDNkZ7e4
         MnYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775204187; x=1775808987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lT5yzHTwnRGJ56vQvZDx1axFPPOVf/phimQ/f5IWFEo=;
        b=J5ojGds2w25CkdqipOCWaIBa/AikqCJBfIEZckDPoTHEsV11wXlSKgUlF1E32DCu12
         BvU5F0X5k3brQzwOmdag7yKyeF6QkqJvytrHPTamRXnIaTxmZdxPboa/nk7fXawNy+dD
         wTsixyEWV9d+jVnD07Q/r0uyRbhB7tTPpvgCPxjan+Euqy3k05kgJ5wgG+O+ik4KBTWe
         c1J0WS9/1lqa+BZ4HK4UTFArG5GjJOmVfLwzxKgOtm11BTS8k1T5m1sWTDsmQpS4r6jQ
         sU8iCabqeFG3YdRKU7smVwnNzMd0Wzb4WkY8HsdHwJeTTWHLD27TxO2zTXaLEGlatyQ6
         6zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775204187; x=1775808987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lT5yzHTwnRGJ56vQvZDx1axFPPOVf/phimQ/f5IWFEo=;
        b=kUM6H4+i/uM+GY848ZA7Uldl46vFub7VKVGtmM2D1zxDIBWmUZ0e2QeOZmw/njvqlB
         6mwn6xMjxRVyBAULKndG0MRnQvpKpy4MkUfSmBCeU/kDYfZrKno46kb19Nkt4DSyTJw+
         cLimyR9qNvxrGzPi3qe14QRaO5tGAdgykWIGM9mW8a6FFFYwwUw8KF6nepdfrYg8J0OL
         mjBIjFCta1iQ9az6DHRC2fmg88b5NspR0ALKg0GwhVN72KSK4Ei9bjzH3e8yl4bVUyhd
         fEwh2ugZGtWLhoVRsiXZ/W0l26fVQVkPrfgTZTb8PjKR2JpE9Q2KjplvZHwtopwxGLGh
         z+4A==
X-Gm-Message-State: AOJu0YyjUoJfIVDHQKNzUJKJMNyrROdI3fq3Z18L2y7Goa5bNlGeFC3D
	6bYdK8gFpn3ZZemO6M1X3AtLbxcaiYqkwr3yisr0MvqrNbEancMglLCijEcmDWCxvhpb99rtmiF
	kr5rtBGJVcyRnl7Kg/TBcBKlfWIrovSs=
X-Gm-Gg: ATEYQzxAQQDEqzVTtGvjbivPNfc50mTWnTVPvF+JLI1PY2XnWnTTdta/1r1InXf47j4
	oAmMt0TlMUVYoNeN1SRZrBPYxgWTNW01Wa0BL+PouXH3HsbiKI4E0cXGexPEh3qw/5wWQNx5425
	kiSw+g4HUNPKEULSgIwB2bX1vWgH4nyzcZKbltupYcjhVQ3bxf/31n/DXHqZqwsrIG2cCKE0hyQ
	WLe5NbQ/Np4p52RWxoEcySrtTq3l3NxzqRTjmmuXeP5Z9Wj+5US5X7FsBeNo1EOgIdZhe4HpflO
	xdI5yhtSwYY3GO92Z6OOP64wZAiMpFGGTUXU3QS9NZA7e720Ot55lo/2a1Wdged3rJH/
X-Received: by 2002:a05:7022:4585:b0:128:ce44:be90 with SMTP id
 a92af1059eb24-12bfb75c3c4mr935709c88.28.1775204187165; Fri, 03 Apr 2026
 01:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402070613.85934-1-christian.couder@gmail.com>
 <20260402070613.85934-11-christian.couder@gmail.com> <xmqqa4vlu1ij.fsf@gitster.g>
In-Reply-To: <xmqqa4vlu1ij.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Apr 2026 10:16:15 +0200
X-Gm-Features: AQROBzCZGVUq5g6Y9clEjNL3yW4PkOWgT445EZ4sqNS_QnrTm_j7JYdfsHK_ADs
Message-ID: <CAP8UFD3CMwTjC36Grhb6_6q0SBWtTwBX4_kM5sf+peTgd7P3dA@mail.gmail.com>
Subject: Re: [PATCH 10/10] t5710: use proper file:// URIs for absolute paths
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:58=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > +# On Windows, 'pwd' returns a path like 'D:/foo/bar'. Prepend '/' to t=
urn
> > +# it into '/D:/foo/bar', which is what git expects in file:// URLs on =
Windows.
> > +# On Unix, the path already starts with '/', so this is a no-op.
> > +pwd_path=3D$(pwd)
> > +case "$pwd_path" in
> > +[a-zA-Z]:*) pwd_path=3D"/$pwd_path" ;;
> > +esac
> > +PWD_URL=3D"file://$pwd_path"
> > +# Same as PWD_URL but with spaces percent-encoded, for use in URL patt=
erns.
> > +ENCODED_PWD_URL=3D"file://$(echo "$pwd_path" | sed "s/ /%20/g")"
>
> Two comments.
>
>  - I was a bit surprised that these are not given as functions but
>    as variables, as a caller that chdirs around in the trash
>    directory would want a URL that points at its current working
>    directory (the expectation is from "pwd" in the name PWD_URL).
>    But a variable based interface "Here is the URL that corresponds
>    to the trash directory" is OK and probably easier to use than
>    "give me the URL corresponding to my current working directory",
>    simply because it allows a caller to append some string to it to
>    come up with a URL for any subdirectory on its own without
>    actually going there.  But in that case, the name PWD_URL would
>    become misleading, as it is PWD as of the moment the variable
>    gets defined, and the true meaning of the variable is not "URL
>    for the current directory", but "URL for the trash directory" is
>    more usable definition.

Right. I will use something like the following then:

TRASH_DIRECTORY_URL=3D"file://$pwd_path"
ENCODED_TRASH_DIRECTORY_URL=3D"file://$encoded_path"

>  - Is it sufficient to only special case SP?  My repository may be
>    $HOME/w/git.git, for example, and the trash repository may be
>    "$HOME/w/git.git/t/trash directory.t5710/", so you need to cope
>    with SP between "trash" and "directory" the test framework adds
>    (to force you to be careful), but the test framework does not
>    control what can be in the leading $HOME part.

I think it's quite unlikely for users to have strange characters in
$HOME, but OK let's be cautious and encode a larger set than just
space characters. And to be extra safe, let's also skip all the tests
if we detect a special character not in the larger set.

So something like:

# Allowed characters: alphanumeric, standard path/URI (_ . ~ / : -),
and those percent-encoded below (% space =3D ; ,)
case "$pwd_path" in
*[!a-zA-Z0-9_.~/:%\ =3D,;-]*)
        skip_all=3D"PWD contains unsupported special characters"
        test_done
        ;;
esac

encoded_path=3D$(printf "%s" "$pwd_path" | sed -e 's/%/%25/g' -e 's/
/%20/g' -e 's/=3D/%3D/g' -e 's/;/%3B/g' -e 's/,/%2C/g')
