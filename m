From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 25/51] i18n: git-submodule "cached cannot be used" message
Date: Sun,  3 Apr 2011 16:45:49 +0000
Message-ID: <1301849175-1697-26-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QSK-00055g-7D
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752992Ab1DCQq4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:46:56 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1DCQqz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:55 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=yNfqoRTfHQM9FcjFZQwGQzi1WoP39pDMeEQn9xAkjBw=;
        b=Uzu1RdNjWF2GTU9g/35Cy8l/okJuKCvhvkCVFQqpJhU1dY8M8bPiyXagAfhsAAycur
         as06VSpPsdVd+iXcxtoue5znQBP6i6V5aHbL58XqDfwgaHkA3yst3Tag0DUyjnh1hbdG
         /yuMQS6gSS86lo/BA8MH7cCR2CYk6to3+BqRI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=o3dlDWtiOwBhFYXmGs27U+W681yCguteu1eNnF0yUNC7Wt/X+6HOKKEzkGVs2D8/nF
         s7CGeZs7Beics95l+64Nq44BiAIUgEKBC7fYaRmu/C0NN0VjALwexAPtu0MRm3icVSCb
         3j7o4Fj7haOqgv9i8hPt+cE7GJfUfgt/4hdNw=
Received: by 10.213.21.24 with SMTP id h24mr3139648ebb.117.1301849214366;
        Sun, 03 Apr 2011 09:46:54 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.53
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:53 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170717>

Gettextize the "--cached cannot be used with --files" message. Since
this message starts with "--" we have to pass "--" as the first
argument. This works with both GNU gettext 0.18.1 (as expected), and
the gettext(1) on Solaris 10.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index c35fab0..28523b7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -588,7 +588,7 @@ cmd_summary() {
 	if [ -n "$files" ]
 	then
 		test -n "$cached" &&
-		die "--cached cannot be used with --files"
+		die "$(gettext -- "--cached cannot be used with --files")"
 		diff_cmd=3Ddiff-files
 		head=3D
 	fi
--=20
1.7.4.1
