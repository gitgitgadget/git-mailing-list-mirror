From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 4/8] vcs-svn: remove spurious semicolons
Date: Wed, 16 Mar 2011 02:02:42 -0500
Message-ID: <20110316070242.GE5988@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 08:02:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzkku-0006Bw-Hh
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 08:02:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771Ab1CPHCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 03:02:48 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41641 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab1CPHCr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 03:02:47 -0400
Received: by ywj3 with SMTP id 3so542904ywj.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ac+uq47w4qDZUTNMybmW7BKYO14arFJJYdAw/j/3zIM=;
        b=tC+yjhyBcRDM3iuTRRBNWUT7EoB1GMixsCdC+deeS+FRhItaRPoTMEDxJlCEMCEJSC
         do/lX5e6byS84iKJap9QBknaFdBtjsji2IBqWfdWjevuon4CJy1n1ZgHGnhZlkUROUi5
         GO78JpzGhC4Qos3ZwWvTva8RXF55+3mXoq5Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EGtDazzWne56TIzyGnkeLiaHgNEDTlrFRjttX7iaUM1GGS01kNCBncXSFJtrWEgYfY
         cb/Upqh1jPLvan7nWjt/iK5zUjYVmY73PHAUGg9QG8cUG0TDMrmS8mSPKy2pBpZt3krS
         paJL6pB1LMbqJNqDzDGakvnUSD6Kv4+3K8WiU=
Received: by 10.151.78.4 with SMTP id f4mr995968ybl.240.1300258966547;
        Wed, 16 Mar 2011 00:02:46 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id w19sm3370660ybe.10.2011.03.16.00.02.45
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 00:02:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316065256.GA5988@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169112>

trp_gen is not a statement or function call, so it should not be
followed with a semicolon.  Noticed by gcc -pedantic.

 vcs-svn/repo_tree.c:41:81: warning: ISO C does not allow extra ';'
  outside of a function [-pedantic]

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/repo_tree.c   |    2 +-
 vcs-svn/string_pool.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/vcs-svn/repo_tree.c b/vcs-svn/repo_tree.c
index 491f013..207ffc3 100644
--- a/vcs-svn/repo_tree.c
+++ b/vcs-svn/repo_tree.c
@@ -38,7 +38,7 @@ static uint32_t mark;
 static int repo_dirent_name_cmp(const void *a, const void *b);
 
 /* Treap for directory entries */
-trp_gen(static, dent_, struct repo_dirent, children, dent, repo_dirent_name_cmp);
+trp_gen(static, dent_, struct repo_dirent, children, dent, repo_dirent_name_cmp)
 
 uint32_t next_blob_mark(void)
 {
diff --git a/vcs-svn/string_pool.c b/vcs-svn/string_pool.c
index f5b1da8..8af8d54 100644
--- a/vcs-svn/string_pool.c
+++ b/vcs-svn/string_pool.c
@@ -30,7 +30,7 @@ static int node_cmp(struct node *a, struct node *b)
 }
 
 /* Build a Treap from the node structure (a trp_node w/ offset) */
-trp_gen(static, tree_, struct node, children, node, node_cmp);
+trp_gen(static, tree_, struct node, children, node, node_cmp)
 
 const char *pool_fetch(uint32_t entry)
 {
-- 
1.7.4.1
