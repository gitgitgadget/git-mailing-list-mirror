From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 5/8] t/README: Document test_external*
Date: Thu,  1 Jul 2010 20:17:55 +0000
Message-ID: <1278015478-6920-6-git-send-email-avarab@gmail.com>
References: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 22:18:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUQDj-0003QZ-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 22:18:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755956Ab0GAUSk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 16:18:40 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56807 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755913Ab0GAUSj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 16:18:39 -0400
Received: by mail-wy0-f174.google.com with SMTP id 23so986337wyf.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=eWENqo7yWWVTdEqO1JtqR3YwxsDzT6HumkHRFjDmzok=;
        b=gpEVyrriF768VkkIKdqekf5e+9JmHo/7VFOTWEAep8sZfo/fZX/IupDIYRrnkamIzQ
         t7yTzgMYdtMqaEcdPYs4cBakGgutuRMCeWLj5ki+CrOZLSgNCjqZil2We57WRi9rFHPg
         swQ1+liuaIO3BAcWmuT8zsMSFEggxu4vUbDRo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=U/ogxcPn8zl4XeG63cfzermFXe2xqwvRydr9IzUCjaRlfHNdBOljlVIT1elSfyRHaS
         AB+5aNsv6GYAPkCoshXulwAiWqiOLD7Q3sp0bCrhvkV/+/EU1cFDnzUfIo8rYg4z2ROQ
         elLIycoHlO47osEyliPCqMuIDeC9uiP2LZV1A=
Received: by 10.213.4.146 with SMTP id 18mr27255ebr.11.1278015518510;
        Thu, 01 Jul 2010 13:18:38 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v8sm261986eeh.14.2010.07.01.13.18.36
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 13:18:37 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1278015478-6920-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150076>

There was do documentation for the test_external_without_stderr and
test_external functions.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 2df56a8..d9b5294 100644
--- a/t/README
+++ b/t/README
@@ -330,6 +330,33 @@ library for your script to use.
 	    test_done
 	fi
=20
+ - test_external [<prereq>] <message> <external> <script>
+
+   Execute a <script> with an <external> interpreter (like perl). This
+   was added for tests like t9700-perl-git.sh which do most of their
+   work in an external test script.
+
+	test_external_without_stderr \
+	    'Perl API' \
+	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+
+   If the test is outputting its own TAP you should set the
+   test_external_has_tap variable somewhere before calling the first
+   test_external* function. See t9700-perl-git.sh for an example.
+
+	# The external test will outputs its own plan
+	test_external_has_tap=3D1
+
+ - test_external_without_stderr [<prereq>] <message> <external> <scrip=
t>
+
+   Like test_external but fail if there's any output on stderr,
+   instead of checking the exit code.
+
+	test_external_without_stderr \
+	    'Perl API' \
+	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+
+
 Tips for Writing Tests
 ----------------------
=20
--=20
1.7.1.251.g92a7
