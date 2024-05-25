Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024AF2119
	for <git@vger.kernel.org>; Sat, 25 May 2024 20:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716668571; cv=none; b=k2O1a50qYwAbYUOfBlGRll8zgLvFCzLWxHQK2UIdZZ4ft1pde43ohfwIeRvTeiEBC2psKZXHbhhRuw+ybwp7S4SQhp+CBaxnWKAeJrf9XogL1TDsNJuoV2Z4sKVZw9LGNf3MKH46lV63Vg+tIEG8rt86ds9lipbM4CrTqXAKYBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716668571; c=relaxed/simple;
	bh=o2aXG53qyy9iPUM9NpwjyMEwnhn6huVq7e//bgJqc9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=ghYNZ2AFe3QVIPLuI6RkG/XwWdm9vqDKvq+7YjjxHKlPGIu9gEu05E2SIkEwxihQUloQEX9AWM4PynVk8aeYmcQcNgLOp2AOhP70yE3ujmRURnXflj4kr8lMz0C+5k619+lhwPqBylQOX6rTr2zuhRREaQYO+i/vWrxMG3+ZUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZI8mUp8+; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZI8mUp8+"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6f144141608so3452781a34.0
        for <git@vger.kernel.org>; Sat, 25 May 2024 13:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716668569; x=1717273369; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGGnitFse688+ymWqlDgC6wLCED9TQ3SBaBYQIRWxmE=;
        b=ZI8mUp8+/U0Ywipm0aAzQhqMJhTPq+uvmdq7vOCM8WXG7JzXw9iTBURntavb8C5zql
         obINmWYg8rw+d11jGInS/3EVLOsiTOKciMR3UPPggaDIlkL3oAh5MR9ca/1ltGKt5+4A
         Og050J5iIQQ2sdmhM2llBfkvqhusM8heBBIu2TkKuKZ8dsTpBVHirw9R41nsJX1dIo4t
         +h2jlpDU0BT2Dy5YB1LTrZghRfyNPy9RfMDOTIGFMTFYpgMhpriZpqNiXEVt00sT6MeR
         zwJHl1Ocu1wW5yYxjP18APVPkentfj16JuQRk+93SKQCzmN97tT+lv0cTH47LHFpeq4P
         o+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716668569; x=1717273369;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGGnitFse688+ymWqlDgC6wLCED9TQ3SBaBYQIRWxmE=;
        b=DcgF+CJpnNuP54br91KK9YcmKxEcNNpFbATD1VOio2Rh5Yq1p+4AeR3kvUYt4ZgXgK
         9BIxIku818b7+UX1deWS7tAEZn04DWJvDVJPmpVkQHhm1RvpvXSmbnoEeuA6ESk5xleK
         M+Df35CQU1EzdqVUl3CT06CmmLycLPpz4lC3YXpHYKAGSraHf/LP314Rn0SdAk4W1S6g
         3ipKgekCC8XXr0J0kpr8R+VJ+wuhMt7SkR+vnZ8d2u7OWFnLevJNV9Ld8Qye7kbNIuex
         zceNS9wbh/MCyLkgn6a4lGOCCBOmC2cWNi8X+XtWDiDUi/TI09GL7EZxSW83ZyyAjdpF
         Y/Kg==
X-Gm-Message-State: AOJu0Yztb5S3YR4aOoDVpOupBOpe52tPvzAJDeOPsipqn52stud/lAdx
	xuu3+ho4TsY7a2nmQFE+W78AOxur7xHNamA1C0C3kzJnh1sLa3x60IBPDst8921apOm9h9wdoaq
	hJU5chLSgmGDpPTCNSklmwrX68VMNzzta
X-Google-Smtp-Source: AGHT+IFiZ7LFz+E5/VsofzsnmKcaMPDWBkKv4e0TsGeIAyx6cy9HaIEWYqlLaNa4b+ZrwwYOuV73iDEz1bpK64xPIi0=
X-Received: by 2002:a05:6870:a10c:b0:24c:a527:3e44 with SMTP id
 586e51a60fabf-24ca527fdadmr6067208fac.32.1716668568729; Sat, 25 May 2024
 13:22:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHa7PX8THmTAYFVwAtjimgcenUPC4A5BF2OHExC82Cnrdtbn=g@mail.gmail.com>
In-Reply-To: <CAHa7PX8THmTAYFVwAtjimgcenUPC4A5BF2OHExC82Cnrdtbn=g@mail.gmail.com>
From: William Ruppel <wcruppel@gmail.com>
Date: Sat, 25 May 2024 16:22:38 -0400
Message-ID: <CAHa7PX_JwsvADE0Xv9AW--5ZgAChwQTWrqNSGhwWbuabk5_PKQ@mail.gmail.com>
Subject: Re: Git "safe directory" not working correctly
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

FYI, I discovered that the issue appears to be related to the single
quotes. If I do this instead, then all repos are considered safe:

git config --global --add safe.directory *

And in a similar vein, to whitelist just the single repo I was having
an issue with, git itself  says the command should be:

"
To add an exception for this directory, call:
        git config --global --add safe.directory '\\bill\gitmaster\Src'
"

But, again, the single quotes don't allow this to work.

All the examples I've seen use single quotes. Has something regressed
w.r.t. to how single quotes are handled?

Thanks.

On Sat, May 25, 2024 at 2:49=E2=80=AFPM William Ruppel <wcruppel@gmail.com>=
 wrote:
>
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
>
>
> What did you do before the bug happened? (Steps to reproduce your issue)
> Upgraded to git 2.25.1.windows.1
> Now when I pull from my remote I get: fatal: detected dubious
> ownership in repository at '\\bill\gitmaster\Src'
> So, I ran this to whitelist everything: git config --global --add
> safe.directory '*'
> However, this does NOT solve the issue! I am still getting the same
> 'dubious ownership' error!
> So... what, is this some sort of bug where UNC paths are not being
> recognized as safe?? Or...?
>
>
> What did you expect to happen? (Expected behavior)
> Pull should succeed without security errors, since I whilelisted *
>
>
> What happened instead? (Actual behavior)
> git craps out with a 'detected dubious ownership' error.
>
>
> What's different between what you expected and what actually happened?
> I cannot pull changes from my remote!
>
>
> Anything else you want to add:
> Please provide a workaround.
>
>
> Please review the rest of the bug report below.
> You can delete any lines you don't wish to share.
>
>
> [System Info]
> git version:
> git version 2.45.1.windows.1
> cpu: x86_64
> built from commit: 965b16798dab6962ada5b0d8cf0dca68f385c448
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: /bin/sh
> feature: fsmonitor--daemon
> uname: Windows 10.0 19045
> compiler info: gnuc: 13.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): <unset>
>
>
> [Enabled Hooks]
> not run from a git repository - no hooks to show
