Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85126CCA47F
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 19:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239890AbiFDTTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239877AbiFDTTD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 15:19:03 -0400
Received: from nmsh5.e.nsc.no (nmsh5.e.nsc.no [148.123.160.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1A3222B6
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 12:18:59 -0700 (PDT)
Received: from [192.168.1.110] (unknown [194.19.73.58])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joak-pet)
        by nmsh5.e.nsc.no (smtp.online.no) with ESMTPSA id 4EB33520D0;
        Sat,  4 Jun 2022 21:18:56 +0200 (CEST)
Message-ID: <5e6850aa-e2ba-e7d5-0abc-b1190f7b0f9f@online.no>
Date:   Sat, 4 Jun 2022 21:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] git-prompt: make colourization consistent
Content-Language: en-GB
To:     Justin Donnelly <justinrdonnelly@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20220603142521.42863-1-joak-pet@online.no>
 <20220604161333.54627-1-joak-pet@online.no>
 <CAGTqyRxS9aBitVivSTqojX_C_VBdgrD7JkUKgKSE6apjabzvQg@mail.gmail.com>
From:   Joakim Petersen <joak-pet@online.no>
In-Reply-To: <CAGTqyRxS9aBitVivSTqojX_C_VBdgrD7JkUKgKSE6apjabzvQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Source-IP: 194.19.73.58
X-Scanned-By: MIMEDefang 2.84 on 10.123.160.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/06/2022 19:30, Justin Donnelly wrote:
> I like this solution. This isn't new, but does anybody know if there
> is a reason why `$w` is compared for equality to "*" as opposed to
> just checking whether it's a nonempty value (`-n`)? I think I'd
> generally prefer it to be consistent with the others, which has the
> added benefit of continuing to work if the asterisk is ever changed to
> something else.
> 

Looking at the commit that introduced colourization, 9b7e776c0a5 (show 
color hints based on state of the git tree, 2012-10-10), it looks like
the author wanted the be as specific as possible in the check, with $w
only being empty or holding a '*', while $i could hold multiple
different indicators. Since the layout of the script has changed
significantly since then, I'll submit a v5 shortly with the $w check
altered.
