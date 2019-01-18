Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 660011F453
	for <e@80x24.org>; Fri, 18 Jan 2019 17:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbfARRdz (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 12:33:55 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44022 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfARRdz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 12:33:55 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so6633080plb.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 09:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnu1Grw41LAxUttyTAwu183QaM40wt8QPmxigXrRJEA=;
        b=vkAsgu/8x5vSiydgbIzf4jY/ZuXS6WyfvGDcrDbusRi89c0aLXi6CmognhlBbLqYJ2
         pEBuw+7ep0O1quVVLrL++debLKMD9KLtTjAuXXCRmA1XTVGrxOV1wtQocWujlDU5XNB0
         7jDzCmHLr6QTgXds3eF7dvEa6bY0lHGD3EN935UfMLjzuWHwuUyNHA+UUHSXJCtis8JL
         1/yhbyI691mgp7Os3GyDXOSHspprThoQYzHrvyZT1e6sbLzZ9TA9MigRgnOv2ckdU/so
         3IKyyRX5/WHYVwEVKcR5pyyJ0Ca0nGmE9Yfp52ZH/TA6qAXTyUiO8jC+KG18G64ldHp0
         jumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnu1Grw41LAxUttyTAwu183QaM40wt8QPmxigXrRJEA=;
        b=QOI0gT6UDtKuBkn7TZhNmrFheL5/y51b2hemk88Zk7zrDjlvzkgwbDDsPVBjQ9SZJ2
         XAVEWc0h7jd5Em78m2CVw0NhTTTzVtiNP9t4PYubmDv8FxNXKCYIbH9ImUxG7l7LACfd
         O4beifm+mwpTJNioW+8ZvSFYwQqqMyec494py/CiBL2XgYN6LtgDU88Vj+6Wmk+5NKmk
         FBrju2GZfMMkJf47o4xXqHHTb1hfX6k55odaZpSUKb35kdw2oCZXej27oBqLzM6nKFG9
         y748WvKKEmH44hYJmi4beRWTW0bX9sB5JPabcWe7mHnQq6FCq/JOngI98tvLQo9lVY0L
         Vjpg==
X-Gm-Message-State: AJcUukcq7xj4AruJGqQT9plwOgENVjPA+5No35SvmgY3c2ErqlU4eeoI
        qYKv+o/uqvd/1qyziEn2boPaJ+2NzujRVg==
X-Google-Smtp-Source: ALg8bN4NhEcn86H5IUIIQOxtvVUdIJFVKz3Z27foVjWdkAb07by7l1zmm3iZXrGGzWLWsiaL+qV3kw==
X-Received: by 2002:a17:902:2c03:: with SMTP id m3mr20741381plb.125.1547832833984;
        Fri, 18 Jan 2019 09:33:53 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id c7sm7838281pfh.18.2019.01.18.09.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 09:33:53 -0800 (PST)
Date:   Fri, 18 Jan 2019 12:33:49 -0500
From:   Barret Rhoden <brho@google.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and
 their changes
Message-ID: <20190118123349.346ca2d1@gnomeregan.cam.corp.google.com>
In-Reply-To: <nycvar.QRO.7.76.6.1901181038540.41@tvgsbejvaqbjf.bet>
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-3-brho@google.com>
        <nycvar.QRO.7.76.6.1901181038540.41@tvgsbejvaqbjf.bet>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-18 at 10:47 Johannes Schindelin <Johannes.Schindelin@gmx.de>
wrote:
> ... and this change limit the user to specifying a single file, for no
> good reason. Worse: specifying two different files via two
> `--ignore-revs-file` parameters will only heed the latter and skip the
> former without any warning.
> 
> A better idea IMHO would be to use an OPT_STRING_LIST() for
> `--ignore-revs-file`, too, and to allow for multiple
> `blame.ignoreRevsFile` config entries (with our usual trick of handling an
> empty setting by resetting the list of paths that were accumulated so
> far, see e.g. how `credential.helper` is handled).

I can do this if you all want, though I was modeling it off the behavior
of -S, which also only takes a single file.  

Thanks, everyone, for all of the feedback.

Barret

