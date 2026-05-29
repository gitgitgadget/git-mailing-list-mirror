Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7906D2E4257
	for <git@vger.kernel.org>; Fri, 29 May 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780016151; cv=pass; b=ZFfxA8ieyBcR5PSMtM9BPIUJ6rsbsXfQyGpsP5y7V5LYltejt0pqUm2me1V3pfzMlV2/ZXVOVkun0q29qIfk2LMHu+rDNxsYzg0Pz62N+Qbjs3xe1pO2yOlP/PNffVjGhgW3P0zRihXzdhFAgiSXkKmnY2R8v3VYZnh77CRG7UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780016151; c=relaxed/simple;
	bh=pUDZZGoHft+XRCLB6pz1qJUxzJKirSR+l7PBEzkc4H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB9F8t+aEyVSUI2eDNBXJHwaAxvJgTq5JpommBiFiZW8ZnVDymvfxJqdHSeUniqjtCPNaEGoPoXys1IL/XvkpCKaxd/wKQh+qDP18Tsd/pqk4XOsukbPbveXvXbm3CLGGGX/fXUkpY65a2wDiVxh0K3EzrBf5GigKTg6OR1ruu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kjsMavW0; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjsMavW0"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so12923441a12.2
        for <git@vger.kernel.org>; Thu, 28 May 2026 17:55:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780016149; cv=none;
        d=google.com; s=arc-20240605;
        b=gzJYqrkkAgX+VbNGnvx+szMaE3BJE4KWQILcycewhHloe/O86GGRHqIfMoJD2uCYoM
         YnaL5Aj1svBEfEMjquID+dO+rO31GmE4RXavL8VDP2/53umN4Jaug5A0ffvCKa+gLbht
         ZT4UBadw5HZHS9VRKOq2WlapCY9vKAXlUG1fAjv7v5+SaiJBx/OYBiM4DXKypWf7onYs
         GMScv4iV5PLve+C7nVzNFN9+8uUPOcMbHMGlaQBnfotpzly22Puh6k8FUldNkRJMfc5u
         EZ+IMUyu1LebBxQggPLOqlnT3FmQvUQJTqy+Dvu6rHph2HnMzafHco11+5Ii22hwCDJe
         LqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e+cEO01gtXQXUxzWl+rt0cd2SzBV4SBpli2cFrxDw/0=;
        fh=4xrY3atBCCYNrISxtVmjBqCmf3u072+qK8fdCrdwsxQ=;
        b=fL627i5oxzr/4sfT5CfLz4LiqGP5eL+3k3x3SjckHDt1JnJOS/IJlKs66nLJqjyUJo
         QtbUqa3nNjEBCG9Vtfc8OlouFk8gsGAgZ0aCnbuUKHkcw4++KCYyh1VCNWoLBgx/nw4N
         b2wB1ZldKir6xUzKgKh697K0P/TfJ+uQC7b57t71heJRPZ0k2jx3XyOZL/9EPzqkegl3
         eI/qoeaYCyiiW8LIO3ocaxTE/XvkWaRAzDyAQ7/r+hH+DhocjAbPwjXGnXUEX5CvPdyb
         jjZsCjPV3ZPYd2NwRKMMWIBkylzjl4bCLH3yDOzh+WNheW1L5n1H7OezQkHcLPUfAhfo
         Jlmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780016149; x=1780620949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+cEO01gtXQXUxzWl+rt0cd2SzBV4SBpli2cFrxDw/0=;
        b=kjsMavW0igLcfjVPazNIeMvMx+R5iMJtx/E2vfzZ/dAAp++ErQzq2rnSdVM9XqUeGc
         cujZmS97GgDqV1ndhc60y3Szmf7CP8Droc2njB8UROn2bpgWLpr6Dy6+iIgeZ51ZE8HV
         UhxQ40pN176DowWsP9/dJliGM+VxNjUbqJiCNm50zrmRIY0eQMKUEkz6pMYywmxhmSuM
         jkg3ZawQh3w/q5y4mgTRvyqqiZCFoVu6JFi1fUuoF+gNg5XP/O3Y+8oafe/48/exCcVf
         75vsgb4IKNIzjNbNsTxyL75ErgFttO+OA7v9DuRuwdFA2kgDkS37u/fjSQ4YCyEbQJrN
         qdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780016149; x=1780620949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+cEO01gtXQXUxzWl+rt0cd2SzBV4SBpli2cFrxDw/0=;
        b=ptdfc+LBlb37Pi7ayA9CeLvdO2a5uZbRJ3HS/ZWWzmOOVODYbiY3qtSiAyjFwrHGRl
         /8drGHJ7hGo3No8+sB0i1sckzmnyMjYfma7QGaJykBB1KXUkoioxDkbbnAksnVTMAKfn
         vJXQ6yz1AFJ5rozqWwybIYgMDcBoWvbY/yP0hh5QMIkvoguhELpuqPm6aTamO9ftjXcH
         AR51t/IFFluR0yLg6CYgyimg2aYHWH8EQvRGxrTUWgEFbi2uOBHZpl2fNGfrahn6HVsN
         0cg4dooKJOEUUAaPQ3Rq7/x4hzxUQPQ0T6J/QdmlbqeJTiAVEpdz9gvLhZ+mnwgKe98/
         OOCw==
