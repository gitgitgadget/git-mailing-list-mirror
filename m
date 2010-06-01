From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/3] Display some help text when patch is empty
Date: Tue,  1 Jun 2010 11:20:21 +0200
Message-ID: <1275384022-12131-3-git-send-email-artagnon@gmail.com>
References: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 11:19:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJNdK-0001sX-WF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 11:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578Ab0FAJTR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 05:19:17 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:41754 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab0FAJTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 05:19:14 -0400
Received: by mail-ew0-f216.google.com with SMTP id 8so1155134ewy.28
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 02:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=ufOgIinHxP55nqTNwSVTAzLWaTdCrarw6uiMBRmTe8o=;
        b=lf1AsDEbd7qZaZCTMEzBUb63fty/jPmXWO7vKRk4BGt9Wbia2uFEHwFZ/aIU+2R5rj
         J9nml9JS4Fq5v6ig8SKSfcJEH3sV1G19QjymxYjxycDY26/dteOG8Sxqr1njJUobHkjW
         CfCYWu3i8z0ORcPwwxKhse/Ss724D8FiE9O28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=RlLZyskvjabd/1BTQ/vPl+7kSLIhmfgc9D3EDhvBo9WM/auatk5/apurjK3XHkXGl5
         j10PBRIUBwDaPj0WvkGiGZlnJp8/zyxH/BJtPWV5uwW2I4PtK8DPJfAkeCM9sUsvS5dO
         3VeFDA0xxHfDo4jRZ39UEkZY9tNDzeP0YMJKU=
Received: by 10.213.22.9 with SMTP id l9mr3206995ebb.5.1275383954228;
        Tue, 01 Jun 2010 02:19:14 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 14sm3659630ewy.10.2010.06.01.02.19.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 02:19:13 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275384022-12131-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148098>

When a patch is found to be empty, prompt the user to use either
--skip or --abort.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b779277..04f02a8 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -592,6 +592,8 @@ do
 
 		test -s "$dotest/patch" || {
 			echo "Patch is empty.  Was it split wrong?"
+			echo "If you would prefer to skip this patch, instead run \"$cmdline --skip\"."
+			echo "To restore the original branch and stop patching run \"$cmdline --abort\"."
 			stop_here $this
 		}
 		rm -f "$dotest/original-commit"
-- 
1.7.1
