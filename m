From: Mark Levedahl <mlevedahl@gmail.com>
Subject: [PATCH] install-doc-quick - use git --exec-path to find git-sh-setup
Date: Mon,  7 Jul 2008 22:37:38 -0400
Message-ID: <1215484658-3312-1-git-send-email-mlevedahl@gmail.com>
Cc: Mark Levedahl <mlevedahl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 04:38:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG36G-0003JO-PI
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 04:38:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687AbYGHChm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 22:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755481AbYGHChm
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 22:37:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:22542 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755390AbYGHChl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 22:37:41 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1095276ywe.1
        for <git@vger.kernel.org>; Mon, 07 Jul 2008 19:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vqrn/RmLeNLoeBkIXKx3JXoEzSw9zlHEC5grpgRO5Fk=;
        b=RH4/cTXrJQ0H3ZR6LojPb/+bSVVb4opXz3nPgKuDzGSBn1+q96Z4p8q5AKSlfxgXUt
         q/LLfmDfRfgEOxtUCcuG6q+q1Oy4AJY4/uZKo5MOrbzTM28XEgyePEdbJr64FDWUz2wz
         +7dwDOFTYw6ZwPu7gFlped+s2Kht7hI+A+eP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qH5QCLNvqxOCNf7iYZ+ZXbTfxYr9S+7ArvXNM6GXz0MfDQtVy1OeTFox9igkqmRYCj
         yBOuEPPaPG0+e0GS/V1ZzImQbIVxc90PYnhja57vpGs8Hs7Xci7XT+ecCq/Jv9C0u4Aq
         8H7tFGg/DGCjXURxhYhy6YOagW+NnjOtFrOqk=
Received: by 10.151.50.11 with SMTP id c11mr9394301ybk.127.1215484660902;
        Mon, 07 Jul 2008 19:37:40 -0700 (PDT)
Received: from localhost.localdomain ( [71.246.235.165])
        by mx.google.com with ESMTPS id 5sm189796ywd.8.2008.07.07.19.37.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 07 Jul 2008 19:37:39 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.2.271.g73ad8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87689>

This is needed as git-sh-setup is no longer in the path.

Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
---
 Documentation/install-doc-quick.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/install-doc-quick.sh b/Documentation/install-doc-quick.sh
index 5433cf8..35f4408 100755
--- a/Documentation/install-doc-quick.sh
+++ b/Documentation/install-doc-quick.sh
@@ -6,7 +6,7 @@ head="$1"
 mandir="$2"
 SUBDIRECTORY_OK=t
 USAGE='<refname> <target directory>'
-. git-sh-setup
+. "$(git --exec-path)"/git-sh-setup
 cd_to_toplevel
 
 test -z "$mandir" && usage
-- 
1.5.6.2.271.g73ad8
