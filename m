Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DE5A1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 17:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBGRkC (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 12:40:02 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37528 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbfBGRkB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 12:40:01 -0500
Received: by mail-wr1-f48.google.com with SMTP id c8so774568wrs.4
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 09:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=PqYXaQIA2FiGKz2hX7kUNJZMm+XyN+NMhN/gNBRObqg=;
        b=eZt0YTuBBPwGmgji6n5sSxU6OusSLaJTi54bk5NDhlG7JD+AuRrxEjZxf8gj3yPOjD
         bLRJBibkXOlbIvLGbodD2K7lt0B8fEXxZUUqfRnqjz0hg2SsVV7egM7wZf12sRmb3k08
         ogv7AQBsCPr+FHXo62vZP8aoxmejNFzvQ3hvRMCXXODzjDuPVh0NNwH0nQBrqEQdNXfp
         eBvIqfNpdg+iZGxe51I1BZQm7smW3qomTjGgUCF9pixOZltxQd/Y/nrA/qtKIlM/n120
         7xHGsUFEDg5OILv1e3KYPzyFpsS6Km9zUZioTkV6OU7NC3sTg6qAAmomRO0wdC2oVxO1
         pEvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=PqYXaQIA2FiGKz2hX7kUNJZMm+XyN+NMhN/gNBRObqg=;
        b=HV5r0Tb6YpFnzwWwASgQ6j9qmx0YarYqGjRYIA0vB198iWv/mXofwqCh7qg9MmiHE/
         r/lwuHitOdRCAH/Np5reiXAaaBjuhHmG81+Ux29D9lO+ovur0EbD5m1kZD8zmRMMnCnr
         p0/n1+Qtxb2H2dgq5Yv76rJumVNhfUDino7s65JTyqrBxyANtkJ1o8PWrvZelPMjjATW
         JTGBdWz2KVazOlz9p6XBbHqk6aggozzjBOx37q12qTAvv0qF/tGaX2DDRAOZ8nYpzhHB
         6EVqjPmbdm8FUFMCCWW4fAfqPC2YxsnLR4OXhrk1GZFORBMcy7HvgtAwT8PTocXn3keT
         o0SA==
X-Gm-Message-State: AHQUAua4lx2oLb0VMatKmk3+SxSdiGeOMcxB66VrD6W9tlgcn7/Oqw04
        18QCdWCjEUIZ7THxtbeDRVU=
X-Google-Smtp-Source: AHgI3IaFPKgPpmOgzcM/43hLdwo/n9xFp8Ub2vDYcr0VUrX7t9lBlQSHxF9Eh40Hk+Woj8CDZYym7Q==
X-Received: by 2002:a5d:52cc:: with SMTP id r12mr3952257wrv.277.1549561199716;
        Thu, 07 Feb 2019 09:39:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t12sm16447162wra.63.2019.02.07.09.39.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Feb 2019 09:39:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'Torsten_B=C3=B6gershausen'?= <tboegi@web.de>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?'SZEDER_G=C3=A1bor'?= <szeder.dev@gmail.com>,
        "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
Subject: Re: t0025 flakey?
References: <nycvar.QRO.7.76.6.1902061123410.41@tvgsbejvaqbjf.bet>
        <20190206104243.GJ10587@szeder.dev>
        <nycvar.QRO.7.76.6.1902061450280.41@tvgsbejvaqbjf.bet>
        <20190206171517.s5lskawpdodc74ui@tb-raspi4>
        <001501d4bf06$506b8640$f14292c0$@nexbridge.com>
Date:   Thu, 07 Feb 2019 09:39:58 -0800
In-Reply-To: <001501d4bf06$506b8640$f14292c0$@nexbridge.com> (Randall
        S. Becker's message of "Thu, 7 Feb 2019 11:58:08 -0500")
Message-ID: <xmqqtvhfpkep.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> On February 6, 2019 13:01, I wrote:
>> On February 6, 2019 12:15, Torsten Bögershausen wrote:
>> > To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> > ...
>> > [PATCH] add: use separate ADD_CACHE_RENORMALIZE flag
>> >
>> > Or has it always been shaky ?
>> > Does anybody know ?
>> 
>> The NonStop port has traditionally had issues with t0025, which we tended
>> to ignore because things did work. We wrote those off as bash issues in
>> t0025 since they seemed to be corrected when we picked up a new bash
>> version about a year ago. I will keep monitoring this, particularly when
> 2.21
>> comes out.
>
> FYI: t0020-t0027 all passed on the NonStop port for 2.21.0-rc0 - so no
> issues for us on this one.

Yup, the preview has both the renormalize fix and another hotfix for
it Peff made.  Thanks all for quick fixes and confirmations.
