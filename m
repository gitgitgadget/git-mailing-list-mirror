From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 37/48] i18n: git-stash drop_stash say/die messages
Date: Sat, 21 May 2011 18:44:18 +0000
Message-ID: <1306003469-22939-38-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:46:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrC1-0000od-QY
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757096Ab1EUSp6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:58 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42788 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756945Ab1EUSph (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:37 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444603eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=tNyLY8lh1lkUwgKSGUqf+f5Bn9ia4FuFS7TGFZ/p8YI=;
        b=Wi98YQBS2frPJ58+2oBvwN+4xwlhPy5U29EI3VtpIwUSsDvzp/G1JR7DtXIXSjM4m8
         DGv7iB4nNeI0rQdH2prDZYe6wDY37Z8QuBETEyFqjwPxxwhpR1Q5WB+ijfy/cPxze6SU
         EFwTZ9jay/fB/77wdnGsMK6dJFWyyTa4U26PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=L9EWUtVaZJwEH6J+HKQ3DFE9+TEd9RhzEEN9wc03aJHn7eUQGXihzRpNko8F7MRzbk
         rvJwGHrAZQklvEWoi/XEX0T0bV/AFHpShE6pY06zw3tfcpkslZf1T1plbwJDY0yFzL0d
         YFbgUtcAU621UTMtMyhbojQKhgcVAt2SejIhA=
Received: by 10.14.38.14 with SMTP id z14mr276746eea.169.1306003537185;
        Sat, 21 May 2011 11:45:37 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.36
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174138>

Gettextize the say/die eval_gettext messages in the drop_stash
function. Since making these translatable would result in a long line
I've wrapped this into two lines.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index fa6b560..c72ba49 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -430,7 +430,8 @@ drop_stash () {
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
1.7.5.1
