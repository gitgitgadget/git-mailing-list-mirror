From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/24] Show usage string for 'git merge-one-file -h'
Date: Mon,  9 Nov 2009 09:04:53 -0600
Message-ID: <1257779104-23884-13-git-send-email-jrnieder@gmail.com>
References: <20091109150235.GA23871@progeny.tock>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 15:56:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7VfB-0002nn-AP
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 15:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbZKIOze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2009 09:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755712AbZKIOzb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 09:55:31 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:64393 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706AbZKIOz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 09:55:29 -0500
Received: by mail-ew0-f207.google.com with SMTP id 3so3179582ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 06:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=kxGPxhNCKzFgrGSGjaHKiXgtSMLd+QLFGmbJJJmalwA=;
        b=TUnTEhOhk8NFqq8y2EXdrKsLXNu0o1hgLxuc3s0q/TR+3AOYPR8yJK0gc6M1aUL5XH
         qP2nqG9TA5QlmrpMnim+sVEOwdSidAg/kHHGaKhSFiaDAT5ICS1sZvJuiBl2iguGYA0N
         KcDGkiHYTgkJImX3ML1kWd/fZNiKzYSt4ese0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=AKt3P+3KpyRt9h15+WOKFPQsk7s3XLWiTU42FOojkQaisIEFPs3PhwpqE7gSEOqbpx
         DBfXhKMVrZD7FgpGbIvl5YxLAWlIAHWzUQJDYSXBYfU4dN8Ywl1InC/d9LEuZMwHYXO5
         HsJnt5DD23gTLJXJYj90tkr8Ia9kNikkcIFww=
Received: by 10.216.93.1 with SMTP id k1mr322628wef.151.1257778534641;
        Mon, 09 Nov 2009 06:55:34 -0800 (PST)
Received: from localhost.localdomain (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id p37sm8922607gvf.9.2009.11.09.06.55.32
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 06:55:34 -0800 (PST)
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <20091109150235.GA23871@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132469>

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-merge-one-file.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/git-merge-one-file.sh b/git-merge-one-file.sh
index 9c2c1b7..d067894 100755
--- a/git-merge-one-file.sh
+++ b/git-merge-one-file.sh
@@ -16,6 +16,18 @@
 # been handled already by git read-tree, but that one doesn't
 # do any merges that might change the tree layout.
 
+USAGE='<orig blob> <our blob> <their blob> <path>'
+USAGE="$USAGE <orig mode> <our mode> <their mode>"
+LONG_USAGE="Usage: git merge-one-file $USAGE
+
+Blob ids and modes should be empty for missing files."
+
+if ! test "$#" -eq 7
+then
+	echo "$LONG_USAGE"
+	exit 1
+fi
+
 case "${1:-.}${2:-.}${3:-.}" in
 #
 # Deleted in both or deleted in one and unchanged in the other
-- 
1.6.5.2
