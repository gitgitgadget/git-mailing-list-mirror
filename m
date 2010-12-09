From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/8] git-gui: handle index lines only in the diff header
Date: Thu,  9 Dec 2010 21:47:53 +0100
Message-ID: <56141ad4622dfc1ee991c9ee3be90dbf3e99b744.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 09 21:48:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQnPQ-0003GF-Q9
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 21:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757039Ab0LIUsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 15:48:09 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:37856 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757003Ab0LIUsI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 15:48:08 -0500
Received: by bwz16 with SMTP id 16so3174895bwz.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2010 12:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=40HA3V2ys52oWqmnm1KcW1w4Y3KOB5RlBiVTu/mgQq8=;
        b=tCWqwMEk8k4d0UyMYUKk7/wFeAyFWDZgaIhBIhwu7iKanFBwMPzbhxn/NuT4f3PWMU
         Cs/cYnc/GDYpkDfBuR86MdbBF+McsL0rdmRMXXnOB0uj/xzH4+r0eATVf2QIgeiqS/xc
         dnrTOaxx3YJy3xQjNrA9WVgC4lxX6TuzWbshk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PEPDqSq3WPoq1xb3ryuhBfv8rBODbUhZ6XmRGofRsuTSwm95KamXApIHGkl9FoYvz1
         piy3N4YNbQOugbia/b9HBacgvR/9HwIyZbBJPcgvy8l9XgbAQZQJVUHXHuXEOv50KnhI
         H7RGfDQYIaZ2kRTyo+5q4q6ma8yxjrncin89s=
Received: by 10.204.114.81 with SMTP id d17mr3015132bkq.135.1291927686946;
        Thu, 09 Dec 2010 12:48:06 -0800 (PST)
Received: from localhost (p3E990761.dip.t-dialin.net [62.153.7.97])
        by mx.google.com with ESMTPS id l3sm11042fan.0.2010.12.09.12.48.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 09 Dec 2010 12:48:06 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
In-Reply-To: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
References: <babc4fe91e54e3923baa6f08cc92ee8ea494e704.1291927657.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163313>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index dae6ca6..0b72924 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -402,12 +402,12 @@ proc read_diff {fd conflict_size cont_info} {
 			    || [string match {diff --cc *}       $line]
 			    || [string match {diff --combined *} $line]
 			    || [string match {--- *}             $line]
-			    || [string match {+++ *}             $line]} {
+			    || [string match {+++ *}             $line]
+			    || [string match {index *}           $line]} {
 				continue
 			}
 		}
 
-		if {[string match {index *} $line]} continue
 		if {$line eq {deleted file mode 120000}} {
 			set line "deleted symlink"
 		}
-- 
1.7.3.2.1200.ge4bf6
