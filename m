Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637D42027C
	for <e@80x24.org>; Thu,  1 Jun 2017 10:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdFAKIm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 06:08:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:58644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751385AbdFAKIl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 06:08:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CCDFAAF2;
        Thu,  1 Jun 2017 10:08:40 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
References: <mvm4lw0un5n.fsf@suse.de>
        <5100A096-EBAC-4B01-A94D-69D31093148D@gmail.com>
        <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com>
X-Yow:  I'm GLAD I remembered to XEROX all my UNDERSHIRTS!!
Date:   Thu, 01 Jun 2017 12:08:40 +0200
In-Reply-To: <xmqqwp8w3uff.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Jun 2017 18:53:56 +0900")
Message-ID: <mvmmv9st3yv.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jun 01 2017, Junio C Hamano <gitster@pobox.com> wrote:

> Depending on the model of "ARM" (or "SPARC") emulated with QEMU, and
> depending on the OS that runs on such an "ARM" or "SPARC", we may
> not see this---if the emulated OS has the "software unaligned-access
> emulation" our userland may not see a SIGBUS.

Even if the architecture implements unaligned accesses in hardware, it
is still undefined behaviour, and the compiler will (eventually) take
advantage of it.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
