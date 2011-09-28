From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3] apply: use OPT_NOOP_NOARG
Date: Wed, 28 Sep 2011 19:47:54 +0200
Message-ID: <4E835DCA.5010708@lsrfire.ath.cx>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org> <4E835CFE.7020501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 19:48:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8yEs-00073e-BA
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab1I1RsC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:48:02 -0400
Received: from india601.server4you.de ([85.25.151.105]:55229 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab1I1RsB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:48:01 -0400
Received: from [192.168.2.104] (p579BE384.dip.t-dialin.net [87.155.227.132])
	by india601.server4you.de (Postfix) with ESMTPSA id 66DFC2F816A;
	Wed, 28 Sep 2011 19:48:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E835CFE.7020501@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182352>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/apply.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index f2edc52..872e40a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3831,7 +3831,6 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 	int i;
 	int errs = 0;
 	int is_not_gitdir = !startup_info->have_repository;
-	int binary;
 	int force_apply = 0;
 
 	const char *whitespace_option = NULL;
@@ -3850,12 +3849,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			"ignore additions made by the patch"),
 		OPT_BOOLEAN(0, "stat", &diffstat,
 			"instead of applying the patch, output diffstat for the input"),
-		{ OPTION_BOOLEAN, 0, "allow-binary-replacement", &binary,
-		  NULL, "old option, now no-op",
-		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG },
-		{ OPTION_BOOLEAN, 0, "binary", &binary,
-		  NULL, "old option, now no-op",
-		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG },
+		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
+		OPT_NOOP_NOARG(0, "binary"),
 		OPT_BOOLEAN(0, "numstat", &numstat,
 			"shows number of added and deleted lines in decimal notation"),
 		OPT_BOOLEAN(0, "summary", &summary,
-- 
1.7.7.rc2
