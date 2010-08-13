From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 08/10] t/t7105-reset-patch.sh: Add a PERL prerequisite
Date: Fri, 13 Aug 2010 20:40:11 +0000
Message-ID: <1281732013-18284-9-git-send-email-avarab@gmail.com>
References: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 13 22:41:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok149-0007V9-Do
	for gcvg-git-2@lo.gmane.org; Fri, 13 Aug 2010 22:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab0HMUlR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Aug 2010 16:41:17 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64062 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0HMUlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 16:41:13 -0400
Received: by mail-wy0-f174.google.com with SMTP id 32so3042025wyb.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 13:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=mrAq/qrg13VjGoyNNk2E056XXZ5gTo2MsYUpajG5SWw=;
        b=iKKMtrOVLLG9AQIU0GS/hD70N3JH4zlw22jhZlKSz51wEGrSpJN4meSJqtroMvKlZI
         RzhL1G6d3ZIX8H1TUa56WqG8TNjjjpTIAPeT28aHZnZ0tA3ftVCg5XGy+NHPSf0vThHS
         nAfaBn0NhHMgImZpy17OpdmHWhHkgkseP7wI4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=gHH25NCkLtga7feDedyL5uuy7cHc6PqjODFjV8Ot4ZyEmrWPy03m47uNSmBYorVmyn
         ovo3Ot5LIMavCww/7pVrolss034Dg+utaV7qBBGt7LY6JA0FjfRlT3BXrmXdhx8W9rL2
         TpJDPiRYv/DkrFLdTHR6PtV47tCFOg8VBFsZA=
Received: by 10.216.49.212 with SMTP id x62mr1704958web.55.1281732072493;
        Fri, 13 Aug 2010 13:41:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id e8sm1838298wej.46.2010.08.13.13.41.10
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 13 Aug 2010 13:41:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.338.gf2379
In-Reply-To: <1281732013-18284-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153495>

Change this test to declare a PERL prerequisite. These tests use the
-p switch, so they implicitly depend on Perl code, but nothing was
declaring this.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t7105-reset-patch.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7105-reset-patch.sh b/t/t7105-reset-patch.sh
index 4b629f7..9891e2c 100755
--- a/t/t7105-reset-patch.sh
+++ b/t/t7105-reset-patch.sh
@@ -3,7 +3,7 @@
 test_description=3D'git reset --patch'
 . ./lib-patch-mode.sh
=20
-test_expect_success 'setup' '
+test_expect_success PERL 'setup' '
 	mkdir dir &&
 	echo parent > dir/foo &&
 	echo dummy > bar &&
@@ -17,20 +17,20 @@ test_expect_success 'setup' '
=20
 # note: bar sorts before foo, so the first 'n' is always to skip 'bar'
=20
-test_expect_success 'saying "n" does nothing' '
+test_expect_success PERL 'saying "n" does nothing' '
 	set_and_save_state dir/foo work work
 	(echo n; echo n) | git reset -p &&
 	verify_saved_state dir/foo &&
 	verify_saved_state bar
 '
=20
-test_expect_success 'git reset -p' '
+test_expect_success PERL 'git reset -p' '
 	(echo n; echo y) | git reset -p &&
 	verify_state dir/foo work head &&
 	verify_saved_state bar
 '
=20
-test_expect_success 'git reset -p HEAD^' '
+test_expect_success PERL 'git reset -p HEAD^' '
 	(echo n; echo y) | git reset -p HEAD^ &&
 	verify_state dir/foo work parent &&
 	verify_saved_state bar
--=20
1.7.2.1.338.gf2379
