From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH 3/3] builtin/blame.c: reduce scope of variables
Date: Wed, 29 Jan 2014 05:33:15 -0800
Message-ID: <1391002395-8665-1-git-send-email-gitter.spiros@gmail.com>
References: <y>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 14:33:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8VGq-0006zS-4N
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 14:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbaA2Ndc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 08:33:32 -0500
Received: from mail-pb0-f42.google.com ([209.85.160.42]:46762 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaA2Ndb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 08:33:31 -0500
Received: by mail-pb0-f42.google.com with SMTP id jt11so1762983pbb.29
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aM2pUYz/KUOGGiyQu2w8AI4DyVQbj6W5UhvdTK4J9lE=;
        b=DYIkA7TsThuLNmV2zdKmdLHiwmRtxClnPI9sjfMFdnIvE6OwsnJtxHHZA8c445ZE7m
         wSd8KZgUfdk3HVquNTJOp6nmnGRz7ezDPPXDfUTxExcPHbTkXuXMqneHSxdYUPxG7hiL
         FhmG29rzLTovtXhQWMVNdWaVdCTeTMS3mVCq05xHhAXuD09AvJWqEIoD+kKqz65x/uHV
         JS0tqcArAWSKzOSUuLBW3tdB1iEFFr/KBQ5kTCe3STK7Kp//1JWdgHTIKf+oeqMWQILf
         UJ7qJscbNIbRYrt0kAkg4zsY9uqmYoWz1HYwZVnp7BypvrEhpdQt6V0RHl62v429/7w1
         sOlQ==
X-Received: by 10.68.221.42 with SMTP id qb10mr7882691pbc.65.1391002411313;
        Wed, 29 Jan 2014 05:33:31 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id j3sm7264763pbh.38.2014.01.29.05.33.30
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 05:33:30 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <y>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241210>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/blame.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index e44a6bb..967a7c6 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1580,14 +1580,14 @@ static const char *format_time(unsigned long time, const char *tz_str,
 			       int show_raw_time)
 {
 	static char time_buf[128];
-	const char *time_str;
-	int time_len;
-	int tz;
 
 	if (show_raw_time) {
 		snprintf(time_buf, sizeof(time_buf), "%lu %s", time, tz_str);
 	}
 	else {
+		const char *time_str;
+		int time_len;
+		int tz;
 		tz = atoi(tz_str);
 		time_str = show_date(time, tz, blame_date_mode);
 		time_len = strlen(time_str);
-- 
1.7.10.4
