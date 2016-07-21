Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F048F203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 16:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753275AbcGUQDp (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 12:03:45 -0400
Received: from mout.gmx.net ([212.227.15.15]:50848 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbcGUQDo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 12:03:44 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lg0sd-1ayJHt18At-00ph5M; Thu, 21 Jul 2016 18:03:38
 +0200
Date:	Thu, 21 Jul 2016 18:02:54 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>
Subject: [PATCH] test-lib: on FreeBSD, look for unzip(1) in /usr/local/bin/
Message-ID: <31dce0b28ae094c976890c1604c4ebbcaef0e7ef.1469116960.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:7VWWBATWETSCPqmzS82muQilBeLNjGvBhdtx7vFNQB6jCoWSoNv
 e6aD6Lz9SP7wvTddLbS5NMTONxGby6SFab1J96am0Hom4iZlDuTQM7mc58nz4GtxHxnad4g
 tccR1xGYpf+M4CAK6zX1arNTG2hpzpFV9G4rD4qYnWp3KVtJpKz49tTOS4HpMbVhNp1UdUv
 s1AfSUnwvEupsEkiTmusA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:/fLTMdsZmDE=:6cfSm5Fshg+QQc2xwgk+bc
 3HGWr3ea6HJiSRj1DVNQpwhDgbrrlvmKBx1ZS9Z7oT15taai4IEGvH2iZuK+L7vn9Uq0FfrgJ
 51OSB9Dc/yiCdyIFCdgOQ6X7vFrItBlQUEgbxEDbcqRseKhqdhJNN4T03fuS8QMBly4151A7q
 VAfSfrn0wUpW79GDCZQASO3IUYXdi2E/Npi9et/RUN50snUAWcZGkpVjkrQ94qXHPSOpnmR13
 HC+GvA/lAJXSyj8BiFOpayg8SfGZymCdg3XFiomF2S4SjyHdvjbMCeBdtQBz6nuelcyYADhMG
 NIBwnumgaWFi8nxNbyodhMKdJSB5YFQlyXnJJoAY8/r7Xg2TQcD768Zzuuaq5v85cug9XO6f1
 Igr2KxjWAKw+RYeguZO/0le5z35507QTtXLSqMJaUKM9lTW6Z8rQXY7beiBTZ5ITi+97sTKSP
 +ulRrQy3EN8OvClLHJGC4hsEFOjUol/fdPfflBCmETzUhrHjDHJAURJ6Gng9xSxete3xE2FEs
 L/7ba3xZNxrdqAXyzURDrhhb6st/2lA17Kcu6MIZ9sTmrQI9rJ1QtmbbnpTUAocrRFCLoZhuV
 1IEuVERJYrFVdbr6O97J5CN8xyj7uZKaTBUR7nxdzZvsPaPBQ/nidAkFDHjO0fgrigu8Q+a0L
 UOwFNFHiDgJlHlKdYVc5+CW82vCvR+i91drpQ8wueO7vYZRSznfMkwMEFex6Jejo49N942oYU
 J8vB5lfY5F0zgMCnLOmMCvY3DkTbvecadmNhxT60EL4Kki3HP5F72nwoJjt1XZl3lveQDkdx5
 6IEmnJQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Eric Wong reported that while FreeBSD has a /usr/bin/unzip, it uses
different semantics from those that are needed by Git's tests: When
passing the -a option to Info-Zip, it heeds the text attribute of the
.zip file's central directory, while FreeBSD's unzip ignores that
attribute.

The common work-around is to install Info-Zip on FreeBSD, into
/usr/local/bin/.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
Published-As: https://github.com/dscho/git/releases/tag/freebsd-unzip-v1
 t/test-lib.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 11201e9..dd2f70c 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -929,7 +929,8 @@ yes () {
 }
 
 # Fix some commands on Windows
-case $(uname -s) in
+uname_s=$(uname -s)
+case $uname_s in
 *MINGW*)
 	# Windows has its own (incompatible) sort and find
 	sort () {
@@ -1100,6 +1101,7 @@ test_lazy_prereq SANITY '
 	return $status
 '
 
+test FreeBSD != $uname_s || GIT_UNZIP=${GIT_UNZIP:-/usr/local/bin/unzip}
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 test_lazy_prereq UNZIP '
 	"$GIT_UNZIP" -v
-- 
2.9.0.281.g286a8d9

base-commit: 29493589e97a2de0c4c1c314f61ccafaee3b5caf
