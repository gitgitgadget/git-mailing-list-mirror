From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 15/51] i18n: git-pull eval_gettext + warning message
Date: Sun,  3 Apr 2011 16:45:39 +0000
Message-ID: <1301849175-1697-16-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:49:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QUZ-0005ya-Dx
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:49:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753339Ab1DCQso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:48:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:59126 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab1DCQqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:46:45 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so1505877ewy.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Y1jAMd4lt2t940LPa+ojjrTYaK8dH9Cb6GkylE60wI0=;
        b=n8c2jmw9mtG3yWysV1YpfkcJn7kjJwo5W9uD2nRCq03RarXzdl+N/YSIU4qW5HjtR/
         160eD6qd4VsStJTXkw/n2eD+UDDCa37saplsnggkD4hQNTixQ0AAHrtevjrvpjG2drbR
         07OZVNpjmR6AiomAexTlSIQEmTa3piu2q1aLI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=ISdFPDLz3+NO/2KMmwjOG6tvOdfJm++Pi0f+l0MbG7ZFkW6bEHzjRDIfMpM/5GiYK8
         yOVXTO93mfnAxS9adMLUetWxe8Wi5AWxMl6nvL2GDQ6hs6wnHXu8KMZ+6CiIyjDyOxwR
         siHRvtfqGT0anUGukbX9jlUPm5Ie29TQBRJIk=
Received: by 10.14.37.76 with SMTP id x52mr2871272eea.27.1301849204946;
        Sun, 03 Apr 2011 09:46:44 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.46.43
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:46:44 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170756>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-pull.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index 36f34d6..e8e534a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -239,9 +239,9 @@ then
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
1.7.4.1
