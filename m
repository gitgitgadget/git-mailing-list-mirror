From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH 4/5] t/t1304: set the mask ACL that is checked in check_perms_and_acl
Date: Mon, 15 Mar 2010 12:14:36 -0500
Message-ID: <YowxgPZqaOkg2MZzY1CxLzeL4DIwxt_o3RKS9xen-cewKbECZA7OIb7mUaY2TbsVR_rHE5GTeU0@cipher.nrlssc.navy.mil>
References: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
Cc: Matthieu.Moy@imag.fr, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 18:16:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDtW-0004dk-MA
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:15:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965533Ab0CORP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:15:28 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43477 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965521Ab0CORPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:15:25 -0400
Received: by mail.nrlssc.navy.mil id o2FHFE3j002281; Mon, 15 Mar 2010 12:15:14 -0500
In-Reply-To: <YowxgPZqaOkg2MZzY1CxL1fbmUZ7CMUf5DgqI3S0X83DgqLNI9AGfI83JRNT8LWYHqXBB-PGS1Q@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 15 Mar 2010 17:15:13.0795 (UTC) FILETIME=[134AB530:01CAC463]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142231>

From: Brandon Casey <drafnel@gmail.com>


Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t1304-default-acl.sh |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/t/t1304-default-acl.sh b/t/t1304-default-acl.sh
index 52246d7..85351ae 100755
--- a/t/t1304-default-acl.sh
+++ b/t/t1304-default-acl.sh
@@ -33,6 +33,7 @@ dirs_to_set="./ .git/ .git/objects/ .git/objects/pack/"
 
 test_expect_success 'Setup test repo' '
 	setfacl -m d:u::rwx,d:g::---,d:o:---,d:m:rwx $dirs_to_set &&
+	setfacl -m m:rwx               $dirs_to_set &&
 	setfacl -m u:root:rwx          $dirs_to_set &&
 	setfacl -m d:u:"$LOGNAME":rwx  $dirs_to_set &&
 	setfacl -m d:u:root:rwx        $dirs_to_set &&
-- 
1.6.6.2
