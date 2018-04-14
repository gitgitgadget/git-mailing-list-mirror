Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D61EF1F404
	for <e@80x24.org>; Sat, 14 Apr 2018 19:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751614AbeDNTxe (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Apr 2018 15:53:34 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36046 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbeDNTxd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Apr 2018 15:53:33 -0400
Received: by mail-wr0-f176.google.com with SMTP id q13so12521062wre.3
        for <git@vger.kernel.org>; Sat, 14 Apr 2018 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=SxBjmTT+7q3cbezkrLQI/xYCURv5gkNdqY+1eUpQ+KM=;
        b=E/8saccNEp2Q4q1zMuJbXhsGBRkjei/e+vhqKgtBCy3m/Mp8cgFIJewLXywKApzQ+8
         b4KCoxssfkpAQq3wjuuMYQJ2m+YhIzcx0yd2GzuLpAZF5hfK91xJTmdNEBzxFZKhtAUF
         2tFTI1MfRZuH5GZcSjTPUxoelZy+2M40wz3VTTgtwmdDgUhl1qnjIoVAMPgs7WJDbvAp
         KK60AHfF92MJYyUMVH8SGL9EfWrVFBKJQfA4ayrvV1iCO1vPGr89nhMnkdWIvl8qO0PJ
         dD7/I3RmLZ4UJ+QmL7jhQeH+GyFggY4FpmQ2xAhB/18KB8KZRQl31zflB3eNBh4/CVjW
         n3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=SxBjmTT+7q3cbezkrLQI/xYCURv5gkNdqY+1eUpQ+KM=;
        b=gS3/pVqf5R250jZq/ZiggY2YviEtKb/rdVV8pFyCN2usFt6egu1u5vTdOaYPOUpkXd
         pwT/JiKZiq9EjNox6EzgKifgMapzmzU6TyHO3PobCYU9nCr4YnGiuLFO0ZCs+i49zZa0
         QUZtcPNRnhRpVFcUZxkVrnuUOiGbhgPjDbBH4waKd7GzL696bJ69Lk9jjriI0P9ycxJ4
         S1IO2JOZuluB9i/13znvhPHxjyif1obXUaHnO/Ji0RmAgzeQ/D3tf3c2APSUHp/h6rUZ
         hVV27NEoZ+RaqlK1jG/dvANFJyI8UveU8FeNpHcmAK+xnZn/e4HokbzcTeOAIb6UldOa
         CehA==
X-Gm-Message-State: ALQs6tBkmqqV2MPzytxgD+9c3Q0AahyB5TUFx8aY+/Dr3zqnQdJyxXl6
        nEbiN3SYmOK9DKxAfy8IwRw=
X-Google-Smtp-Source: AIpwx49ZFPxh3rirgjTSo9ZeVptX+VJYVyiaRHRaY9SqS30l+UEBad3+wlkRQoein1UtneGlw7LFHQ==
X-Received: by 10.28.114.15 with SMTP id n15mr7042451wmc.88.1523735612008;
        Sat, 14 Apr 2018 12:53:32 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 63sm3614314wrn.12.2018.04.14.12.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Apr 2018 12:53:31 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] read-cache.c: make $GIT_TEST_SPLIT_INDEX boolean
References: <20180414153513.9902-1-pclouds@gmail.com> <20180414153513.9902-2-pclouds@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180414153513.9902-2-pclouds@gmail.com>
Date:   Sat, 14 Apr 2018 21:53:30 +0200
Message-ID: <877ep9fttx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 14 2018, Nguyễn Thái Ngọc Duy wrote:

> While at there, document about this special mode when running the test
> suite.

This whole series looks good to me, and I see this patch addressed the
confusing test env variable situation I pointed out in v8
(https://public-inbox.org/git/87d0zkw8r9.fsf@evledraar.gmail.com/),
thanks!
