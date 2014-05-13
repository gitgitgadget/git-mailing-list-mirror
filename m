From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT v2 02/29] Allow "guilt delete -f" to run from a dir which contains spaces.
Date: Tue, 13 May 2014 22:30:38 +0200
Message-ID: <1400013065-27919-3-git-send-email-cederp@opera.com>
References: <1400013065-27919-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:32:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkJNG-0007t2-3m
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 22:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbaEMUc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 16:32:27 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:38289 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708AbaEMUc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 16:32:26 -0400
Received: by mail-lb0-f174.google.com with SMTP id n15so699587lbi.5
        for <git@vger.kernel.org>; Tue, 13 May 2014 13:32:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m0Y5h2W60kBK4mvCeOwPqfjfvu8A89bXEHqkc7CmGXo=;
        b=IHJU0d73nu5tuVBhv31mvGM+ma8m9GVTSRJ9EUfd0dqmB9SbIerGZnX6Cec85SZwZi
         jtnXxRi/hSOMR8FJN7AmPlPlbMPpQlhxJmsMvXXQwm8NAWAPtXXvNfjZHfRQwODLf2/w
         Zvyd6f2Xhvk1W45Z81D7iGt38FYZUHvXFyu1WROED6UffT4M7Xfyz81rWInw0zft6Rz/
         cndAKaPUhRc8mWWT8O/7C2LvSZL7hn4hibCXJaQr/w6WHHNHocumyM/NNE/ACaMA7KSA
         rG2vfSTxF+rPVJDMuYAB0DXsMDG31Jw6SoSaTnSpa0abiP9HV/LCjLoHCryBUPcPNyG1
         ZshA==
X-Gm-Message-State: ALoCoQlcmTMyuq+GUaHRn17lMxkMg9ZrLqZ0k/dYKXChoRsxhCXgfyShj205xNf/OTDHG2gHQZTf
X-Received: by 10.112.171.67 with SMTP id as3mr30478331lbc.10.1400013144723;
        Tue, 13 May 2014 13:32:24 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id m2sm11431763lbp.31.2014.05.13.13.32.23
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 13:32:23 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1400013065-27919-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248817>

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
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
