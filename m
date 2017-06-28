Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8EA2023D
	for <e@80x24.org>; Wed, 28 Jun 2017 22:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdF1WpA (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 18:45:00 -0400
Received: from mout.web.de ([212.227.15.4]:54957 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751610AbdF1Wo6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 18:44:58 -0400
Received: from [192.168.178.36] ([79.237.60.227]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MeBVG-1d64CZ28Lu-00PsM8; Thu, 29
 Jun 2017 00:44:53 +0200
Subject: Re: [PATCH v4 4/6] coccinelle: add a rule to make "expression" code
 use FREE_AND_NULL()
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20170615231549.20085-1-avarab@gmail.com>
 <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
 <20170615231549.20085-5-avarab@gmail.com>
 <xmqq7f0byayu.fsf@gitster.mtv.corp.google.com>
 <2122b01f-7627-cd1b-c7df-751c076f90ff@web.de> <87injfkd0j.fsf@gmail.com>
 <433f9fb7-a202-1091-46de-04535b2a49e1@web.de>
Message-ID: <f0fa8268-227c-829b-8611-2f94a5c4c1ee@web.de>
Date:   Thu, 29 Jun 2017 00:44:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <433f9fb7-a202-1091-46de-04535b2a49e1@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:1atV5iZgcYZ9QDSbiip6M/IUwGJSK216zdDHOvFr+9K3xf/SsLI
 GrUPThm8EbzF5mvLhT+UCNca85zUKyuMIArDfNmewcUSJK++K5akMYThcqHYC5jou+vayat
 Qi+JmFTqVI/gTTw4l6yH0Jm4M3h7v/YKlc1n9CVs5OUPK7nDmUO4dnZhhaSHL5Z7+7fS0IL
 agvoDe3uaADKeIiMVcuSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QwBI+A2P1uk=:iMR7++Mf/sgAfs73AlOKWU
 B6SuVQXCJbFSMcTkMVLx38tUUsAinbhK1Ug70GbCB9wSlCaUXbBkBeBvA6Uap/4KZlK9qGtGu
 PMSO1aAyk80EJXnh8jXPbnvww2l1UffLMCXbbqltJZXTDK6k8ZG3sGpBSjSo4jZcRoczheYlA
 yfSYHiByP7smzsNPo+qBrgdeuIUaIBscfogZSBzzliVowf7SuFLrxwgq5nxVCqv09yJ8yfxfs
 LZGGP9DltJ6dn8WW6BXlhWxmjcT++m2F0tpxlmCyq9S2QgYaVttIfb42DSjxRTRlzBCAhVzk6
 mvwwlk32W0S4e3SHKum8oHjjkvtP4/NAKD9hOEgteGbcUN0MTZJnfyh0i7p6vDNEnI8F9VwGF
 Xvh9wb6Jj2TGqSkpXgWRM6EDZc/PWpiVkT/A0ebUQFPznMgRoUfFy7q0xeAiLN7gLVmgwM3m/
 G2AoYArH6CbOaQ3GS33NjrfslyBRBZzA4DcYHTq1VBJRE35yYbpejfZVaGvFX2fV47pwLHgcW
 ebNU5y+Bb4yzQYy05CPB3ZfMH0uJolqGzfr5N3HkBELnHjSm8YN+6KAUTlOC6B1lyJ7EkdCD4
 +n++jqY0ANkuXKtTRzPBB7hVQsIKTBhO6AILjGIni6HbnRqJ7KFwi4KN8ZWOI4Ew9jchoxO+9
 koEvYFFItpz2/euwtl4pk0Vr8HNUcciCJTCI4VYA5zdTy+2RKx9ozlc/M072grPZXXIn/sVr/
 +HCPdWMcBQkspkid/EgRztUf5bP5OUn7EGTlP1uPNSOhi75iGyYObfYx5VqIrlH4m6G61srS8
 2Sc9FPY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.06.2017 um 00:21 schrieb René Scharfe:
> $ git am
> # pasted my email
> Applying: coccinelle: add a rule to make "expression" code use FREE_AND_NULL()
> # results in commit message with scissor line, interesting..

"git am --scissors" commits with the correct message.  I'll do a
"git config --local --add mailinfo.scissors true" real quick..

René
