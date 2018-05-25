Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CACC1F51C
	for <e@80x24.org>; Fri, 25 May 2018 09:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965532AbeEYJrH (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 05:47:07 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:59778 "EHLO
        cpanel4.indieserve.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965491AbeEYJrG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 05:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crashcourse.ca; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lCjVw6mCIWWc+1G3AuuBT8RgP9QmySk7pK1mbfI4wf4=; b=P+EoPlfhwd2QdVznDA+OUFOVhS
        ov4DZiOecKs2cdoA0cjfTDk9ZrdB22Ui52CvN2NedASe7W7vfF0fmkUh2AbqTNOEqHkIuzt7P+iXC
        agyeIucULIPzo0j6KLZ5AkW6u0By4Z5Q4nEQD0sGKM0RWcMNCe49CMndwxjWUESlHXCnEK1G9cfWZ
        sUdKVl6OMOAae17xNnRUJfdxkrKdSCmHNUOrrruZTZO0uh6Z88vUWcFZ3asnz3NsqB6VZ1qgNzR+A
        PXOxeuI94bCpd/DzqoGwe/5mx9xVR/TcTxIIHrRkGlzrzp39w/a7uhZRy5leP94UM+naBRGQZ4hx2
        WcATdFzQ==;
Received: from cpeac202e043973-cmac202e043970.cpe.net.cable.rogers.com ([174.112.22.87]:44449 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1fM9JP-0012Wk-VJ
        for git@vger.kernel.org; Fri, 25 May 2018 05:47:05 -0400
Date:   Fri, 25 May 2018 05:45:09 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Git Mailing list <git@vger.kernel.org>
Subject: [PATCH] Clarify that a tag can refer to a non-commit object
Message-ID: <alpine.LFD.2.21.1805250543230.8587@localhost.localdomain>
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


Reword "man git-tag" to clarify that a tag can refer directly to an
arbitrary object, not just a commit object.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 1d17101ba..87c4288ff 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -34,8 +34,8 @@ in the tag message.
 If `-m <msg>` or `-F <file>` is given and `-a`, `-s`, and `-u <keyid>`
 are absent, `-a` is implied.

-Otherwise just a tag reference for the SHA-1 object name of the commit object is
-created (i.e. a lightweight tag).
+Otherwise, a tag reference that points directly at the given object
+(i.e., a lightweight tag) is created.

 A GnuPG signed tag object will be created when `-s` or `-u
 <keyid>` is used.  When `-u <keyid>` is not used, the

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                  http://crashcourse.ca/dokuwiki

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
