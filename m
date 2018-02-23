Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69EF01F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeBWVZN (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:25:13 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38062 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751527AbeBWVZM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:25:12 -0500
Received: by mail-wm0-f68.google.com with SMTP id z9so6912419wmb.3
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/IZcje+zeL0Y/EjmkPwhHaLp8eTNBT8bezSbVzn0nN8=;
        b=aK3FI6todq6VwjB3D0XVW9g3Z6KUTMCCfPnA/woPEiIE7KbSQHVARzvWVvk2Xi07GF
         ZyydwI4Iuz01veoXYycsUKtNBWORLuJ40DxsUyD1UODcoemeWC8VHYD9Pc/AC4GFp+Be
         hWQi+JSDcdJhyVMxLilUqzI13Ac0qSJx9HvJxoawa+h0xLJ8vtWLsbo4c0eVgc4yTuu7
         twvbisnVoLkvuVODJ3wOEADPIaeEfzRtK0V2FEnY0cpQgGXfREV0vN7fRpPlZRN4Jsff
         VP/RfaGQfW27ThUweocrMF45m4MQV3p9SX6SgAsLNxxfIgED8TvsjyxfoOtWYNtCVi9e
         ypQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/IZcje+zeL0Y/EjmkPwhHaLp8eTNBT8bezSbVzn0nN8=;
        b=Oeca177ShDZdIad9O9wXZseOTvokrZtPdo1gBh4U/JZBYFu6YbfdBkOKmXcO4154Xv
         vtQk5mEou1qLKs3ZZnW5pDIgLKcdqUSj712g6uaWmqsnb0zpXoqwmN4jPFOSn08r/1vY
         zBr/lGO6y9LtnOcMsDySgTBrbN8gr2sSPK6PFdfoLDAjnfTQz26NJYtoeAMGke9pUqYX
         xqpXPyhArcDSF1XvrZO9UjobIQAmcx0TwVHDak+vaYf87S77bg0HwcLiOiAckMqIicKr
         k4php0L9SzWKkKBvnh6aD9CCQoUVVcA1ekkiZwgcyQ+ZaZd7xowH6ETNbP2Ngt4Y9JX2
         ZqsA==
X-Gm-Message-State: APf1xPADo14GixCZ/NdHjtxZqW+mSTJiVLO+oBtE5AMOwr2D3LSro6wr
        qhzwwvg4/wg1ftYP3yMdenM=
X-Google-Smtp-Source: AG47ELtyp5qxRkI6vTPF2Ryvv7FxMoFluLtWr3emPE5MA5gPB+7RWdBzv0oCGtqJXcFlKWM6VFrWng==
X-Received: by 10.28.164.195 with SMTP id n186mr2970944wme.149.1519421110444;
        Fri, 23 Feb 2018 13:25:10 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z73sm3328342wmc.3.2018.02.23.13.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 13:25:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     paul@mad-scientist.net, Git mailing list <git@vger.kernel.org>
Subject: Re: Git "branch properties"-- thoughts?
References: <1519324188.6391.156.camel@mad-scientist.net>
        <2607f7e8-b680-50ac-0c08-7abc35499f1d@talktalk.net>
Date:   Fri, 23 Feb 2018 13:25:09 -0800
In-Reply-To: <2607f7e8-b680-50ac-0c08-7abc35499f1d@talktalk.net> (Phillip
        Wood's message of "Fri, 23 Feb 2018 11:22:58 +0000")
Message-ID: <xmqqo9kfs8ju.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

> It would certainly be nice to be able to share branch descriptions so
> that if I clone a repository I can get a bit more detail about the ideas
> behind each branch. Shared descriptions could be displayed in web uis. I

One thing to note is that there is no universal identity for
branches across repositoryes that push and pull from each other.  My
'refs/heads/master' may be copied to your 'refs/remotes/origin/master'
so in that sense, any "branch property" I give to my 'master' branch
(including the 'branch.master.description') could be copied to its
corresponding "remote-tracking branch property" you have, but that
is the easy part.

It is quite hard to figure out how these branch properties you
acquired from me on my branches affect properties of _your_ own
branches that build on top of the branches you obtained from me.

Perhaps a narrow special case of two or more people collaborating on
a single topic branch with the same focus would be helped by blindly
sharing the "branch property" across the local and remote-tracking
branches that share the same name.  I.e. the shared repository may
have 'optimize-frotz' topic branch, you and your friend both copy to
your 'refs/remotes/origin/optimize-frotz' remote-tracking branch,
and these copies will share the same "branch properties" copied from
the shared repository.  Then if you and your friend both work on the
topic by "git checkout -b optimize-frotz origin/optimize-frotz",
perhaps your and your friend's optmize-frotz branch would inherit
the same "branch properties" copied from their upstream.  Because
all of the participants are focused on a rather narrow task of
"optimizing the frotz feature" on their branches that share the same
name, pretending as if these are "logically" the same branch, and
enforcing that by sharing the "branch properties", may make sense.

But for a generic branch like 'master', that arrangement would not
work well, I am afraid.  You may have N copies of the same project,
where the 'master' branch of each is used to work on separate topic.
The focus of the 'master' branch of the overall project would be
quite different from each of these copies you have, hence it is
likely that it would be inappropriate to share the task list and
stuff you would want to add to branch descriptions and branch
properties between the shared repository's 'master' and any of your
'master' in these N copies you have.

So...
