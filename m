From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH] t5500-fetch-pack: ignore output from git init
Date: Sat, 23 May 2009 12:34:42 -0700
Message-ID: <1243107282-9259-1-git-send-email-bebarino@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 23 21:35:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7wzn-0005Px-Ft
	for gcvg-git-2@gmane.org; Sat, 23 May 2009 21:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134AbZEWTep (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 15:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753856AbZEWTep
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 15:34:45 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:42624 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZEWTeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 May 2009 15:34:44 -0400
Received: by rv-out-0506.google.com with SMTP id f9so790747rvb.1
        for <git@vger.kernel.org>; Sat, 23 May 2009 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer;
        bh=7vZOSG1iIPiD0xaYeQU1HPMDhngEvAMVn2EAHsEd4pE=;
        b=KeabKEiLqslC0sUJqoncngULafdXg80O2unKWFlwFi/+XkBJ6GoT+gxsABiGlUY1YU
         o43CKc0wgjg3pDxY/nD0bh9Q2AFioLfOmKD+cN00baCOzmoT/mnkC3LIsBaCBdoJrQ//
         XdyjjC3AUExk2kiMtjaDV8mngiDSp6PDDvhJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MAdKLUFQh6oYuTpJtl7q7SZv/DbwdlrabwnFvzvEUXKiTOBeru+3Wel1/TrW+D+3IL
         orQhACMO7ri3NwNfAtwGs3qCNkwMGI16QBkkKtGB/CtLiJnUraJg5vhHfVYHWitCgDVv
         9suptJi+a7/wBuOD19pzxADYyi0QeHZfC0/Rs=
Received: by 10.141.206.10 with SMTP id i10mr1125388rvq.152.1243107285572;
        Sat, 23 May 2009 12:34:45 -0700 (PDT)
Received: from earth ([76.89.212.195])
        by mx.google.com with ESMTPS id g31sm3366449rvb.33.2009.05.23.12.34.43
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 May 2009 12:34:45 -0700 (PDT)
Received: by earth (sSMTP sendmail emulation); Sat, 23 May 2009 12:34:42 -0700
X-Mailer: git-send-email 1.6.3.1.145.gb74d77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119800>

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t5500-fetch-pack.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index c450f33..ce74508 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -97,7 +97,7 @@ pull_to_client () {
 (
 	mkdir client &&
 	cd client &&
-	git init 2>> log2.txt &&
+	git init 2>> log2.txt > /dev/null &&
 	git config transfer.unpacklimit 0
 )
 
-- 
1.6.3.1.145.gb74d77
