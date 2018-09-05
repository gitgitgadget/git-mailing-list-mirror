Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FAC51F404
	for <e@80x24.org>; Wed,  5 Sep 2018 17:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIEWQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 18:16:32 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43081 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbeIEWQb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 18:16:31 -0400
Received: by mail-wr1-f48.google.com with SMTP id k5-v6so8542157wre.10
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6pUgxjE/ujIJKCSUhTN1JR4IZo6V4l+R/p2svIDNv/U=;
        b=BXFd2F+8nFilwwLufJ3HGkXZWg2DTWTCb2XS+k25+OmPLgM4ijYXnToLLYogwlE28X
         MzYFS5F1CxGUWNxwRgUOuDNzzykxuMcEJh5cAZcybkHv0QYryWNO16U1ltJl7pvJB101
         QhYPJr881O3dNK1pgAQ1MvuzgPtHJnHVWSYbwGjto0F8exeZcj7FycX4Ape/mjLvt01M
         dejPuMo4y6Evij5iTyhkUGA20fMPFtxxDlHmOdIzVmOM/mS1vnUUzFogsuN4WVTWP1zQ
         0frVITV0WHY2t6p9pR81t8BkeS4DEhcDIc2cZ8NmrmroXzyr8p53uqN6w6CxM+iXMdq3
         LkuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6pUgxjE/ujIJKCSUhTN1JR4IZo6V4l+R/p2svIDNv/U=;
        b=Hlu1d++/d9Q5fv8F+yMOSQq/tBSTFP01qRGzd3SymqEM3z0sEdxj/WHwMMwX+3dSZ5
         wHnk3MWJH8uQaYl7C4vti6VhB/gakKWtQEH1gDgzQfGpFEf6fn7OjLtnCo4modd2b05Y
         t2GBxwnZT1mSoGwQp20+4U7k5O0nSeUwB+nbyltXTeSxNDPgeDu+7A4GEx7tKeLTs1Pv
         B9AiFQNj0k+H58Nwj7qv+2bl6BjKdXYMqz/bj/vCjUH0XzKLv17v6NqBxn+zKUm7GlW9
         sezGcz2ZhleOFIz8QOjtq+5JVG8fOnydzoV3nMMdF2GfCO3GOyCpxgU8YjFp9lOErrsF
         lo7A==
X-Gm-Message-State: APzg51CTcumdpFEShBRhgBddiXZctdKXi3a5qIaS5pYOryeq/ThsWsDC
        6Lh04pKlSLsgLChW17AMf0Y=
X-Google-Smtp-Source: ANB0VdaPtdDOuM/oiUxTqeZxthC0lOvB+XLOFhfS3z4asHtdeC1dRlacQ/6paZKEqW3RnQ3lMFYVWw==
X-Received: by 2002:adf:b519:: with SMTP id a25-v6mr8515903wrd.273.1536169517285;
        Wed, 05 Sep 2018 10:45:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g2-v6sm3868698wrd.71.2018.09.05.10.45.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 10:45:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2018, #01; Tue, 4)
References: <xmqqmusw6gbo.fsf@gitster-ct.c.googlers.com>
        <CAPig+cTQLED6P2AWrxU=pvNc6WzO-5YVsPNh3fg28LdZqU15AA@mail.gmail.com>
Date:   Wed, 05 Sep 2018 10:45:15 -0700
In-Reply-To: <CAPig+cTQLED6P2AWrxU=pvNc6WzO-5YVsPNh3fg28LdZqU15AA@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 5 Sep 2018 05:14:13 -0400")
Message-ID: <xmqqftyn4z4k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> This description mischaracterizes what these changes are about.

Thanks for a replacement text; very much appreciated.

