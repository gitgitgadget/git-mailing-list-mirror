Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58135C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 05:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiHUFS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 01:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHUFS4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 01:18:56 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4437325C62
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 22:18:55 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id g16so5869360qkl.11
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 22:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=GALaJFASbi6OXP1v2OPEs8Aqtf+h44UyTiOaFBRO5Hg=;
        b=d4DFybeKEjW3IGKAR4IlY+/MMXjiQlLldg7rA7j8naXfwN/rRkRha5MIBTNq6Leg+n
         /y9RENAunlJ/0uFy8A+aSKwuqEmr3Fs2/uvW7ByxjHiwLdJ9UL5vmkiDlRrOy5ujcPiS
         XEZQnWrzbvVoUUy4NYom/Vg9qRugi6+IxNUto5xE2shJ0U9Vi0LZYUzTIiVIiluv6rTR
         bQBf55JhjTCMCjnq80WxZa0XNPY17DEP5qhMvsjdy30cd+PsS19ciSUmT5kbzF6iaE+o
         2iZYPOhzYyGimXP+w7mL3Na0G+NFYj6N4Ck8dUW4Lqdc7bdXmd+9qs2Ovqkeetgy9DyK
         fgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=GALaJFASbi6OXP1v2OPEs8Aqtf+h44UyTiOaFBRO5Hg=;
        b=gM8v1iJTU52Epbazig2D5jtZ/DamLTFZ5/6/5NEryIUXGgj6sYHjvArcW9iXKRH4uW
         rVbPt4lPlNeGbT+FpdXe1pUmHSIsAKE5IJEox4ZIskmIYTUuPOYbWoCEaR+aJ6dafUQx
         kEN5Sirhcc0GLT2TJ0nd/DSSOZUaIH41eFFv1mj/m+aOOXOT7Vr2vg1bSfQxdheFI7bj
         b4dhf8ryVXJ0XQGsml3tfkgLvd17GJc8T1r1ol9IieuM5iriU2nRb5gLNR3le3osD/7T
         PN7/4p4CBSvllXAkbhNHTRtzPBsEbCoJjr5H9g2h2vmBzcij2N6Uy/2eSCVwU7zPswWj
         sfKg==
X-Gm-Message-State: ACgBeo2KYyOWB6M1Uc062hR9NSelgyhqjZtgGm+3M1jhDbpg54FeNzdC
        7+EL4l9pcODod+NT05OAqL62VvGmKaLjASZfYFg=
X-Google-Smtp-Source: AA6agR6lkdUzLihU5RmH5wDjG9RRBo+JrkPqf5lRLQ9M9Ka6cPtW5jRi6TMCPNhyauFfdpSYySw9rzA8i+TNPfA/psw=
X-Received: by 2002:a05:620a:444b:b0:6bb:238a:2454 with SMTP id
 w11-20020a05620a444b00b006bb238a2454mr9412528qkp.183.1661059134384; Sat, 20
 Aug 2022 22:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1331.git.1661056709.gitgitgadget@gmail.com>
 <92840bf63782ca302e9d48a12faf7d4f5b3cc2d5.1661056709.git.gitgitgadget@gmail.com>
 <CAPig+cTMxj14gYGXgE3LAPFQRdDYXiH=Fd_iCwzoJp9uS1jCzg@mail.gmail.com>
In-Reply-To: <CAPig+cTMxj14gYGXgE3LAPFQRdDYXiH=Fd_iCwzoJp9uS1jCzg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Aug 2022 22:18:43 -0700
Message-ID: <CABPp-BGYbdjXNXPp9rW02Ay72CWVkHKdpSDCs8V9aQA8Tu68Gg@mail.gmail.com>
Subject: Re: [PATCH 1/2] merge: only apply autostash when appropriate
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 9:53 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Aug 21, 2022 at 12:41 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > If a merge failed and we are leaving conflicts in the working directory
> > for the user to resolve, we should not attempt to apply any autostash.
> >
> > Further, if we fail to apply the autostash (because either the merge
> > failed, or the user requested --no-commit), then we should instruct the
> > user how to apply it later.
> >
> > Add a testcase verifying we have corrected this behavior.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> > @@ -255,6 +255,15 @@ test_expect_success 'merge --squash c3 with c7' '
> > +test_expect_success 'merge --squash --autostash conflict does not attempt to play autostash' '
>
> Did you mean s/play/apply/ ?

Yep; will fix.
