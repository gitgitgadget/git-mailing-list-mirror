From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 10/12] gettextize: git-submodule "[...] path is ignored" message
Date: Mon, 13 Sep 2010 22:09:16 +0000
Message-ID: <1284415758-20931-11-git-send-email-avarab@gmail.com>
References: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 00:10:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvHEe-00079c-NH
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 00:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754972Ab0IMWK1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Sep 2010 18:10:27 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44144 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913Ab0IMWKV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 18:10:21 -0400
Received: by mail-wy0-f174.google.com with SMTP id 22so6742715wyf.19
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 15:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=G77mbsL0cY2VDOA3Vu1oOFG7Ila6bIefkVioHIbd2Ik=;
        b=gzYaqqA1VnmojyZJEko27DX9sdC8u1Oi9AmEqAm/c+o/N1eU3HtoqFiqI2hHR0Wo82
         PaPheN9GPhtO9iVSjqg3Bdnd/fK661gmsFzEE0BQCpgx9EhgusyBn+foYumfNCiI4maP
         WWSitKiQ3Abw7rXRkSZmToQOQrT6XZddz+82g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kHP/S5tSy8n6tKI1qaWt8Yun+fS9nF1kz+Me9G1Uzx/vlGuY2gtsgfErSUWEfDqo5f
         pdsAv1eaxZj8TPa7sjDdk2SpuPoIRdZ2mNc0sObmEEg4G5l2mnkScjmG0Y2q6EblfuJ8
         OmvS+iV8Z9l+DQRy8tFoXbi7ii/toCmqSzTFQ=
Received: by 10.216.150.219 with SMTP id z69mr3134034wej.75.1284415821064;
        Mon, 13 Sep 2010 15:10:21 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm4296416weq.9.2010.09.13.15.10.19
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 13 Sep 2010 15:10:19 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.220.gb4d42
In-Reply-To: <1284415758-20931-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156142>

Gettextize the "The following path is ignored" message. This is
explicitly tested for so we need to skip some tests with
NO_GETTEXT_POISON.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-submodule.sh           |    6 +++---
 t/t7400-submodule-basic.sh |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 6ec6aa5..cd37bf7 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -208,9 +208,9 @@ cmd_add()
=20
 	if test -z "$force" && ! git add --dry-run --ignore-missing "$path" >=
 /dev/null 2>&1
 	then
-		echo >&2 "The following path is ignored by one of your .gitignore fi=
les:" &&
-		echo >&2 $path &&
-		echo >&2 "Use -f if you really want to add it."
+		echo >&2 "$(eval_gettext "The following path is ignored by one of yo=
ur .gitignore files:
+\$path
+Use -f if you really want to add it.")"
 		exit 1
 	fi
=20
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 9bda970..0531dd1 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -86,7 +86,7 @@ test_expect_success 'submodule add' '
 	test_cmp empty untracked
 '
=20
-test_expect_success 'submodule add to .gitignored path fails' '
+test_expect_success NO_GETTEXT_POISON 'submodule add to .gitignored pa=
th fails' '
 	(
 		cd addtest-ignore &&
 		cat <<-\EOF >expect &&
--=20
1.7.3.rc1.220.gb4d42
