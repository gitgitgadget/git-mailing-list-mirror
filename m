Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EC91F453
	for <e@80x24.org>; Mon, 29 Oct 2018 14:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeJ2W6g (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 18:58:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38475 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbeJ2W6g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 18:58:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2-v6so2588983wmh.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=QjRQZMK3kY6V1JwsL2YZGNuJ+nGESacNv9WazCscgow=;
        b=WxBGCxn2DFRFCJdhss3hWg7ANZvGLqGGl2znpWJ2XlL48Z/PzfXPfIyG3buVXcVMx/
         zRtdALgVFBoaW3H7EWaWESezLshwUscC4uWrm+YpiA6KnorgGuJzWy2WUlhBZRuf7H8D
         2k5h4wngvtQLCO6UL64H2+1lfiJi/3ulASDVv3krz5B2jgBsgF3k/4RA1Fjl6PR4HaHD
         99yFRicd9RsSWcHTq+g9tA53KtGJzSYfsZ45CiCgvrGnq0+uQrsbp1fxi0KhrJJzth0i
         YZI+yKi1CpIXwZu2DWKJ162udgM2vRCGU4Uc/uYecsPrwKW7BNlLe4tXwXpLYuBtVRB1
         d7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QjRQZMK3kY6V1JwsL2YZGNuJ+nGESacNv9WazCscgow=;
        b=OhQlJFfg1D3S6/AKtIrTfxxJnWlUG242lTXjykW1A9w2+ltD2l+tBVv9WMNsGPVdhm
         pR0wYd2oLXVDQieYP+257KsyvHWPfHEz2xVB3oA+bgpgy+9i5NMlCGupTwDZ9C9Utupa
         leS7cHkwxuonLEZyzgSpvo30/IUBnpYmAfIq2mRjML50gJYsIwJJ7dK1Px8YrDOUizSZ
         6PwYHjNeE4yr2C0emEkw9ZkU6dMYyotaraQI+Jf+efH5Qgdfba4gdBDbjtjRNt9q0b3Z
         sSXDwgkbTUyZk0Kp/0bcJy/CBG5gophrArg4fa5Ibih5cD76WaJtBJoyg8ATTWeZDx7f
         5Sqw==
X-Gm-Message-State: AGRZ1gKGu1JTPQS6W6bhXvsUuHMFp16Tzdl4Cx03viSIikpqgWQfe7Tq
        KXNkaA0B5oxWh56ZH3o05gw=
X-Google-Smtp-Source: AJdET5c/dAe5XkYZWaWeJTH2G6wTAYcu3zXeLcQI6mmjsZP0NXVv2o4gZyDkiN83oNkHFhGcZPVCfA==
X-Received: by 2002:a1c:80c4:: with SMTP id b187-v6mr2655351wmd.97.1540822184990;
        Mon, 29 Oct 2018 07:09:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b16-v6sm1637773wro.56.2018.10.29.07.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 07:09:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
References: <20181028065157.26727-1-pclouds@gmail.com>
        <20181028065157.26727-13-pclouds@gmail.com>
        <20181029105304.GP30222@szeder.dev>
Date:   Mon, 29 Oct 2018 23:09:43 +0900
In-Reply-To: <20181029105304.GP30222@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 29 Oct 2018 11:53:04 +0100")
Message-ID: <xmqqsh0o3kuw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

>> -	fprintf(stderr, "%s in %s %s: %s\n",
>> -		msg_type, printable_type(obj), describe_object(obj), err);
>> +	fprintf_ln(stderr, _("%s in %s %s: %s"),
>
> Are the (f)printf() -> (f)printf_ln() changes all over
> 'builtin/fsck.c' really necessary to mark strings for translation?

It is beyond absolute minimum but I saw it argued here that this
makes it easier to manage the .po and .pot files if your message
strings do not end with LF, a you are much less likely to _add_
unneeded LF to the translated string than _lose_ LF at the end of
translated string.
