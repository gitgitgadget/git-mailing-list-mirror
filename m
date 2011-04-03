From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 16/51] i18n: git-pull split up "no candidate" message
Date: Sun,  3 Apr 2011 16:45:40 +0000
Message-ID: <1301849175-1697-17-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSH-00055g-Va
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882Ab1DCQqt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:49 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33259 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848Ab1DCQqq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:46 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505908ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=94j9rqc83u+wWg+LR7jSX+mKKll+quGLEnHnQ+qUQmE=;
        b=tXJB8Pyj+RufoIisWn4ZjDml4ocXuH/rESUP2rQo9zAIppHgDJ6fIXMo8y877CoJBo
         /kCzPuoxLPmEMji0/aLiFB/MHI+s+vXXbVzSRgGA3pNOTTussQWkY3tz/0pdDsp2HBiw
         avs1vu+L78wTUm05Gt7tofQgu763pRAenMgho=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=XiOBQdoAZKCP7j8eQc4Tzo6v/nLq5ALZT4cuWvOqxRZoNPhgaru0ciB3fjPLpdDeDu
         j3dDkM6O1m6HS+gCzwKl3bAWmdWSLVEUSw8EpSSYNU74gNekrAVeuTOgXcXlXb/nX6As
         2bECYEHllkB3lMu5DWiXV97ERdOIkjppqLKG0=
Received: by 10.14.123.205 with SMTP id v53mr2999203eeh.217.1301849205739;
        Sun, 03 Apr 2011 09:46:45 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.45
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:45 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170712>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index e8e534a..95b1fb2 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -155,13 +155,14 @@ error_on_no_merge_candidates () {
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
1.7.4.1
