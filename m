Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB89C433EF
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 00:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242517AbiFJAeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jun 2022 20:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239769AbiFJAeE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jun 2022 20:34:04 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4D65DE4D
        for <git@vger.kernel.org>; Thu,  9 Jun 2022 17:34:00 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPSA id 6A0255208A;
        Fri, 10 Jun 2022 02:33:57 +0200 (CEST)
Message-ID: <8bfdf2eb-70f8-ad28-5dac-5ee598cd487a@online.no>
Date:   Fri, 10 Jun 2022 02:33:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] git-prompt: fix expansion of branch colour codes
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <20220607115024.64724-1-joak-pet@online.no>
 <20220609204447.32841-1-joak-pet@online.no> <xmqq4k0tgz6s.fsf@gitster.g>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <xmqq4k0tgz6s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/06/2022 02:05, Junio C Hamano wrote:
> t9903 seems to fail with this, though...?
> 

Ah yes, sorry about that, I seem to have gotten a bit ahead of myself.
Since the wrapping of $b was entirely moved to before colouring happens,
the tests need to be reverted back to their state from before the
previous commit, with the exception of the extra $c_clear in the test
with two active indicators. I'll submit a v2 with this change shortly.
