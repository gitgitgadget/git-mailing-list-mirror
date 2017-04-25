Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513A51FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 16:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1948078AbdDYQZC (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 12:25:02 -0400
Received: from mout.web.de ([212.227.17.11]:64764 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1947162AbdDYQZA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 12:25:00 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxODe-1bwJjM3OVm-016zVG; Tue, 25
 Apr 2017 18:24:50 +0200
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
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fdc17512-94dc-4f7f-4fd3-f933e1b18e8f@web.de>
Date:   Tue, 25 Apr 2017 18:24:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704250851420.23677@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:ewIx6/oZtp7F+C7OucYDlfI1pwojuuDfKXFK4FxNdvVUuzJtc2Z
 OcgZIYz97CW0ENcForHfFy7CEciQkDLG0Zs7lg7WNG/H1aHgoJaloNxJYypZRouIbFt3iRL
 qATMwo5/3kZsgEzNdy9n7y2vPwM0tie0/Elb8sDomn+dEqFPp6VlFS53gR1QYdK2f+DIPT5
 3T+PSajvXfiPvT/ePSk5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B+tvgaclnIc=:UC1yvau38UYMIAo3vGqnxy
 7/oL/33IC6HeSe3dyTGRwoOv9BTMQLyyTW/KA39kTTZz6PbFEgtKaorJd3U0j15kaAc5ztqS6
 LfAHO0y47uhfJqUI0EZ8BaUNMunoHI0TiEwA/D6Ivdebemw57xKCpuYceEwPZZQtDD0o/GncL
 F7MZInD53/WdBLzPMW0yCMFHR4pHgNQY8o/affYRPJ1+Ugvd1dZ8Cg5wshm0vfTjvJUZleTVg
 m6PPcNYiRYSayIFH5UdCWBtho6ETd2YO6qV2zUJSwX3lHOIAjZyavMF2IJ6OdXeGU4Q/IfaUd
 4CxpEZvxWapm374nXwCQHGEojlxYifeVIE0zWgqtBpUT3G9eDiFu+QBmD5DXsKTgu08ghnrtn
 0whcMpHzqnwki2o9CNoDXvCJHFP73QN489L+dsqzzN5o5lsTppB12zT2fu88Lw686RdHfCMJh
 3iTF9igBva4fdX0/35d+bKJnJZTPlZYHgNfz1dNVN+zFagmZEzD047kheXpMI+hk5w1mDDBS4
 1nAn/9ndXBDqo0Fr8H1VItY+R/uVKmmEKozMJJJUHDm8c7y00iOQDWlPBw3Ado+J1E4BALutW
 Ie5C9D8FPL/lSExjWMC/5g3mlll+HpZVm2Z0ikL3tAahrRcExBiw3wwO2up4rXW/ZKopyJ8AV
 g00JeJuS0Z1Dqef8j1g57/uN55urp+vlV6q1J7KqtG1rYYHpoHAqFDUhCiAM4aTDbmSNtwCox
 yTzlPjEob20gARyawJan3Ij6WKcVtOnhjcYrxIV8lmaw0ivoHtPzdlWZgSEYak4g8+IYppTEH
 Nhe/VGr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 25.04.2017 um 09:55 schrieb Peter Krefting:
> René Scharfe:
> 
>>> This needs to be >=. The spec says that if the value is 0xffffffff, 
>>> there should be a zip64 record with the actual size (even if it is 
>>> 0xffffffff).
>> Could you please cite the relevant part?
> 
> 4.4.8 compressed size: (4 bytes)
> 4.4.9 uncompressed size: (4 bytes)
> 
> "If an archive is in ZIP64 format and the value in this field is 
> 0xFFFFFFFF, the size will be in the corresponding 8 byte ZIP64 extended 
> information extra field."
> 
> 
> Of course, there is no definition of how they define that "an archive is 
> in ZIP64 format", but I would say that is whenever it has any ZIP64 
> structures.

I struggled with that sentence as well.  There is no explicit "format"
field AFAICS.  The closest at the archive level are zip64 end of central
directory record and locator.  But what really matters is the presence
of a zip64 extended information extra field to hold the 64-bit size
value.

There's also this general note a bit higher up:

       "4.4.1.4  If one of the fields in the end of central directory
       record is too small to hold required data, the field should be
       set to -1 (0xFFFF or 0xFFFFFFFF) and the ZIP64 format record
       should be created."

My interpretation: An archiver that can only emit 32-bit ZIP files
(either because it doesn't support ZIP64 or due to a compatibility
option set by the user) writes 32-bit size fields and has no defined way
to deal with overflows.  An archiver that is allowed to use ZIP64 can
emit zip64 extras as needed.

Or in other words: A legacy ZIP archive and a ZIP64 archive can be
bit-wise the same if all values for all entries fit into the legacy
fields, but the difference in terms of the spec is what the archiver was
allowed to do when it created them.

	# 4-byte sizes, not ZIP64
	arch --format=zip ...

	# ZIP64, can use 8-byte sizes as needed
	arch --format=zip64 ...

Makes sense?

René
