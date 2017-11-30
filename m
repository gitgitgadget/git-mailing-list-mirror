Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C859E20C11
	for <e@80x24.org>; Thu, 30 Nov 2017 15:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbdK3PN2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 10:13:28 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:53011 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdK3PN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 10:13:27 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3yngs01cd7z1qwHZ;
        Thu, 30 Nov 2017 16:13:23 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3yngrz3lvCz1x9Sj;
        Thu, 30 Nov 2017 16:13:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id uwM6ZChAlaNV; Thu, 30 Nov 2017 16:13:22 +0100 (CET)
X-Auth-Info: flgrVEQqNhPCmFAZkWMAyIiw36f6yHwMV6exAtQ3QtFB9KT/q+ods5W+Nv8iyqEB
Received: from localhost (ppp-188-174-145-191.dynamic.mnet-online.de [188.174.145.191])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 30 Nov 2017 16:13:22 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 67A7C2C266E; Thu, 30 Nov 2017 16:13:21 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Thomas Adam <thomas@xteddy.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net
Subject: Re: [PATCH v4 0/2] launch_editor(): indicate that Git waits for user input
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
        <20171129183514.wze5trxjfgqxqs7z@laptop.local>
        <C91E8F24-DD13-4FEC-BAB3-A8B8F2DBBA8D@gmail.com>
        <20171130144255.5w72jcpz4a5igiro@laptop>
X-Yow:  I'm definitely not in Omaha!
Date:   Thu, 30 Nov 2017 16:13:21 +0100
In-Reply-To: <20171130144255.5w72jcpz4a5igiro@laptop> (Thomas Adam's message
        of "Thu, 30 Nov 2017 14:42:57 +0000")
Message-ID: <87a7z3re9a.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Nov 30 2017, Thomas Adam <thomas@xteddy.org> wrote:

> On Thu, Nov 30, 2017 at 02:55:35PM +0100, Lars Schneider wrote:
>> 
>> > On 29 Nov 2017, at 19:35, Thomas Adam <thomas@xteddy.org> wrote:
>> > 
>> > On Wed, Nov 29, 2017 at 03:37:50PM +0100, lars.schneider@autodesk.com wrote:
>> >> +		if (print_waiting_for_editor) {
>> >> +			fprintf(stderr, _("hint: Waiting for your editor input..."));
>> >> 			fflush(stderr);
>> > 
>> > Just FYI, stderr is typically unbuffered on most systems I've used, and
>> > although the call to fflush() is harmless, I suspect it's not having any
>> > effect.  That said, there's plenty of other places in Git which seems to think
>> > fflush()ing stderr actually does something.
>> 
>> I agree with the "unbuffered" statement. I am surprised that you expect fflush()
>> to do nothing in that situation... but I am no expert in that area. Can you
>> point me to some documentation?
>
> Because stderr is unbuffered, it will get printed immediately.

POSIX only requires stderr to be "not fully buffered".  If it is line
buffered, the message may not appear immediately.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
