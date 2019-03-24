Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5635820248
	for <e@80x24.org>; Sun, 24 Mar 2019 12:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfCXMyz (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 08:54:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45843 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfCXMyy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 08:54:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id s15so7070491wra.12
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 05:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6yMtHUuRFj4qgMxynsg1bH4wTCBqtvBdMPoEOxR4VNM=;
        b=SKidZdie7mXHUI3p8dSH9uXLx7SMo8ql6Dk7ZpV8mUTYK4lU6qn2ujEZaHJx2QhUCu
         sW89ZHTk5YylybY/sagnqwRQO8ElkgplNExty2MaNSHTo3rugjhRR9tfu/6HI1NILCmc
         Ne2DfN5+Z6n8W43zx9tHPQKsI0bKBihRSOmxKarWWQyE0p/C5gm23Lncq0GilrboViO0
         0lIj7Teo5TqVa1wrX7tvaNgz+xdaeQ7gBz0Ky13O91j/SPYXEetT7fuJAF3f31TDPlI5
         ECfs6kW+HKj6HRW+bVrW6p9EDVeCRSUbnDYil1M8VeKLGog/icygq18c5uVQYXpZrG0G
         gfLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6yMtHUuRFj4qgMxynsg1bH4wTCBqtvBdMPoEOxR4VNM=;
        b=FSxY2GnrH9QyRXmKTpSG0zWijJLWcc6NLOhFtpeIQiYi2c5sw2GbdplKd3pXkVWSMY
         mvKvI/7c2aNtoMdDp/pvKgBjPoVwFF+XkBG+mkxWUbZ7A0q3EclyyqkIO2xyqyNBrg7P
         GbTAVEHStvS+LwFdN4+poHliA1/uouSHfq21x++V9XhI1AJ/i5s+8rXHJmNraV7024X5
         pfZY2Ij5Gfss4aihs7WIpNSxWsCzJbOb3NVYHdUPRuYOh0R9lclc8LGZhdj7D9qBIfHn
         ev150X/5S+onU1/HUzcimmDm5f1STGF76pRBZHpYF5MmxSpmM3Vycop5bHreC+U8f1mc
         VcWg==
X-Gm-Message-State: APjAAAXpHDlieweS1p5i9MARbytpYnlxc5l4NJFFChWpjNaZgSoPg3qJ
        O2u/coCVdF1JKmo9YEwj89s=
X-Google-Smtp-Source: APXvYqzBD4aDoAKtqDH+uH3K7Fe2X61x5SvJFyDRDyB4hFWqUA+LDHcFaFF4yuhsKtCRFKJu+P8aFg==
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr12143196wre.309.1553432092929;
        Sun, 24 Mar 2019 05:54:52 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id 7sm47303794wrc.81.2019.03.24.05.54.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 05:54:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] check-docs: fix for setups where executables have an extension
References: <pull.162.git.gitgitgadget@gmail.com>
        <f06126c3a11119bf6e2a830bbac312f65582387f.1552478212.git.gitgitgadget@gmail.com>
        <20190322184347.GC12155@Taylors-MacBook-Pro.local>
        <nycvar.QRO.7.76.6.1903241055230.45@tvgsbejvaqbjf.bet>
Date:   Sun, 24 Mar 2019 21:54:50 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1903241055230.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Sun, 24 Mar 2019 11:02:27 +0100 (STD)")
Message-ID: <xmqqbm20ph45.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Sharp eyes, and a *very* good point. The double space is actually required
> for this patch to work as intended. I added the following explanation to
> the commit message:
>
>     Note that `$(ALL_COMMANDS)` starts with a space, and that is rather
>     crucial for the `while read how cmd` loop: some of the input lines do
>     not actually have the form `<how> <cmd>`, but only `<cmd>`, therefore
>     `$cmd` evaluates to the empty string, and when we are looking for
>     `* $cmd *` in ` $(ALL_COMMANDS)`, we do find it because the latter
>     starts with a double space.
>     In other words, the double space helps us skip the lines that list
>     only a command.

That sounds more like a bug in the existing set-up even before your
patch (in fact, these lines are probably from 2007 or so, long
before you started touching our top-level Makefile heavily).  If we
want to ignore lines with only one token, I'd rather see it
explicitly done, e.g.

	... generate data ... |
	while read how cmd
	do
		# skip a line with a single token
		case "$cmd" in "") continue ;; esac

		# is $cmd part of the known command list?
		case " $(ALL_COMMANDS) " in
		*" $cmd "*)	;; # skip
		*)	echo ... warning ... ;;
		esac
	done

instead of relying on "if $cmd is empty, then SP + $cmd + SP makes
double space, so let's have double space somewhere in the list of
known commands" cuteness.

Thanks.

