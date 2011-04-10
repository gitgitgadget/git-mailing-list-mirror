From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 10/11] revert: Give noop a default value while argument parsing
Date: Sun, 10 Apr 2011 20:41:56 +0530
Message-ID: <1302448317-32387-11-git-send-email-artagnon@gmail.com>
References: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 10 17:14:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8wL1-00007s-Ru
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 17:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093Ab1DJPOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 11:14:02 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:49368 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754045Ab1DJPOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 11:14:00 -0400
Received: by mail-iy0-f174.google.com with SMTP id 14so4855877iyb.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 08:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=BlhuiReHzXPit5g3l4re8l9aF4B4rjr6F9vmw62Ad1A=;
        b=dVq/IVkZuzq/51f5fnvNJLOcv/RUAP//q0o5sM4TH6jgZtvyxcsdrHQXctzm+gUivp
         VoUCW/Ka3v3mFLICC8uuzhJ+kUH52RsidIOIqWeFr1uGQutNoghyRgRvsmGrUwHf52MV
         ueutfZIHWKQJglyWch1dkgiC3e8SkbzidLOBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dKaGQmsYjapkzAqMBl9Tse9PrnLur+4CWnD2pr4oYGabByZUAlqZnJziCwQU+VMFYH
         dIeUTLj8WdvyJA0rgU0UuWZfpmu3kNVSeytF2J7xu0rEZam1mIgqbu8d843vYI1N/7zf
         FF9QqDmw+V5xG6IjiZRU8LMDTbUFNB4Z0PHRU=
Received: by 10.43.69.199 with SMTP id yd7mr6484570icb.370.1302448440550;
        Sun, 10 Apr 2011 08:14:00 -0700 (PDT)
Received: from localhost.localdomain ([203.110.240.41])
        by mx.google.com with ESMTPS id f28sm3367928ibh.67.2011.04.10.08.13.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 08:13:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.rc1.7.g2cf08.dirty
In-Reply-To: <1302448317-32387-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171264>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/revert.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index 25969a5..0720721 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -112,7 +112,8 @@ static void parse_args(int argc, const char **argv)
 {
 	const char * const * usage_str = revert_or_cherry_pick_usage();
 	const char *me;
-	int noop;
+	int noop = 0;
+
 	struct option options[] = {
 		OPT_BOOLEAN(0, "abort", &cmd_opts.abort_oper, "abort the current operation"),
 		OPT_BOOLEAN(0, "skip", &cmd_opts.skip_oper, "skip the current commit"),
-- 
1.7.4.rc1.7.g2cf08.dirty
