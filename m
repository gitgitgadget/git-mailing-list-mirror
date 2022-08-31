Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADCEECAAD8
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 05:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiHaFgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 01:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaFgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 01:36:05 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 22:36:01 PDT
Received: from mta25.mailii.org (mta25.mailii.org [5.152.202.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B77E5B076
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 22:36:00 -0700 (PDT)
X-Mailin-Tag: 5.144.130.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=srs.mailii.org; s=mail;
        h=content-transfer-encoding:content-type:in-reply-to:references:cc:to:subject:
         from:mime-version:date:message-id:from;
        bh=YIQtQPFBRpQi0Fh+gnExlJ1XvEFOkUWr9AlncceVsoI=;
        b=mu/46fhWjDcsCAY2liJPBF3U61fH4LF7Q13wP2EQ5gv4BRAF5vdomIxI8+ptT9kzNQ//UpmLttmjS
         vrLOd1ety0i/vcHO+mRYAkk7we0/OOdAQ4VMFcfgl2tzfzouTFsEKL8umkGRgnn8nCS0pXlC0KH5T4
         FFRWhuknRyVJAx30=
Received: from linux1.centraldnserver.com (linux1.centraldnserver.com [5.144.130.11])
        by gw3.mailii.org (Halon) with ESMTPSA
        id a195a082-28ee-11ed-bfe0-005056a70a42;
        Wed, 31 Aug 2022 10:04:50 +0430 (+0430)
Received: from [5.214.167.86] (port=2297 helo=[192.168.1.173])
        by linux1.centraldnserver.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <admin@rzmahdi.ir>)
        id 1oTGNB-00BNOg-Cp;
        Wed, 31 Aug 2022 10:04:44 +0430
Message-ID: <a1a0672b-4f6b-debd-34d1-bbd9e60f520e@rzmahdi.ir>
Date:   Wed, 31 Aug 2022 10:04:31 +0430
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
From:   Reza Mahdi <admin@rzmahdi.ir>
Subject: Re: [PATCH v2] sha256: add support for Nettle
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
References: <20220705230518.713218-1-sandals@crustytoothpaste.net>
 <20220710132907.1499365-1-sandals@crustytoothpaste.net>
 <220710.86mtdh81ty.gmgdl@evledraar.gmail.com> <xmqqwnckrkg9.fsf@gitster.g>
 <Yssyt40xrxjtaL6m@tapette.crustytoothpaste.net> <xmqqa69gr9ei.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa69gr9ei.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Hostiran-MailScanner-Information: Please contact the ISP for more information
X-Hostiran-MailScanner-ID: 1oTGNB-00BNOg-Cp
X-Hostiran-MailScanner: Found to be clean
X-Hostiran-MailScanner-SpamCheck: 
X-Hostiran-MailScanner-From: admin@rzmahdi.ir
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/11/2022 1:07 AM, Junio C Hamano wrote:
>   (3) We can allow only one to be set and otherwise error out.
> 
>       If somebody wants to write autoconf support, they have to come
>       up with the precedence order, or support the "--with[out]-X"
>       thing to customize, in order to ensure that the configure
>       script picks exactly one.
> 
>       Because not everybody has nor need to have enough knowledge to
>       choose one among the multiple choices available to them, this
>       is hostile to those who do not use configure.
> 
>       Not an improvement over what we have today.

I think this is the most used and familiar to folk. There is no need
to have multiple options since all of backends work perfectly.

And, of curse "--with-X" option must be meaningful when the sha256 is
enabled.