X-Forwarded-Encrypted: i=1; AFNElJ8W2tWeA7MWHi6Ap/DE17+3KuYqmERa7WfvfUqRE/84eEZEgbQZD/5/ZXZ2Wju2DJuMUEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj8Byl+rD4ppCDF2FAPPXOC5amw1kQQ8YksIfqtsMuA3QeaWG/
	CLRgunoOpUx9q944gF5JHEQ4YMT/aYgx2ARly6y2vPMblxOXFmDNW5+VMneXxKy0IYwisEYechp
	IsoXkAtagwKAtjrPgeomXO4xCMb4KUS0YbfeD
X-Gm-Gg: Acq92OEY5toYUyjgln+mfuL8SLGTYuB2pNyxe/Io5Qh5eq2oZzyrhrClz+AjvLX1A+E
	88cZxbUDurhMeseMT/Ey/hDboLcVFwvlSKfQC8rc4JwTZvciDtaRtWVXeoEbnpwo/J8wxc7FY7o
	7U2uS+t4ZEVcGSn0QnTAzl/+StNACOHgq6TOECPU0pessfM4ybLoKvThqtlKcVdIm/GYxe8C66c
	Eq0nzzGEKK+/Pw0hzefFwMZUjtb+lDPk9gua8PwiRMyxqK5gglP4FSFtyenR1dbLRGZdoLKa7AJ
	jdBAKHBTZRTXPFMEDMqAu+GTEC9VY7HUaKslp7cD5Jaz2zEc4xk=
X-Received: by 2002:a05:6402:3604:b0:677:75e5:a1b3 with SMTP id
 4fb4d7f45d1cf-68c10976bf1mr216954a12.18.1780016148693; Thu, 28 May 2026
 17:55:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2120.git.1779415884.gitgitgadget@gmail.com>
 <pull.2120.v2.git.1779733799.gitgitgadget@gmail.com> <c25647c6e571e293fc994e0620ca37709f680f8a.1779733799.git.gitgitgadget@gmail.com>
 <xmqqjysqnbxu.fsf@gitster.g>
In-Reply-To: <xmqqjysqnbxu.fsf@gitster.g>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Thu, 28 May 2026 17:55:35 -0700
X-Gm-Features: AVHnY4KtQRzVJhDHctUUsWI8Cv_xhks-GW0VtEwvLx78I4gdvU6B9NF_MrE02ec
Message-ID: <CAC2QwmLa24iaUz5G0rnt-kxE5_o+4WdS2eYA_JyC_GfPhLUW6g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] diff: add long-running diff process via diff.<driver>.process
To: Junio C Hamano <gitster@pobox.com>
Cc: Michael Montalbo via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 7:26=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Zero hunks with status=3Dsuccess means the tool considers the
> > files equivalent.  Git skips diff output for that file.
>
> Is "zero hunk" a common word or some random string you invented?  If
> the latter, which is I am assuming it to be, you should define what
> it means at/before the first use.  Here in the proposed log message,
> and ...
>
> >
> > Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
> > ---
> >  Documentation/config/diff.adoc   |   8 +
> >  Documentation/gitattributes.adoc |  40 ++++
> >  Makefile                         |   1 +
> >  diff-process.c                   | 206 +++++++++++++++++++
> >  diff-process.h                   |  28 +++
> >  diff.c                           |  23 +++
> >  t/.gitattributes                 |   1 +
> >  t/t4080-diff-process.sh          | 338 +++++++++++++++++++++++++++++++
> >  8 files changed, 645 insertions(+)
> >  create mode 100644 diff-process.c
> >  create mode 100644 diff-process.h
> >  create mode 100755 t/t4080-diff-process.sh
> >
> > diff --git a/Documentation/config/diff.adoc b/Documentation/config/diff=
.adoc
> > index 1135a62a0a..4ab5f60df6 100644
> > --- a/Documentation/config/diff.adoc
> > +++ b/Documentation/config/diff.adoc
> > @@ -218,6 +218,14 @@ endif::git-diff[]
> >       Set this option to `true` to make the diff driver cache the text
> >       conversion outputs.  See linkgit:gitattributes[5] for details.
> >
> > +`diff.<driver>.process`::
> > +     The command to run as a long-running diff process.
> > +     The tool communicates via the pkt-line protocol and returns
> > +     hunks that are fed into Git's diff and blame pipelines.
> > +     If the tool returns zero hunks, the file is treated as
> > +     unchanged for both diff output and blame attribution.
> > +     See linkgit:gitattributes[5] for details.
>
> ... also here.
>
> I do not know if you mean "the tool returns no hunks" (there is no
> "hunk <old_start> <old_count> <new_start> <new_count>" line passed
> from the tool over the protocol) or "the tool returns zero-hunk"
> (there is a special "zero-hunk" message to signal this particular
> condition sent over the protocol), and this description does not
> quite help disambiguating between the two.
>
> If the former, then avoid "zero hunks" as it sounds like a noun with
> special meaning.  Yes, we can say "tool returns one hunk", "tool
> returns 31 hunks", etc., so "tool returns zero hunks" may logically
> be correct, but "when the tool returns no hunks with status=3Dsuccess"
> is much less confusing, I think.

Yes, "zero hunks" was my own invention and I see why it's confusing. Will
update the messaging to use "no hunks" instead and do a broader sweep of
the documentation to clarify the protocol and expected tool behavior.
