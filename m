Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DD4C1F404
	for <e@80x24.org>; Sun, 18 Mar 2018 18:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754324AbeCRSVq (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Mar 2018 14:21:46 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:40189 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeCRSVp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Mar 2018 14:21:45 -0400
Received: by mail-it0-f52.google.com with SMTP id y20-v6so7594480itc.5
        for <git@vger.kernel.org>; Sun, 18 Mar 2018 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=EH5sOJ76WNYRTaIsdYMlumusVkDWcyjSQEZuJXFpK2I=;
        b=HZl9/SCqGAq6foL2aKFE1nhwG83Ju1aLPJCBPzadUoahj2GKmorwLjKAURYt7RdYTy
         4WAqNd8e8AquB6E0Vmt/WfZ9BZum8zIrbJr0hyH683fMs/YnVsQXBj/NhsOgPqzamowJ
         6p/VhLMEPUYtAGysNqioeLpz46VLHtuORNAzaS0oVs1mZOvnUDT0dKHYftRUmDbEL8J9
         bHI0WpMFcnqzPZa6WP3b7OBk6qe8DaEAFjaJE81gTToT9GVyQVo7JpG82kFOr0nuiQ3r
         hPsRwUZRBdwiGn6OYRxAzx5qV68x9Chqf+IOuAwkqox8SOr/C/ho6xHj44nrZY9+OepZ
         684w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=EH5sOJ76WNYRTaIsdYMlumusVkDWcyjSQEZuJXFpK2I=;
        b=UKv6N/KSOLa5/+jETCm0Pobw6j9lRPBoCdoluJ4N+NuPV6Y5O2bchT54qx/9V9k51Z
         GkFtjBbGRuLDNxQv4mkPJ5pOVFekLqCq4wxvX7K9PQYMGd79JYNWFUgJtO7PH2ZLTWF2
         xKAGV1oh+K+dRzsvnS4ajRW753kDtuMz40MWzNCgylWJlyYovY4B7ZZC+gL95tWo14Py
         Kdi047CCOoPRZbXssBI1/OvIEHIAB/sChkddLNo2gHfXJzEQWGPTwgh7h+aXYF2/znJU
         MtgO3FbipXppeoUX8owHK3YZVPZMC4Q3uJb3rJf2RYQOfBhqvFy9JeZiGrnECP9dEbNh
         P1LA==
X-Gm-Message-State: AElRT7Fps3jUokQoRNs0wrrUl4ZIWgqThflqmLTY0W/z5grTmIaDVa25
        Tr9GZiuTvZ4zfZFTc7lJfhsQ3fXjadMO0FWDpQnnYXJ6
X-Google-Smtp-Source: AG47ELsDwu+iv4cPXOf5IfvCdE1g3mqXydQwsseEBvt/IxxQ/c+QQGHZSypHve5W9FGhRhfeWIJABUz6LVW6zavMoDA=
X-Received: by 2002:a24:9794:: with SMTP id k142-v6mr6170181ite.40.1521397303726;
 Sun, 18 Mar 2018 11:21:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Sun, 18 Mar 2018 11:21:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 18 Mar 2018 19:21:43 +0100
Message-ID: <CAP8UFD35QP0jwQ22jfUaNgo92o3vG8bV5n=iYnmn1ichxndphg@mail.gmail.com>
Subject: Draft of Git Rev News edition 37
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        William Chia <wchia@gitlab.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-37.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/279

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Gabriel and me plan to publish this edition on
Wednesday March 21st.

Thanks,
Christian.
