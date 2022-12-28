Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DC5C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 14:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiL1Omu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 09:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiL1Omt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 09:42:49 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DCF11805
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 06:42:48 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BSEghla061094
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 28 Dec 2022 09:42:44 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Taylor Blau'" <me@ttaylorr.com>
Cc:     <git@vger.kernel.org>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com> <xmqqilhwp5g4.fsf@gitster.g>
In-Reply-To: <xmqqilhwp5g4.fsf@gitster.g>
Subject: RE: [BUG] fatal: transport 'file' not allowed during submodule add
Date:   Wed, 28 Dec 2022 09:42:39 -0500
Organization: Nexbridge Inc.
Message-ID: <011201d91aca$a5db7800$f1926800$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIU6GJDc0yG7ZReRHFxQVmMhwXR0AFwOXgbrgBBjNA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



>-----Original Message-----
>From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
On December 27, 2022 10:34 PM, Junio C Hamano wrote:
><rsbecker@nexbridge.com> writes:
>
>> As of 2.39.0, I am now getting fatal: transport 'file' not allowed
>> when performing a submodule add after a clone -l. The simple reproduce
>> of this
>> is:
>> ...
>> This happens for any submodule add on the same system. Some online
>> research indicates that there was a security patch to git causing
>> this, but I can't find it. This does not seem correct to me or how this
improves
>security.
>> Help please - this is causing some of my workflows to break.
>
>Thanks for reporting, Randall.
>
>This suspiciously sounds like what a1d4f67c (transport: make
`protocol.file.allow`
>be "user" by default, 2022-07-29) is doing deliberately.  Taylor, does this
look like a
>corner case the 2.30.6 updates forgot to consider?

I have tried using 'git config --local protocol.file.allow always' and/or
'git config --local protocol.allow always' to get past this, without
success. 

--Randall

