Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CD6ECAAD5
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiIFPS0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 11:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238269AbiIFPRq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 11:17:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502B192F58
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 07:30:38 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w28so8115267qtc.7
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 07:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=YA+Fr142u/8IOo8hC6KTCOuD5NmhTLZhZ1b+Sn5JkFA=;
        b=QdOtUc1B/VLkZDZYgbg8cx59XcSlOBhmJbBKhDXTW5sSt6pLsl/mS/kN0gR3v9Z7F/
         8jioG0reX2bnVD5w0eGZQcEx/tPXQPsAFAMxgTrKeXC4ae+tbK5vQU2CvTNCmIciNeW8
         lh6/cDTHQU7t6Ov0H46aGuGILSQMG1/gNhKUg9+OonLMCAUkfSqgkalx7eFLB7tLEsld
         GcHW+OLtO5ChjvRm3l6JxN1UrmeIgGFrl5kioWYvtddYIVV9Em/lJvSQebyNEnVyChNC
         qNFRBAfzY1l/YuNgpbYIBG6EChFQU5uEk00Yz11GozSyHJinyk0iZcfOyGH1yHoJMBsp
         Ua3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YA+Fr142u/8IOo8hC6KTCOuD5NmhTLZhZ1b+Sn5JkFA=;
        b=FkiNgE4OXu0PIUN5yslw4NXsH6SbV2o3YC4LMvzJD45qkPm8nqS5VE53bFY878q6wn
         niq+fvN7hRjYzyq/ku+bz77i0BT26b1fSFKls1dFGT/qQAQrPJLDGHbASukVW8sfXG1y
         E34UtphP4p3brEDZN5Msf8mUFB5UWt5IeoVL5cKEQqKVi/20hn95R7vvh+dJsPRXgNDZ
         tJ0Jy6uwyeTjbi53Az1txfu+N7gFydLLIx+B/5g6+uxUEj89Fgz8aYosAz3OShrD0O62
         ydd1bzNKGH3Aqtsh2PR9d9D47hMnWY+DJSPhiG6HKrX50tKeqwDw1XkYtFuWHRK0LNI5
         Eppw==
X-Gm-Message-State: ACgBeo00SDoCf7Il2hyNEWmS2T6L9HT7k1FVud4eKZr1M+gx5CIwfjUv
        w3RXo3BpMBPuCp4NsfbSxQNmLCRQMMmlYjEo45LBt02/6Tf+jw==
X-Google-Smtp-Source: AA6agR6p+qKCgVvvrsE3FE2c+w+1ib6Y8Pp2CfSbhdLy/IQqnRDPOrXaU7G0CqZkSsjMgh4lK9gMGyql+EqGSL+6oN8=
X-Received: by 2002:a05:620a:4546:b0:6bb:da4a:e0d9 with SMTP id
 u6-20020a05620a454600b006bbda4ae0d9mr36351443qkp.187.1662473862620; Tue, 06
 Sep 2022 07:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqilm1yp3m.fsf@gitster.g>
In-Reply-To: <xmqqilm1yp3m.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 6 Sep 2022 07:17:31 -0700
Message-ID: <CABPp-BEX0ScdAvQ1YaPUPNQ197mhcRMEFnHBoJ_0MBTK3nv_DA@mail.gmail.com>
Subject: en/remerge-diff-fixes (Was: Re: What's cooking in git.git (Sep 2022,
 #01; Mon, 5))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Sep 6, 2022 at 12:41 AM Junio C Hamano <gitster@pobox.com> wrote:

> * en/remerge-diff-fixes (2022-09-02) 3 commits
>  - diff: fix filtering of merge commits under --remerge-diff
>  - diff: fix filtering of additional headers under --remerge-diff
>  - diff: have submodule_format logic avoid additional diff headers
>
>  Fix a few "git log --remerge-diff" bugs.
>
>  Will probably need to rebase to make it mergeable to 'maint'.
>  source: <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>

It rebases to 'maint' without conflict and the result correctly
applies there...but rebasing to maint causes it to drop a line of code
("TEST_PASSES_SANITIZE_LEAK=true") which is called out in the commit
message, making the commit message look funny.  Also, while that line
removal turns out to not matter to maint (because the leak checker was
already off), it is critical for main.  So, if you merge the rebased
result back to main, the leak check will fail -- unless the merge back
is an "evil merge" that restores the removal of that line.

So, which of the following would you prefer?
  * A separate series for maint and main?
  * Just ignore maint?
  * Me to rebase on maint to tweak the commit message, and then you
carefully reinstate the line removal as part of the merge back to
main?
