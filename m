From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] Git.pm: fix documentation of hash_object
Date: Sun,  1 Jun 2008 22:26:25 +0200
Message-ID: <1212351985-11682-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 01 22:27:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2u9F-0002zm-V8
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 22:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbYFAU0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 16:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbYFAU0c
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 16:26:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:29195 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbYFAU0b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 16:26:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so572811fgg.17
        for <git@vger.kernel.org>; Sun, 01 Jun 2008 13:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date:message-id:x-mailer:from;
        bh=2+7XvHq37S8ZqpAa1RF5s9Im0/biX+l7eEINDCTJvhM=;
        b=u1V1CAaIMEJtGrlidD9ULGTmOcTj2JfJDpWtG1E+LVVnOBJR0gG/vXKIM/An9E8S4am1EUA1oF4Vk+oQFp0IFQ3VJTbsu4AUGo5T1+hieWTdEdeEOacZ3esHUYuL1b21RDfL5m+I7rI8EysQuzf3d+LPaj45JOs3bCGE/ocrAdA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=dfF1ifvFm9RTnKfDPtRRDmRYufADo1NX56sAIBITLAHJZ9JdCkC0+zUHkQYRH15U5TY9VHClUOZ3ur3VRc/RzFoOxQjp5cetW2ze/6/165KwP3vXUufUlmP+zhnsB+4c2Szjet6Sv/JPTe1xZnOY8tJ0i9K8eKC074QNTQnmCjc=
Received: by 10.86.66.11 with SMTP id o11mr605069fga.43.1212351989892;
        Sun, 01 Jun 2008 13:26:29 -0700 (PDT)
Received: from fly ( [91.33.205.25])
        by mx.google.com with ESMTPS id 4sm2694020fgg.9.2008.06.01.13.26.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 01 Jun 2008 13:26:28 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <LeWiemann@gmail.com>)
	id 1K2u8I-00032m-1K; Sun, 01 Jun 2008 22:26:26 +0200
X-Mailer: git-send-email 1.5.5.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83464>

The documentation of hash_object incorrectly states that it accepts a
file handle -- in fact it doesn't, and there is even a TODO comment
for this.  This fixes the documentation.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
This should be implemented eventually, but in the meantime let's just
correct the documentation.

 perl/Git.pm |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/perl/Git.pm b/perl/Git.pm
index 80f7669..07b92c7 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -760,9 +760,8 @@ sub parse_rev {
 
 =item hash_object ( TYPE, FILENAME )
 
-Compute the SHA1 object id of the given C<FILENAME> (or data waiting in
-C<FILEHANDLE>) considering it is of the C<TYPE> object type (C<blob>,
-C<commit>, C<tree>).
+Compute the SHA1 object id of the given C<FILENAME> considering it is
+of the C<TYPE> object type (C<blob>, C<commit>, C<tree>).
 
 The method can be called without any instance or on a specified Git repository,
 it makes zero difference.
-- 
1.5.5.GIT
