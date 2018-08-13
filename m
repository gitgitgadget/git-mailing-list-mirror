Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9997A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 15:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeHMR5c (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 13:57:32 -0400
Received: from mail.nic.cz ([217.31.204.67]:56411 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729063AbeHMR5c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 13:57:32 -0400
Received: from [IPv6:2001:1488:fffe:6:83a:b589:ce68:b04] (unknown [IPv6:2001:1488:fffe:6:83a:b589:ce68:b04])
        by mail.nic.cz (Postfix) with ESMTPSA id 8116062705;
        Mon, 13 Aug 2018 17:14:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1534173290; bh=S6q99IfaE01rgJu6anmOWv+u3qRzAbERbnFafRnoshQ=;
        h=From:To:Date;
        b=B0DAaYzV0ADly15AE09EeWbNzi1HmeMUC/ufN/boorDCwJ3PGKd4Wr0LrrPY90rLs
         QrLTZX/eUSU7Q1iHwtRXZKEbOssorN1kUahxovZSVFXKJrooyGxwpoZj+T8b0loLlK
         hR7rjaFH9yYM9NqNJiO2UrEGXWXA1yr7yCkFHL1g=
From:   Vojtech Myslivec <vojtech.myslivec@nic.cz>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?B?S2FyZWwgS2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org
References: <20180803133630.32oxubwttealvhxk@work-pc>
 <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
 <20180803160634.GA19944@sigill.intra.peff.net>
 <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
 <20180808230456.GA21882@sigill.intra.peff.net>
 <20180808231226.GA34639@genre.crustytoothpaste.net>
 <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
 <20180809014302.GB34639@genre.crustytoothpaste.net>
 <20180809143010.GD1439@sigill.intra.peff.net>
 <xmqqtvo3d0by.fsf@gitster-ct.c.googlers.com>
 <20180809171219.GF1439@sigill.intra.peff.net>
 <xmqqy3dfbcys.fsf@gitster-ct.c.googlers.com>
Autocrypt: addr=vojtech.myslivec@nic.cz; prefer-encrypt=mutual; keydata=
 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
 gy8WZQDS
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully
 when signature is not trusted
Message-ID: <88aca5f1-61e6-c089-f69e-952937c85a5f@nic.cz>
Date:   Mon, 13 Aug 2018 17:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqy3dfbcys.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9.8.2018 20:40, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I guess leaving it serves as a sort of cross-check if gpg would return a
>> zero exit code but indicate in the status result that the signature was
>> not good. Sort of a belt-and-suspenders, I guess (which might not be
>> that implausible if we think about somebody wrapping gpg with a sloppy
>> bit of shell code that loses the exit code -- it's their fault, but it
>> might be nice for us to err on the conservative side).
> OK, this time a real log message.

Now it is possible to achieve git verify-tag/verify-commit exits
unsuccessfully when signatures are not trusted. I would like to
introduce some tests for this behavior to prevent this problem in the
future.

Thank you all for discussion and for solving the issue.

Vojtech and Karel
