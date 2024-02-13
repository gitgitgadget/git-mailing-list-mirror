Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA98604A5
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707845753; cv=none; b=hAzlXbUF9TXUE7xfOX1pu3hC8LfNzJXHFlMr3dahwM9lrze/4vLgEaFe3mv8tkR8/PYAdR2V6+JmKpqyfJzNRQ94BIsujw46Rr9hjPIypNgg9KucwpOQIGEBVcuqDJITB+Rzcr7tysFs8pff/Sor7PGf6yitzoGLC82PLaHkQ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707845753; c=relaxed/simple;
	bh=FcVcxrPBAGeKJi65NwQRQelpzCtFXcRJM1neFQRtCb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCB7gknDwcBk1ODf/wYVCyHdhoPWtB80oYmJDmUyuFaqsP1UE1spatjzFuF31rW3AHvPPJWTlgbod9rwJgiusHcRpiiptdAHf2LUUXIWAzW4k+8SgT5h8vu02ZvVFa2plcCZzd+AJ45vf17FvBX6jV25nLqwxN8edacx8v0J1p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6uS7oPA; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6uS7oPA"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2a17f3217aso597956866b.2
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 09:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707845750; x=1708450550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j3g1u7BaIkja1jrm4jFVSJyJSEVuDARxi2vPNF3LvHs=;
        b=A6uS7oPAenRF/WhFRIh9RPxOJJBDnQjAOIYpaC/QD6sJdMXmDfHHQdA6z7iiAponID
         qH7O2GRrSmZ5ljnPRQ8fMU0LKpTJI2yjXREtrxhqUDHVfTuE/r4zOU7UEsOUYBftzPdT
         93rUeNmUjt7mXOXL7x3YfKuNeJMp6TIIWC4hGOPJNH9YfmmU1hRzyjjX3r90102udA76
         QU7wgvwh5RlsHMDePfPiLhR2EB7EzWha0YHUiM6MeXA6GcOwdsnU0cMEJjqUtcFPNMWh
         Tw0l3AyzogtESfyA2ifVmsKVLmxo7fCV0z+hJ8BZTlaC3FUu47Cmlbh5dis5GqcqOGq4
         42nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707845750; x=1708450550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3g1u7BaIkja1jrm4jFVSJyJSEVuDARxi2vPNF3LvHs=;
        b=wSnY8VG51PhaJQMT8k4+VR8j1C9/uMtI1YAn5mnU+kWSLcZFHYhPF2aN0ml+bUMBI5
         jrfy6uonOcrRFzC8/yzgFKu9m5kqpv3n3HWbG3oMZDHq3Ralq74Mexf6yuwMHWbQVPpD
         U8HjsP2JTMThfJCIty5PUVffkfBCC/1jIZ1wyWRWWdjVGosEbeAfiC/6tMauIshJm7FP
         gpSNSowNTIKGHzvYLXPgLytORJBlAzERYICg7gJBoLRK5FwgPxeXAGNv+//K9XJK5Pnc
         l0FVzbllIFqD229ygpX6s9E1p0ikYKPFty1THdvqcXHOfX2/gCJEx92fDlL1VzTQ2Cmj
         GiLw==
X-Gm-Message-State: AOJu0Yx4CqJ6iyJJu//97R0OmTEphO/OYmzNiI4VmJshkprYNF8k16mO
	unoPbU2inU2qUHr3mVmBI51BlajglUgWcHOPwKlVbKiQKagQ2l1zI8vrMnmw8T7gGVPPz9mEhHB
	usZwphTMNC751FqN1gcXMLfvGcs/0kyFWWa0=
X-Google-Smtp-Source: AGHT+IGVyozx5rWWbbxcrbDakls8aHyAB6yWQMRhJ/YUvFSBd5+Qncfr8TM09ZO0BK3QmI98ihRocXZIevCWjgN7Kbk=
X-Received: by 2002:a17:906:f0d1:b0:a3d:3a5:f7ad with SMTP id
 dk17-20020a170906f0d100b00a3d03a5f7admr36389ejb.10.1707845749541; Tue, 13 Feb
 2024 09:35:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cbb450b3-b333-4391-ac83-66c2daf0ae4d@gmail.com>
