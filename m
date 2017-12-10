Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E821F407
	for <e@80x24.org>; Sun, 10 Dec 2017 20:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbdLJUbW (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Dec 2017 15:31:22 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38571 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752410AbdLJUbW (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Dec 2017 15:31:22 -0500
X-IronPort-AV: E=Sophos;i="5.45,390,1508796000"; 
   d="scan'208";a="304820788"
Received: from orange.lip.ens-lyon.fr ([140.77.14.54])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-GCM-SHA256; 10 Dec 2017 21:31:20 +0100
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
To:     "mqudsi\@neosmart.net" <mqudsi@neosmart.net>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: SSH port ignored when ssh:// prefix isn't specified
References: <0101016042190a3b-091dfab3-e010-4fbe-94e7-739ae3090883-000000@us-west-2.amazonses.com>
Date:   Sun, 10 Dec 2017 21:31:07 +0100
In-Reply-To: <0101016042190a3b-091dfab3-e010-4fbe-94e7-739ae3090883-000000@us-west-2.amazonses.com>
        (mqudsi@neosmart.net's message of "Sun, 10 Dec 2017 20:23:45 +0000")
Message-ID: <q7h9y3mamik4.fsf@orange.lip.ens-lyon.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"mqudsi@neosmart.net" <mqudsi@neosmart.net> writes:

> Basically, while `git clone ssh://git@example.com:2222/path` works, the same
> with the `ssh://` prefix doesn't, and attempts to establish a connection to
> port 22 instead: `git clone git@example.com:2222/path` (I'm not sure what it
> will do with the `:2222` should the connection actually succeed).


I don't see a simple way to distinguish between "I want to connect to
port 22 and access directory 2222/path" and "I want to connect to port
2222 and access directory path". So Git chose for you the first option
(if you replace 2222 with abcd, it clearly makes sense).

-- 
Matthieu Moy
https://matthieu-moy.fr/
