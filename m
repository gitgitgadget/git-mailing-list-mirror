Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B128D1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 22:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeC1WZB (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 18:25:01 -0400
Received: from mout.web.de ([212.227.15.4]:58801 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753426AbeC1WZA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 18:25:00 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzaxm-1eXHsM1MRO-014lUg; Thu, 29
 Mar 2018 00:24:52 +0200
Subject: Re: [PATCH] submodule: check for NULL return of
 get_submodule_ref_store()
To:     Stefan Beller <sbeller@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, jeremy@feusi.co,
        Prathamesh Chavan <pc44800@gmail.com>
References: <9c3c0161-f894-3368-ece2-500d0bb6f475@web.de>
 <20180328183832.243036-1-sbeller@google.com>
 <CAPig+cT1Yp8J8E0VDKdxvPdVD-UBsyDfQS+a83zOAW11ayfhnA@mail.gmail.com>
 <CAGZ79kYD+RC_Z7AH_uH9tZSDHhkikML4HkxUNGxkW8voHJ1i3A@mail.gmail.com>
 <CAPig+cQ_j4OyBjsZHE8ZPBojqD7HhSEb14-CFY9qYfXX+dafpQ@mail.gmail.com>
 <38570708-e166-0004-878a-2d8442c12b65@web.de>
 <CAGZ79kYL55+=9UbW7H-c7OUg6CHbnzdkxs0ZMsFnEAaoVXRwLw@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <096248bf-0a33-7360-e82b-b7a36e362604@web.de>
Date:   Thu, 29 Mar 2018 00:24:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kYL55+=9UbW7H-c7OUg6CHbnzdkxs0ZMsFnEAaoVXRwLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:/9k70/HJ+3U15qr0yzcavaaEmLb+WoZIEEx6lONRu32+XsF4aYJ
 RePJn/RI6ykYZ6kXWgQGXjRTe4BYGNENAxZc4Ckosb7U6ZC8kHLikV8d1Lr0QhK4szvbSkp
 4lzRaGeR/uSbX0IrOC48A3J4PRqbDp7DBzEf0fOEy92+Nq6nH+UmgsWIpWTjDxYjZJGJPvv
 cMygP1fOYH6H/wdm7p2tw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mrRiZwratlg=:bbeYN79KeIY9bq8Mre2F5p
 Cf7orq1x/Xh5RIZIwH1qNm73oVvRp7j5ZJwGqlmFtMPgSGsc70S8tCAIzU9aE6ruPx123BY5C
 42A2X3H8pot6cM42p8riY3fC73gChijpBJClpdklVn8ZbuoOvRHGWIdjZDcGx7vxxC+Zf2QpA
 QTw8vnSfo6BARoulcRyIO47qzXWTGZNzq4UB5qsetWzHIGhr3Vc1GEX0FiYyR8NVQ2eRqLO6p
 f34HTi6mRkgsIb0JziJmip7sxTwBR9fUJj9ZNF4FeTcSuGXMrS+Hq1jWCz7GDipkFRuNiI3op
 KnnqWDKwXxtengcVSddUNA9SZitkqsziNzyrU6FrTB4l7o4vERZhOWDkEwIYKtto0ysd9iu1B
 sM+ZZTeE6dkO/XUWrlrqn/XB1a3h+VRaVmHlK9uGhYSku4suJKDLOvzMhgLABg3jOJ8UYu586
 EsmVdRnY58s0qkgUWeYfKw+Zj2MD/EL0Z3u1lSBLNLhpx5ZVuCJBgPUbholZs/FtwkiFOAseF
 FANrFBiTP1DLArMfOzJNVRw0ZoID8fUS42MNl6rDP3pBoiJOCEeqp//yxLve+Si+hYPcL+cr7
 lpr1EE79pRDGlIfCM4YdQp1LkBvMqRGb4ylM6sJ5p6eHCazgGK2i7vVzIJkjLsD0LKd14T4Jz
 r07CSLrviLV+3k1ORXdQB1HYaNaUlmwQjpQZ5ZbrXAFrzxqfh22vn8jW9N7lEDJqtJJrEQkC7
 tXhgl8h2bfBk1ZJ5cITzp8h5wx9okwkEDcyq8SLAmHb0BSJW3OEQZAQ+0m0aYFe/JIorKVlpj
 TpIgCCJmxDM+FbTCr5aJycbePEC2aWOleHF1jSmMVpb8cHVcbY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.03.2018 um 23:37 schrieb Stefan Beller:
>> This looks nicer here in the script, but doesn't test exactly what users
>> type most of the time, I suppose.
>>
>> So how about this?
> 
> Looks good to me, though I had a nagging feeling at first that the
> regex could be made more concise.
> Why do we need the optional "[^ ]" inside \1 ?
> 
>> +       sed -e "s/^ \([^ ]* repo\) .*/-\1/" <actual >expect &&

[:xdigit:] would match the hash more precisely, but I don't know how
widely this character class is supported among sed implementations.
And being so strict may require changes once SHA1 is replaced -- new
hashes might be marked with a special character.  And it's longer
anyway.

\S could be used instead, but I also don't know how widely this is
supported.

. could be used as well, of course, but that feels a bit sloppy to
me.

Using separate s commands for beginning and end of the line would
be shorter.  This here is slightly longer, anyway:

	/ repo / {s/^ /-/; s/ (.*//}

What do you have in mind?  How to transform this:

 b2613938d15a18d9d4a504cacd9654fd1c879197 repo (heads/master)

... into this:

-b2613938d15a18d9d4a504cacd9654fd1c879197 repo

... while keeping other lines unchanged?

René
