From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 5/8] t/README: Document test_external*
Date: Thu,  1 Jul 2010 21:18:20 +0000
Message-ID: <1278019100-8332-1-git-send-email-avarab@gmail.com>
References: <m3630zncwx.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 01 23:22:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OURDf-0004tz-8E
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 23:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131Ab0GAVWU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 1 Jul 2010 17:22:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58286 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759090Ab0GAVSf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 17:18:35 -0400
Received: by ewy23 with SMTP id 23so898108ewy.19
        for <git@vger.kernel.org>; Thu, 01 Jul 2010 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=lkmcUuV/QkHUItH0bKuu2ZHL2Uxgm+eBD+NPxXbXr7c=;
        b=tyXcI1m7VY0364sppORYBn9F4NmxabHfmEP2BSXiMYFa7IwWpDwMJ++rsEHKjQ3RY8
         sDu+VmozoLvsvyGC48kMdDhEtpBhageInsXoGgomR+k7GlHyvG1dzMvvRP4gz5eTkURS
         PGOwcgOAdkPZZsoGimCbVmO7ZvP9j3z2+uLW0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Mp0v9YC0BYpNHrI0NfWoUn1mrnDRpk26S+jEcdfpTxk0wfyWZHSfqCNZ2UDoks5TMd
         zEbdccr4cAejaiWaZtP9elLlS9VHSKtInHznW5Jt8l1mRUMFcDenqZyPiWzGbWm9zkAu
         uftI6tac3x/DjnNTZHeO8Tg0MrNLcO00e8Yuc=
Received: by 10.213.28.199 with SMTP id n7mr16878ebc.96.1278019113602;
        Thu, 01 Jul 2010 14:18:33 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id a48sm759065eei.7.2010.07.01.14.18.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 01 Jul 2010 14:18:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <m3630zncwx.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150084>

There was do documentation for the test_external_without_stderr and
test_external functions.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

On Thu, Jul 1, 2010 at 20:52, Jakub Narebski <jnareb@gmail.com> wrote:

> I think this example was to be about 'test_external'; currently it
> duplicates example for 'test_external_without_stderr'.

Quite correct. Here's a fixed patch that uses your example. Thanks.

 t/README |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 2df56a8..3c31cff 100644
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
+	test_external \
+	    'GitwebCache::*FileCache*' \
+	    "$PERL_PATH" "$TEST_DIRECTORY"/t9503/test_cache_interface.pl
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
