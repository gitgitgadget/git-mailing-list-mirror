From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 5/8] gettextize: git-pull split up "no candidate" message
Date: Mon, 13 Sep 2010 19:35:55 +0000
Message-ID: <1284406558-23684-6-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpP-0005HT-Kr
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab0IMTgU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:20 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56015 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0IMTgT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:19 -0400
Received: by mail-ey0-f174.google.com with SMTP id 6so2866593eyb.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=MECd6aa2jo0ShlrQN74AJyksHvlISGC67249xQNDWVU=;
        b=GSlfgaL739OOS46moZWEPmAZha8u4fe7wo0A80l0EokUQcsTWuhJ8QTXW/bDfr8S5l
         cv4aw6YvnpRGNKWb11l2U0wSIJxYwFkrVyk/wwR8CfiYAvK1INPeGu0KOshvry0GHy8/
         IezWRjXEE6Bp1RNF/xYtw9j2jr53JPDqs/e0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=G6853KRwCv87q5CsP+UTaBiqHKcqSnUYKbh/g5CuLllaKuh1SEF7z6o8B8rscv0ncI
         JN9EjNra9Sck57eeTJpUUDAu4qY+2BE88gMUlaWGFoA+8LiAsBF0Hl6ybr4cOZtDfy+m
         fVehS+aP4/4Oql2svUiElzAS78uDR6LIAwrnk=
Received: by 10.216.22.74 with SMTP id s52mr3031851wes.11.1284406578232;
        Mon, 13 Sep 2010 12:36:18 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.17
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156118>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index f42d3e3..bbb2a0a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -147,13 +147,14 @@ error_on_no_merge_candidates () {
=20
 	if [ $# -gt 1 ]; then
 		if [ "$rebase" =3D true ]; then
-			printf "There is no candidate for rebasing against "
+			gettext "There is no candidate for rebasing against among the refs =
that you just fetched.
+Generally this means that you provided a wildcard refspec which had no
+matches on the remote end."; echo
 		else
-			printf "There are no candidates for merging "
+			gettext "There are no candidates for merging against among the refs=
 that you just fetched.
+Generally this means that you provided a wildcard refspec which had no
+matches on the remote end."; echo
 		fi
-		echo "among the refs that you just fetched."
-		echo "Generally this means that you provided a wildcard refspec whic=
h had no"
-		echo "matches on the remote end."
 	elif [ $# -gt 0 ] && [ "$1" !=3D "$remote" ]; then
 		echo "You asked to pull from the remote '$1', but did not specify"
 		echo "a branch. Because this is not the default configured remote"
--=20
1.7.3.rc1.110.g6776a.dirty
