From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 16/48] i18n: git-pull eval_gettext + warning message
Date: Sun,  8 May 2011 12:20:48 +0000
Message-ID: <1304857280-14773-17-git-send-email-avarab@gmail.com>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 14:23:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ31Q-0004a3-9E
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 14:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754152Ab1EHMXh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 08:23:37 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50701 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098Ab1EHMVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2011 08:21:47 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1327021ewy.19
        for <git@vger.kernel.org>; Sun, 08 May 2011 05:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=6h45jEXzhPAW7ThFQXCbrFZP/wYFbEslEA1zv0EkNDs=;
        b=XXAdxLGuzhCesBrwQ+t1scUnoYRPss7qhjiHEPNj93h0plWYrRUyQtOzYFS49aSGln
         8UJUu9Ksg/vch7SMZ0WsXo/21dVv/PJNSdEYobJEzcGmsSDX2FM4qu/J8zw4A/08NFxZ
         rC86vvinwf/p7Pb9WhAJBYR9DgoGqjuUGsER4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Fgvwwkg6w87TNs/O0ir0PYUNRpge5O5BqqoBtAvLNMsrTk2J6Zb1R95F56HTZIb6wX
         Xw4pWqy2pDaxbiXOdaLEedrzNLiyZAeEiTw2jVSxlHNrKxAsCHeoxQxzQKCQ2t1YNHg3
         JkYOZT9KGJWvrL0w78CP3yrrpTpDx+BIbLgXo=
Received: by 10.213.103.65 with SMTP id j1mr661435ebo.79.1304857306589;
        Sun, 08 May 2011 05:21:46 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id n55sm2690046een.2.2011.05.08.05.21.45
        (version=SSLv3 cipher=OTHER);
        Sun, 08 May 2011 05:21:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.4
In-Reply-To: <1304857280-14773-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173146>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 06dcd81..79ba9ab 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -217,9 +217,9 @@ then
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
1.7.4.4
