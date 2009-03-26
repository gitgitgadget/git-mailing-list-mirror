From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/10] refs: add "for_each_bisect_ref" function
Date: Thu, 26 Mar 2009 05:55:09 +0100
Message-ID: <20090326055509.1bc16b28.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 05:57:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmhey-0003eW-46
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 05:57:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217AbZCZE4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 00:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZCZE4O
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 00:56:14 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:38765 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751994AbZCZE4N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Mar 2009 00:56:13 -0400
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id C55174B0019;
	Thu, 26 Mar 2009 05:56:01 +0100 (CET)
Received: from localhost.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp2-g21.free.fr (Postfix) with SMTP id A9F114B0009;
	Thu, 26 Mar 2009 05:55:58 +0100 (CET)
X-Mailer: Sylpheed 2.5.0 (GTK+ 2.12.12; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114725>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 refs.c |    5 +++++
 refs.h |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 8d3c502..2b21148 100644
--- a/refs.c
+++ b/refs.c
@@ -662,6 +662,11 @@ int for_each_remote_ref(each_ref_fn fn, void *cb_data)
 	return do_for_each_ref("refs/remotes/", fn, 13, 0, cb_data);
 }
 
+int for_each_bisect_ref(each_ref_fn fn, void *cb_data)
+{
+	return do_for_each_ref("refs/bisect/", fn, 12, 0, cb_data);
+}
+
 int for_each_rawref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0,
diff --git a/refs.h b/refs.h
index 29bdcec..e5d6e80 100644
--- a/refs.h
+++ b/refs.h
@@ -23,6 +23,7 @@ extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
 extern int for_each_branch_ref(each_ref_fn, void *);
 extern int for_each_remote_ref(each_ref_fn, void *);
+extern int for_each_bisect_ref(each_ref_fn, void *);
 
 /* can be used to learn about broken ref and symref */
 extern int for_each_rawref(each_ref_fn, void *);
-- 
1.6.2.1.317.g3d804
