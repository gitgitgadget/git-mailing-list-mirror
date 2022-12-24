Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D01FC4332F
	for <git@archiver.kernel.org>; Sat, 24 Dec 2022 08:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiLXIKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Dec 2022 03:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXIKN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Dec 2022 03:10:13 -0500
Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41794DF76
        for <git@vger.kernel.org>; Sat, 24 Dec 2022 00:10:12 -0800 (PST)
Received: from [192.168.0.98] (unknown [93.83.142.38])
        by bsmtp3.bon.at (Postfix) with ESMTPSA id 4NfGtp24F6z5tlB;
        Sat, 24 Dec 2022 09:10:08 +0100 (CET)
Message-ID: <3c55ac67-5090-b7af-a212-2996bad66fb2@kdbg.org>
Date:   Sat, 24 Dec 2022 09:10:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: js/drop-mingw-test-cmp, was Re: What's cooking in git.git (Dec
 2022, #03; Sun, 11)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <xmqqpmcqv7qh.fsf@gitster.g>
 <o428pr88-sn2p-o715-52ns-1r6750762572@tzk.qr> <xmqqa63ss3fl.fsf@gitster.g>
 <c57ecd23-7ca7-2501-983f-6661c7872a01@gmx.de> <xmqq7cyksy88.fsf@gitster.g>
From:   Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqq7cyksy88.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.12.22 um 14:05 schrieb Junio C Hamano:
> I know we have been operating under such a test environment, but
> after seeing the exchange between Réne and J6t, I was hoping that we
> do not have to keep being sloppy.

Things did not turn out to be as simple. After ripping out all
special-casing of GIT_TEST_CMP from a MinGW build, I notice at least one
case that needs special treatment (it's `tar tf` that writes CRLF
output). On top of that, there are prerequisites SED_STRIPS_CR,
GREP_STRIPS_CR and perhaps NATIVE_CRLF that should be reconsidered.

For the time being, I suggest to take Dscho's patch.

-- Hannes

