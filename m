From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v3 6/7] t/README: A new section about test coverage
Date: Sun, 25 Jul 2010 19:52:44 +0000
Message-ID: <1280087565-24671-7-git-send-email-avarab@gmail.com>
References: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 25 21:56:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od7JU-0005Uv-6R
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 21:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751733Ab0GYT4j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Jul 2010 15:56:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57032 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126Ab0GYT4i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 15:56:38 -0400
Received: by ewy23 with SMTP id 23so646558ewy.19
        for <git@vger.kernel.org>; Sun, 25 Jul 2010 12:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=9Bm2Z0Ek909xrvaeR8fBestx9qrs1sCWdV8eanveqak=;
        b=QOfSe0xcF40LTxZQyyP43PQrFAhIunkrQe01AYM3hBBuRNwb2wZDQsEwinJuGYFIjv
         fRJRYN4DRpYWqKX+ai+zjHyBWi/TPQKGQwQ3+KelQbDVZCdFU5jVLuK7RaIi51tX8VGR
         jET9862MAcwGw24OC+xnIQ9ovr0Yrqi/jR22A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=URrbakX8zsuafWtWn/gOQ1d8j1aVAkWocA3zqhcxMcUeBb+zhGdf8CNLjDPk+KpHLn
         LG42LvqVPR9HrgP5+079XPWZF1bnAqoS1yZIazZ8d6ldlIRYcGTRgUN1jwI5T0eGzD8y
         T90Wn0Vow6hlws2U6XXuBhDKEtosKjdP36wuU=
Received: by 10.213.7.2 with SMTP id b2mr5562182ebb.22.1280087593091;
        Sun, 25 Jul 2010 12:53:13 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-237-210.pools.arcor-ip.net [88.67.237.210])
        by mx.google.com with ESMTPS id a48sm4369452eei.19.2010.07.25.12.53.10
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 25 Jul 2010 12:53:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <1280087565-24671-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151788>

Document how test writers can generate coverage reports, to ensure
that their tests are really testing the code they think they're
testing.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/t/README b/t/README
index 0d1183c..15d4b52 100644
--- a/t/README
+++ b/t/README
@@ -268,6 +268,9 @@ Do:
 	git push gh &&
 	test ...
=20
+ - Check the test coverage for your tests. See the "Test coverage"
+   below.
+
 Don't:
=20
  - exit() within a <script> part.
@@ -508,3 +511,42 @@ the purpose of t0000-basic.sh, which is to isolate=
 that level of
 validation in one place.  Your test also ends up needing
 updating when such a change to the internal happens, so do _not_
 do it and leave the low level of validation to t0000-basic.sh.
+
+Test coverage
+-------------
+
+You can use the coverage tests to find code paths that are not being
+used or properly exercised yet.
+
+To do that, run the coverage target at the top-level (not in the t/
+directory):
+
+    make coverage
+
+That'll compile Git with GCC's coverage arguments, and generate a test
+report with gcov after the tests finish. Running the coverage tests
+can take a while, since running the tests in parallel is incompatible
+with GCC's coverage mode.
+
+After the tests have run you can generate a list of untested
+functions:
+
+    make coverage-untested-functions
+
+You can also generate a detailed per-file HTML report using the
+Devel::Cover module. To install it do:
+
+   # On Debian or Ubuntu:
+   sudo aptitude install libdevel-cover-perl
+
+   # From the CPAN with cpanminus
+   curl -L http://cpanmin.us | perl - --sudo --self-upgrade
+   cpanm --sudo Devel::Cover
+
+Then, at the top-level:
+
+    make cover_db_html
+
+That'll generate a detailed cover report in the "cover_db_html"
+directory, which you can then copy to a webserver, or inspect locally
+in a browser.
--=20
1.7.0.4
