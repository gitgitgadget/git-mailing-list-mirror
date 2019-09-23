Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B24341F463
	for <e@80x24.org>; Mon, 23 Sep 2019 15:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfIWPBq (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Sep 2019 11:01:46 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44865 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfIWPBq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Sep 2019 11:01:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id r16so13132115edq.11
        for <git@vger.kernel.org>; Mon, 23 Sep 2019 08:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=s7DpcJFLBBmWq3MmPL6zVdAFJD0GI1udmN9pjKfUhdk=;
        b=LvglQBX5PvwsfqlgTrchSays5uE6H0l0dc8g/Dq2ksubFFXd8b9GPqZWy8+FrANa+A
         QsB3B612hJkwj9q0LHZy/9O6nsRSk6WVkDMwE40Lgu2bRPMJc/JPn4Iqu+fA0zftNag4
         OB8/jSgUGAjtBmOzc/74R5fmkmLdtgs2CR1VkTdotwR7u7Zp8DAuJNbwDvs0MTqpJYwF
         clCgN739eoNydZxmcMEZCUitYY5k5s8uEGGjhptGzoJzPYIN2kvOx1nmg/hVcMELJSux
         an/0mCbDKQZpXwcoWgiAE0VUckEW7gAdwdliLCDPkTCwk0f6HC9J89QVgdoeR5EVMD7m
         oPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=s7DpcJFLBBmWq3MmPL6zVdAFJD0GI1udmN9pjKfUhdk=;
        b=RQcpsVGeVIqgfb6asjMuDgGqUa3/fJublUWuuvYt1uwV8MZnQ3JxIrHzJI3vx3k+By
         2RM/3pwXLPKgojQUPKwoiqBUDICa1JGyixQjH8EfPTgSXqbzLxheXUPBCjJlZpcwO8+6
         FQPYELdsgx7sQmVvDi/PDCeOf170V6W+fGdEy89WiTd6aQHhFqz6MxrXqo1gfbtSuv1c
         96PLTfrJaxc0E30HrZqDbuQX03T54/K0lBUunqduae7Dt6M6P05nXRTrk6xAqtgz7Ivw
         Oxamdxsdbq22iMNNZkneeyZBny1TSen5Q2PjuXaRLDv/+TsYyYjC/B04HS6VyP6bm1h6
         Fcfg==
X-Gm-Message-State: APjAAAWJ9H7Jb5kiVBr62sC02xFX/UESNwJYu/T3A0s4m6UOOlYUMI10
        CckO2nYyN8FsC9Hos/Li9kUuu77mGsDqdmwW87gccrHeKsY=
X-Google-Smtp-Source: APXvYqyiPOY1v9P+DS6508G/tOSi4N63k2mqdlwFQHBOFZnlB3FmOQc4nyzBsjbqzRQig74mNtaSKGi7B9ONBXw80/U=
X-Received: by 2002:a50:ab0f:: with SMTP id s15mr489584edc.119.1569250904037;
 Mon, 23 Sep 2019 08:01:44 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 23 Sep 2019 17:01:32 +0200
Message-ID: <CAP8UFD3nB_jn=KLp+2WMCzh9uo4HME7tc2Fn4-MqxCM+drydWA@mail.gmail.com>
Subject: Draft of Git Rev News edition 55
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        James Ramsay <james@jramsay.com.au>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Emily Shaffer <emilyshaffer@google.com>,
        Robert Dailey <rcdailey.lists@gmail.com>,
        Bryan Turner <bturner@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-55.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/394

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

In this edition I try to cover a few more topics than usual, though
the articles are shorter. Feel free to improve on any article if you
think that there are important things that could be added to them.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition late on
Wednesday September 25th.

Thanks,
Christian.
