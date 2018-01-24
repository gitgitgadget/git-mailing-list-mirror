Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFB2C1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 21:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932602AbeAXVRl (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 16:17:41 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44396 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVRk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 16:17:40 -0500
Received: by mail-pg0-f68.google.com with SMTP id m20so3591719pgc.11
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 13:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GmNHiMnV6oywo9bGgMiOQl+51IpH3Kwl93a0NEtm4Sw=;
        b=tebk3IXjGeAf6K4tpayyWwLWZ+/0RVdINwqtnPPax3W8BlLB91CVzdgnkcojoegzkr
         Li+iOmiP+iHDoC5en2Tr80j8b1p/p3LlvFwFTC8IWTDD7l3HZO7rArMV1HGQPYJtUKZK
         tFeM8j0+jVt7abYxL0V1H5pXgU84XbIIXdidbwEU9Jr2uYkJAHcYHiItvRy8ceOV+beu
         HC2Gwxoz/rx2D29V4Ouo6HOjjo+48rxR4BbDX2eyjCo/2kYC7/LQg5Qr3wnh4KZr2sTZ
         zVN5Q24Ta/m8Iuik8OPFvTnMOfseweYkCj6dvebwJU5IKKkT6CS9HOhMXBaNJCtqQK9V
         wHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GmNHiMnV6oywo9bGgMiOQl+51IpH3Kwl93a0NEtm4Sw=;
        b=ZZWMsujrsBEbQB+789Y1Hp8el9PV/Lv/34BwJo+Ol+csF6NMqd3QauaM6Xh5PNot00
         4y+FLL33RPmJFU39G6KsCnKzny59vvfzFdgyI8U0O+Xo0KHj37AI1eXX3kJRIhDBLN7q
         WOzf6UGP8a76bRWUOrUKK+vHPg8mz5zom1gf+Qj8jxdx9m3nRdPzsb5p+AosxE5iYuq7
         +bNOHYOiOBHxIOjhB/kzocp9PRU542Ug9/uf6rOhix2FeY/GOgcx096tDyBU7a+GdEzH
         /9zoRn/UTtwW8RzS4KORkSvovitDcpXgFpb9hAA5MkCe2YXs50hw2fJMzTRCDMHpvg4a
         Mvbw==
X-Gm-Message-State: AKwxytfWPHUyWUK9I8HGhO8JZU5jwGiJPswBLgHIqnzVEpIdOdV+uVos
        Sd9Y7NYOJZQNGYpsfHjIKrA=
X-Google-Smtp-Source: AH8x224gViDbUPTZRtHe1YXwlYFOAdXOAuOzQz9WReOjGQoO9Tqkma/IktJUbeizsfI5FSWy3lhFHg==
X-Received: by 2002:a17:902:28a4:: with SMTP id f33-v6mr5989224plb.192.1516828659271;
        Wed, 24 Jan 2018 13:17:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:69e6:5f42:e334:a0e2])
        by smtp.gmail.com with ESMTPSA id e4sm9805739pff.116.2018.01.24.13.17.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 Jan 2018 13:17:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <randall.s.becker@rogers.com>, <git@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] Bring NonStop platform definitions up to date in git-compat-util.h
References: <20180121234203.13764-1-randall.s.becker@rogers.com>
        <20180121234203.13764-4-randall.s.becker@rogers.com>
        <xmqq1sifdmf3.fsf@gitster.mtv.corp.google.com>
        <001601d39554$e19d24c0$a4d76e40$@nexbridge.com>
Date:   Wed, 24 Jan 2018 13:17:37 -0800
In-Reply-To: <001601d39554$e19d24c0$a4d76e40$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 24 Jan 2018 15:49:46 -0500")
Message-ID: <xmqqzi53arda.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> > +#ifdef __TANDEM
>> > +#if !defined(_THREAD_SUPPORT_FUNCTIONS) &&
>> !defined(_PUT_MODEL_)
>> > +/* #include <floss.h(floss_read,floss_write,floss_fsync,floss_fork)>
>> > +*/
>> > +/* #include <floss.h(floss_fork)> */
>> > +#endif
>> 
>> The above adds a conditional no-op?  That's confusing...
>
> We are trying to make PUT work with git on NonStop. I can't tell you how
> much of a pain it is. This is a placeholder for others (outside our group)
> to know where to muck. I can remove it if you don't want it there.

It is OK as long as it was done on purpose.  I was just making sure
that this was an unfinished WIP sent by mistake before proofreading.
