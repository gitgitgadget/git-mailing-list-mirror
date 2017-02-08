Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15E411FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 14:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754680AbdBHOR5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 09:17:57 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:28436 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753928AbdBHOQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 09:16:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 50F261E2E8F;
        Wed,  8 Feb 2017 14:23:10 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 74EbFzGK0BcL; Wed,  8 Feb 2017 14:23:10 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id F1E5A1E2E23;
        Wed,  8 Feb 2017 14:23:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GzTm-1ivD0g4; Wed,  8 Feb 2017 14:23:09 +0100 (CET)
Received: from [192.168.178.77] (46.128.140.114.dynamic.cablesurf.de [46.128.140.114])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id AE7171E1877;
        Wed,  8 Feb 2017 14:23:09 +0100 (CET)
Subject: Re: [PATCH 2/2] pathspec: don't error out on all-exclusionary
 pathspec patterns
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>
References: <alpine.LFD.2.20.1702072113380.25002@i7.lan>
Cc:     Git Mailing List <git@vger.kernel.org>
From:   Cornelius Weig <cornelius.weig@tngtech.com>
Message-ID: <35bd1d35-4cb8-cf40-38ee-7442efc0f139@tngtech.com>
Date:   Wed, 8 Feb 2017 14:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.20.1702072113380.25002@i7.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Again, as Duy pointed out this should be documented.

How about something like this:

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index f127fe9..781cde3 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -387,7 +387,9 @@ Glob magic is incompatible with literal magic.
 exclude;;
        After a path matches any non-exclude pathspec, it will be run
        through all exclude pathspec (magic signature: `!` or `^`). If it
-       matches, the path is ignored.
+       matches, the path is ignored. If only exclude pathspec are given,
+       the exclusion is applied to the result set as if invoked without any
+       pathspec.
 --
 
 [[def_parent]]parent::
