From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv6 14/16] t7800 (difftool): add missing &&
Date: Sun,  3 Oct 2010 14:00:12 -0600
Message-ID: <1286136014-7728-15-git-send-email-newren@gmail.com>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, avarab@gmail.com, jrnieder@gmail.com,
	Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 03 21:59:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Uif-0002yx-1i
	for gcvg-git-2@lo.gmane.org; Sun, 03 Oct 2010 21:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902Ab0JCT7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Oct 2010 15:59:18 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52092 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0JCT7P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 15:59:15 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so1157426pxi.19
        for <git@vger.kernel.org>; Sun, 03 Oct 2010 12:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=IfkbAMuWoCgN+raYVwkgZ3WLu2GJa7BLPz2CNNWfsLk=;
        b=nRdwQif19ZsdutVuQ5sbjMSdPfQQRRzJFrW4P3HDms1TEQpetQ0gbCI6PMZtig+YiF
         ti8rZyj3bOO63p4TWKMm4TRoNDgWQeNQzE9WngyjMYeQC87VtoHnpi3Y2mwzYLMcZ/WI
         FOhI6IuaHpc0KTb2f4yunZ3CIm+pG/25HShb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=BvVjd3ZjrVrsHY5x8eoFJydVVl9Ns3Vo90soKgELM8AO222r3RSxFheaU3y36MjsGN
         9L87c1wGGieNvTAIic4u4NRz7wsPwAtdcFoQsfbt/BAYBjemI//9QofuYp5QXZeb1AHm
         PYxHidmIcrOowli7l1NIc3Tp/JOS49+aa9sIc=
Received: by 10.114.102.20 with SMTP id z20mr10101627wab.133.1286135955596;
        Sun, 03 Oct 2010 12:59:15 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id d2sm7661138wam.14.2010.10.03.12.59.13
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 03 Oct 2010 12:59:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.1.66.gab790
In-Reply-To: <1286136014-7728-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157905>

Also remove a call to 'git config --unset difftool.prompt', since that =
is
already unset by restore_test_defaults.

Acked-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7800-difftool.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 58dc6f6..4048d10 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -98,7 +98,7 @@ test_expect_success PERL 'difftool --gui works withou=
t configured diff.guitool'
=20
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success PERL 'GIT_DIFF_TOOL variable' '
-	git config --unset diff.tool
+	test_might_fail git config --unset diff.tool &&
 	GIT_DIFF_TOOL=3Dtest-tool &&
 	export GIT_DIFF_TOOL &&
=20
@@ -166,7 +166,7 @@ test_expect_success PERL 'difftool.prompt config va=
riable is false' '
=20
 # Test that we don't have to pass --no-prompt when mergetool.prompt is=
 false
 test_expect_success PERL 'difftool merge.prompt =3D false' '
-	git config --unset difftool.prompt
+	test_might_fail git config --unset difftool.prompt &&
 	git config mergetool.prompt false &&
=20
 	diff=3D$(git difftool branch) &&
@@ -211,7 +211,7 @@ test_expect_success PERL 'difftool last flag wins' =
'
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success PERL 'difftool + mergetool config variables' '
-	remove_config_vars
+	remove_config_vars &&
 	git config merge.tool test-tool &&
 	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
=20
@@ -254,17 +254,17 @@ test_expect_success PERL 'difftool -x cat' '
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
1.7.3.1.66.gab790
