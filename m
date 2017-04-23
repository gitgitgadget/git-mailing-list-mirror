Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2DB1FE90
	for <e@80x24.org>; Sun, 23 Apr 2017 00:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427255AbdDWARH (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Apr 2017 20:17:07 -0400
Received: from mout.web.de ([212.227.17.12]:63680 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427247AbdDWARG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2017 20:17:06 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8hsl-1c5pz40Yx1-00wCTW; Sun, 23
 Apr 2017 02:17:01 +0200
Subject: Re: [PATCH] archive-zip: Add zip64 headers when file size is too
 large for 32 bits
To:     Johannes Sixt <j6t@kdbg.org>,
        Peter Krefting <peter@softwolves.pp.se>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <3C736801-6BB8-41CC-88FF-C42FC853A736@blackthorn-media.com>
 <alpine.DEB.2.11.1704222019420.12779@perkele.intern.softwolves.pp.se>
 <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <04ad7a06-969d-ffa5-b792-ccc1e7e45fd2@web.de>
Date:   Sun, 23 Apr 2017 02:16:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:HgbrKI+mbUoEjuMhcmt9ZfUazTBjbpH9rpbWsQsgWG2UQaCi0+t
 bb5aZ65gJa6YW/UefuV1YPx3hw6A4/ti8PKElUilM0xEuUQGE5KhwSBiIQzH1j/UNZrtEpl
 sWEhT2gBk82EBrKe9ruEhESi98cdmPxdWJIuwSo5GoOT5aglRgLjhVShPKqlEJLvCGwCAUH
 aIahMIqz81+eBzbGQxWmg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xMpEYVR9TEM=:BEpQUlx8wbf2bdp10+Pr1P
 RgNB+b2L2L728g3iBUZsAZM1QuFdKcOkP5pWYqp0QhsJTgUUDwLsrTr7ydJ5sflKf6AaK2QHu
 NBWXZfeaVSk6NY/k1mnAfozWCyN2MBvanQlj1JCuQuelt2mxIXoUVckYpfmotgMPrg/MVhTJ5
 JYlFRLHzYzsomS1/28UWxrCRSS8CxOxV4op31aE1Z28dwM4OIgfc0djruxaZOBrFn5zn04O1r
 qpQXtf9utNY/avyNw+rj61Qo4rUSBYQVAfFuJLiq6Uj8ZeXpPyJ+kPEjs0iWzNb/iKUC3FY8O
 99diQb94uAvo4d8Hudul0mRUn9wuzetrhiZff7KSDZxv7KxX9BtZMPtHtpcLP1JO0HZ/YHDx4
 RxX8MH2BXH/hcCa3GuN6+sc1QwqQC+LgP/Zsd+Y+S7+X1VEO78HtEwc911QmNF95puFAZAgoy
 zZB0MkPRcU7wguO1rwRdio6eaHL/vklhcJbB6oZN10IRYJ+WE1TICoVEg3l40sRs5lGddT5j6
 sihadgQOmg/Yil7wAzRbuo5/8b4FEQhZR+Uy/YlcUdUf3judhM+Dko6oWTM8TVVa+L8FwZjUt
 Mcv8HX9DzRZtpRHgT8nb6Gp5QnhlRN5QUfewJbB2nr9bTAp1D3jkqeLfPIHfN67Gxo4faeYo+
 omFJ96ndsWqcn0MbM5Z0m4vaupKANRIfieSSrHJR8PQ/1eOxSGfe2rcvPL3cIPu1BBCWUAHzP
 CoRwQQEQ78uDj+yR4uPXP6CATDpfz2WuFSkg/DJXYJ7CUxHky9Q/igTSbebuD2WyCR4CrBEvW
 RTwjGpg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.04.2017 um 23:52 schrieb Johannes Sixt:
> Am 22.04.2017 um 21:22 schrieb Peter Krefting:
>> @@ -279,6 +299,7 @@ static int write_zip_entry(struct archiver_args 
>> *args,
>>      int is_binary = -1;
>>      const char *path_without_prefix = path + args->baselen;
>>      unsigned int creator_version = 0;
>> +    int clamped = 0;
>>
>>      crc = crc32(0, NULL, 0);
>>
>> @@ -376,7 +397,7 @@ static int write_zip_entry(struct archiver_args 
>> *args,
>>      copy_le16(dirent.comment_length, 0);
>>      copy_le16(dirent.disk, 0);
>>      copy_le32(dirent.attr2, attr2);
>> -    copy_le32(dirent.offset, zip_offset);
>> +    copy_le32(dirent.offset, clamp_max(zip_offset, 0xFFFFFFFFU,
>> &clamped));
>>
>>      copy_le32(header.magic, 0x04034b50);
>>      copy_le16(header.version, 10);
>> @@ -384,15 +405,26 @@ static int write_zip_entry(struct archiver_args
>> *args,
>>      copy_le16(header.compression_method, method);
>>      copy_le16(header.mtime, zip_time);
>>      copy_le16(header.mdate, zip_date);
>> -    set_zip_header_data_desc(&header, size, compressed_size, crc);
>> +    set_zip_header_data_desc(&header, size, compressed_size, crc,
>> &clamped);
>>      copy_le16(header.filename_length, pathlen);
>> -    copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE);
>> +    copy_le16(header.extra_length, ZIP_EXTRA_MTIME_SIZE + (clamped ?
>> ZIP_EXTRA_ZIP64_SIZE : 0));
>>      write_or_die(1, &header, ZIP_LOCAL_HEADER_SIZE);
>>      zip_offset += ZIP_LOCAL_HEADER_SIZE;
>>      write_or_die(1, path, pathlen);
>>      zip_offset += pathlen;
>>      write_or_die(1, &extra, ZIP_EXTRA_MTIME_SIZE);
>>      zip_offset += ZIP_EXTRA_MTIME_SIZE;
>> +    if (clamped) {
>> +        struct zip_extra_zip64 extra_zip64;
>> +        copy_le16(extra_zip64.magic, 0x0001);
>> +        copy_le16(extra_zip64.extra_size, ZIP_EXTRA_ZIP64_PAYLOAD_SIZE);
>> +        copy_le64(extra_zip64.size, size);
>> +        copy_le64(extra_zip64.compressed_size, compressed_size);
>> +        copy_le64(extra_zip64.offset, zip_offset);
>> +        copy_le32(extra_zip64.disk, 0);
>> +        write_or_die(1, &extra_zip64, ZIP_EXTRA_ZIP64_SIZE);
>> +        zip_offset += ZIP_EXTRA_ZIP64_SIZE;
> 
> Is this correct? Not all of the zip64 extra fields are always populated. 
> Only those whose regular fields are filled with 0xffffffff must be 
> present. Since there is only one flag, it is not possible to know which 
> of the fields must be filled in.
> 
> Readers will most likely ignore trailing fields that should not be 
> there; however, when the offset exceeds 32 bits, but not the compressed 
> size, readers will pick the compressed size and interpret it as offset.

The offset is declared as unsigned int, so will wrap on most platforms
before reaching the clamp check.  At least InfoZIP's unzip can handle
that, but it's untidy.

The offset is only needed in the ZIP64 extra record for the central
header (in zip_dir) -- the local header has no offset field.  That said,
I haven't been able to implement proper 64 bit offset support so far.

René
