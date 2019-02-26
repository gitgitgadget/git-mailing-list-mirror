Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F264E20248
	for <e@80x24.org>; Tue, 26 Feb 2019 16:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfBZQbG (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 11:31:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33993 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfBZQbG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 11:31:06 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so6465576pgd.1
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 08:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxTWcqybwtU/RMK5i9JbFwM1wANBwQfX/rYOiKSq51o=;
        b=VZ8RPdyBsKrO5IK8SI904RZExC5E4+q0iD6CvgqN80Pl0fjPsKJmRClrE/qJyRMpdL
         DO5krUNpLYvA2ZisjrxDPts+A0CzTuv02Xxp/VFrxGQHqCGXfEmWOwZAgEkl/Tywqqvu
         qBx1kIxV+lBKoYwo3yWc+4zCHRbr04EyTHjXUR3G3Gfh7AU3wUewPR72myineVDafTFl
         bfeIwgx5Q0fcE8IX/p5XLbHLOcTedesgXsM0KcXJtCIxjArJTDJMu9MOv3isLCqRDnQX
         6TJgKj9nCtVY4Ol+dVScJlxI8Fy2d9jBBWRuy2x0PLAmmPyO1P7yQ56YFjd/hW+Fn8bn
         95mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxTWcqybwtU/RMK5i9JbFwM1wANBwQfX/rYOiKSq51o=;
        b=m1rBY9pmNvHg76Y+ljKjO4clu2EgmvcAihU5WeA4gJocewUPhhnc8zj49MNuj5uLHM
         b/10G3ysuLNU/RYb2JvhMg455s6F7b/orYXelg12RoYlKCWwc442X/FWYh/m5gcGnGos
         utEivrJnrbMiRGnQm8gpatGXBAH3UjhlhhC1+0EgVeX01tyV20VjdCtkaE5Nw2Qu6k9q
         FHaiDoYjNgLiRgfbhQ8sKOAH3Z2X3TfdVfLinN0tS1+dEmSVP8LqakCWPKFTqHnsMl/z
         qYnDU9YL76WdKIw0MXPRcdSvqAmlnFhzWBSCVv2ntd56IuhByuJESutjgJR0XRghcBhB
         92TQ==
X-Gm-Message-State: AHQUAuZbJjQfMPgkGVrK+Hj7wXEjZryqCR848Rd6D23dqUNN3gX2o4VP
        giovWsunRmIXfuXishuiHxDoC7Uq3ONpP/edl5SVTt63
X-Google-Smtp-Source: AHgI3Iaz6/D8wGlTZsR3crtWWsY/6whEiBGqViz4MxktsEEH9fZLS6t24B82AQ48j3p8jq8c9RPDgvtgfvI0PESv4YE=
X-Received: by 2002:a63:1616:: with SMTP id w22mr24848828pgl.200.1551198665559;
 Tue, 26 Feb 2019 08:31:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.152.git.gitgitgadget@gmail.com> <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
In-Reply-To: <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 26 Feb 2019 17:30:51 +0100
Message-ID: <CAN0heSqSp-a0zUKT5EaGLBYnRtESTnu9GKWtGARz2kaOAhc1HQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] tests: replace `test -(d|f)` with test_path_is_(dir|file)
To:     Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Feb 2019 at 14:43, Rohit Ashiwal via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> t3600-rm.sh: Previously we were using `test -(d|f)`
> to verify the presencee of a directory/file, but we
> already have helper functions, viz, test_path_is_dir
> and test_path_is_file with same functionality. This
> patch will replace `test -(d|f)` calls in t3600-rm.sh.

I think this makes a lot of sense. If a test breaks, we'll get some
helpful error message. Thank you for working on this.

> -       ! test -d submod &&
> +       ! test_path_is_dir submod &&

Now, here I wonder. This (and other changes like this) means that every
time the test passes, we see "Directory submod doesn't exist.", which is
perhaps not too irritating. But more importantly, when the test fails,
we don't get any hint. So a failure is just as silent and "non-helpful"
as before. I can think of a few approaches:

 1 Teach `test_path_is_dir` and friends to handle "!" in a clever way, and
   write these as `test_path_is_dir ! foo`. (We already have helpers
   that do this, see, e.g., `test_i18ngrep`.)

 2 Don't be clever, and just introduce `test_path_is_not_dir`.

 3 Don't bother, because this small change here doesn't make the error
   case any worse.

 4 Don't do this small change here, and leave cases like this for a
   later change (something like 1 or 2 above).

What do you think?

There are a few of these "!". The other changes look good to me.

Cheers
Martin
