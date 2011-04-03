From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 40/51] i18n: git-stash drop_stash say/die messages
Date: Sun,  3 Apr 2011 16:46:04 +0000
Message-ID: <1301849175-1697-41-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTL-0005RJ-PK
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150Ab1DCQrQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:16 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753037Ab1DCQrN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:13 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=64YJC0ybxRFMABobZRLGG4rnBJu5IAMphngScz4s6FE=;
        b=NK2kZNc7V+60MC0UrOpzfAV93BFVKwn2bfiZzTLxgjDsNi77pMtomNkhsnAKtPI/ZN
         BRe8pqj5FPUBRWDuqlqmx3FK74dVFDtFQzxZ+V/20ysAo3GxiEGk8M9QzjGOX/1cf1K1
         elQKWvIHH6hGScbmlpiNuBNWUR5Jk7RxEV2sM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=mxjU3dMj50k05VdCLP8SkFSCZKcpuKkHql08j/n4LT2vXjKo0sJIpqZUD2HBpFg9Tu
         Yld8okOEr7hEvf2cdBHuxYB/oAQEBDIQUgLJphL5V/waEk3cya52BbbfdIDbP+XpypX0
         brYaAFISnZL2s9bhUCpYz/fBJ/tck74cpQP64=
Received: by 10.213.107.79 with SMTP id a15mr1161672ebp.86.1301849232621;
        Sun, 03 Apr 2011 09:47:12 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.11
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170740>

Gettextize the say/die eval_gettext messages in the drop_stash
function. Since making these translatable would result in a long line
I've wrapped this into two lines.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 0468499..5f00bf7 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -433,7 +433,8 @@ drop_stash () {
 	assert_stash_ref "$@"
=20
 	git reflog delete --updateref --rewrite "${REV}" &&
-		say "Dropped ${REV} ($s)" || die "${REV}: Could not drop stash entry=
"
+		say "$(eval_gettext "Dropped \${REV} (\$s)")" ||
+		die "$(eval_gettext "\${REV}: Could not drop stash entry")"
=20
 	# clear_stash if we just dropped the last stash entry
 	git rev-parse --verify "$ref_stash@{0}" > /dev/null 2>&1 || clear_sta=
sh
--=20
1.7.4.1
