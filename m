From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 4/5] t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND
Date: Tue, 17 Aug 2010 09:24:41 +0000
Message-ID: <1282037082-12996-5-git-send-email-avarab@gmail.com>
References: <20100817080322.GA28476@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 17 11:26:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlIRO-0001Ud-AA
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 11:26:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081Ab0HQJ0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 05:26:21 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40116 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757317Ab0HQJ0O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Aug 2010 05:26:14 -0400
Received: by wyb32 with SMTP id 32so6801688wyb.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=yoGbhN4qJ3DjWSRB4SuDQY+hALk/KeaOtbAM06lpkas=;
        b=gecPIDP8R+hA9HP9tZXx7fJccsbTO8BuMqGJIKu3BV13G8/95GW7bGWis4SmOS6vGb
         4s2S8QSb3LG5vK6NJre6pAIuwcLOD1O1dV0X+NDZq86wp2mXrFwV8fqO8OnqkgJRAvcW
         Bhra+Vzc4sn1NiSMGuwURkRckqswbpp12r0t4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=rryV7bztKknetfAa+EKUlTtvfdfYoou6rTAjno3+s6hE/cnEX+JDLgxtvPGGM2BhBe
         cPjqwrrSe3LsqcJx+qRO6u3F1p1r3Y94GJiv/+QI0JmcBBTweoQwCQYvsU9dLhtMlxvG
         YaFOk3hq3zlvGYaGAy/7I1klvYhMneJ5RRzUQ=
Received: by 10.216.11.131 with SMTP id 3mr507771wex.92.1282037172824;
        Tue, 17 Aug 2010 02:26:12 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id w14sm3916254weq.33.2010.08.17.02.26.11
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 02:26:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.389.gc3d0b
In-Reply-To: <20100817080322.GA28476@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153738>

Now that we have a regex engine that supports REG_STARTEND this test
should fail if "git grep" can't grep NULL characters.

Platforms that don't have a POSIX regex engine which supports
REG_STARTEND should always define NO_REGEX=3DYesPlease when compiling.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Acked-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t7008-grep-binary.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t7008-grep-binary.sh b/t/t7008-grep-binary.sh
index eb8ca88..c0f9f3f 100755
--- a/t/t7008-grep-binary.sh
+++ b/t/t7008-grep-binary.sh
@@ -61,7 +61,7 @@ test_expect_success 'git grep -Fi iLE a' '
=20
 # This test actually passes on platforms where regexec() supports the
 # flag REG_STARTEND.
-test_expect_failure 'git grep ile a' '
+test_expect_success 'git grep ile a' '
 	git grep ile a
 '
=20
--=20
1.7.2.1.389.gc3d0b
