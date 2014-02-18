From: =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Subject: [PATCH v2 2/3] revert.c: Add --record-origin
Date: Tue, 18 Feb 2014 22:27:41 +0100
Message-ID: <a6a124ba7e8a4a4582da28687f5a2aa43c78c31d.1392758057.git.agx@sigxcpu.org>
References: <20140218192039.GC7855@google.com>
 <cover.1392758057.git.agx@sigxcpu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 18 22:28:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFsD5-0004cy-D5
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:28:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbaBRV2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 16:28:06 -0500
Received: from xvm-169-183.ghst.net ([95.142.169.183]:44668 "EHLO
	photon.sigxcpu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937AbaBRV2E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:28:04 -0500
Received: from honk.sigxcpu.org (localhost [IPv6:::1])
	by photon.sigxcpu.org (Postfix) with ESMTPS id 9DD38A37
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by honk.sigxcpu.org (Postfix) with ESMTP id 1FFC7FB04
	for <git@vger.kernel.org>; Tue, 18 Feb 2014 22:28:03 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from honk.sigxcpu.org ([127.0.0.1])
	by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gs6k67sKu7Cg for <git@vger.kernel.org>;
	Tue, 18 Feb 2014 22:28:02 +0100 (CET)
X-Mailer: git-send-email 1.9.0.rc3
In-Reply-To: <cover.1392758057.git.agx@sigxcpu.org>
In-Reply-To: <cover.1392758057.git.agx@sigxcpu.org>
References: <cover.1392758057.git.agx@sigxcpu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242355>

This makes sure we have a command line option that corresponds with the
config file option.
---
 Documentation/git-cherry-pick.txt | 1 +
 builtin/revert.c                  | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index c0274bd..63db07d 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -57,6 +57,7 @@ OPTIONS
 	message prior to committing.
 
 -x::
+--record-origin::
 	When recording the commit, append a line that says
 	"(cherry picked from commit ...)" to the original commit
 	message in order to indicate which commit this change was
diff --git a/builtin/revert.c b/builtin/revert.c
index 0c14af4..899f3e4 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -99,7 +99,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 
 	if (opts->action == REPLAY_PICK) {
 		struct option cp_extra[] = {
-			OPT_BOOL('x', NULL, &opts->record_origin, N_("append commit name")),
+			OPT_BOOL('x', "record-origin", &opts->record_origin, N_("append commit name")),
 			OPT_BOOL(0, "ff", &opts->allow_ff, N_("allow fast-forward")),
 			OPT_BOOL(0, "allow-empty", &opts->allow_empty, N_("preserve initially empty commits")),
 			OPT_BOOL(0, "allow-empty-message", &opts->allow_empty_message, N_("allow commits with empty messages")),
-- 
1.9.0.rc3
