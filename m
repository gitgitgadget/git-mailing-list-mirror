Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B7EE207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 19:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422748AbdD0TzJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 15:55:09 -0400
Received: from mout.web.de ([212.227.17.12]:51687 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1422739AbdD0TzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 15:55:00 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5OYl-1e27vM1fgN-00zau6; Thu, 27
 Apr 2017 21:54:55 +0200
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
 <87470c8c-e061-e4b3-42fe-84a30858fc0d@web.de>
 <alpine.DEB.2.11.1704270552590.4681@perkele.intern.softwolves.pp.se>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a9cb6572-500e-bbc6-2aac-7cb940d4b171@web.de>
Date:   Thu, 27 Apr 2017 21:54:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.11.1704270552590.4681@perkele.intern.softwolves.pp.se>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:7mjuY4j9Mca4Is9MZVpiAzqQtHzBSW+cts0lOBmr7VOqoY1CyFY
 KxPtTDS8ZiGIgLuO+MbfaFCuDaRGMDufNqHm/ikKvaOdokdKZtx3spfgpZ1fs8z6pjgOgPZ
 dQe2qR4kNqsGyQXV8ZzpOrZwGLuJOQrpZAv7VDpgIUAx6hsGYU/F3gk4tj9cUVFnUCnvtqb
 KNfe6U611QW6zLr5Bbe7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wCopf7jU0wQ=:wNcbRUuimkPaHqk9ezDprG
 z0aCli+1G3beyjMhMMKDEy/++tSZfi5zjYYhIkrd3IRTa1urJIhgqK+7L1Ju7ArOiS0dLuKDS
 cpg0Vnc4ObalC8z10VbJf5miaTfqb1GDqxR0tNBgjmy50j38sSxMbCTj+TxSWoVvZWbadWnK3
 GJM9PgNsV25I71VaINeY7K9lDjBNF0BDZMZ30/DE8S6aTH7QMnmDGwlMGXu+3ZytOmnrqjqsA
 fRbxhKO5NX4vlqZ8Ieda3gAPCxQBR0jgZj0fZx8N/vsHhbjdZV05CAWOIEB2ycAqeGmEYJ+D6
 ZwbcfYeyYHcwf8R4Yw3vrB4h9JBBl+MSLoylr6SMzgo489Cwy9lNML4c1dU73sdWHCfqx8zol
 ab02Tgvvrdjz1jJawYiCukcjNECQpLTmcGJNboGvV1TE9fET4vcsd+mE8nzpsZkoLMF20Zw6U
 19ioUnK7zVp05RWGjPl31/qLRG+ZnhIKgLa7pILntWTGCZOHvjT8N9KYqv5j0i+L6VFqDtIK5
 SZ6Pcqa++QbSBt2cl9RBFbTnnREBlhFTy8hDE8As84rWTaCS93jXTuAzLSXdtuDWYMP7SgDJ9
 d+XnwB86vjJWS0MNVsi6JjNn9wKxBNri/3RybuLxToH9eAmlljO0Z2ydfl4+oxvk+B6XFrOdN
 B02CjFv4xGNHOg6h0uN9AQBV/7wkHTnd/rvOS8JXBTAXx9uu4NK5XSLUU4a4OZlR5lGp+eoYi
 DUSRO4vTg3ljtV8o2cnLLq25jJdpjYXcsAqjXj43HSrKyGDymWvZkg3PodSTE59ggw8lKHz5Y
 kzxKxKD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 27.04.2017 um 06:57 schrieb Peter Krefting:
> René Scharfe:
>> Windows XP.  Don't laugh. ;)
>
> You can always install 7-zip or something to extract on XP.

Sure, but if we were to start emitting zip64 records regardless of the
size of entries then we'd break compatibility.  We should have a very
good reason for doing that.  (I don't see the need so far.)

>> What do other archivers do?
> 
> You should compare with what bsdtar (libarchive) does in zip64 mode. It 
> also only ever does streaming mode (with data descriptors and such), and 
> it does zip64.

Good idea.  They do the same as InfoZIP (whose behavior I copied in
the series), i.e. emit zip64 records only for big files by default:

https://github.com/libarchive/libarchive/blob/master/libarchive/archive_write_set_format_zip.c#L722

They set the bar much higher for the uncompressed size of streamed
files; they emit zip64 extras only for sizes bigger than 0xff000000.

>> But I think a more important question is: Can the generated files be 
>> extracted by popular tools (most importantly Windows' built-in 
>> functionality, I guess)?
> 
> OK, so only enable zip64 mode if there are files >4G or the archive ends 
> up being >4G. But the question is how we can tell, especially in 
> streaming mode, and especially if data descriptors are magical...

The type of descriptor to use depends on the presence of 64-bit
sizes in a zip64 extra for that record.  For streaming compression
some kind of threshold lower than 0xffffffff needs to be set,
because deflate can increase the size of the result.

René