In-Reply-To: <cbb450b3-b333-4391-ac83-66c2daf0ae4d@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 13 Feb 2024 18:35:37 +0100
Message-ID: <CAP8UFD2ypikjKEVMmHMg7=jwv8J0y5xhx6PxsiLsGdhz2+S3PQ@mail.gmail.com>
Subject: Re: [GSOC][RFC] microproject: use test_path_is_* functions in test scripts
To: Vincenzo MEZZELA <vincenzo.mezzela@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Feb 13, 2024 at 5:10=E2=80=AFPM Vincenzo MEZZELA
<vincenzo.mezzela@gmail.com> wrote:
>
> Hello everyone,
>
> I'm Vincenzo, a Master's degree student in Computer Engineering and
> Cybersecurity.
>
> As I'm approaching the end of my academic journey, I'm eager to
> contribute to the Git project
> and the GSoC represents a good opportunity to do so. Upon exploring the
> online documentation
> of git for the application to the GSoC I'm keen to begin the required
> microproject.

Thanks for your interest in working on Git!

> Among the microproject proposed here
> https://git.github.io/SoC-2024-Microprojects/ , I would like to
> work on replacing 'test -(e|f|g|...)' with test_path_is* .
>
> Can you confirm if this task has already been taken by someone else?

This is a generic microproject so even if someone else is working on
this microproject, you can also work on it as long as you don't work
on the same file as that person.

> Approach:
>
> As far as I understood, The work consists in replacing the shell 'test'
> command in the test
> script under 't/' directory with the ones present in the
> t/test_lib_functions.sh as follows:
>
> - test -f --> test_path_is_file
>
> - test -d --> test_path_is_dir
>
> - test -e --> test_path_exists

Note that you only need to do that replacement in one test script
under the 't/' directory.

> To approximately measure the number of required replacement, I run the
> following commands from the
> 't/' directory (branch master):
>
> > # Files  that requires a replacement
>  > git grep -r 'test -[efdx]' 2>/dev/null| awk '{print $1}' | uniq -c |
> sort -n -r
> >>    190 t7301-clean-interactive.sh:
> >>     147 t7300-clean.sh:
> >>      21 t2004-checkout-cache-temp.sh:
> >>      17 t2401-worktree-prune.sh:
> >>      16 t2003-checkout-cache-mkdir.sh:
> >>      14 t0601-reffiles-pack-refs.sh:
> >>      13 t4200-rerere.sh:
> >>      12 t9146-git-svn-empty-dirs.sh:
> >>      12 t7603-merge-reduce-heads.sh:
> >>      12 lib-submodule-update.sh:
> >>    ...
>  >>
>  > # Number of replacements
>  > git grep -r 'test -[efdx]' 2>/dev/null| awk '{print $1}' | uniq -c |
> sort -n -r | awk '{sum +=3D $1} END {print sum}'
>  >> 853
>  > # Number of files that requires a patch
>  > git grep -r 'test -[efdx]' 2>/dev/null| awk '{print $1}' | uniq -c |
> wc -l
>  >> 169
>
> Although the replacement work might not be difficult, it spans over many
> different test files.
> Do you want me to submit a patch for each of them as part of the
> microproject?
> If not, How many patches do you expect me to submit?

We would like a single patch that performs the necessary replacements
in a single file.

For reference in https://git.github.io/General-Microproject-Information/ we=
 say:

"Change only a few files"

and

"This means that for a microproject that consists in refactoring or
rewriting a small amount of code, your patch should change only ONE
file, or perhaps 2 files if they are closely related, like =E2=80=9Cfoo.c=
=E2=80=9D and
=E2=80=9Cfoo.h=E2=80=9D."

Thanks,
Christian.
