Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D23DC46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 12:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjAPMbm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 16 Jan 2023 07:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbjAPMbl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 07:31:41 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7601DB8B
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 04:31:40 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 30GCVFQW058452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 16 Jan 2023 07:31:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Hans Petter Selasky'" <hps@selasky.org>,
        "=?UTF-8?Q?'Michal_Such=C3=A1nek'?=" <msuchanek@suse.de>
Cc:     <git@vger.kernel.org>, <wrights@alrajhibank.com.sa>
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org> <20230115135245.GB16547@kitsune.suse.cz> <b1984123-569a-c290-8048-158c1c5e08b4@selasky.org> <20230116091346.GC16547@kitsune.suse.cz> <6a398405-e5f8-0b78-e463-41d79e49e78b@selasky.org>
In-Reply-To: <6a398405-e5f8-0b78-e463-41d79e49e78b@selasky.org>
Subject: RE: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
Date:   Mon, 16 Jan 2023 07:31:10 -0500
Organization: Nexbridge Inc.
Message-ID: <017801d929a6$6f8271b0$4e875510$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHTa2iI6WI7r9JWJtwuSXW3VRG3CwJQIR2YAkP/mtoChNZEygGgx7ONrmamOiA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On January 16, 2023 4:56 AM, Hans Petter Selasky wrote:
>On 1/16/23 10:13, Michal Suchánek wrote:
>> when that data is copied to a new location a new CRC is calculated
>> that can detect an error in that location.
>
>Yes, that is correct, but what is "copying data"? Are you saying that copying data is
>always error free?

Not in all possible computing devices, no. But in certain high-reliability and mission critical systems, there are parity checks and communication mechanisms that verify the integrity of data transfers memory-to-memory, memory-to-register, and over inter-CPU bus, and memory-to-disk-storage checks. The result of a corruption on one of my systems would result in a CPU halt rather than blindly accepting the result, taking the faulty processor offline until the cause is investigated and then reloaded or repaired. This applies to any component, including disks, CLIMs, DMA, and anything else in the architecture.

