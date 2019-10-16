Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC4701F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 06:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbfJPG5q (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 02:57:46 -0400
Received: from mail-vk1-f173.google.com ([209.85.221.173]:33589 "EHLO
        mail-vk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731974AbfJPG5q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 02:57:46 -0400
Received: by mail-vk1-f173.google.com with SMTP id s21so4933510vkm.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 23:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ymk8DOueijenwSMprYL4qCUMddKajYdMz2ocBmwqjLo=;
        b=O8z6QUOdFiO+bdbaSAvgFdhF/516Uz/GjC7tiEag/Z4ro/JE1sdw5rdUzrrAwfHzO8
         lP33MFFYrJFfUsWcgudAjN1qbX2MqbjwiIR7zvZ49PthWsXlPbfnA+McdnImxuM2clXb
         f5cwbx451Rhu1vQx6myVz4e92KXYOkOPTZwsx4DRZIOtXLKzctsiYOFneKFftH4YRfxf
         ccRZnlQbHKATAz1G0NdSPied5Ins9V4ZbSTqw7KreZNppX+ihILqqtJ6BvrZa4V37mC9
         VPu2spxwn4wJCqJDiB/eJ/R+Zcvup4s1nmgTxO8KkF8sFi3csduPCM2C5FXb72h0RbzA
         Epyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ymk8DOueijenwSMprYL4qCUMddKajYdMz2ocBmwqjLo=;
        b=XxtEQoR3DGUkXYPeUWy88yIj35TByr3CX/YYGJo7aEtNxv4TSUhlykvI5qDb7a0X13
         IRDMs4czQvnV6PlPJc2Ekh8k/P4TPVaGW6/l7upMpD2WXfz3hRcdCrp4Dr9OlHmHFuka
         tk/Cp+wXc7DFtxQd6rVeL09tHoza1pKo9OlL3XodFA3vBYQTB4TWVy+T3TqJ67OawNHS
         dFhvD6nvkC8GLIW5rQ7VhxaolRDR6/QfTyj7CjGU70Y58luTCP6H5m5mkbBWItS2A4Bx
         kY4nKzRI1I36bGdpV5Z9NMSss3lob2P5MvxzOYM0HWXAVAi42ZAvQMuAskfPA30n0ncs
         3uiA==
X-Gm-Message-State: APjAAAWGPvqXTAWAOoVGb87sHwKo5mVe+053cU5ZR3x3TX1OnUypOXwT
        2MMNR/seogkalZgbRIcA+cCi+4dDnBEzCbuhsTg=
X-Google-Smtp-Source: APXvYqyoD2+gD0g4Euh6SOVNGOM+7UlqLOW4rdUwCqkqC+u8qE0wc4iXcG2gtP6cs6NXA8KO2Z/DGXMUzpY+UFjSN1Q=
X-Received: by 2002:a1f:c105:: with SMTP id r5mr21543744vkf.9.1571209065230;
 Tue, 15 Oct 2019 23:57:45 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh84abmjm.fsf@gitster-ct.c.googlers.com> <CABPp-BHnSG+PtnU=jKHW2_hfLtBK1Sib_W+nqY08gGj8yHGCgw@mail.gmail.com>
 <xmqq8splbhxf.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8splbhxf.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Oct 2019 23:57:34 -0700
Message-ID: <CABPp-BE5WmqXuiyQgMxcRXyjnPu141KD56ddfneVqoGdXLKSoA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Oct 2019, #04; Tue, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 15, 2019 at 6:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> * en/merge-recursive-directory-rename-fixes (2019-10-12) 2 commits
> >>   (merged to 'next' on 2019-10-15 at ebfdc3ff7b)
> >>  + merge-recursive: fix merging a subdirectory into the root directory
> >>  + merge-recursive: clean up get_renamed_dir_portion()
> >>
> >>  A few glitches in the heuristic in merge-recursive to infer file
> >>  movements based on movements of other files in the same directory
> >>  have been corrected.
> >>
> >>  Will merge to 'master'.
> >
> > I'm surprised this one was merged straight down to next; perhaps I
> > should have highlighted my plans a bit clearer in the thread?
>
> My mistake.  I am willing to revert the merge to give the topic a
> clean slate.  Just tell me so.

Yeah, let's revert it.

> > Also, a very minor point but "glitches" may be misleading; it suggests
> > (to me at least) a malfunction rather than a failure to trigger,...
>
> I used the word to mean a failure to trigger (after all, a heuristic
> that fails to trigger when most people would naturelly expect it to
> is showing a glitch in that case).  A better phrasing, please?

Oh, I guess I just had a different connotation for glitch.  I guess
what you had is fine then, but alternatively we could spell it out
just a little more:

When all files from some subdirectory were renamed to the root
directory, the directory rename heuristics would fail to detect that
as a rename/merge of the subdirectory to the root directory, which has
been corrected.
