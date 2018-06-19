Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26AA61F403
	for <e@80x24.org>; Tue, 19 Jun 2018 18:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966703AbeFSSC3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 14:02:29 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45712 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966551AbeFSSC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 14:02:28 -0400
Received: by mail-ot0-f195.google.com with SMTP id a5-v6so660919otf.12
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 11:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ARBu+tgOCNJ6CLhh56uzijG5zq0UGOJmbcYFq04U9Ds=;
        b=QoR1Z4GqQPHewhDzbWmijLFk7qt4ODdnzq7qHICPSMPQ5lcepi2QVH6Pjl90pj9klh
         9MzFVzi7eg9DRWiTl68W7PvURUVmcjO5IxJ1uiPQEK5AKsLyOdIEYtZePnfiBpyt/oy5
         C5u9GetzXxQv3nQHXTq4NqB0IA5eX+JOZ/ACIl8dfxZDqvQbTn/a3+zwUkdvcaVj/PEY
         6Jthkgx8Bo4ETtYfYJVN4Rh2cmcneDwCkd1RiwYonEM2Nu61BPStUbBFOUexelTYOAQb
         EluAR/nnUzCNCxX+XKlbqgYFX9GSZPoI5+81dxUJDMr8i5Zs9KYgBMfsJA5yX7SCfoxq
         SjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ARBu+tgOCNJ6CLhh56uzijG5zq0UGOJmbcYFq04U9Ds=;
        b=mQLK0uNYb/AXbedzckTIZ8t7I3Aj2mb1RbXt4mSikR6OrF8QUXh0dMye5lmyYEUGNU
         g2b8rNgQbSmt9VN44LeyAby2llk7HgMEoOgkOWeaUYjOj2fajcWwQ7tluM1aZG1zjjed
         IxUd7k1WwWaCtALRG4d48xbCL9TTKgk/YtuU51Zrws1u5TF74UAU+Z0pyS+DIzpFeVoY
         ud7bPQeftV44AH6aV7GUjmWv8ahYr5esnV1/txDL80buNFw98D/owv71uIFxfttGyVco
         8RmIk0rs0IKaLYz6CG6x+1KH5epEOwWoBscFOUZv56GZBwQ2C2p667IULmUgLJ7pxW7E
         bzNg==
X-Gm-Message-State: APt69E2XUgqFkbfbYNrXWGdHLf8fCfsoJ9tUlAUZ6mgbXlhF4Ymfh/Li
        EiUvql7eNnlLFtCyuh9rO7jCYA==
X-Google-Smtp-Source: ADUXVKImnW3h1QoWWy+WN5Z63l99KfYrvRo1QEhdYlB36xD5atRm56zYu0KQ9fyVd/3EN8eJbQo9yw==
X-Received: by 2002:a9d:7391:: with SMTP id j17-v6mr10058071otk.169.1529431347445;
        Tue, 19 Jun 2018 11:02:27 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id v50-v6sm320407otd.7.2018.06.19.11.02.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 11:02:26 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Tue, 19 Jun 2018 13:02:25 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619180225.GA50589@syl.attlocal.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
 <20180619174846.GA27820@sigill.intra.peff.net>
 <xmqqo9g6vet5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqo9g6vet5.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 10:58:30AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
> > Although there are interesting cases around inversion. For example:
> >
> >   git grep --not \( --not -e a --and --not -e b \)
> >
> > is equivalent to:
> >
> >   git grep -e a --or -e b
> >
> > Do people care if we actually hunt down the exact column where we
> > _didn't_ match "b" in the first case?  The two are equivalent, but I
> > have to wonder if somebody writing the first one really cares.
>
> I may be misunderstanding the question, but I personally would feel
> that "git grep --not <ANYTHING>" is OK to say "the entire line is at
> fault that it did not satisify the criteria to match <ANYTHING>".
> I.e., I'd be happy if --column marked the first column as the
> beginning of the match, or --color painted the entire line in the
> output of the former.

I think that Peff is pointing out that a short-circuiting OR will cause
a line like

  b foo a

to print the column for "a", not "b" (when given "-e a --or -e b").

Thanks,
Taylor
