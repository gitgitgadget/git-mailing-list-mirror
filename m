From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] Document receive.advertiseatomic
Date: Mon, 12 Jan 2015 16:24:02 -0800
Message-ID: <1421108642-22213-1-git-send-email-sbeller@google.com>
Cc: sunshine@sunshineco.com, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jan 13 01:24:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YApHJ-0002Re-Ci
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 01:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbbAMAYI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 19:24:08 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:57381 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbbAMAYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 19:24:06 -0500
Received: by mail-ie0-f178.google.com with SMTP id vy18so30561iec.9
        for <git@vger.kernel.org>; Mon, 12 Jan 2015 16:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=SxnABxFijcdyqzDKERhBif6lK/qImUfFuv5Wo/FO+/I=;
        b=mG0wC5XsbI4laGv8QPcimlzvN+JTqaedP8hgZ3gF54JqXOHLksIz1iniFC1TRGOv9K
         GGlLY9f33IZYEawvVx+WnNcSkATJpyzuNPPHbOabiNu9iV+0sZJ5yccz6nIlC424LgF+
         tl+mu8+ERP/e8RrXeXMXnmECBvJ+WKFxKHGCi3gRmrkg9Hf5Ssay9rn396/HRcw/i2JR
         wmVr+sC2nBsDhK/He62XmKZHhbLaiClpOQ6vO/sVP8nKzeJZaYE8qG9BBNOAdZL92cUH
         YsmyvOHIueOzD9R5/0Ej2Uhp5eppMIvr8Sj/xgqa3/yL+ww4NbaAyrNEbn6okAmc9Y7a
         m/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SxnABxFijcdyqzDKERhBif6lK/qImUfFuv5Wo/FO+/I=;
        b=MrIZ5DzL0TEqnUXu0TQmJW9eU6jwC8BnXJFwlttyr+nrInifD7wrVuanJ2JJLIDPuC
         H8sFxdREPU96Jd1Ty/DoCksQcG4Rh0VS+WIuDKsqj3UovhbU7BVDdFBNZF+JA0Bvz5pa
         IyR3HHZQbPqoomjJiM3UX5vYv5+Y914Zy/aMqFyrlysAdTt0BWOwP6Uzr/X4uEN2O3AQ
         sVDRKWP+BKxynloVkR+myut1UzRYThcz7ACzjgdehdvmjdksFegp4KBw/A8DEDf9nmDW
         oGrZUoy5vg9UuRyRIyhdk9CN7Nt/03K01PWN/g93776HSEo9HeqdiSkXaq/56lO4jeVG
         b61g==
X-Gm-Message-State: ALoCoQmXF73o9xkBLA/lJaVdn5OOOrUuXy+RrQEb+IIb/v34cLoCHeGMrPAu4T8OoGuLJII6SfSX
X-Received: by 10.107.131.102 with SMTP id f99mr30278016iod.31.1421108645456;
        Mon, 12 Jan 2015 16:24:05 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:50ea:ea5:b131:957b])
        by mx.google.com with ESMTPSA id g5sm9374630iod.25.2015.01.12.16.24.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Jan 2015 16:24:05 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262310>

This was missing in 1b70fe5d3054 (2015-01-07, receive-pack.c: negotiate
atomic push support) as I squashed the option in very late in the patch
series.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v1:
    This goes on top of origin/sb/atomic-push

 Documentation/config.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..4f8f498 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2072,6 +2072,11 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
 
+receive.advertiseatomic::
+	By default, git-receive-pack will advertise the atomic push
+	capability to its clients. If you don't want to this capability
+	to be advertised, set this variable to false.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
-- 
2.2.1.62.g3f15098
