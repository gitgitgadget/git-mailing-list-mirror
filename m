Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416781B7F5
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710966952; cv=none; b=BN0j2vUjwJc2qALGBpfU3sh3PveX6ArPVpbDb1OvKSlaG8cbmltKg7zzw50dc9SZUHMwyzLss0nWxVKocWfUSv3rRY9G9a9rsH51xzhIHgACbUi43XWIxuDs1ns2lzlC++YfX1e5eSUQsyCC9wr+tGtRIVxdpssaAbqlcMUGUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710966952; c=relaxed/simple;
	bh=Q6JfoysL7/MO+5hzvrJ1b6gmAtlviE/q92A19BhAi9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lM0OTCVi6GsAzZ2mKa43cYZkP0oFwhnTvsC7EfyW2quxGKz1dJvold8wWyiyyj18LFzZH3avgUs3AxoPHJOGGME9rzS/I1sK9FUAHR2cSdTJ0s6H26+X3FAtBK5ZvzUNOwfvjSOTBArV1EK2Jk5a7MBxQ4LLefAX5/sODDm8Gh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3bd72353d9fso189307b6e.3
        for <git@vger.kernel.org>; Wed, 20 Mar 2024 13:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710966949; x=1711571749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtxsjiPBH4u7o8n9777B7DvnRY1WCSBXy/Z+v6a2xAg=;
        b=GixNWJwHCk7+5TQDnjOghNH60mHJ2c9jcxvGcfRdM12vNvZ9pWIZ79Y/D5u1+jjfrk
         R0l3kVXrLr17KGTG2S4mvqdHs8N6borIk307V3oHOj2toKKKofqTUG+wxxDs3qRghXiB
         GokuPOAtMI7eCr33XpO9jvaj2NCQjT4k55wseErbIWBlErgZLcdED/TqTvdlRWztJlf1
         VWbIkmvRqV6lWmRsJteoyBDH4R5o+VyeA36/UZ51FS+B2ZDgH84xX2UJZrvCDP7TTsj1
         r5v9mTiA3RDUhkKhCa6h+l1CBOFkYAd/02xCQVGzsHH2gYnr61r/mH/SofV+xIFECst4
         lVZQ==
X-Gm-Message-State: AOJu0Yxg0V4OnTwHOI0sxSr+LwjTRHc/LiT0BbgLyuxeh8Qn+HkfXu20
	KBHGtJhZCwwBgo6apBYBaaDUzoaUDJGRtwZ0KJ98YYobEA9ykYUgyQyDHF2z3j6X+LBlWoEgAjl
	XvbAl91Z/DZ7PHjecf29F14gs4P5tDZvt1qI=
X-Google-Smtp-Source: AGHT+IGw5CQZN1/gq9uOFTHdn45JtMnIiocuEnYdsBoo78iR9CEmEtZR+/MnulBxw+UfytQMic1h+C7+wuoPhShzfPM=
X-Received: by 2002:a05:6808:f90:b0:3c3:a696:c7e1 with SMTP id
 o16-20020a0568080f9000b003c3a696c7e1mr2269517oiw.3.1710966949334; Wed, 20 Mar
 2024 13:35:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1700.git.1710964109659.gitgitgadget@gmail.com>
In-Reply-To: <pull.1700.git.1710964109659.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 20 Mar 2024 16:35:38 -0400
Message-ID: <CAPig+cTPgh=Yf7x9FHNgDbNDViMCJg9aqg9F_C=OO1BB_=AErw@mail.gmail.com>
Subject: Re: [PATCH] t9803-git-p4-shell-metachars.sh: update to use
 test_path_* functions
To: Sanchit Jindal via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sanchit Jindal <sanchit1053@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 3:48=E2=80=AFPM Sanchit Jindal via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> From: sanchit1053 <sanchit1053@gmail.com>
>
> Signed-off-by: sanchit1053 <sanchit1053@gmail.com>

Thanks for submitting a microproject. Some comments...

The From: and Signed-off-by: lines should include your full name and
email address, so probably:

    From: Sanchit Jindal <sanchit1053@gmail.com>
    ...
    Signed-off-by: Sanchit Jindal <sanchit1053@gmail.com>

Reviewers would like to know why the changes made by the patch are
desirable, so use the space between From: and Signed-off-by: to
explain the rationale for the patch. This particular case doesn't
require much explanation, but you may want to say something about how
the `test_path_*` functions provide useful diagnostics when they fail
whereas `test` does not.

> ---
>     t9803-git-p4-shell-metachars.sh: update to use test_path_* functions
>
>     I have updated the statements test [!] -[e|f] with the corresponding
>     test_path_* functions The statements are at the end of their respecti=
ve
>     texts and can be easily replaced
>
>     I am having trouble with the git send-email and my institutes firewal=
l,
>     that is why I am trying to use gitgitgadget

This portion after the "---" line is for commentary which doesn't
become part of the official commit message (unlike the portion above
the "---" lines). When you resubmit, you can use this commentary area
to explain what you changed between v1 and v2 (which, in this case,
will just be adding a commit message and fixing the From: and
Signed-off-by: lines). GitGitGadget inserts what you wrote in the PR's
description into this area below the "---" line, so you'll want to
update the PR's description to explain what changed between v1 and v2.

> diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-met=
achars.sh
> @@ -33,8 +33,8 @@ test_expect_success 'shell metachars in filenames' '
> -               test -e "file with spaces" &&
> -               test -e "foo\$bar"
> +               test_path_exists "file with spaces" &&
> +               test_path_exists "foo\$bar"
> @@ -52,8 +52,8 @@ test_expect_success 'deleting with shell metachars' '
> -               test ! -e "file with spaces" &&
> -               test ! -e foo\$bar
> +               test_path_is_missing "file with spaces" &&
> +               test_path_is_missing foo\$bar
> @@ -100,8 +100,8 @@ test_expect_success 'branch with shell char' '
> -               test -f shell_char_branch_file &&
> -               test -f f1
> +               test_path_is_file shell_char_branch_file &&
> +               test_path_is_file f1

These changes all look trivially correct and faithfully retain the
intention of the original `test` checks. Good.
