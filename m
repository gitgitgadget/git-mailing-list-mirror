From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] post-receive-email: add --dirstat output to update_branch summary section
Date: Tue, 22 Apr 2008 10:30:31 +0100
Message-ID: <200804221030.31805.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 11:31:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoEqb-0003s2-Op
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 11:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757244AbYDVJar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 05:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757057AbYDVJar
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 05:30:47 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:56580 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756832AbYDVJaq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 05:30:46 -0400
Received: by an-out-0708.google.com with SMTP id d31so580957and.103
        for <git@vger.kernel.org>; Tue, 22 Apr 2008 02:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=+Fr/aeF1TEFju6VFgw0SXZ7CHSlOZxxwCTauHZlyjik=;
        b=pZLi0W+tr4tDSM0mTvU1spceiOQPjgL7yuEk/PTmsNQvGfgBpAMEE/6EQpt8PoavD5bh6DWYCt8MrtYje3ZTtwUvs+wI+tFNVxLhWtvIw7C8pegAw3GAHwX77ya4MiCr3O1lUVXrei74LLqySw9ztFwOHnjORFUEznNVLkLPkeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=aBfX3plj3+0akR8NbIL+zDI62P2xDELyFwcwPjmXrkcrOGMR1GtFbshP2PAzVbbiGGklQ0HaoAIh30V9qEDcspoXulrgU5wShovvhMbtSMC+YuJSMpbvMhYcO/jJYlFcf+VDmQ2542BG7/R8T0mEr4SRTWOlSWEUhax8Wzqusy0=
Received: by 10.100.110.15 with SMTP id i15mr7397342anc.97.1208856645998;
        Tue, 22 Apr 2008 02:30:45 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTPS id c53sm2711450wrc.28.2008.04.22.02.30.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Apr 2008 02:30:37 -0700 (PDT)
X-TUID: 1fcb3f618c4220db
X-UID: 9
X-Length: 857
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80087>


Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 contrib/hooks/post-receive-email |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 62a740c..2e706b3 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -410,6 +410,8 @@ generate_update_branch_email()
 	# non-fast forward updates.
 	echo ""
 	echo "Summary of changes:"
+	git diff --dirstat $oldrev..$newrev
 	git diff-tree --stat --summary --find-copies-harder $oldrev..$newrev
 }
 
-- 
1.5.5.1.57.g5909c
