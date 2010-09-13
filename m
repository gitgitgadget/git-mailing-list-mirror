From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 4/8] gettextize: git-pull eval_gettext + warning message
Date: Mon, 13 Sep 2010 19:35:54 +0000
Message-ID: <1284406558-23684-5-git-send-email-avarab@gmail.com>
References: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 13 21:36:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvEpP-0005HT-4A
	for gcvg-git-2@lo.gmane.org; Mon, 13 Sep 2010 21:36:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755198Ab0IMTgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 15:36:18 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:49809 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187Ab0IMTgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 15:36:16 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6574868wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yI/qQpCvBQdX/VCkIFg0bAtECKDC4TltqBiPRi/sAVU=;
        b=uDq50P6cyVttzk3sl2Crjle0bUJ3SiONlCa2t02uxGXcUCxVyfuvKF8hMrrfgwODVV
         PfOMNe67jRsvh9RFOUybKQb1V9/SJh2Yt9HIGvgiBDxv4jeybIJzswsp25mrQZ3PMlHv
         bU4L5r9gK6UsuQewKWFOv/13moYFUV/7PdMUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Z7+lic6xwxiz1d0aoBNTRKWZ8Ai+CNGCK5FVkqZU86dD1mm06Lfn9/plO37MDEKrvr
         xwxpMODvM3Hz4S/vDoTCERZL9PH3Y3vsNAxs6JgY78mvq3z5XOBQgJyG+BXpjBYD714B
         UL9UIypWczIVHaSIfKmiNXt9FpywFnD9VtFXw=
Received: by 10.216.188.209 with SMTP id a59mr2984750wen.87.1284406576060;
        Mon, 13 Sep 2010 12:36:16 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm4178195wej.2.2010.09.13.12.36.15
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 12:36:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.110.g6776a.dirty
In-Reply-To: <1284406558-23684-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156117>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 99837dd..f42d3e3 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -233,9 +233,9 @@ then
 	# $orig_head commit, but we are merging into $curr_head.
 	# First update the working tree to match $curr_head.
=20
-	echo >&2 "Warning: fetch updated the current branch head."
-	echo >&2 "Warning: fast-forwarding your working tree from"
-	echo >&2 "Warning: commit $orig_head."
+	echo >&2 "$(eval_gettext "Warning: fetch updated the current branch h=
ead.
+Warning: fast-forwarding your working tree from
+Warning: commit \$orig_head.")"
 	git update-index -q --refresh
 	git read-tree -u -m "$orig_head" "$curr_head" ||
 		die "$(eval_gettext "Cannot fast-forward your working tree.
--=20
1.7.3.rc1.110.g6776a.dirty
