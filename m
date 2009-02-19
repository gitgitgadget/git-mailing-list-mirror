From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH 3/6] Improve error message for branching an existing branch
Date: Thu, 19 Feb 2009 07:36:24 +0000
Message-ID: <200902190736.24402.johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 08:38:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La3Tn-0002pi-5I
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 08:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbZBSHg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 02:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752572AbZBSHg2
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 02:36:28 -0500
Received: from wf-out-1314.google.com ([209.85.200.169]:20229 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752570AbZBSHg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 02:36:28 -0500
Received: by wf-out-1314.google.com with SMTP id 28so363579wfa.4
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 23:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:date:to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=b1ealL5U+hd4uERkcS6y5HU1mfQ98RUXcKBKHJHH5kU=;
        b=bZDZI6XEjXNoiZkycXF/SEfXDGbVXI5kq8UGIK1BmvtU/iQuGteOJRkrEbiaM+K8F8
         Iq1mw3R8jMGDMyu2/nXrYpP2RzlsV6J7OfOph3aQMSs/OZdMSyH2tJ50aiITIBi/3Qd0
         pnqRfl/BcboDu3m1Jf9H3DV+E3Mnpgb+5M8Ok=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:date:to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=wdMZtos9zBdpyPqCB8mq1GcWkunVQcMUof2PV8IehqNsNcWvQt42Rakthf8CUPFEwk
         fwbUcmu7jOArKf2XAZ4eZ4alaT10CoxErisCbJuMWydHgX52hV2kyoQiGO7dqhuDLLcP
         htMnxK4bhUQoVeO2NAqIApLAweePKum14HbwA=
Received: by 10.142.230.11 with SMTP id c11mr4134823wfh.219.1235028987665;
        Wed, 18 Feb 2009 23:36:27 -0800 (PST)
Received: from johnflux-desktop.localnet (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id 29sm1861226wfg.33.2009.02.18.23.36.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 18 Feb 2009 23:36:26 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110636>

Signed-off-by: John Tapsell <johnflux@gmail.com>
---
 branch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index 1f00e44..86ac293 100644
--- a/branch.c
+++ b/branch.c
@@ -120,7 +120,8 @@ void create_branch(const char *head,
 
 	if (resolve_ref(ref.buf, sha1, 1, NULL)) {
 		if (!force)
-			die("A branch named '%s' already exists.", name);
+			die("A branch named '%s' already exists.\n"
+			    "Maybe you wanted to change to this branch with: git checkout '%s'", name, name);
 		else if (!is_bare_repository() && !strcmp(head, name))
 			die("Cannot force update the current branch.");
 		forcing = 1;
-- 
1.6.2.rc1.3.g7d31b.dirty
