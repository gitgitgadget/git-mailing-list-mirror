From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv4 13/15] t7800 (difftool): add missing &&
Date: Sun, 26 Sep 2010 17:14:37 -0600
Message-ID: <1285542879-16381-14-git-send-email-newren@gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 27 01:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P00Pz-0005ch-9q
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 01:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758406Ab0IZXNc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Sep 2010 19:13:32 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43680 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758379Ab0IZXNb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Sep 2010 19:13:31 -0400
Received: by mail-pw0-f46.google.com with SMTP id 6so1036112pwj.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9/Xegrf/pWsPa4ZbyBB4ItlWLDzT47AP7nK7JH12lQ8=;
        b=e9+1PRsZkY7AraM+NopVQpESZVPoVCXpPyDHj1IUJakJWhSe+hyYxsGT67D8436Z5U
         U+7UWBSFNnENvczEy5FXA/O74K0zABmE9iP8z8CrAknnzz8NkgLB4tLTlY/wOo1o9n+7
         mAMfPVXC6t83PMhJ38Bsee4zOtuZXF6ceAOrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=egNM+xmgEomD2sPWtZqrqWsHvI9dU8KWhmQ2OXfqudtOjZYqpSuQJoAzv0wb+C8sHS
         ODSnsnnP9Uo2kGNryGW6kkKNcCo65JK5MCk3R9qSdb/oqCWDvSPDm3QmwKKh8imgHphI
         rfoEFRb38w/MNbJPTwap2vunwKtn41+UC39w0=
Received: by 10.114.26.16 with SMTP id 16mr7390089waz.16.1285542810729;
        Sun, 26 Sep 2010 16:13:30 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id c24sm9242157wam.19.2010.09.26.16.13.28
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 16:13:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285542879-16381-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157279>

Also remove a call to 'git config --unset difftool.prompt', since that =
is
already unset by restore_test_defaults.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7800-difftool.sh |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 58dc6f6..ffb1960 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -98,7 +98,7 @@ test_expect_success PERL 'difftool --gui works withou=
t configured diff.guitool'
=20
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success PERL 'GIT_DIFF_TOOL variable' '
-	git config --unset diff.tool
+	git config --unset diff.tool &&
 	GIT_DIFF_TOOL=3Dtest-tool &&
 	export GIT_DIFF_TOOL &&
=20
@@ -166,7 +166,6 @@ test_expect_success PERL 'difftool.prompt config va=
riable is false' '
=20
 # Test that we don't have to pass --no-prompt when mergetool.prompt is=
 false
 test_expect_success PERL 'difftool merge.prompt =3D false' '
-	git config --unset difftool.prompt
 	git config mergetool.prompt false &&
=20
 	diff=3D$(git difftool branch) &&
@@ -211,7 +210,7 @@ test_expect_success PERL 'difftool last flag wins' =
'
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success PERL 'difftool + mergetool config variables' '
-	remove_config_vars
+	remove_config_vars &&
 	git config merge.tool test-tool &&
 	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
=20
@@ -254,17 +253,17 @@ test_expect_success PERL 'difftool -x cat' '
 '
=20
 test_expect_success PERL 'difftool --extcmd echo arg1' '
-	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" bran=
ch)
+	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" bran=
ch) &&
 	test "$diff" =3D file
 '
=20
 test_expect_success PERL 'difftool --extcmd cat arg1' '
-	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branc=
h)
+	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branc=
h) &&
 	test "$diff" =3D master
 '
=20
 test_expect_success PERL 'difftool --extcmd cat arg2' '
-	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branc=
h)
+	diff=3D$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branc=
h) &&
 	test "$diff" =3D branch
 '
=20
--=20
1.7.3.95.g14291
