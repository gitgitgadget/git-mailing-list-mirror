From: Dan McGee <dpmcgee@gmail.com>
Subject: [PATCH 2/5] tree-walk: drop unused parameter from match_dir_prefix
Date: Wed, 30 Mar 2011 20:37:58 -0500
Message-ID: <1301535481-1085-2-git-send-email-dpmcgee@gmail.com>
References: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Cc: Dan McGee <dpmcgee@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 03:38:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q56q4-0003MT-05
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 03:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933831Ab1CaBiK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 21:38:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33023 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933827Ab1CaBiI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 21:38:08 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so1864765iwn.19
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 18:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=1Z3R5EgYpUHRI+8HI/+IlBsKeHaqSe9PH4loEhLSwpw=;
        b=wlgAQ4WOo/msIxNIwcfl1F+unphANrWB4Bs38XcPbCkb4mM7mcLPobDhi0lop0r94F
         NUnNC3dFFONamviZ/IsxvIUi/tvbwu5NBnpjOtRYAZ+CoQ/qnwZjZjlRfY3iVoEZTBgT
         NsbpouTbb0BmmKqVS/ftoIwW4U7b71Bf4zak4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DpyncnEteB0tlc8zBDhrtt4cSJnG53U39+7dZKeu8KT71w9Bj4hkk+YvPuzilxh+U3
         I/V9Swfluthv1ywWdAMhzbW4z8yVOxDcIHssW9qo+RjyHXgKaG2W3JsfDn6G2QqW3Ilg
         s2rCgOmyepL1M1lQJk43nx1mSWGj4MVFraOX4=
Received: by 10.231.67.213 with SMTP id s21mr2086178ibi.22.1301535487962;
        Wed, 30 Mar 2011 18:38:07 -0700 (PDT)
Received: from localhost (c-71-239-242-45.hsd1.il.comcast.net [71.239.242.45])
        by mx.google.com with ESMTPS id o3sm379609ibd.61.2011.03.30.18.38.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 18:38:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301535481-1085-1-git-send-email-dpmcgee@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170440>

Signed-off-by: Dan McGee <dpmcgee@gmail.com>
---
 tree-walk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tree-walk.c b/tree-walk.c
index 322becc..9be8007 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -522,7 +522,7 @@ static int match_entry(const struct name_entry *entry, int pathlen,
 	return 0;
 }
 
-static int match_dir_prefix(const char *base, int baselen,
+static int match_dir_prefix(const char *base,
 			    const char *match, int matchlen)
 {
 	if (strncmp(base, match, matchlen))
@@ -579,7 +579,7 @@ int tree_entry_interesting(const struct name_entry *entry,
 
 		if (baselen >= matchlen) {
 			/* If it doesn't match, move along... */
-			if (!match_dir_prefix(base_str, baselen, match, matchlen))
+			if (!match_dir_prefix(base_str, match, matchlen))
 				goto match_wildcards;
 
 			if (!ps->recursive || ps->max_depth == -1)
-- 
1.7.4.2
