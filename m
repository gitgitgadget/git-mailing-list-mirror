Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FECC10E5
	for <git@vger.kernel.org>; Thu,  9 May 2024 05:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715231007; cv=none; b=T7ij9pBZLX7N507RDsE8liFFcm/im4vi1yiW/yCWqhnmiupJZ37i/VDw23skKAGNKZB/32j09zPodLWlJzMFRN+CUtNYmd0wOqeyYcM526x2j5M4Mqa9p+xHTdbaHGVfUHGyYPIQneYMzQHnwDHPcB5HYv5N5O/nCTUcFwEszJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715231007; c=relaxed/simple;
	bh=GWLIBFgh5YLLoVi4DRrCUXKY4f3EISUrRHDBGS7sLfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=jL0nBIj+1uEPPef8uUKZSbl353JaDPEQgUjpqLdnSnsDp/qxzXTTUJTjnJIYiT2rjbZtw9jBJgv/vl0Vzt8u6mxIcQ/rfwErnxbnHucQbAakkAb0CmCHwlwOZkKHiKs2GQ/UQ5hcLqRW8uxjxti2jZ3sLGGS/wAab33suwyyQW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ECVlQ689; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECVlQ689"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7da37436e36so18381239f.0
        for <git@vger.kernel.org>; Wed, 08 May 2024 22:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715231005; x=1715835805; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUWvEpvNFXDcZHKXflfAP/Z797OmWLlhvdjYttVlEdA=;
        b=ECVlQ689B91x70oELJa6nxpfqrrAJq0UYU4NVEuhtqsvY+Lwug554PAbErhR0RbD7l
         ke0dYWCc1er2dV4gpTbYzW5u9WOXuhsdrbrT6UpjT0ekwbvASsq5OYn7/RtTM4w6WwtZ
         18gEa61aADxtIpMq3rrEZTXkf0+Jc6DLO5QjQHMx4NFdOr7tO5X6M5csZ0pFyGTAP9ON
         uknep0kanVM/U0BXi9dvNQ5Dj7VXW+3C6qX1i/xFVhMZ/ECT03cfZs5fvWxsuelJf0hc
         xv9u+GpHjrfzH/MzoCRq7iaDO5+SyaEQQtKKEK7vjhLJFyqU31g2MhdqLmb06NqEFEPB
         LWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715231005; x=1715835805;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUWvEpvNFXDcZHKXflfAP/Z797OmWLlhvdjYttVlEdA=;
        b=oaRAsgO7HOput6UKIIm7/X6cwGv/LoK/p3GLU8w/DUiHgN7I9a0aOUAigxf/Doz9ii
         4U09fPTuEBWooDldGyHCWX4Rz2VIcMT24bnoZ2LjTE5P8lnbZ2D9jJGLfKwyNdTKeYPL
         EAuGw0re4HLQ4z7zl55bwD2hTpq2vPzWr8N38Ru56m0ULifEXCc1TW1gBVD+vWXnGuqG
         PpsLCSd8cucd2cQvEy+Y5c8juHe4V/4YpLReaWHAvCk1dqpX95zObwsUZaevPFUPlZmI
         MlcgWTYFeFTUGvuZiDR136qInqSPP9WtQSx1LifnCtrZWC5KHRV+hnSZ9u4jo5WR5z0m
         gPGg==
X-Forwarded-Encrypted: i=1; AJvYcCW3aOKvGhdOOT4x939DDlyKnWL5S+4DjOLe6KHOaIxN3CaTkewWD5xJPhQLrtxLRmOj64JQ4YMz7sNSrubT8QXgO4g5
X-Gm-Message-State: AOJu0Yy2bTTwsPsV7UjQIhm2CiWucS6Rz7duFbmBmU4jsLm5dtfkppgM
	e7BCTDZgCNN8ldKI9wYeTLlDcPi0SDKqYaGWqsvXrvghlsIBiAA575pLseNJkajPsIxXoQTJZ6D
	9GrQUK0oBvrNCegW3BjK+TpwUc5I=
X-Google-Smtp-Source: AGHT+IG5ZQsOMQNILSpcTQNtF1KlSNw6hJbMDMKJjmpzgB3YTrA1/sUBS42nBXqo9Iw2m5fkj5MyCMY49uqT6vZ1ZvE=
X-Received: by 2002:a05:6602:6d8c:b0:7e1:7e1e:624c with SMTP id
 ca18e2360f4ac-7e18fd4bcacmr561930039f.5.1715231005304; Wed, 08 May 2024
 22:03:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com> <ZhBZOY1aEFW4YoD8@tapette.crustytoothpaste.net>
