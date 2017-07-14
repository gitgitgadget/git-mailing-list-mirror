Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C9EC20357
	for <e@80x24.org>; Fri, 14 Jul 2017 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754373AbdGNR1D (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 13:27:03 -0400
Received: from mail.eclipso.de ([217.69.254.104]:59596 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753554AbdGNR1D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 13:27:03 -0400
Received: from [127.0.0.1] (politkovskaja.torservers.net [77.247.181.165])
        by mail.eclipso.de with ESMTPS id 739FF831
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 19:27:01 +0200 (CEST)
X-ESMTP-Authenticated-User: 00022B69
Subject: Re: [PATCH 0/2] Fix regression: CamelCased aliases
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
References: <cover.1500021526.git.johannes.schindelin@gmx.de>
 <20170714090256.ne4gqgppt2qshtak@sigill.intra.peff.net>
 <xmqq60evrqyd.fsf@gitster.mtv.corp.google.com>
 <20170714153015.crklfqaa2qc573zo@sigill.intra.peff.net>
 <xmqqh8yfq8pr.fsf@gitster.mtv.corp.google.com>
From:   astian <astian@eclipso.at>
Message-ID: <1d79b017-38b3-e1cb-a4bf-1153dc4fdbca@eclipso.at>
Date:   Fri, 14 Jul 2017 17:26:00 +0000
MIME-Version: 1.0
In-Reply-To: <xmqqh8yfq8pr.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

FWIW, I don't like 2, I don't like the irregularity in the invocation:

  $ git branch
  * master
  $ git BRANCH
  git: 'BRANCH' is not a git command. See 'git --help'.
  $ git config alias.br 'branch -v'
  $ git br
  * master 51c785c initial
  $ git BR
  * master 51c785c initial

There is also this:

  $ git branch
  * master
  $ git BRANCH
  git: 'BRANCH' is not a git command. See 'git --help'.
  $ git config alias.branch 'branch -v'
  $ git branch
  * master
  $ git BRANCH
  * master 51c785c initial


