From: Thomas Klausner <tk@giga.or.at>
Subject: cogito-0.16: t/test-lib.sh: Unportable test(1) construct
Date: Mon, 16 Oct 2006 03:05:20 +0200
Message-ID: <20061016010520.GS25390@danbala.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="V88s5gaDVPzZ0KCq"
X-From: git-owner@vger.kernel.org Mon Oct 16 03:05:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZGuz-00074S-7g
	for gcvg-git@gmane.org; Mon, 16 Oct 2006 03:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWJPBFW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Oct 2006 21:05:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWJPBFW
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Oct 2006 21:05:22 -0400
Received: from danbala.ifoer.tuwien.ac.at ([128.130.168.64]:49650 "EHLO
	danbala.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1751078AbWJPBFV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Oct 2006 21:05:21 -0400
Received: by danbala.tuwien.ac.at (Postfix, from userid 116)
	id 2932313A77D; Mon, 16 Oct 2006 03:05:20 +0200 (CEST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28942>


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

As of version 0.16, cogito is using an unportable bash extension
"==" for test(1) in t/test-lib.sh. This is not supported by most
other shells or even test(1) from GNU coreutils. Please use "="
instead. A patch is attached.

Thanks,
 Thomas

--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-aa

$NetBSD: patch-aa,v 1.1 2006/10/16 00:44:15 wiz Exp $

--- t/test-lib.sh.orig	2005-11-27 16:26:16.000000000 +0000
+++ t/test-lib.sh
@@ -87,16 +87,16 @@ test_failure_ () {
 	say "FAIL $test_count: $1"
 	shift
 	echo "$@" | sed -e 's/^/	/'
-	test "$immediate" == "" || exit 1
+	test "$immediate" = "" || exit 1
 }
 
 
 test_debug () {
-	test "$debug" == "" || eval "$1"
+	test "$debug" = "" || eval "$1"
 }
 
 test_expect_failure () {
-	test "$#" == 2 ||
+	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-failure"
 	say >&3 "expecting failure: $2"
 	if eval >&3 2>&4 "$2"
@@ -108,7 +108,7 @@ test_expect_failure () {
 }
 
 test_expect_success () {
-	test "$#" == 2 ||
+	test "$#" = 2 ||
 	error "bug in the test script: not 2 parameters to test-expect-success"
 	say >&3 "expecting success: $2"
 	if eval >&3 2>&4 "$2"

--V88s5gaDVPzZ0KCq--
