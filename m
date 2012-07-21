From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 6/7] Remove unused and bad gettext block from git-am
Date: Sat, 21 Jul 2012 23:50:55 +0800
Message-ID: <d1af1d40b0edbb8e356ecbb700cd0a7c13832a8f.1342884459.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
 <a7d2248051ddc62e38e67d9efbb41c01498c7a4c.1342884459.git.worldhello.net@gmail.com>
 <0fd901035a418562d3d9282553a96124814a298a.1342884459.git.worldhello.net@gmail.com>
 <77cbbce0450735a66ef1d9101af0bc82e3fc545c.1342884459.git.worldhello.net@gmail.com>
 <941f7bd695e8a14c940a5b8e4214d2773ae82557.1342884459.git.worldhello.net@gmail.com>
 <d5c4000b859f4b30af6fc3faec008403b82246bf.1342884459.git.worldhello.net@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 21 17:52:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ssbyz-0005VS-RD
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 17:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813Ab2GUPwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jul 2012 11:52:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55391 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab2GUPwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2012 11:52:25 -0400
Received: by mail-pb0-f46.google.com with SMTP id rp8so8041000pbb.19
        for <git@vger.kernel.org>; Sat, 21 Jul 2012 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=tqXOmhW4RdzRQY5sHzn2IDEOunVUOWzUWn98rp/rrmU=;
        b=upxIzEHIZHtZgmezzusP0Bn5dprvbFY9f0UPJxm6bSczFjZrqh5iYymqdygYquPjok
         7kDYT1TGzi+5Z4XyTFhPBpFhecISEcPBsO+k4vOhP94i7XXFpKOW7Wv8H93RTtoZ2KAX
         HLWiE3fAp4I6QPnRjHsYJv6f4E0hXQoV/VhTlQ/7jdzE5uvDlb5W+akkxcONBjJI4rJg
         hL8oPFI9PUX47Si5USuLPJuc3PKaE4kjpqjh6MIJBjKBT27qZJ58rBNZIAiGgffLC2b1
         hbP/hfkaBdRQrpD8BGd87eMBblWNOsGorinpNtitkMJoiXjhVlT5oi05hNSU3l6QSSyM
         JscQ==
Received: by 10.66.86.199 with SMTP id r7mr19375749paz.1.1342885945058;
        Sat, 21 Jul 2012 08:52:25 -0700 (PDT)
Received: from localhost.localdomain ([123.116.228.123])
        by mx.google.com with ESMTPS id nj4sm6241849pbc.5.2012.07.21.08.52.19
        (version=SSLv3 cipher=OTHER);
        Sat, 21 Jul 2012 08:52:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.2.259.g37fc0e1
In-Reply-To: <d5c4000b859f4b30af6fc3faec008403b82246bf.1342884459.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1342884458.git.worldhello.net@gmail.com>
References: <cover.1342884458.git.worldhello.net@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201816>

Gettext message should not start with '-' nor '--'. Since the '-d' and
'--dotest' options are not exist in OPTIONS_SPEC variable, so it's safe
to remove the block.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 git-am.sh | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/git-am.sh b/git-am.sh
index 20c1a..cfa63 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -413,9 +413,6 @@ it will be removed. Please do not use it anymore.")
 		abort=t ;;
 	--rebasing)
 		rebasing=t threeway=t ;;
-	-d|--dotest)
-		die "$(gettext "-d option is no longer supported.  Do not use.")"
-		;;
 	--resolvemsg)
 		shift; resolvemsg=$1 ;;
 	--whitespace|--directory|--exclude|--include)
-- 
1.7.11.2.259.g37fc0e1
