From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2 2/3] git am: Display some help text when patch is empty
Date: Wed,  2 Jun 2010 10:33:36 +0200
Message-ID: <1275467617-23065-3-git-send-email-artagnon@gmail.com>
References: <1275467617-23065-1-git-send-email-artagnon@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 02 10:38:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJjTL-0001qY-D8
	for gcvg-git-2@lo.gmane.org; Wed, 02 Jun 2010 10:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab0FBIil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jun 2010 04:38:41 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:44399 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076Ab0FBIik (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jun 2010 04:38:40 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2010 04:38:40 EDT
Received: by ewy23 with SMTP id 23so553325ewy.1
        for <git@vger.kernel.org>; Wed, 02 Jun 2010 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=A8rd5PrhHkvG+G/LO2EqA8egoTjjye1GnGvEHpDHXU0=;
        b=XNrzA4lJ5VnFXofl6p+KFjKHom8vOAVSzxGr/V1t92OBuFjcMtDpblPal+DrkTwLri
         lE+/sQLwD01If3r1E4Jp2cfF8nwiM9fwLdYM5gpWnV4uPs5Os3ZIU2cXmWOBHNbWWgn3
         E3AptqaY1q3E2VM6PXUEbcrJdziDnQh69fl+E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Oj4bBnxC1VASMyVpzux79CtYL5Z6I9bHG6r5lolrT3HpJHi0BPo2jZ0opLQTG6JKLY
         FzlojMVgmakORAHRZ6kxhz0XFqJT6KhMBk+pKTNNVJdcKaJFJ+HTFTgqYvs1zgEi3zRk
         wR5B+vFF05HLKhdsIGI7OslV4FEzrByXOwwOQ=
Received: by 10.213.19.197 with SMTP id c5mr4700786ebb.95.1275467540740;
        Wed, 02 Jun 2010 01:32:20 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id 15sm4298814ewy.12.2010.06.02.01.32.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 02 Jun 2010 01:32:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1275467617-23065-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148227>

When a patch is found to be empty, prompt the user to use either
--skip or --abort.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 git-am.sh |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index b75358b..a52c2b4 100755
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
