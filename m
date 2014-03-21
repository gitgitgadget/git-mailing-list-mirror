From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 02/28] Allow "guilt delete -f" to run from a dir which contains spaces.
Date: Fri, 21 Mar 2014 08:31:40 +0100
Message-ID: <1395387126-13681-3-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:33:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxK-0002BU-Ok
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:33:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662AbaCUHdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:21 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:54791 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842AbaCUHdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:03 -0400
Received: by mail-la0-f42.google.com with SMTP id ec20so1408700lab.29
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxKboOdTWAA/8GXahDgrTr9rMGhJUs97Qh9pQe8gwSA=;
        b=HCmx9TNE/a2PDyo5543FLmp2URRJNy9DVSqdd0nzTfWUY5OFZeBvt7TiQzNZzVydkw
         qzX58VwgQE6qzeL2nK4+rqL0/rGJ38DrfnLhsJ3euh8SQHXlMOxOEZiwGQzvIbNgDgwc
         PN7EcisKZc9h31Qy7ILO5rd7pR55ds1W2EGhfJWIx+7p0e+I0VqiQOMRUjYZszbn47FZ
         CoCOxg64uxjplCMfWplD51gjJ6Wldibs62m/poNkWf3esKxiZ2aoKGxBaXcbqDHePMTW
         5PVVg+nWEls4YHlbEQePRtbU9sSgndG/p4hlS8Wl5f+RWGH54C1lc9ZLyD4mrXLwjaas
         BlMw==
X-Gm-Message-State: ALoCoQnJTRDImFRaevPCWOeoI6QsBXt1J5CJQOsdyBPrKdzsGf3v6Cy0b/pFCdLkB9c5PexltNJk
X-Received: by 10.112.171.67 with SMTP id as3mr31092264lbc.10.1395387181753;
        Fri, 21 Mar 2014 00:33:01 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.00
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244646>

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-delete | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-delete b/guilt-delete
index 3e394f8..967ac10 100755
--- a/guilt-delete
+++ b/guilt-delete
@@ -49,7 +49,7 @@ series_remove_patch "$patch"
 
 guilt_hook "delete" "$patch"
 
-[ ! -z "$force" ] && rm -f $GUILT_DIR/$branch/$patch
+[ ! -z "$force" ] && rm -f "$GUILT_DIR/$branch/$patch"
 
 exit 0
 
-- 
1.8.3.1
