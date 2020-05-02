Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A95C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22A62075B
	for <git@archiver.kernel.org>; Sat,  2 May 2020 18:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588445311;
	bh=ghuKwEONJTBfj5U6kOgpoFkyF0eqbqS43dPxMAARjCY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CCdQH3CoXcFZyu4D0skdvsvXgs3/P/GSlUAtpeaJdeNAfVgRgEBWbS+E/rQK2lMPd
	 3v1OCECT5NpSzre/qbrkjb9w+W6cLFH6S82TT9x+S8ZRkYPcqLR+fWLpiGiLr4fl8z
	 Ujb2B4zaXD6tb9bCYFwInkE0gM864Fx0plOkcIQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgEBSsa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 14:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbgEBSsa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 14:48:30 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA452206CD;
        Sat,  2 May 2020 18:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588445310;
        bh=ghuKwEONJTBfj5U6kOgpoFkyF0eqbqS43dPxMAARjCY=;
        h=From:To:Cc:Subject:Date:From;
        b=SM679T9Jr4gj0tvVNNhDnuawAmTuMbiLnMrRZBdUeIHNRG2vfX3CKRV2Qy0jXukC4
         09/wOt8+d24TdXFLO4WrdH078d4CNgMdtNHjuaFd5EM/jz8xS3Q0s3UTwU9iEkSB3u
         VgPVGbcSnZYbYNMKPOpT7I9mh0eo4oVJX9gNRDfw=
From:   Wolfram Sang <wsa@kernel.org>
To:     git@vger.kernel.org
Cc:     Wolfram Sang <wsa@kernel.org>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: [PATCH RESEND tig 1/2] Document how to use pipes and redirection with 'bind'
Date:   Sat,  2 May 2020 20:48:24 +0200
Message-Id: <20200502184825.26707-1-wsa@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When my bind command using a pipe did not work, I grepped through the
docs for 'pipe' and 'redirection' with no results. Only after I found
out in the issues tracker that it was intentional, then I noticed the
solution in the examples, too.

Add a paragraph to make it more explicit.

Signed-off-by: Wolfram Sang <wsa@kernel.org>
---

This time with proper CCs. Sorry for the noise!

 doc/tigrc.5.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/doc/tigrc.5.adoc b/doc/tigrc.5.adoc
index 630e8f6..1aa8085 100644
--- a/doc/tigrc.5.adoc
+++ b/doc/tigrc.5.adoc
@@ -690,6 +690,9 @@ console output shown (as if '!' was specified). When multiple command options
 are specified their behavior are combined, e.g. "?<git commit" will prompt the
 user whether to execute the command and will exit Tig after completion.
 
+Note that if you want to use pipes or redirection in your commands then you
+must run them in a subshell, i.e. embed your commands in `sh -c '<commands>'`.
+
 Browsing state variables
 ^^^^^^^^^^^^^^^^^^^^^^^^
 
-- 
2.20.1

