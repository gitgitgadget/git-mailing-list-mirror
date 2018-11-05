Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F3FB1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 16:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbeKFB3M (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 20:29:12 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:34104 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbeKFB3M (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 20:29:12 -0500
Received: by mail-it1-f173.google.com with SMTP id t189-v6so8077384itf.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 08:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NEV37X/c1A9UQK2BjP7pV3YHkVo23+MbFTUBZfwoUWc=;
        b=AdZQE9fDddgPsGNNEp7qm6/9I5Q95WTLQlZ4Z7Q3UIDnYCpUhE9brPyDWT4skvFpN3
         CnyuxAvJYBVhQakmGHQ2S1o9YiCMM7vCl9GSLtSBiIoebS88EbwxBaVNNniA/1OEkYuT
         6Y+N+JRv4QmVpwUFBdQiQDWvmYqIwc1GcVi+1wGUcFmjX1ieg3YS7dx7pP9fxnUH6jE0
         983Jo/tw+Hee1zEws5gwxG4hlCAtKNFHtI+t2mQYscbVvQTesuY0Y7MpxnjzcRM63Pqv
         ZWsBa1Dc8Ja48Ihkf3MDbZVL0oECgxm5YEFEshWJfwd3UhSdbTcqUuvGTqHP/5D8pZ7r
         hhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NEV37X/c1A9UQK2BjP7pV3YHkVo23+MbFTUBZfwoUWc=;
        b=qH6E0mRAtbVviHLjAQiVnUXphDjmD1CqwSXHJdG9zPfmwLYtnw71jCUME3m2b7Ad6N
         6MWeQgc6vacuMY4RNwptiPVUp24d9GMc9tzvKkHQlrMfrvNksfIr/I54txacEYTalVdC
         kgl3pgr4cnvf5+9oLio57XGHSbsNgjbsddl2NITJlDC1M0omr1+bGeMIgmRLKUT0Oaz3
         YVSDzzwwb3ln3DaB/6ubZqi2gVGssZRZC8NGiYcQMa6xVmoUsOoKvGHmwvrKj2U6iUtT
         18yB1s+aRpyKAcozPDGf+tMKuCvFQ6oS3Ek4GGj+Yv9k0AmUq37UKR0V/YGDqFR8/e64
         nrnQ==
X-Gm-Message-State: AGRZ1gKvot4XIKg9fhgj882mZtELF43O9rZ0Np5sZSjChHN3Xpluwe2S
        zIubz/CUYJrHD0OKRoFqv0ZUl4Yjnl3H368yZeHmvw==
X-Google-Smtp-Source: AJdET5eZ6yp0bEmh79DIzJ+6kglXUVYAT/Xk6ALgda22AW6OYIppgg34+t/lJQIM4RlLI/dOYf4FEo/EIYAxz6RxEjU=
X-Received: by 2002:a24:fec3:: with SMTP id w186-v6mr6114663ith.10.1541434128391;
 Mon, 05 Nov 2018 08:08:48 -0800 (PST)
MIME-Version: 1.0
References: <20181104072253.12357-1-pclouds@gmail.com> <20181104181026.8451-1-pclouds@gmail.com>
 <20181104213007.GL731755@genre.crustytoothpaste.net>
In-Reply-To: <20181104213007.GL731755@genre.crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 5 Nov 2018 17:08:22 +0100
Message-ID: <CACsJy8AJY=J=YF1w-aWZkMYeNa9R05ThAqka7vDFNpvre5TB0g@mail.gmail.com>
Subject: Re: [PATCH/RFC v2] sequencer.c: record revert/cherry-pick commit with
 trailer lines
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 4, 2018 at 10:30 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> However, I do have concerns about breaking compatibility with existing
> scripts.  I wonder if we could add a long alias for git cherry-pick -x,
> say "--notate" and have "--notate=text" mean "-x" and "--notate=trailer"
> mean this new format.  Similarly, git revert could learn such an option
> as well.

I don't think it will help unless you are the only developer on some
repo. If you have some scripts parsing the old format, people could
choose to commit using the new format anyway and your scripts will
have to adapt (it's too late to revert because it's already part of
git history).

The transition plan could be outputing both old and new formats at the
same time (optionally allowing to disable the old one) and leave it
like that for a couple releases. Then we could stop producing the old
output and hope that all the scripts in the world have caught up. Not
a great plan.

> One final thought: since our trailers seem to act as if we wrote "this
> commit" (has been), I wonder if we should say "Reverts" instead of
> "Revert" for consistency.

Yeah that or Reverting:, both are better than Revert:. I guess I'll
just go with Reverts: if this patch moves forward.
-- 
Duy
