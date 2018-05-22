Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C20B200B9
	for <e@80x24.org>; Tue, 22 May 2018 07:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeEVHtt (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 May 2018 03:49:49 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:43754 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeEVHts (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 May 2018 03:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hp/dnEBpun+oOPMKjvhpa4LmkshFIDzH08O5WKvYg7U=; b=aK2w1jyKEKojv0mBuJNhLdAOfJ
        h9VnNP38eFFQFUu4jbJtEWj4WIHqnUI7MYxmVKjiU5GOPs6g9SsDkx60miS2TQ4BXp9x/0dc8+Vs8
        UftAXVT6P7mHaZNKBAOHF4sfaDGyA0suqwOKQAfS9L7kYnbtk2NevZvrpE6vXZBV3QGzzeCWdOmx4
        Risy89dsPJHtGnsQRV5U/r3HpG5UOqicq7XnXAHE+tJtPb3wiJDeyyGE5JPYTNeVUCm0YocpMWKCq
        ZV/+UhyEPRHSYkdR4SYoGApOsjhJdZ88FaW4Ov42AKLTzUrW6/dKRIN5xhidDZ6DswX9AKsyadJdK
        GzqHHVdw==;
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:55300 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fL23F-002eoz-5p
        for git@vger.kernel.org; Tue, 22 May 2018 03:49:46 -0400
Date:   Tue, 22 May 2018 03:48:13 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] Doc: Mention core.excludesFile in "man git-clean"
Message-ID: <alpine.LFD.2.21.1805220345150.749@localhost.localdomain>
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


Add a reference to the configuration setting "core.excludesFile" to
the man page for git-clean.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index 03056dad0..449cbc2af 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -55,13 +55,15 @@ OPTIONS

 -e <pattern>::
 --exclude=<pattern>::
-	In addition to those found in .gitignore (per directory) and
-	$GIT_DIR/info/exclude, also consider these patterns to be in the
-	set of the ignore rules in effect.
+	In addition to patterns found in any of .gitignore (per directory),
+	$GIT_DIR/info/exclude and the exclude file specified by the
+	configuration variable core.excludesFile, also consider these
+	patterns to be in the set of the ignore rules in effect.

 -x::
 	Don't use the standard ignore rules read from .gitignore (per
-	directory) and $GIT_DIR/info/exclude, but do still use the ignore
+	directory), $GIT_DIR/info/exclude and the exclude file specified
+	by core.excludesFile, but do still use the ignore
 	rules given with `-e` options.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
 	conjunction with 'git reset') to create a pristine

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
