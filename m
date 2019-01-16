Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B54E5211B4
	for <e@80x24.org>; Wed, 16 Jan 2019 04:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbfAPEI4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 23:08:56 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:51527 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfAPEI4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 23:08:56 -0500
Received: by mail-wm1-f43.google.com with SMTP id b11so516485wmj.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 20:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0wRUFJxHA5NQmiNtWHBhnPmiNqPAJfVc/JTzeq9sj90=;
        b=EjkzHUsxvaM3eIsPnLz0fT+z+ETG5yMyP1LwGA1MVDsxhBvsSWq86A8zOXSbpwAY4B
         MVoIP5V07LT4+jMRdlMhGET//ittTQPhzPy5yJ4y1uJJjyLOZApcyjSU33fW1dioWStk
         Kw/z/NDtvNOrOhwe/bspAu8RGCxcJNDSo26wc3hjQvWdHB5NhHSZf6lxqz0Qndsj1MvQ
         kI6giDm8F40MORMnX/sjpv7zMbZkgNqrs/TerjqKCu8H1xVHwK5FIX4Ie6dd/lY9Gx1q
         4KtS1h7b4V3K55Pgqy7eKGspjvDSQAivTjm+3sMhlUdb3lU0B0utHOsp9NwMqGm/DFXF
         tRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0wRUFJxHA5NQmiNtWHBhnPmiNqPAJfVc/JTzeq9sj90=;
        b=Rl1Q2DwoG8PfOhcq7yxDQlaLeHoovlDO5LU1jm+f69O+wlfIPGxv7wFLF8Va0BT62s
         we6r7WKktEJG0GmYez9jHcIWI2MEe4/0+OSJqCh1rzLG4VwlAGnBi5xQ/S2aB5jLAR45
         BODkWNGCvJdEmkps5iiTHjyC0XxEZoh26LdF6hM28bLv61vOmWbGxaXNyMlRopVCE57Q
         RCR+5+5n9sfA1KQzxGwA4rMCYFisXCD6eZdHg9JlC+80KoaPTomBtJRXeumkRtB7/vqp
         5vqp/+H9YJEm+KyBjomXlUqKxYQYBV9WWyKCkyu4dq0rIAv/cDas/+i2jleFZD0C+P0r
         0A6g==
X-Gm-Message-State: AJcUukel36VU9GTHRoKDKhFXPggPkiQDw03qyU7k/EWZwBdJBQDSXbqN
        IL1DoViqzaXNsc0995/bbBo=
X-Google-Smtp-Source: ALg8bN61POUvrv4aDMqCfKLx64H6XcdkNDy7X9hFNy5g79tjpAgAyQmlhCvUtUoOZllbnmGl3BifQQ==
X-Received: by 2002:a1c:5a42:: with SMTP id o63mr5625180wmb.88.1547611734166;
        Tue, 15 Jan 2019 20:08:54 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 129sm55728672wmd.18.2019.01.15.20.08.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 20:08:53 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2019, #02; Tue, 15)
References: <xmqq4la9r1sl.fsf@gitster-ct.c.googlers.com>
        <20190116040254.oeeqelwkfe5b35gu@dcvr>
Date:   Tue, 15 Jan 2019 20:08:53 -0800
In-Reply-To: <20190116040254.oeeqelwkfe5b35gu@dcvr> (Eric Wong's message of
        "Wed, 16 Jan 2019 04:02:54 +0000")
Message-ID: <xmqq36ptp7l6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> * ew/ban-strncat (2019-01-02) 1 commit
>>   (merged to 'next' on 2019-01-08 at 3bba2ae2bb)
>>  + banned.h: mark strncat() as banned
>
> Can you squash in Eric Sunshine's speling fix in my commit message?
> (s/iself/itself/)
> https://public-inbox.org/git/CAPig+cR2w3S==3-zstjmuB9jw4H-aPK7xqMeMLK-P94=+18jJQ@mail.gmail.com/

After it got merged to 'next' about a week ago?  Perhaps not.

