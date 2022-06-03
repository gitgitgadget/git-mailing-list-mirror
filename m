Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718C1C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 18:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348059AbiFCSwK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 14:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348024AbiFCSwH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 14:52:07 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB2C2871D
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 11:52:03 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPSA id 9BB2252060;
        Fri,  3 Jun 2022 20:52:01 +0200 (CEST)
Message-ID: <9fa34f22-3404-7bf8-6985-642c80634bf8@online.no>
Date:   Fri, 3 Jun 2022 20:51:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] git-prompt: make colourization consistent
Content-Language: en-GB
From:   Joakim Petersen <joak-pet@online.no>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Justin Donnelly <justinrdonnelly@gmail.com>
References: <20220602145935.10512-1-joak-pet@online.no>
 <20220603142521.42863-1-joak-pet@online.no> <xmqqy1ydhfcc.fsf@gitster.g>
 <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no>
In-Reply-To: <7d391d82-b15e-4a31-5207-c4037fec0bf9@online.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/06/2022 19:23, Joakim Petersen wrote:
> That does seem like a much better idea for maintainability, I can
> change the patch to do this instead. I have one question, though: the
> sequence $c$b (bare state and branch name) is a special case, where
> they're intended to have the same colour, should I wrap both in colour
> set, colour clear, or only clear after $b? The former requires rewriting
> the tests or changing $gitstring to not include $c when $c is empty,
> while the latter keeps the tests unchanged, but may pose a problem if
> "BARE:" should at any point not appear immediately before the branch
> name.

Sorry, the former (colourizing and clearing $c and $b individually)
requires rewriting tests no matter what.
