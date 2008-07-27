From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 1/2] git-gui: Fix the Remote menu separator.
Date: Sun, 27 Jul 2008 10:34:21 +0400
Organization: TEPKOM
Message-ID: <200807271034.21833.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 08:35:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzqw-0005M6-7c
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYG0Gee (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751866AbYG0Ged
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:34:33 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:61871 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbYG0Ged (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:34:33 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1894025fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=v3ZfqiW8K3FCE0pm1Ah8RdUsRe+/CROfa8SiwICXTAM=;
        b=WPqX5cbmVwXNfNVQEQnrSg46uMLLHvJD8TWayyfI6Zkw9LNW+gd74sm6lRG9edRXGr
         +2aemB9evXJ1YyXbTQ3+EsTF1Y78bowVKBbPIMKLW8lRiqudZnGJzxzI8bfT3F9GJrVB
         qeC31yZQ/ChV0ehFTRzH8rqx0a+RkK6W+Ua8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=eKbHdtZWxUPJ65qrl7zaoELC94zVOw131CyNgewM5Il6g7SGb+Isj50oI7EacuSvw1
         njRl9QpoEgwq9tWYR25RAuOpi5Y9/ax6vhvrcotq2TaB5IiLu6iPTSnUDIC9tEhDBsFJ
         4mmXJMUxLQug4+Ciw4WBUnOMM30jpDXNy5eAI=
Received: by 10.86.4.2 with SMTP id 2mr1423346fgd.15.1217140471371;
        Sat, 26 Jul 2008 23:34:31 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id 3sm1859580fge.3.2008.07.26.23.34.29
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:34:30 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90321>

It was positioned incorrectly (offset by one position)
if the menu had a tear-off handle.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	A couple of random fixes.

	-- Alexander

 git-gui.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 9d0627d..da903a1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2926,6 +2926,7 @@ if {[is_enabled transport]} {
 	populate_fetch_menu
 	set n [expr {[.mbar.remote index end] - $n}]
 	if {$n > 0} {
+		if {[.mbar.remote type 0] eq "tearoff"} { incr n }
 		.mbar.remote insert $n separator
 	}
 	unset n
-- 
1.5.6.3.18.gfe82
