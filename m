Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1D671F404
	for <e@80x24.org>; Wed, 24 Jan 2018 18:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965139AbeAXSjl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 13:39:41 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:45052 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965045AbeAXSjk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 13:39:40 -0500
Received: by mail-qt0-f169.google.com with SMTP id l20so12855672qtj.11
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XfX0l1SXdrRW4kTQauZ+kgkHahYWZxSZHipwozPMl4Q=;
        b=HGXK6tfIDXYQMpMmMj1T6pkE4sJWBS2IpVduEWOi6o7QGaqWoMLsncZyLOhWqimP5y
         jAh77y8CXcgnlxK0ty8CqP1NUMHYT65sFZOrqO26IJIKTH2geP0vGFJDJlDutcg0E8Q8
         iAmLqUiXQhsr+j2Z1DWGwW/D2LhdM490RR7NN6Cd6knf7UJdnlTXxm90MeKjbzwbijkE
         yjwzvj4t2tPlu5k9hBvDjip6nCLFXWMsWb5dEHpiqPvv1yQ1B83oTB+Hf9Kl8rqk3LQF
         5JYvhapnZRJKlLcAME0gDNbdDChWflck5xfTVJqgPW8hW1H2mE+xcBq1iy9qLczYIUMr
         cCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XfX0l1SXdrRW4kTQauZ+kgkHahYWZxSZHipwozPMl4Q=;
        b=D6WxRNc5Lcc6abe38PCC/fTbJvTUw831MBhqmrgUCkJ71cn7lufJtrnr4SyuMpVbfO
         Zp0WO/H4oDRCZOF7cqo1BOtsw5DF+CEuhOjDL0r840MhLJu8k7+IZmOpck8ciHqrj/PI
         fPqGcQnY8e1R9okx4EqDkcO//X9gDrObyANHrsBUBSDAj9xgjIZRhfG34dFGgH/peBJI
         vUINBHe3hUMNDQqPzkF37QlIAk/lBZUWgHam0bOIU6CaGf3oqaeq2Cuiiyyh5DR/9s3U
         naFrKRysnxXbqP4zLFntyBNaXiCwmefSzKdqs9Sa0xJ6wv9kM4XQbpjVjRQr8Ig/enJX
         56kw==
X-Gm-Message-State: AKwxyteLMHH+LJ7G1AVrqfQoVEQ7NZr7an0NUsOfTFfV8I6MVO4ExfQ1
        r2EFu4TIywKCfQbOPW6msxw9kutIsTPGzCgIdJA=
X-Google-Smtp-Source: AH8x224dpUQy2jvOkGu/WveJl1RoEDmjwbjlQB6KzEVDwuyP6+4R0aeEswxahzuTJns0Jobd/YhXEyBn7QM07pvpr24=
X-Received: by 10.200.7.74 with SMTP id k10mr11891959qth.333.1516819179701;
 Wed, 24 Jan 2018 10:39:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 24 Jan 2018 10:39:39 -0800 (PST)
In-Reply-To: <20180124123422.10637-3-phillip.wood@talktalk.net>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
 <20180124123422.10637-1-phillip.wood@talktalk.net> <20180124123422.10637-3-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 24 Jan 2018 13:39:39 -0500
X-Google-Sender-Auth: gPhfYVMNJCp6YGlXN6BmS3_KLBc
Message-ID: <CAPig+cRryaafwP4gBLe_6ebWZo12HWtEC6e2CbbP6a5gVh6W4w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] t7505: Add tests for cherry-pick and rebase -i/-p
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 7:34 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> Check that cherry-pick and rebase call the 'prepare-commit-msg' hook
> correctly. The expected values for the hook arguments are taken to
> match the current master branch. I think there is scope for improving
> the arguments passed so they make a bit more sense - for instance
> cherry-pick currently passes different arguments depending on whether
> the commit message is being edited. Also the arguments for rebase
> could be improved. Commit 7c4188360ac ("rebase -i: proper
> prepare-commit-msg hook argument when squashing", 2008-10-3) apparently
> changed things so that when squashing rebase would pass 'squash' as
> the argument to the hook but that has been lost.
>
> I think that it would make more sense to pass 'message' for revert and
> cherry-pick -x/-s (i.e. cases where there is a new message or the
> current message in modified by the command), 'squash' when squashing
> with a new message and 'commit HEAD/CHERRY_PICK_HEAD'
> otherwise (picking and squashing without a new message).
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>

Let's drop the Reviewed-by: from me. Although I spotted a minor
portability issue while scanning a previous iteration, I did not read
the patch closely enough to draw any conclusion of its overall
correctness. Normally, a Reviewed-by: is given explicitly by a
reviewer when confident that the patch is correct and meets the stated
goals.

I suspect that Reviewed-by: Junio ought, similarly, to be dropped.
