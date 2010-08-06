From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 3/3] t/README: Document the predefined test prerequisites
Date: Fri,  6 Aug 2010 21:19:25 +0000
Message-ID: <1281129565-26124-4-git-send-email-avarab@gmail.com>
References: <1281129565-26124-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 06 23:20:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhUKv-0005ak-BH
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 23:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821Ab0HFVUB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Aug 2010 17:20:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51612 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab0HFVT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 17:19:56 -0400
Received: by mail-wy0-f174.google.com with SMTP id 39so8201142wyb.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 14:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=kXlEIDNfYio3wPq84tkkPQ4WivcKDghn6R0yyO7pQJg=;
        b=EHYKo3pc8HyTYKTcm8ERhAv8lPEaf3ELdLB5uAlN2lT9P0RsWhxM0GMedyVmWSBkBQ
         eJ3e9IGhD/poxGFj6s7jI8tx23Iu9ATTTKGUN1k+er4A7DDJLuPybFqwDii5hf4B/vba
         YuvvWTtZSnpC3I7gCpr9FTT5KI+uCHdHRizUw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=lqPuOxDxzPClInJIRsu5GcGcLNUrmgpYpkblO+lli3ZEbRwVGR5mQfgNpVFYmzTfuJ
         bmf41tMTR74/aC8gQlipUkZsewc+qJzUoGrEmYMNe1MWmFYJwfQLy9RcUtcobGI3OIJr
         erNCKve8yImkY/jdT4q4P/62FFADMAxtrGjr0=
Received: by 10.227.157.198 with SMTP id c6mr10919675wbx.144.1281129595093;
        Fri, 06 Aug 2010 14:19:55 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id k7sm1167559wej.2.2010.08.06.14.19.53
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 14:19:54 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1281129565-26124-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152815>

The README for the test library suggested that you grep the
test-lib.sh for test_set_prereq to see what the preset prerequisites
were.

Remove that bit, and write a section explaining all the preset
prerequisites. Most of the text was lifted from from Junio C Hamano
and Johannes Sixt, See the "Tests in Cygwin" thread in May 2009 for
the originals:

    http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=
=3D118385
    http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=
=3D118434

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/README |   45 ++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/t/README b/t/README
index d07b67a..dc07939 100644
--- a/t/README
+++ b/t/README
@@ -410,11 +410,12 @@ library for your script to use.
  - test_set_prereq SOME_PREREQ
=20
    Set a test prerequisite to be used later with test_have_prereq. The
-   test-lib will set some prerequisites for you, e.g. PERL and PYTHON
-   which are derived from ./GIT-BUILD-OPTIONS (grep test_set_prereq
-   test-lib.sh for more). Others you can set yourself and use later
-   with either test_have_prereq directly, or the three argument
-   invocation of test_expect_success and test_expect_failure.
+   test-lib will set some prerequisites for you, see the
+   "Prerequisites" section below for a full list of these.
+
+   Others you can set yourself and use later with either
+   test_have_prereq directly, or the three argument invocation of
+   test_expect_success and test_expect_failure.
=20
  - test_have_prereq SOME PREREQ
=20
@@ -487,6 +488,40 @@ library for your script to use.
 		...
 	'
=20
+Prerequisites
+-------------
+
+These are the prerequisites that the test library predefines with
+test_have_prereq.
+
+See the prereq argument to the test_* functions in the "Test harness
+library" section above and the "test_have_prereq" function for how to
+use these, and "test_set_prereq" for how to define your own.
+
+ - PERL & PYTHON
+
+   Git wasn't compiled with NO_PERL=3DYesPlease or
+   NO_PYTHON=3DYesPlease. Wrap any tests that need Perl or Python in
+   these.
+
+ - POSIXPERM
+
+   The filesystem supports POSIX style permission bits.
+
+ - BSLASHPSPEC
+
+   Backslashes in pathspec are not directory separators. This is not
+   set on Windows. See 6fd1106a for details.
+
+ - EXECKEEPSPID
+
+   The process retains the same pid across exec(2). See fb9a2bea for
+   details.
+
+ - SYMLINKS
+
+   The filesystem we're on supports symbolic links. E.g. a FAT
+   filesystem doesn't support these. See 704a3143 for details.
=20
 Tips for Writing Tests
 ----------------------
--=20
1.7.1
