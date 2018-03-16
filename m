Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 235331F404
	for <e@80x24.org>; Fri, 16 Mar 2018 17:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeCPR1N (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 13:27:13 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39564 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbeCPR1L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 13:27:11 -0400
Received: by mail-wr0-f194.google.com with SMTP id c24so656721wrc.6
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 10:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Ek1cNNXGlprko4tEJQQUK7k4CknqLylWTvOoK2dZeGA=;
        b=nil22Uuv5c/X1Em+XYROFQYuSTuqZs+uPOcKsIWr4eyVmMIBVl5yc/E9NPnPy4eyGz
         d/s04DujNcycHPhTNvAMupOeNTar/aV5rrRo0bnGTjJ+GGIeLVL84G3BTNeM202i9mZF
         Xyz2sxc3+e6vg8SD9E97Y5DVI55POm+rh5tHGwzRWorXT7n8blqdw1qbf+evwF54/LAn
         IUDjeQy38s0vZnSSrXupSY+j0N07hS6Od6hVWpPeRf4MyNXBUrOlNmvY6cwJeoSM9XXK
         SX3dSP3LCZjwagJhjzX+kuTlCYQGmpSEpyj+5eOqpMl/GGqEN8ZkEFyx5lcZDqNGWv0h
         fKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Ek1cNNXGlprko4tEJQQUK7k4CknqLylWTvOoK2dZeGA=;
        b=HPvHnFTtrAwxlb4VX7OKtA0NJBTLpQ9zYJBN8trEvE/z9P0XW37lwTEj7fou1iQalX
         /ZuDnNRkswUg87qWJE+4oeHdtobNHrNFQcaibBqIWeaFKd80sTtjclGR00GbCFCCDw/0
         WIE5OF3Vuo4dKNCxevGfUUPgTaEyjVSINy1yu7j1LCD763BRm2+KRIzuDuhzBI7lI/o3
         SjCPGbIjc7CgQyU+PJaV40gdV9fnEvuMiSQO2y+GIjAQ7mbgNglFIDEpz2YglKo7c1DJ
         HQYWgq8rVU6+yHenbSQgBGFkOzerWVatIfwOW8zQHaovbs+NCIutNN/PZe3YDkkE1MNZ
         +FaQ==
X-Gm-Message-State: AElRT7EZnAhV6csyrSG77h0BEWNsfjVBiIngmS9RYvptNSArGpo3vAJU
        M+KBHdo6sHzKJVAiq+ZVWEA=
X-Google-Smtp-Source: AG47ELsUeuasJ3cJkKUNwky+ugPG+k9y/iebHzYoxufzA07+cx6DQoGcEKSCnyrppgllaQZXaLq5gw==
X-Received: by 10.223.173.207 with SMTP id w73mr2497633wrc.234.1521221229084;
        Fri, 16 Mar 2018 10:27:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y6sm6649529wmy.16.2018.03.16.10.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 10:27:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, git@jeffhostetler.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
        <20180314192736.70602-1-dstolee@microsoft.com>
        <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803151821270.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <xmqq37115ggs.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1803161249060.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Fri, 16 Mar 2018 10:27:07 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1803161249060.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Fri, 16 Mar 2018 12:50:59 +0100
        (STD)")
Message-ID: <xmqqpo442aok.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > Stolee, you definitely want to inspect those changes (`git log --check`
>> > was introduced to show you whitespace problems). If all of those
>> > whitespace issues are unintentional, you can fix them using `git rebase
>> > --whitespace=fix` in the most efficient way.
>> 
>> Another way that may be easier (depending on the way Derrick works)
>> is to fetch from me and start working from there, as if they were
>> the last set of commits that were sent to the list.  "git log
>> --first-parent --oneline master..pu" would show where the tip of the
>> topic is.
>
> That is not really easier. We had that discussion before. Stolee would
> have to remove your Signed-off-by: lines *manually*.

In return, all the whitespace fixes (and other fixes if any) I did
on my end can be reused free by the submitter, instead of having to
redo it *manually*.

If a reroll of the series does not touch one specific commit, that
commit can be left as-is; I do not see a need to remove anybody's
sign-off or add yet another of your own, if the last two sign-offs
are from you and your upstream maintainer, if you did not change
anythning in what you got from the latter.  This depends on what
tool is used to work on refinement, but with "rebase -i", you'd
leave "pick" as "pick" and not "edit" or "reword" and it would do
the right thing.

If you did refine, you get an editor when you record that
refinement, so it is just a few key strokes, either "dd" or \C-k, to
do that removal *manually*.  So I am not sure why you are making a
mountain out of this molehill.

If you do want to remove the last two sign-off (i.e. penultimate one
by the author done during the initial submission, plus the last one
by me), well, "rebase -i" is open source.  We can add features to
the tool to help everybody collaborate better.  Extending changes
like planned addition of --signoff by Phillip, it is not all that
far-fetched to add a mechanism that notices a project-specific
trailer rewrite rules in-tree and uses that in between each step to
rewrite the trailer block of the commit message, for example, and
the rule

> I understand that it is a trade-off between time you have to spend and
> that others have to spend, and since you do not scale, that trade-off has
> to be in your favor.

That tradeoff may exist, but it does not weigh in the picture above
at all.

Perhaps it is better to try to actually think of a way to work
together better, instead of just whining.
