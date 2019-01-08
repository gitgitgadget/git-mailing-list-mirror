Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BF711F803
	for <e@80x24.org>; Tue,  8 Jan 2019 16:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbfAHQkY (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 11:40:24 -0500
Received: from mout.web.de ([212.227.17.12]:41077 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729219AbfAHQkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 11:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1546965609;
        bh=Cyyj1zwwiYyrDgjt8mxwzBgrM0UOxwdnPMVMW0IwWTI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=mZCJvlAIb+t8gC0pVtw4nxe3nZmh8yK3X2+g9hD4q9mvhVFj3dZnv09mAJvYsqI0h
         zw7WTp2j0jqpsuc4mpMWpdPy9JT7xmOsL+WPcGhFfkMCzwnXVWCrc6vVA8Ii939LqJ
         6rEOgr/J1PlIp1rCBrzBN4p1Lb3Ue521MwUvM2e8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.36] ([91.20.59.41]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MEVlN-1gWDAm3BsH-00FhWz; Tue, 08
 Jan 2019 17:40:09 +0100
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <20190107083150.GC21362@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
Date:   Tue, 8 Jan 2019 17:40:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190107083150.GC21362@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2rQkIk/4rDv2mvpPtdUj2MIu+ZF8bZBflb4nAk+VIZkgbyWA54D
 4nfpZupipqkv15r7SWhkvhS+EF3fVrbifedcjvjbPFKvpd/5SXoupTkvc9O1FLc10PhiBYq
 PWwkEr2RM1nSPLyvsq80WTGN0nQhs6KYMY5JCeQ8Bhwk0CaXhCfVwuJY01idfWlpCbTpKXV
 aL4obiKzbzwXmNQjJRYuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xYnxFwboiDM=:uv+YGxCQWrZM/EM8AR38K6
 RELle7RIfNtyo5t54A7qukboXvGkVDKWph4jt+X5Pmnvasw5BSM9ugKrq8LvS4WB6AsfygcnP
 bZPs9y7mTJ0csfgyMqRSIeVwGVmbGcCPtPEaSaktMsanjSkxkduuArSF5Y4QJMBJna/FzEkZi
 zxwzl8aszpSI3zu72SqfJtMTHMkCfODpXe8SwoNkwGNQe/5KkW3WPElbC8opoOU/LJDM/eckZ
 /FqQV7i4DWNq8RSDLzX5ezKZziANj2MlZ9kRW8NCw+TjBjITdeuAXVYYutr0WXr1nSq3nNh3H
 rkRhWohGfTFqlndfzaw5axejFYIy0iwipVfNEKAG4AXRikwxKuFft+lPy6Y9RXNGRPdGkkqbG
 TMWbkuxep+FLsfeGIYn75cZ5VA/0+11LBy23qcyZTWCX7m5DrgX/tciLKpDXyYdrzQ/icovzL
 N9wylqcQDJ96YMO0otg6Z0xstXYoOaY8yEvPomqfBlfj4KFio8q+ppV8J5ncVEhlcW0miIZuc
 4U2tAIrTY4wpPKxbjojLefaRjE9MiZMi70bYZ++SRA+OH1hl0SdjvldMf/Q9Kwb2rfWNu0yTJ
 UA0NwIaN4TwyAbHTwvzOsEgpBCL+7eOrt0vCWxW1Yoy99f9n2vvAW+4RkS6Ib37PesVFSrGY+
 PKQI3RfyC0fnfzgtqJqXRXPWJuBm3uYEEXgg1tpUpdxq0JuBPkKK+GEechTenYXZmY6qCfLHs
 V5oQifTkZnOFJX5EdN8HYEVAlYY5AzhJamd7Hq9B+scsNPbQgBEcK0WE1sUhUJMubaPQ5yo32
 3RpZUBaU27bDResx4a33YzM5ZojqNCyyn0H+1L/AYG57sPC4W6GfH9Oc+seF1YAhg5aIUbfH5
 qCME3+wzbmAWEAHxwMXRO1LnHIzfM/lYrtqyj6v50KOK+/U570RwL0d5CRPw6o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 07.01.2019 um 09:31 schrieb Jeff King:
> I also cleaned up my sha1/object_id patch and rebased it on top of what
> you have here. Though as I worked on it, it expanded in scope a bit.
> Possibly it should be a separate series entirely, but that would create
> some annoying textual conflicts on merge.
> 
>   [01/11]: sha1-file: fix outdated sha1 comment references
>   [02/11]: update comment references to sha1_object_info()
>   [03/11]: http: use struct object_id instead of bare sha1
>   [04/11]: sha1-file: modernize loose object file functions
>   [05/11]: sha1-file: modernize loose header/stream functions
>   [06/11]: sha1-file: convert pass-through functions to object_id
>   [07/11]: convert has_sha1_file() callers to has_object_file()
>   [08/11]: sha1-file: drop has_sha1_file()
>   [09/11]: sha1-file: prefer "loose object file" to "sha1 file" in messages
>   [10/11]: sha1-file: avoid "sha1 file" for generic use in messages
>   [11/11]: prefer "hash mismatch" to "sha1 mismatch"

I skimmed them; they look good to me.  6 and 8 are particularly
satisfying; getting rid of hash copy operations just feels nice. :)

Junio only took 1 to 5 into pu; 6, 7 and its sidekick 8, 10 and 11
conflict with sb/more-repo-in-api; 9 could go in unmodified.

René
