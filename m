Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1F3B1FC3E
	for <e@80x24.org>; Sun, 30 Apr 2017 05:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426291AbdD3Faz (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 01:30:55 -0400
Received: from mout.web.de ([212.227.17.12]:65023 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939133AbdD3Fax (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 01:30:53 -0400
Received: from [192.168.209.79] ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1G68-1dxm090AVU-00tE7l; Sun, 30
 Apr 2017 07:30:49 +0200
Subject: Re: [PATCH v3 0/5] archive-zip: support files and archives bigger
 than 4GB
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
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
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <e30554f3-1aa3-acea-500b-6392fce902be@web.de>
Date:   Sun, 30 Apr 2017 07:31:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <edf33657-f74b-3cd5-44a7-8e16231bd978@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:pd/EUp1tDHpa3zBlIxsB+RCWgZP09hOhsB4he8I/5I5Z7XsRnwp
 f2s9TiaFRnTEjQeYT4Qe3TwPCBOwaBk4RWdq/uI/LlcddKLzP4ujMeBLeXn0NqAoQzGSLzR
 5EXdutAfBIzKwsNIcIKsfmcvDbt4D6306w8S6MS0NK+bR8iotijFYarrNdt95+02+R75i21
 WUXevXxfwxrp41ZptzsTg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yzSVtZFgDzM=:+rM01s7esFTYcSWSvxyo7V
 wKF4yAFA0XI878FLX6svoHloqkUL851/LewX7th0E2IxESJw9DsFkWNzUqxSY6a7eUYFutg8s
 12XhrQIqEDel/akQ8Pg2UltsiCda4dmuobQ8OMZw321qB5wBm9HvYvj4gqXKKraXw4p4eRmSo
 cjw/RiZTurenmvGX7Abd49DtW4jp7NYJ6HivomzHwOzYQJ2p4Wl51Zn7yarj5H1nYZJDN75G8
 GBqyX0W+DFRN1NrtgyIgFCfyiXr5OTbJ0hKAR9rCMdxL9o6imF9SNeZKL2+4jOMHkHrBDFIbx
 DYUbURlEvTQCbcZTnfTts9nPa4R5pqL72j0gIF19SWMDL1aLcYpyyS0Z0xCGx/vhRvwtdE+yi
 rbW6/7cZgehPQzhHA9p3O07qKfK7E5Ua9XGztdu6ZTQwwM+48kfIyfGH7LtZjsPIIHvgseXG8
 WOKQjmnuIprCRhjRWAcA+3lRJqlEB6gsvEAPQxrn20CTnM1NjNjZBT4hY0E7kcRwf9vFVbO2H
 kWgAxCbjP80kIKdSQPqEHhyIOC+zNIOEfLf7ckbL0jypxCbyRRAfFQ9sVFu3p//7ZPVx5Zinv
 /eLcPawMAbfp2QIfMZjub076W21a4hKRNy1/yiYy8PJqW0GZiME5hH8uo93szn2UQWMZAeT0O
 byUoxzVXFtACfoK/WLLZrfH+KKfOeswUCgMnGpbGz1oRT4pF0SVKfYi4KyjpF9y5EvHH5r6ai
 uC2+FHqsXM2NWHzEhbUivCKoYIriXmRT5BS6Itfzz3LzdFvqncXQW5vYMFPTTFINNhKeWEL79
 gphbOk8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 30/04/17 00:28, René Scharfe wrote:
> Am 29.04.2017 um 23:00 schrieb Torsten Bögershausen:
>> This fails here under Mac OS:
>> commit 4cdf3f9d84568da72f1dcade812de7a42ecb6d15
>> Author: René Scharfe <l.s.r@web.de>
>> Date:   Mon Apr 24 19:33:34 2017 +0200
>>
>>      archive-zip: support files bigger than 4GB
>>
>> ---------------------------
>> Parts of t5004.log, hope this is helpful:
>>
>> "$GIT_UNZIP" -t many-big.zip
>>
>> Archive:  many-big.zip
>> warning [many-big.zip]:  577175 extra bytes at beginning or within zipfile
>>    (attempting to process anyway)
>> error [many-big.zip]:  start of central directory not found;
>>    zipfile corrupt.
>>    (please check that you have transferred or created the zipfile in the
>>    appropriate BINARY mode and that you have compiled UnZip properly)
>> not ok 12 - zip archive bigger than 4GB
>> #	
>> #		# build string containing 65536 characters
>
> Which version of unzip do you have (unzip -v, look for ZIP64_SUPPORT)?
> It seems that (some version of?) OS X ships with an older unzip which
> can't handle big files:
>
>    https://superuser.com/questions/114011/extract-large-zip-file-50-gb-on-mac-os-x
>
> Is the following check (zip archive with files bigger than 4GB) skipped,
> e.g. because ZIPINFO is missing?  Otherwise I would expect it to fail as
> well.
>
> René
>

Sorry, I was not looking careful enough, the macro `$GIT_UNZIP`
gave the impression that an unzip provided by Git (or the Git test framework) 
was used :-(

$ which unzip
/usr/bin/unzip

$ unzip -v
UnZip 5.52 of 28 February 2005, by Info-ZIP.  Maintained by C. Spieler.  Send
bug reports using http://www.info-zip.org/zip-bug.html; see README for details.

Latest sources and executables are at ftp://ftp.info-zip.org/pub/infozip/ ;
see ftp://ftp.info-zip.org/pub/infozip/UnZip.html for other sites.

Compiled with gcc 4.2.1 Compatible Apple LLVM 7.0.0 (clang-700.0.59.1) for Unix 
on Aug  1 2015.

UnZip special compilation options:
         COPYRIGHT_CLEAN (PKZIP 0.9x unreducing method not supported)
         SET_DIR_ATTRIB
         TIMESTAMP
         USE_EF_UT_TIME
         USE_UNSHRINK (PKZIP/Zip 1.x unshrinking method supported)
         USE_DEFLATE64 (PKZIP 4.x Deflate64(tm) supported)
         VMS_TEXT_CONV
         [decryption, version 2.9 of 05 May 2000]

UnZip and ZipInfo environment options:
            UNZIP:  [none]
         UNZIPOPT:  [none]
          ZIPINFO:  [none]
       ZIPINFOOPT:  [none]

-------------------
And here is the longer log:
not ok 12 - zip archive bigger than 4GB
#
#               # build string containing 65536 characters
# 
s=0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef &&
# 
s=$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s &&
# 
s=$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s$s &&
#
#               # create blob with a length of 65536 + 1 bytes
#               blob=$(echo $s | git hash-object -w --stdin) &&
#
#               # create tree containing 65500 entries of that blob
#               for i in $(test_seq 1 65500)
#               do
#                       echo "100644 blob $blob $i"
#               done >tree &&
#               tree=$(git mktree <tree) &&
#
#               # zip it, creating an archive a bit bigger than 4GB
#               git archive -0 -o many-big.zip $tree &&
#
#               "$GIT_UNZIP" -t many-big.zip 9999 65500 &&
#               "$GIT_UNZIP" -t many-big.zip
#

skipping test: zip archive with files bigger than 4GB
         # Pack created with:
         #   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
         mkdir -p .git/objects/pack &&
         (
                 cd .git/objects/pack &&
                 "$GIT_UNZIP" "$TEST_DIRECTORY"/t5004/big-pack.zip
         ) &&
         blob=754a93d6fada4c6873360e6cb4b209132271ab0e &&
         size=$(expr 4100 "*" 1024 "*" 1024) &&

         # create a tree containing the file
         tree=$(echo "100644 blob $blob  big-file" | git mktree) &&

         # zip it, creating an archive with a file bigger than 4GB
         git archive -o big.zip $tree &&

         "$GIT_UNZIP" -t big.zip &&
         "$ZIPINFO" big.zip >big.lst &&
         grep $size big.lst

ok 13 # skip zip archive with files bigger than 4GB (missing ZIPINFO of 
EXPENSIVE,UNZIP,ZIPINFO)

# failed 1 among 13 test(s)
1..13


