Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A89051F403
	for <e@80x24.org>; Sun,  3 Jun 2018 12:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751062AbeFCMYV (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 08:24:21 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:55046 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeFCMYU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 08:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZbP0G4yjvD13m6cn8nD1+poeNwI4pRb4N1me/OZKeGw=; b=Wwlm3vmmuEBfJ6hPVAS2XXsQdS
        dfWued6/1e9Z9OFqxzJ/eXWKOrrmPXguH0Q3AymRs/MNmhJxTvUllAXWWh19cjiXheSAtjYmfcLeN
        oF8zPiU/ogiTWcXppCsa5wWWAFu3iDjNuGPTT3gwbdsd27buAaXjuEZN49VWpv4EGSEKrzYzqqhtj
        okc0LlbIzaDV/O96tF7w9PIRmlVOOqdfKtuWXoSq6gsYw/YaGD1gC3BfqLWqbMKmHWR+q42UV13Bt
        CI+OWmbAdxJdWaW20qi/RKoJMX02FXWxq7XOL6hY8RBU7rIEQbQGXhvQkYiN3ECN1x87Z36XYSb5M
        wPajJXpQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:60080 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fPS3V-004Zwl-D3
        for git@vger.kernel.org; Sun, 03 Jun 2018 08:24:18 -0400
Date:   Sun, 3 Jun 2018 08:22:11 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] sha1-file.c: Correct $GITDIR to $GIT_DIR
Message-ID: <alpine.LFD.2.21.1806030820180.14575@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix single misspelling of $GITDIR to correct $GIT_DIR.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

only occurrence in entire code base that i ran across, so i figured
might as well fix it.

diff --git a/sha1-file.c b/sha1-file.c
index 555e780f4..695e5c627 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -610,7 +610,7 @@ void add_to_alternates_memory(const char *reference)
 /*
  * Compute the exact path an alternate is at and returns it. In case of
  * error NULL is returned and the human readable error is added to `err`
- * `path` may be relative and should point to $GITDIR.
+ * `path` may be relative and should point to $GIT_DIR.
  * `err` must not be null.
  */
 char *compute_alternate_path(const char *path, struct strbuf *err)


-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
