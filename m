Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E40D207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 23:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032854AbdDZXiO (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:38:14 -0400
Received: from mout.web.de ([217.72.192.78]:49265 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032845AbdDZXiM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:38:12 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXpdL-1dZjwV2x2V-00Wmcm; Thu, 27
 Apr 2017 01:38:08 +0200
Subject: Re: [PATCH v3 4/5] archive-zip: support archives bigger than 4GB
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
 <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
 <02ddca3c-a11f-7c0c-947e-5ca87a62cdee@web.de>
 <alpine.DEB.2.11.1704241912510.30460@perkele.intern.softwolves.pp.se>
 <d453610f-dbd5-3f6c-d386-69a74c238b11@web.de>
 <alpine.DEB.2.11.1704250851420.23677@perkele.intern.softwolves.pp.se>
 <fdc17512-94dc-4f7f-4fd3-f933e1b18e8f@web.de>
 <alpine.DEB.2.11.1704262154420.29054@perkele.intern.softwolves.pp.se>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <87470c8c-e061-e4b3-42fe-84a30858fc0d@web.de>
Date:   Thu, 27 Apr 2017 01:38:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704262154420.29054@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:G88Q2NHiKsKgi5VJzwNtzUBTLGsvc5vtiILYOlaNVxebJwm0lhM
 VOtCUH6u34/xojYFWnXjTPSajoQ2S8Pm9xPW0hcez6sqOaqxk8aIyZug1opBU/zFVWiSUZ8
 fgvX9ry4+lC8y8tyEUWuQfebkt9uKrWJv5hEsEDpsUiBCfCfS5WOPkQF2+b6beU3RYGbOZi
 kS/m8sj8oeYTTlI91wzyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3m2M8Mm0dWI=:Tjbl96qXcuLNIGsSIfxmqn
 HJabwjwWiALSBN7gbmYolqzCNvepP5bgUTuBEmFKFkUSmC0fp0lHjc35AT+jTQ1E9ef6PPiVx
 XLbgQf7sfOR/XowhBETX5xiVvmdiCQ1b8vClxx+VIFrsnwCVD9/wv8ch5mguLvYs9ZqyBlT3f
 YmAOJYg0Q/Dvr/jxCnqOuzr7xA9xkvQ+tNW34DL3TAbtayenXw6JZahnFRsOS79HlYpkH1GzU
 68bpMkdvyrgdcMmc4nMT/CyIIHiqeV/APIcR4OnkH+GmjjOT8HUjunlgjqRaLZrz3dSsj2/P5
 RqaXVLxR7Twza/oYWaZE6+9DHgSCZwCYXXEkEvM89wLcoqfJxB1CgDGGd9qa9YVbk9YvffDnz
 yPm5ujB780qzKQcEAQjhDt9HJFX5Y5QzO2w6gIXH3hq+2RqWsv1B+d+AuAlYDvJzzt5o01ceY
 ijd5s+6G8c6PrdRTFWmP2nlpLamYd60z8kPUDQoQVNym2vUMId45fWi6K4VG9CXvlFg24+rJ4
 cDZY0Slsmy5X+WRyvZpCOohFaf388/K8uy0OfWXtO6wXBFUcv6LLLxQsDtP5onT+4iiODJrtl
 ZrHpw/72e1mdQXasSs3ciTiSxlbsT8H001EtoZzX/t4lXCSMhHNPKmhqYmFeQnUWfXwRj8NSF
 3Q84Uox4zGKzm9tiT5qrN1vaP0Jr6deAnF8zH9skXJt5jKTuBEbMvXkSxXXIHWvQ40otK8liw
 ueRo/cNqyyPD1Kz13haj70/7C5SBTUG4Fu+U0GvgW2R+jvYEwQm7OidRDmTSyY8FzWY6A/jbz
 kd+yzf8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.04.2017 um 23:02 schrieb Peter Krefting:
> René Scharfe:
> 
>> I struggled with that sentence as well.  There is no explicit "format" 
>> field AFAICS.
> 
> Exactly. I interpret that as it is in zip64 format if there are any 
> zip64 structures in the archive (especially if there is a zip64 end of 
> central directory locator).

The crucial point is that I think the choice is per entry, i.e. if we
had to write a zip64 record for one file we can still emit a legacy
record for the next file that has a size of 0xffffffff.

>> Or in other words: A legacy ZIP archive and a ZIP64 archive can be 
>> bit-wise the same if all values for all entries fit into the legacy 
>> fields, but the difference in terms of the spec is what the archiver 
>> was allowed to do when it created them.
> 
> As long as all sizes are below (unsigned) -1, then they would be 
> identical. If one, and only one, of the sizes are equal to (unsigned) -1 
> (and none overflow), then it is up to intepretation whether or not a 
> ZIP64-aware archiver is allowed to output an archive that is not in 
> ZIP64 format. If any single size or value overflows the 32 (16) bit 
> values, then ZIP64 format is needed.

Sizes can be stored in zip64 entries even if they are lower (from a
paragraph about the data descriptor):

"4.3.9.2 When compressing files, compressed and uncompressed sizes
       should be stored in ZIP64 format (as 8 byte values) when a
       file's size exceeds 0xFFFFFFFF.   However ZIP64 format may be
       used regardless of the size of a file."

(But I don't see a benefit.)

>>     # 4-byte sizes, not ZIP64
>>     arch --format=zip ...
>>
>>     # ZIP64, can use 8-byte sizes as needed
>>     arch --format=zip64 ...
>>
>> Makes sense?
> 
> Well, I would say that it would be a lot easier to always emit zip64 
> archives. An old-style unzipper should be able to read them anyway if 
> there are no overflowing fields, right? And, besides, who in 2017 has an 
> unzip tool that is unable to read zip64? Info-Zip UnZip has supported 
> Zip64 since 2009.

Windows XP.  Don't laugh. ;)

If you write zip64 extras for all size records then an old extractor
will only see the value 0xffffffff in them and ignore the zip64 part --
or ignore the entries outright.

Writing zip64 records only as needed saves space -- and that's what
zipping is all about, isn't it?

Adding unnecessary zip64 records would produce different ZIP files than
earlier version of git archive.  That's not a strong argument as changes
to libz can potentially do the same, but it still might affect someone
who caches generated ZIP files.

What I sent matches the behavior of InfoZIP zip (modulo bugs).  Why not
follow their lead?

(And one of the bugs in my patches not setting the version field to 45
as you pointed out earlier already.  InfoZIP may forget to do that if it
uses a zip64 extra for recording the offset, but it does set the version
correctly for files bigger than 4GB.)

What do other archivers do?

But I think a more important question is: Can the generated files
be extracted by popular tools (most importantly Windows' built-in
functionality, I guess)?

René
