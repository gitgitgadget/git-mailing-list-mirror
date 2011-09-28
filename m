From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] revert: use OPT_NOOP_NOARG
Date: Wed, 28 Sep 2011 19:47:50 +0200
Message-ID: <4E835DC6.2040505@lsrfire.ath.cx>
References: <7v39fhv8se.fsf@alter.siamese.dyndns.org> <4E835CFE.7020501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 28 19:48:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8yEl-0006yQ-U2
	for gcvg-git-2@lo.gmane.org; Wed, 28 Sep 2011 19:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab1I1Rr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 13:47:59 -0400
Received: from india601.server4you.de ([85.25.151.105]:55228 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753517Ab1I1Rr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 13:47:58 -0400
Received: from [192.168.2.104] (p579BE384.dip.t-dialin.net [87.155.227.132])
	by india601.server4you.de (Postfix) with ESMTPSA id E48F92F8040;
	Wed, 28 Sep 2011 19:47:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0) Gecko/20110922 Thunderbird/7.0
In-Reply-To: <4E835CFE.7020501@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182351>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin/revert.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 3117776..db5b1d4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -72,12 +72,10 @@ static int option_parse_x(const struct option *opt,
 static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage();
-	int noop;
 	struct option options[] = {
 		OPT_BOOLEAN('n', "no-commit", &no_commit, "don't automatically commit"),
 		OPT_BOOLEAN('e', "edit", &edit, "edit the commit message"),
-		{ OPTION_BOOLEAN, 'r', NULL, &noop, NULL, "no-op (backward compatibility)",
-		  PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 0 },
+		OPT_NOOP_NOARG('r', NULL),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
-- 
1.7.7.rc2
