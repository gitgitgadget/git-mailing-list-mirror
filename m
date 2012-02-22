From: Russell Myers <mezner@russellmyers.com>
Subject: git-p4 uses -h for host instead of -H
Date: Tue, 21 Feb 2012 19:49:12 -0500
Message-ID: <4F443B88.6020902@russellmyers.com>
References: <CAA5tD2sYSqtGTwW1PmFMB_mP_xG24VS6hPXTLD33bJsMaj4MWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070106090706070706010604"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 22 01:49:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S00OY-0004ri-NF
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 01:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431Ab2BVAtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 19:49:15 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42731 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab2BVAtP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 19:49:15 -0500
Received: by yhoo21 with SMTP id o21so3226564yho.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 16:49:14 -0800 (PST)
Received-SPF: pass (google.com: domain of mezner@russellmyers.com designates 10.236.155.225 as permitted sender) client-ip=10.236.155.225;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of mezner@russellmyers.com designates 10.236.155.225 as permitted sender) smtp.mail=mezner@russellmyers.com
Received: from mr.google.com ([10.236.155.225])
        by 10.236.155.225 with SMTP id j61mr39195254yhk.43.1329871754724 (num_hops = 1);
        Tue, 21 Feb 2012 16:49:14 -0800 (PST)
Received: by 10.236.155.225 with SMTP id j61mr30503978yhk.43.1329871754626;
        Tue, 21 Feb 2012 16:49:14 -0800 (PST)
Received: from [192.168.11.37] (99-99-46-163.lightspeed.tukrga.sbcglobal.net. [99.99.46.163])
        by mx.google.com with ESMTPS id j2sm34511816ani.19.2012.02.21.16.49.13
        (version=SSLv3 cipher=OTHER);
        Tue, 21 Feb 2012 16:49:13 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <CAA5tD2sYSqtGTwW1PmFMB_mP_xG24VS6hPXTLD33bJsMaj4MWg@mail.gmail.com>
X-Forwarded-Message-Id: <CAA5tD2sYSqtGTwW1PmFMB_mP_xG24VS6hPXTLD33bJsMaj4MWg@mail.gmail.com>
X-Gm-Message-State: ALoCoQlC2rPkDhRmhnzA3PCyhOgE/X0qrnsSNe5TCrx7j99WvhF5tslhH9IWXyO5Mn6X0BXd2ceq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191207>

This is a multi-part message in MIME format.
--------------070106090706070706010604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

In attempting to use the git-p4 plugin I ran into an issue when the host 
argument was specified using the -h argument instead of the -H argument 
for the host. As a result, I found that instead of git-p4 specifying a 
host, it gets help information. Correcting this issue allowed me to 
clone without issue. I've attached a patch of what I did to fix the 
issue if this is indeed believed to be an issue.

Thanks,

Russell


--------------070106090706070706010604
Content-Type: text/x-patch;
 name="host_flag_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="host_flag_fix.patch"

>From 2f6c91282c98ca0a45269524ec74655f76921ec9 Mon Sep 17 00:00:00 2001
From: Russell Myers <mezner@russellmyers.com>
Date: Tue, 21 Feb 2012 19:18:54 -0500
Subject: [PATCH] Changing host argument to -H from -h. Based on
 http://www.perforce.com/perforce/doc.current/manuals/p4guide/03_using.html
 '-H' is the apporpriate flag while '-h' is a flag passed
 for help content.

---
 contrib/fast-import/git-p4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index a78d9c5..d2fd265 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -38,7 +38,7 @@ def p4_build_cmd(cmd):
 
     host = gitConfig("git-p4.host")
     if len(host) > 0:
-        real_cmd += ["-h", host]
+        real_cmd += ["-H", host]
 
     client = gitConfig("git-p4.client")
     if len(client) > 0:
-- 
1.7.5.4


--------------070106090706070706010604--
