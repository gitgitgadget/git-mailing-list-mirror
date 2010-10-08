From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [TopGit PATCH 10/10] [RFC] tg-patch: simulate mnemonic prefixes
Date: Fri,  8 Oct 2010 09:58:08 +0200
Message-ID: <101fe6e1e47292faa21770ab3a5a0b204897ac63.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
 <0e1f993f68d36f0c3d848c2aa78f46c7130a24f1.1286524446.git.bert.wesarg@googlemail.com>
 <f8601225b41e5f03b50688c0582466879faaff26.1286524446.git.bert.wesarg@googlemail.com>
 <c013d1489409b5d6e76764aba07eca7107715691.1286524446.git.bert.wesarg@googlemail.com>
 <724f5482452ad11bd3fb8560bacb080fa1cef0a4.1286524446.git.bert.wesarg@googlemail.com>
 <66f0cf2d3c7d2778616fa51bd8d81eb04d0528f6.1286524446.git.bert.wesarg@googlemail.com>
 <009a8ed75bd5dcee636e049b11a1bf3ca8ee6fc7.1286524446.git.bert.wesarg@googlemail.com>
 <39cbbf4b56e79fe95d603d2f1aa6112c89150bff.1286524446.git.bert.wesarg@googlemail.com>
 <0fd777939e0ca49b6e0013ab667cadbfae55e879.1286524446.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Fri Oct 08 09:58:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P47qs-00020q-9D
	for gcvg-git-2@lo.gmane.org; Fri, 08 Oct 2010 09:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755337Ab0JHH6j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 03:58:39 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47865 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755221Ab0JHH6g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 03:58:36 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so77566bwz.19
        for <git@vger.kernel.org>; Fri, 08 Oct 2010 00:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=moAbZP30SuYgovV0y6hQkmGhBMOeHpZtXHgz6gkY6Fk=;
        b=XqKDAMb1wbD//D/FhaeOcL6EATCAAKmCWy2APxhQu7KGe1XEU/IV4luCgkBdl/Ro1l
         2+k21HelpaTrw+zYipmZJoVIgE24RSrI5Lylf+hGq03k4+LPW4EHTwVfvulMGAl6ZP3u
         cOHOD91UpX2NfqLbedzr273BkvHc15FcN9oQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=BXS4NOyuIxbNShdUS7z1pHfycMKPbXkYrnKlN/oUp9f749PT7C9phW0CKGoN3diNNE
         KkQOZR/vKK9lMzDhUDML58UOJCnUZ6yWNjxE8N5Zjp4TidJH6lci8oI/AuUbs91Mc/04
         UVgrEJCCgxvVO40SwvpoMC6z6qxfiN7ZKJlDU=
Received: by 10.204.55.20 with SMTP id s20mr1666551bkg.168.1286524716287;
        Fri, 08 Oct 2010 00:58:36 -0700 (PDT)
Received: from localhost (p5B0F732C.dip.t-dialin.net [91.15.115.44])
        by mx.google.com with ESMTPS id o12sm1167486bkb.9.2010.10.08.00.58.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 08 Oct 2010 00:58:35 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.1067.g5aeb7
In-Reply-To: <0fd777939e0ca49b6e0013ab667cadbfae55e879.1286524446.git.bert.wesarg@googlemail.com>
In-Reply-To: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
References: <160b8b0eb6152da98f4fa633ac25c7a25ff32aa4.1286524446.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158489>

b/ is for base, i/ and w/ correspond to -i/-w and t/ is the committed
topic.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 tg-patch.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tg-patch.sh b/tg-patch.sh
index dcce672..c8ad723 100644 tg-patch.sh
--- a/tg-patch.sh
+++ b/tg-patch.sh
@@ -6,7 +6,7 @@
 name=
 
 head_from=
-
+dst_prefix="t/"
 
 ## Parse options
 
@@ -15,7 +15,8 @@ while [ -n "$1" ]; do
 	case "$arg" in
 	-i|-w)
 		[ -z "$head_from" ] || die "-i and -w are mutually exclusive"
-		head_from="$arg";;
+		head_from="$arg"
+		dst_prefix="${arg#-}/";;
 	-*)
 		echo "Usage: tg [...] patch [-i | -w] [NAME]" >&2
 		exit 1;;
@@ -72,6 +73,9 @@ if [ $b_tree = $t_tree ]; then
 else
 	# use the ui diff command when the pager is active
 	diff_command=diff
+	if $(git config --bool diff.mnemonicprefix); then
+		diff_command="$diff_command --src-prefix=b/ --dst-prefix=$dst_prefix"
+	fi
 	[ "x$GIT_PAGER_IN_USE" = "x1" ] ||
 		diff_command=diff-tree
 
-- 
1.7.1.1067.g5aeb7
