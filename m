Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128351F404
	for <e@80x24.org>; Fri, 30 Mar 2018 13:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbeC3NwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 09:52:13 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40700 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3NwM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 09:52:12 -0400
Received: by mail-wr0-f196.google.com with SMTP id n2so4787688wrj.7
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 06:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2e457XKvpaG5Xq82ApBDnFeexB1Oga1MewpSuQInmH4=;
        b=s1WWdqU1Uve0GD9tGuxiF2bs33TE+Hrmq63Vu0AYlCt89IqL3yABATOdJe3qfv66Or
         DANpG8cZQOX7AI2Qlmcu7h0PjyOPMEZxEQChx7WCgkrJHyBG2nHl7I47FgNhzSBbgXwJ
         DxCDK04j5o+p+WMYmnI0NojDl8phJVEIpjOD8QamQXAowX5lJlj6gWu7CZEPm3K1IQCp
         dqf4zry1ebw3ndcBBhsBEUubz9tgOo7T3Yx8KelIOtvk8Rj7TPmfCJW4ihMl2cIhGaWc
         OcVGhFQjs1VQNSKG8GitptOx2c1qCrerfYRgncPuXmtMzjRaU94YOHjmHyVh51HyQgYq
         gEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2e457XKvpaG5Xq82ApBDnFeexB1Oga1MewpSuQInmH4=;
        b=V9oGdnG3oJaE6tn40Bqsn7vUcH3hUQbdBoYqgSaqB+mX0shNrIEsFKNUI2EDsEG+vn
         bp/kkW7SJUroUNx5kPHedU3P7oOYBvfNybnuDT1mjOc2ZFFPz+LDe9gLfq39RQrRW7E4
         cPStxXOV4BVCQe5nnUTYaNLKKomiQy7kdHhv739UY7TbXvpLzzB48Exe9KzEB8HwHas4
         afBXybBOPoeiC+qMYs+NYT2n2wGyzn/JQadeYvX88acpc0/XLbltMdjKKCDQwqfw2/WP
         2ixVXkNor5QEis9+QFEwWeivH13fSydoKAEIFJbaHD7wYmlxXI3C9A3XP3QUw6m7DJKi
         4tIw==
X-Gm-Message-State: AElRT7FZYDQCCuRdcI9ADFvBELBGDn6cEahREKK4eyJirjdnnoPNfQnU
        DFOlF7+AiOVDr4fMxGbEXKk=
X-Google-Smtp-Source: AIpwx4/pO4yqIRhQcqCjcc0AGqesRGI/PrsPuCVCCI8aAQtPqtIMV08xWrmYqkvN56dhoMh1FcEAhw==
X-Received: by 10.223.210.12 with SMTP id g12mr9380080wri.131.1522417930881;
        Fri, 30 Mar 2018 06:52:10 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id u44sm12543341wrb.67.2018.03.30.06.52.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 06:52:09 -0700 (PDT)
Date:   Fri, 30 Mar 2018 14:55:37 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/6] worktree: remove force_new_branch from struct
 add_opts
Message-ID: <20180330135537.GB2629@hank>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
 <20180325134947.25828-4-t.gummerer@gmail.com>
 <CAPig+cQQUbBihLeBRemLHnx42E9b_qUt-mKgDyRRy0-UQTYBKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQQUbBihLeBRemLHnx42E9b_qUt-mKgDyRRy0-UQTYBKw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/27, Eric Sunshine wrote:
> On Sun, Mar 25, 2018 at 9:49 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > The 'force_new_branch' flag in 'struct add_opts' is only used inside the
> > add function, where we already have the same information stored in the
> > 'new_branch_force' variable.  Avoid that unnecessary duplication.
> 
> When I was reviewing your original dwim-ery series (inferring 'foo'
> from 'origin/foo'), I noticed that 'struct add_opts' had accumulated a
> number of unnecessary members over time, including this one. My plan
> was to submit a patch removing all those pointless members after your
> dwim-ery series settled, however, I never got around to it.

Ah right, I didn't look at them in detail, so I failed to notice that.
While I'm already in the area I may as well do that, thanks for the
suggestion!

> This patch might be a good opportunity for doing that cleanup
> wholesale, removing all unneeded members rather than just the one. (If
> so, you'd probably want to move to this patch to the front of the
> series as cleanup before the meatier changes.) Anyhow, it's just a
> thought; feel free to respond with "it's outside the scope of this
> series" if you're not interested in doing it.
> 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
