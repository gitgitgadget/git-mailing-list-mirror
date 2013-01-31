From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 3/3] gpg: Allow translation of more error messages
Date: Wed, 30 Jan 2013 18:01:06 -0800
Message-ID: <1359597666-10108-4-git-send-email-sboyd@codeaurora.org>
References: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 31 03:01:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0jTP-0008G0-69
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 03:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755607Ab3AaCBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 21:01:22 -0500
Received: from wolverine01.qualcomm.com ([199.106.114.254]:30435 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab3AaCBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 21:01:16 -0500
X-IronPort-AV: E=Sophos;i="4.84,573,1355126400"; 
   d="scan'208";a="23137439"
Received: from pdmz-ns-snip_115_219.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.115.219])
  by wolverine01.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Jan 2013 18:01:09 -0800
Received: from sboyd-linux.qualcomm.com (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 7056B10004DC
	for <git@vger.kernel.org>; Wed, 30 Jan 2013 18:01:09 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.439.g50a6b54
In-Reply-To: <1359597666-10108-1-git-send-email-sboyd@codeaurora.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215085>

Mark these strings for translation so that error messages are
printed in the user's language of choice.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 gpg-interface.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 2c0bed3..474c037 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -109,10 +109,10 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	args_gpg[0] = gpg_program;
 	fd = git_mkstemp(path, PATH_MAX, ".git_vtag_tmpXXXXXX");
 	if (fd < 0)
-		return error("could not create temporary file '%s': %s",
+		return error(_("could not create temporary file '%s': %s"),
 			     path, strerror(errno));
 	if (write_in_full(fd, signature, signature_size) < 0)
-		return error("failed writing detached signature to '%s': %s",
+		return error(_("failed writing detached signature to '%s': %s"),
 			     path, strerror(errno));
 	close(fd);
 
@@ -124,7 +124,7 @@ int verify_signed_buffer(const char *payload, size_t payload_size,
 	args_gpg[2] = path;
 	if (start_command(&gpg)) {
 		unlink(path);
-		return error("could not run gpg.");
+		return error(_("could not run gpg."));
 	}
 
 	write_in_full(gpg.in, payload, payload_size);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
