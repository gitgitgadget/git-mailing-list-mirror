From: Sun He <sunheehnus@gmail.com>
Subject: [PATCH] builtin/pack-objects.c:write_pack_file() replace tmpname with pack_tmp_name in warning
Date: Sat,  1 Mar 2014 00:26:14 +0800
Message-ID: <1393604774-19480-1-git-send-email-sunheehnus@gmail.com>
Cc: mhagger@alum.mit.edu, Sun He <sunheehnus@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 28 17:27:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJQHy-0002rl-FO
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 17:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752417AbaB1Q1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 11:27:50 -0500
Received: from mail-pb0-f51.google.com ([209.85.160.51]:36738 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbaB1Q1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 11:27:49 -0500
Received: by mail-pb0-f51.google.com with SMTP id uo5so253619pbc.38
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 08:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dpHlpw73jsM3m1aaN8Frz2gnE2JEElKfoFnrqDuU5c8=;
        b=tIS5PxAA0D+OpR66BGIkZ3ZFxo1gqZZ8YDgMiVVi44aw7ksoNje42E0CgdgdkFYU4n
         hT7Tqt8WefzPVH6OgwZAochAsNGfP/5DtbqCUvnmu2MbrQc8c1Jn/Twfly1hFBKXbFXJ
         MhAzXmMoTd5P47edab+DFhImeQ3CWkYgxbbwB+b/k9O30d7MJssJPBlV+2/aqkmj3CcX
         mtPr0zXYU3X4WlhAx1csTEY79RFyLoDM97CFE+Ok3GQEcCQaglU+pvdUUE3ORlPNNoGM
         J6gmzmb0dkX1XZ68T8zgipJqvflvQmcqhBHGR/gqFQ3ReuuNc+kVyBZIBw2SRa8BY6rO
         gBsg==
X-Received: by 10.68.201.226 with SMTP id kd2mr4294447pbc.157.1393604859115;
        Fri, 28 Feb 2014 08:27:39 -0800 (PST)
Received: from ENIGMA.61.134.1.4 ([61.150.43.99])
        by mx.google.com with ESMTPSA id oz7sm7635483pbc.41.2014.02.28.08.27.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2014 08:27:38 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242981>

Signed-off-by: Sun He <sunheehnus@gmail.com>
---
The tmpname is uninitialized and it should a bug

Please ignore the former patches about this with wrong format.
I am sorry to cause a jam in your inbox. ^_^

In the end, I wanna thank Michael Haggerty who give me help.

 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index c733379..4922ce5 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -823,7 +823,7 @@ static void write_pack_file(void)
 				utb.modtime = --last_mtime;
 				if (utime(pack_tmp_name, &utb) < 0)
 					warning("failed utime() on %s: %s",
-						tmpname, strerror(errno));
+						pack_tmp_name, strerror(errno));
 			}
 
 			/* Enough space for "-<sha-1>.pack"? */
-- 
1.9.0.138.g2de3478.dirty
