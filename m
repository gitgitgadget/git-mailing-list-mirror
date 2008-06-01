From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 1/3] Remove unused remote_prefix member in builtin-remote
Date: Sat, 31 May 2008 23:57:48 -0400
Message-ID: <20080601035748.GA32176@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 05:59:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2eit-0004ep-1O
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 05:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYFAD5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 23:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754127AbYFAD5w
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 23:57:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:41538 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbYFAD5w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 23:57:52 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K2ehO-00050W-25; Sat, 31 May 2008 23:57:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 848E920FBAE; Sat, 31 May 2008 23:57:48 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83427>

Not sure when this became unused, but no code references it,
other than to populate the strbuf with an initial value.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-remote.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 99a34df..c76fe2e 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -206,7 +206,6 @@ static void read_branches(void)
 
 struct ref_states {
 	struct remote *remote;
-	struct strbuf remote_prefix;
 	struct path_list new, stale, tracked;
 };
 
@@ -262,8 +261,6 @@ static int get_ref_states(const struct ref *ref, struct ref_states *states)
 	}
 	free_refs(fetch_map);
 
-	strbuf_addf(&states->remote_prefix,
-		"refs/remotes/%s/", states->remote->name);
 	for_each_ref(handle_one_branch, states);
 	sort_path_list(&states->stale);
 
-- 
1.5.6.rc0.158.g7c7a1
