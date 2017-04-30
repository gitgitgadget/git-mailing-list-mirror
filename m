Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EE221F829
	for <e@80x24.org>; Sun, 30 Apr 2017 13:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032752AbdD3NG4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 09:06:56 -0400
Received: from mout.web.de ([212.227.15.14]:50297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032541AbdD3NGy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 09:06:54 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LvS9z-1e4Rim0rXH-010bK6; Sun, 30
 Apr 2017 15:06:47 +0200
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
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
 <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <1448ad65-126a-41a0-cc1c-49d54aed3f26@web.de>
Date:   Sun, 30 Apr 2017 15:06:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <d8a1edfc-e4d6-2bd2-7b07-a1a10d89490a@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:9/oboQR7tcVQG3PJVFtKPWl5k/4qy3sxEwdtTRuNzDCIoN8Fafc
 WruUtIz8zsyC2zHykC4xaJjsFl+M0SpblZVRhnq2rMNJLcdWc6xc3wDK/1LaPE+i7HInoaX
 7Z83ybNQH19XAZDR63wwft14tAxE6w6hh89BiR42GH3zDcxqfM/Y+ejTz1dQM3+KOiFATLV
 PcVeNtFI+TZhhu2zs++zQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mYXZC6Bx5M0=:nXPvIY6yYh3oczNMpF6Sqh
 wwjieruhQ9eXmqPonHStrD3I1yMR5tcHzH0E6txLGDY6iSJ/2xjzzetB78NlD70xSqbGbDwpr
 ocTXvwtAn7xLALNXfeEruc4but8I8DTuvHjPxGsQcSAz5j1XZ10gpngIphUsOAMo77Ora0Wu+
 4GhyuWOqUIfkTPemMn1mNDEmGtygfGdnAm6orfThN7UMalscT5lSDMT3XkIXsH2ixN+OmxziH
 7dFWvRx4Tdl+ivV4PIi8ULsWRv/D5AVTv972JUxYA1gJGhC7DYsp3e7Jgq5qLyX0LC2sP0Efa
 1oFovOej39MIhfTQsGce4eErOQhfWn5dIH4i7iSY0bMNaGV5nXu02Ahel35eXz0U3O+4hsxUo
 R7muijQF5CeTbLXPltQXIYYljSiwZQo4woQX8KrVwGsJfWhEiLodf8AD5WoQPuB7SBiX8UriI
 0m2AHSRtnaeyRqiTrroOt99IskaIEaHoo2UhbSlbqgm3Pmd9r2NPvt/06p4Glc8jfM5DGSYfp
 e35RD88wC5yIr6Scp9WHpgK2JQu3V2toI4vQDpznaok5AQ4e8b7l+xV1kscED4I3ZynQJATxx
 89OEN7d+xH+//IK6+1miXVj9NK3yBy5ZQlR9UIcfNoDM5Kg8ZKDSeNwlIIsC7UFFKkOg530ql
 1x3vn9T/7W0jkGXeFeS5QQ/spC2KNAu7k1zAfxfxxkdiQIcPDSWPmyLEP2AvNCOpimpiX8udT
 /RS7P1Ra3jYfILL6Q/v+pzBePJZpA2hBcupUwqmG9amE5FVJwD7vpO0jb+Zf0BaiCrpon1Uj2
 w69VdbD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-04-30 09:53, René Scharfe wrote:
> Am 30.04.2017 um 07:31 schrieb Torsten Bögershausen:
>> Sorry, I was not looking careful enough, the macro `$GIT_UNZIP`
>> gave the impression that an unzip provided by Git (or the Git test 
>> framework) was used :-(
>>
>> $ which unzip
>> /usr/bin/unzip
>>
>> $ unzip -v
>> UnZip 5.52 of 28 February 2005, by Info-ZIP.  Maintained by C. Spieler.  
>> Send
>> bug reports using http://www.info-zip.org/zip-bug.html; see README for 
>> details.
>>
>> Latest sources and executables are at ftp://ftp.info-zip.org/pub/infozip/ ;
>> see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.
>>
>> Compiled with gcc 4.2.1 Compatible Apple LLVM 7.0.0 (clang-700.0.59.1) 
>> for Unix on Aug  1 2015.
>>
>> UnZip special compilation options:
>>          COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
>>          SET_DIR_ATTRIB
>>          TIMESTAMP
>>          USE_EF_UT_TIME
>>          USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
>>          USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
>>          VMS_TEXT_CONV
>>          [decryption, version 2.9 of 05 May 2000]
>>
>> UnZip and ZipInfo environment options:
>>             UNZIP:  [none]
>>          UNZIPOPT:  [none]
>>           ZIPINFO:  [none]
>>        ZIPINFOOPT:  [none]
> 
> OK, so they indeed still ship the old version of unzip that doesn't
> support big files.
> 
>> ok 13 # skip zip archive with files bigger than 4GB (missing ZIPINFO of 
>> EXPENSIVE,UNZIP,ZIPINFO)
> 
> And if you had zipinfo then this test would certainly fail.
> 

After installing unzip via mac ports, I have:

$ which zipinfo
/opt/local/bin/zipinfo

$ which unzip
 /opt/local/bin/unzip

$ unzip -v
UnZip 6.00 of 20 April 2009, by Info-ZIP.  Maintained by C. Spieler.  Send
bug reports using http://www.info-zip.org/zip-bug.html; see README for details.

Latest sources and executables are at ftp://ftp.info-zip.org/pub/infozip/ ;
see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.

Compiled with gcc 4.2.1 Compatible Apple LLVM 7.0.2 (clang-700.1.81) for Unix
Mac OS X on Jan 31 2016.

UnZip special compilation options:
        COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
        SET_DIR_ATTRIB
        SYMLINKS (symbolic links supported, if RTL and file system permit)
        TIMESTAMP
        UNIXBACKUP
        USE_EF_UT_TIME
        USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
        USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
        VMS_TEXT_CONV
        [decryption, version 2.11 of 05 Jan 2007]

UnZip and ZipInfo environment options:
           UNZIP:  [none]
        UNZIPOPT:  [none]
         ZIPINFO:  [none]
      ZIPINFOOPT:  [none]


> Anyway, thanks for running these expensive tests!  You could retry
> with unzip version 6.00 and its zipinfo if you want.  But we
> certainly need the following patch:
> 

The 6.0 is not compiled with ZIP64_SUPPORT....
After manually doing a copy-paste of your patch from below, tests are skipped:

ok 11 - zip archive with many entries
ok 12 # skip zip archive bigger than 4GB (missing UNZIP_ZIP64_SUPPORT of
EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT)
ok 13 # skip zip archive with files bigger than 4GB (missing UNZIP_ZIP64_SUPPORT
of EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO)

[patch snipped]

