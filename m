Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B38F21F407
	for <e@80x24.org>; Tue, 12 Dec 2017 07:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750915AbdLLHPL (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 02:15:11 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:33688 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750715AbdLLHPK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 02:15:10 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3ywrgd1SjLz5tlJ;
        Tue, 12 Dec 2017 08:15:09 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9AFB92A79;
        Tue, 12 Dec 2017 08:15:08 +0100 (CET)
Subject: Re: [PATCH v1] convert: add support for 'encoding' attribute
To:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org, tboegi@web.de,
        peff@peff.net, patrick@luehne.de
References: <20171211155023.1405-1-lars.schneider@autodesk.com>
 <a07a0b5c-453a-f644-d5e5-7d185a943088@kdbg.org>
 <0BA27EC9-3836-407A-9A8A-52D06B8052AE@gmail.com>
 <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <48ebcb7a-2a7f-e790-2613-a1f3e3dc41f9@kdbg.org>
Date:   Tue, 12 Dec 2017 08:15:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqzi6o3go9.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.12.2017 um 01:59 schrieb Junio C Hamano:
> Stepping back a bit, what does this thing do you are introducing?
> And what does the other thing do that J6t is using, that would get
> confused with this new one?
> 
> What does the other one do?  "Declare that the contents of this path
> is in this encoding"?  As opposed to the new one, which tells Git to
> "run iconv from and to this encoding when checking out and checking
> in"?
> 
> If so, any phrase that depends heavily on the word "encode" would
> not help differenciating the two uses.  The phrase needs to be
> something that contrasts the new one, which actively modifies things
> (what is on the filesystem is not what is stored in the object
> store), with the old one, which does not (passed as a declaration to
> a viewer what encoding the contents already use and does not change
> anything).

Well explained!

> ...  perhaps "smudge-encoding" would work (we declare that the
> result of smudge operations are left in this encoding, so the
> opposite operation "clean" will do the reverse---and we say this
> without explicitly saying that the other end of the conversion is
> always UTF-8)?  Or "checkout-encoding" (the same explanation; we do
> not say the opposite operation "checkin/add" will do the reverse).

I would favor "checkout-encoding" over "smudge-encoding" only because 
"checkout" is better known than "smudge", I would think. I do not have 
better suggestions.

-- Hannes