In-Reply-To: <ZhBZOY1aEFW4YoD8@tapette.crustytoothpaste.net>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 8 May 2024 22:03:13 -0700
Message-ID: <CABPp-BEogmpG7pYmC84WhQCy0tP97cV8BZ8epPeo4fzmRjU5Rg@mail.gmail.com>
Subject: Re: Unexpected git merge exit code when killing merge driver during
 ancestor merge
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Matt Cree <matt.cree@gearset.com>, 
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 5, 2024 at 1:04=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-04-04 at 16:16:05, Matt Cree wrote:
> > Hello all. I have observed some strange behaviour when exiting a custom=
 merge driver that I was wondering if there=E2=80=99s any reason for =E2=80=
=94 I think it may be a bug but I=E2=80=99ll leave that to you to decide.
> >
> > I=E2=80=99m configuring that merge driver to exit during a merge at the=
 first sign of conflicts =E2=80=94 the exact nature of the rules for the de=
cision to exit early isn=E2=80=99t too important I think though so given it=
=E2=80=99s =E2=80=98work stuff=E2=80=99 I=E2=80=99ll leave some details out=
.
> >
> > Here is my current understanding of how the ort strategy will deal with=
 this.
> >
> > - Ort runs the merge driver with the parameters for the current file to=
 be merged
> > - When the driver returns exit code 0 is returned it is treated as havi=
ng no conflicts
> > - When the driver returns exit code 1-128 is returned it is treated as =
having conflicts
> > - When the driver returns exit code 129+ is returned it is treated as s=
ome kind of error scenario
> >
> >
> > Then subsequently
> > - If all files returned exit code 0 during the merge git will return ex=
it code 0 i.e. no conflicts
> > - If any file returned exit code 1-128 during the merge git will return=
 exit code 1 i.e. conflicts
> > - At any time if the driver returns 129+, git will stop merging and ret=
urn exit code 2 i.e. error?
> >
> > However, when setting up a criss-cross merge scenario and =E2=80=98shor=
t circuiting=E2=80=99 the merge during an ancestor merge, I get exit code 1=
34
> >
> > Here=E2=80=99s a couple of quick scripts that help recreate the situati=
on https://gist.github.com/mattcree/c6d8cc95f41e30b5d7467e9d2b01cd3d
>
> Thanks for the repro steps.  I'm on Debian, which uses dash as /bin/sh,
> and I also use a different default branch (dev), so I was able to
> reproduce with the following patch applied:
>
> ----
> diff --git a/init-repo.sh b/init-repo.sh
> old mode 100644
> new mode 100755
> index e0f42a4..25d7f25
> --- a/init-repo.sh
> +++ b/init-repo.sh
> @@ -1,5 +1,5 @@
>  rm -rf merge-driver-test
>  mkdir merge-driver-test
>  cd merge-driver-test
> -git init .
> +git init -b master .
>  git commit --allow-empty -m "Initial"
> \ No newline at end of file
> diff --git a/run-merge.sh b/run-merge.sh
> old mode 100644
> new mode 100755
> diff --git a/run-recursive-merge.sh b/run-recursive-merge.sh
> old mode 100644
> new mode 100755
> index 6920720..c63d652
> --- a/run-recursive-merge.sh
> +++ b/run-recursive-merge.sh
> @@ -1,3 +1,5 @@
> +#!/bin/sh
> +
>  cd merge-driver-test
>
>  current_time=3D$(date "+%Y%m%d-%H%M%S");
> @@ -12,7 +14,7 @@ featureA=3D"$current_time-feature-a";
>  featureB=3D"$current_time-feature-b";
>  featureC=3D"$current_time-feature-c";
>
> -function writeFiles() {
> +writeFiles() {
>  cat > $xmlFileName << EOM
>  <?xml version=3D"1.0" encoding=3D"UTF-8"?>
>  <CustomLabels xmlns=3D"http://soap.sforce.com/2006/04/metadata">
> ----
>
> I take it from the "Abort trap" message below, you're on macOS, but I
> don't think that's relevant to reproduction.
>
> > The logs also show
> >
> > ```
> > Assertion failed: (opt->priv =3D=3D NULL), function merge_switch_to_res=
ult, file merge-ort.c, line 4661. ./run-recursive-merge.sh: line 162: 78797=
 Abort trap: 6 git merge $featureC --no-ff --no-commit
> > ```
>
> This is definitely a bug because we triggered an assertion.  The
> assertion asserts that that case will never happen, so if it does, we've
> made a mistake in our code.
>
> This also explains the 134 exit status, because on most Unix systems,
> `SIGABRT` is signal 6, and when a program exits with a signal, the shell
> returns an exit status of 128 plus the signal number.  Because a failed
> assertion calls `abort`, which raises `SIGABRT`, that would lead to an
> exit status in the shell of 134.
>
> I've CC'd Elijah Newren, who's the author of merge-ort and who wrote the
> code.  I'm not familiar at all with merge-ort, so I can't speak to what
> might be going wrong here.

brian: Thanks for tagging me and expounding on the testcase.
Matt: sorry for taking so long to respond.

This is just a quick note to say I'm aware of the bug and will respond
(I think there might be a simple fix here), but for various reasons
it's going to be a couple more weeks.
