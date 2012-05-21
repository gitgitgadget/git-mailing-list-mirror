From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 4/7] revert: free opts.revs to do a bit of cleanup
Date: Mon, 21 May 2012 16:56:06 +0200
Message-ID: <20120521145610.1911.57879.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:10:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUG3-0003sk-Ui
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab2EUPKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:39 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39682 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab2EUPKh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:37 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6BBC9A62FE;
	Mon, 21 May 2012 17:10:31 +0200 (CEST)
X-git-sha1: f5ecb3495be69aba4654aedd0f9fe6d2fbe4ba64 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198112>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/revert.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/revert.c b/builtin/revert.c
index 82d1bf8..5f82a84 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -217,6 +217,7 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
+	free(opts.revs);
 	if (res < 0)
 		die(_("revert failed"));
 	return res;
@@ -232,6 +233,7 @@ int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 	parse_args(argc, argv, &opts);
 	res = sequencer_pick_revisions(&opts);
+	free(opts.revs);
 	if (res < 0)
 		die(_("cherry-pick failed"));
 	return res;
-- 
1.7.10.2.555.g6528037
