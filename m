Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7F641FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755133AbeASALB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:11:01 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:43831 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754775AbeASAKo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:10:44 -0500
Received: by mail-wm0-f53.google.com with SMTP id g1so254447wmg.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=xQOYwoU+X37qoFMZIOLw48hiWfcXA7rNNFxanYOfoig=;
        b=PXD3WKEH1YsFphW6E2K8GjcyXu1aGzDjF8eM3sXc7LGE9aTJQtGYMRISrDKTXtCsk6
         akGLhIGZ31Mdh+Hpg8OFeAKXAVt0Vi0bzYYwT+8FyNBZBAypkuWKvGi8R7SJoNq4XHRB
         WWaJWKBucayXZ9G204KCTDoR9U4Lfznyy+CuanLe69zGU5+EYIh9b7BU5xRy6x3v4dS4
         WDANJDN+uQ4WQHHEqDmWyfzs7Rot7RYYZwDuihQIWFRwvEGYTcuW7XeqjU7yZUtO4i2s
         ZDS21yq0Nu5y1fGYayFh6Nna1KJpFXnHJD8mohEZsGZ7ZMQLjmewKjtkvR97hAQPMJbX
         A4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=xQOYwoU+X37qoFMZIOLw48hiWfcXA7rNNFxanYOfoig=;
        b=kq7+tJ+7lg3G//eamEpzdkQvApgs9/nbABKYGwJ1qnjE8zqYSo/Z5iDzVl2CSVd3iZ
         qVQ3SrfrQPMkLi1zUUgpv+uA9W+EXDItR4i4aNlHv/GuX+r8CHrWFsaA7MWkjilfTwAO
         AkPWRalwsoucQhf4P8cqU/fkHuSjj35pXZpUia7wWRwknBqxJHn6FF2Ulo8bES8D60t7
         XMyqOoPXwe+PVjYygHWgE5PWUq/ZA29LRhODAxRrgFE0uBV4JwOdWux4SZj5/56Z/t9f
         P/55DcisevHyX2N5aQLaMK8gGLMiA+6Hu1qCrmfIYNzcTas+uom9NQBnvkgcTzbglmw+
         kZmg==
X-Gm-Message-State: AKwxytcxcbs36fdvzWDRVY1IpqNKgCsQyFg/lUHU7I4cchIEzGjk4mtx
        byMfIWW46BFAipe4FRQAGDA=
X-Google-Smtp-Source: ACJfBoufLWkvHWoCtR2q6nTOp+0f1dkAQRHyFQPZEiU4hjUFDI2RUX/jw4j6fqsb7Rrldbd9Iio8mA==
X-Received: by 10.80.134.123 with SMTP id 56mr10322866edt.285.1516320643429;
        Thu, 18 Jan 2018 16:10:43 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id a5sm594207edm.38.2018.01.18.16.10.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 16:10:41 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     randall.s.becker@rogers.com, git <git@vger.kernel.org>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [RFC PATCH] NonStop port changes for git 2.16.0.
References: <20180118224243.5016-1-randall.s.becker@rogers.com> <CAGZ79kb4Zr6QnNydRX56B_4Jo5fveufBFJAD7r_8U-NRSMa2qQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CAGZ79kb4Zr6QnNydRX56B_4Jo5fveufBFJAD7r_8U-NRSMa2qQ@mail.gmail.com>
Date:   Fri, 19 Jan 2018 01:10:40 +0100
Message-ID: <87a7xaiu7z.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 18 2018, Stefan Beller jotted:

> On Thu, Jan 18, 2018 at 2:42 PM,  <randall.s.becker@rogers.com> wrote:
>> Further: there are 6 known breakages that have been reported. The perl
>> issues relating to completion codes are being examined at present by the
>> platform support teams so are not addressed by this patch.
>
> For perl I'd suggest cc'ing Ævar (cc'd just now) as that seems his
> field of expertise.

Just to make sure I'm keeping up, this refers to some breakage not
detailed in the patch above, right?

The only perl-related change I see is undoing part of 6c109904bc ("Port
to HP NonStop", 2012-09-19) having to do with how we find perl/python
(which, not being at all familiar with NonStop, makes sense to me).

But sure, if there's some details about those 6 issues I might have time
to take a look, but it sounds like it's being looked at by NonStop
support...
