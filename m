Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F760C433E0
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 11:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 256E02078A
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 11:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgFMLtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 07:49:18 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:60671 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgFMLtS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 07:49:18 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 49kbV21LVVz5tlB;
        Sat, 13 Jun 2020 13:49:14 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9F70C41AF;
        Sat, 13 Jun 2020 13:49:13 +0200 (CEST)
Subject: Re: Re* [PATCH 8/9] fast-export: respect the possibly-overridden
 default branch name
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Matt Rogers <mattr94@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        don@goodman-wilson.com, stolee@gmail.com, Jeff King <peff@peff.net>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
 <1efe848f2b029e572cea61cadcfe36b9d3797836.1591823971.git.gitgitgadget@gmail.com>
 <CAOjrSZvm9QNUttUNVBEUMPJ8zgYEoAnSPN5_6N5uwpiM1sVrcQ@mail.gmail.com>
 <20200610233912.GU6569@camp.crustytoothpaste.net>
 <CAOjrSZvV6+ApfmOBa7rdXDPQJbExRsOfodO16i_1N5QjjhCB1w@mail.gmail.com>
 <xmqq3672cgw8.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006111559300.56@tvgsbejvaqbjf.bet>
 <xmqqpna5bq2l.fsf_-_@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2006121451100.56@tvgsbejvaqbjf.bet>
 <xmqqy2os2u55.fsf@gitster.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <405521ec-aed7-ff76-5b48-70e9d11018e6@kdbg.org>
Date:   Sat, 13 Jun 2020 13:49:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2os2u55.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.06.20 um 17:14 schrieb Junio C Hamano:
> 	/*
> 	 * Anonymize the name used for the primary branch in this
> 	 * repository, but reserve `ref0` for it, so that it can
> 	 * be identified among other refs in the output.
> 	 */
> 
> is the minimum I would expect before calling it an improvement.  We
> could add
> 
> 	It is often `main` for new repositories (and `master` for
> 	aged ones) and such well-known names may not need
> 	anonymizing, but it could be configured to use a secret word
> 	that the user may not want to reveal.
> 
> at the end to explain the motivation behind anonymizing even more,
> if we wanted to.

IMO, making the primary branch identifiable is a reasonable
justification to treat it specially. But then, why does it have to be
renamed to 'ref0'? Couldn't it just be renamed to Git's default primary
branch name, be it 'master' today or 'main' or whatever in the future?
After the anonymization, nobody will know whether that was the real name
of the primary branch or not. Leaving it at 'master'/'main' reduces the
mental burden of the recipient of the anonymous repo.

-- Hannes
