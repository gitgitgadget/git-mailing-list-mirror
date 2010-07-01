From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 5/8] t/README: Document test_external*
Date: Thu,  1 Jul 2010 15:10:01 +0000
Message-ID: <1277997004-29504-6-git-send-email-avarab@gmail.com>
References: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 17:19:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OULXx-0002zS-Gj
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 17:19:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756589Ab0GAPTR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 11:19:17 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61787 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755587Ab0GAPTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 11:19:16 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Jul 2010 11:19:16 EDT
Received: by wwb24 with SMTP id 24so12835wwb.1
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=eBAJ2IRv3KFYqPn4wL0hmicRb//f4uFoytr6F8NxWzU=;
        b=c30ov/Rgs2MrIFs8ZxEYGozaptlgTq0SW0kQkLDRsecUVADmPO7d8P69YEuKm7sHJb
         82CynBvCj8ujxH5hO3xnidyaQHt9cnihNosoXedt3kVPeZw0WSsPjLZKrO2gfKPAcR0H
         GJ+nRVx87s8fafyFGzDbuSQ5dvb8ID9q/QYW4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=azviLQHUGet/tcank1kRQRRDcZGymgu5JhllPfeTpWJ6cOyR8JCJAKiZG0twvG15Wg
         E6JlEU4V3WW5KOUicr3lf4br0Hh8+kF7wQyu7Q5dtMIMuOIwYugm7T+uYge7DPU6tigI
         8dVXIpAzyHTQDKgNImi2bcz3L7pn4LVLF4VqY=
Received: by 10.213.15.193 with SMTP id l1mr5743012eba.93.1277997052861;
        Thu, 01 Jul 2010 08:10:52 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm10377672eeh.12.2010.07.01.08.10.51
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 08:10:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277997004-29504-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150047>

There was do documentation for the test_external_without_stderr and
test_external functions.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 67f8f30..43d6d4d 100644
--- a/t/README
+++ b/t/README
@@ -329,6 +329,33 @@ library for your script to use.
 	    skip_all=3D'skipping perl interface tests, perl not available'
 	    test_done
 	fi
+   =20
+ - test_external [<prereq>] <message> <external> <script>
+=20
+   Execute a <script> with an <external> interpreter (like perl). This
+   was added for tests like t9700-perl-git.sh which do most of their
+   work in an external test script.
+  =20
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
+   =20
+ - test_external_without_stderr [<prereq>] <message> <external> <scrip=
t>
+=20
+   Like test_external but fail if there's any output on stderr,
+   instead of checking the exit code.
+=20
+	test_external_without_stderr \
+	    'Perl API' \
+	    "$PERL_PATH" "$TEST_DIRECTORY"/t9700/test.pl
+
=20
 Tips for Writing Tests
 ----------------------
--=20
1.7.1.251.g92a7
