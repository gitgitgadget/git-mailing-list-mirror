From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 43/86] submodule: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:36 +0100
Message-ID: <20131109070720.18178.68022.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2h8-0004uI-So
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:10:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933334Ab3KIHKM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:12 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54125 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933280Ab3KIHIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:39 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id B8FE6A2;
	Sat,  9 Nov 2013 08:08:37 +0100 (CET)
X-git-sha1: 1d9c7bd504674faaba2a355c7f1a26b21fa54983 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237525>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 1905d75..21fe14e 100644
--- a/submodule.c
+++ b/submodule.c
@@ -201,7 +201,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 
 int submodule_config(const char *var, const char *value, void *cb)
 {
-	if (!prefixcmp(var, "submodule."))
+	if (has_prefix(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
 		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
-- 
1.8.4.1.566.geca833c
