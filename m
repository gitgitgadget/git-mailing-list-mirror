Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 346D81F78F
	for <e@80x24.org>; Sun, 30 Apr 2017 07:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164100AbdD3HyG (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 03:54:06 -0400
Received: from mout.web.de ([212.227.15.14]:62499 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1036635AbdD3HyF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 03:54:05 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M9oaG-1dFlF63a2q-00B7uN; Sun, 30
 Apr 2017 09:53:57 +0200
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>,
        Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <3df2b03f-ab86-09ac-0fc8-3c6eb10c6704@web.de>
 <edf33657-f74b-3cd5-44a7-8e16231bd978@web.de>
 <e30554f3-1aa3-acea-500b-6392fce902be@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
Date:   Sun, 30 Apr 2017 09:53:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <e30554f3-1aa3-acea-500b-6392fce902be@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:GV0yByO5401YickLXLlFNOosTARtVDNC3pKv5P22Q/4nWUvWRxX
 lFbQWRpiW/+oQtHzfILcxKUJehTcNK0zGlFLf/iok/uBRrJ+Bz5BgbQeEeYhNGkwBjN1HkQ
 e/2EVDFvHcnf/zRwnVt1/Gh/ZexFBW+9C9brI8bPDMgqjv+SNapwV83oFDxkLYmE5IBzB1B
 hvsL7QmnYTUx91YF81ohw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:TGsgOq1xg4o=:0Xh50QbewffHFv/q27x2Zf
 E/03dfe600gWHqmiHnXyCEUiPR50iHR/OVafBvsO4VcDMslGwqZ5h44dGvt2TypdcdAofWq0B
 FMUqjY1BDjEDGFxzQv2RMhLx3lzEwMfbfoQod3n57nNZBgsc28I8EGPg5BYYwwQr8uwr3ibLX
 ZgSqEGk7CFF8JFHCJiqoMZn9L4B2uSl9bXqcPP03/o/9AvEjn/ui8WHAGMnOa65PrVrgg/grj
 qoUWQTHmu44J7OkmjGAzdC1OksstWlZanudHnZs5qwIx5B56lZiaikfUqR4h+9+x4YT961pcX
 7JeLjfcJr6el8n78qrKLgtwiAn6WPGZlYwLfKgG+1Vsvp4rpD5d6Vxn+BPruGfk2L026OqGLV
 lF+QMR4+r+MEJjxi0P8ELQQ0Kq+p7+2StHv9cQbCj+mPB+DrzoMyWWqkjEDziSdxhqojp3CZB
 RHlES6j/Rg7kBzqwXchoxUdET353g1RpsvOwQdj6EDSAp4Ml3v6b3Zjep73nrZRFmOQdqxTHN
 mdjnkepqEUkR64YfdPz/iG7iZcy5XidkI2TaQ5JaNSB9SAqSYZa3FSpIlGoqlVObJfEWzi+ll
 skoEAn0iK1OTZYao7c6j2S38SrPHuYNVm4X70IfOG3coulgcleMJsD9+GXUp5tiaEVxGwTE3u
 Aeitg1StuD7pcFHKTewQYCEKua4DI12rkd051S8d4JGCK3VkHJb6LQQmUhmmmp0Je01hNZ/Gi
 vGCKUMsp0U9oJ6k8Z2Gs/s6vKpSJGBgh1TXRpV7ak6Vhj1a44auNjhGITLVG1y4n9uVCQcqHm
 sUBszOU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.04.2017 um 07:31 schrieb Torsten Bögershausen:
> Sorry, I was not looking careful enough, the macro `$GIT_UNZIP`
> gave the impression that an unzip provided by Git (or the Git test 
> framework) was used :-(
> 
> $ which unzip
> /usr/bin/unzip
> 
> $ unzip -v
> UnZip 5.52 of 28 February 2005, by Info-ZIP.  Maintained by C. Spieler.  
> Send
> bug reports using http://www.info-zip.org/zip-bug.html; see README for 
> details.
> 
> Latest sources and executables are at ftp://ftp.info-zip.org/pub/infozip/ ;
> see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.
> 
> Compiled with gcc 4.2.1 Compatible Apple LLVM 7.0.0 (clang-700.0.59.1) 
> for Unix on Aug  1 2015.
> 
> UnZip special compilation options:
>          COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
>          SET_DIR_ATTRIB
>          TIMESTAMP
>          USE_EF_UT_TIME
>          USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
>          USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
>          VMS_TEXT_CONV
>          [decryption, version 2.9 of 05 May 2000]
> 
> UnZip and ZipInfo environment options:
>             UNZIP:  [none]
>          UNZIPOPT:  [none]
>           ZIPINFO:  [none]
>        ZIPINFOOPT:  [none]

OK, so they indeed still ship the old version of unzip that doesn't
support big files.

> ok 13 # skip zip archive with files bigger than 4GB (missing ZIPINFO of 
> EXPENSIVE,UNZIP,ZIPINFO)

And if you had zipinfo then this test would certainly fail.

Anyway, thanks for running these expensive tests!  You could retry
with unzip version 6.00 and its zipinfo if you want.  But we
certainly need the following patch:

-- >8 --
Subject: [PATCH] t5004: require 64-bit support for big ZIP tests

Check if unzip supports the ZIP64 format and skip the tests that create
big archives otherwise.  Also skip the test that archives a big file on
32-bit platforms because the git object systems can't unpack files
bigger than 4GB there.

Reported-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 t/t5004-archive-corner-cases.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 9106c53c4c..fd23c75f59 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -27,6 +27,9 @@ check_dir() {
 	test_cmp expect actual
 }
 
+test_lazy_prereq UNZIP_ZIP64_SUPPORT '
+	"$GIT_UNZIP" -v | grep ZIP64_SUPPORT
+'
 
 # bsdtar/libarchive versions before 3.1.3 consider a tar file with a
 # global pax header that is not followed by a file record as corrupt.
@@ -155,7 +158,8 @@ test_expect_success ZIPINFO 'zip archive with many entries' '
 	test_cmp expect actual
 '
 
-test_expect_success EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
+test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
+	'zip archive bigger than 4GB' '
 	# build string containing 65536 characters
 	s=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef &&
 	s=$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s &&
@@ -178,7 +182,8 @@ test_expect_success EXPENSIVE,UNZIP 'zip archive bigger than 4GB' '
 	"$GIT_UNZIP" -t many-big.zip
 '
 
-test_expect_success EXPENSIVE,UNZIP,ZIPINFO 'zip archive with files bigger than 4GB' '
+test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
+	'zip archive with files bigger than 4GB' '
 	# Pack created with:
 	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
 	mkdir -p .git/objects/pack &&
-- 
2.12.2
