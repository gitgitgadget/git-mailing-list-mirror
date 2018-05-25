Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1584B1F42D
	for <e@80x24.org>; Fri, 25 May 2018 01:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972139AbeEYBik (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 21:38:40 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:44513 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S972137AbeEYBig (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 21:38:36 -0400
Received: by mail-wr0-f178.google.com with SMTP id y15-v6so6344911wrg.11
        for <git@vger.kernel.org>; Thu, 24 May 2018 18:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OF8MBdnWXSzx6N0EtUt90p6XUfp/whHt0ZJzaQUOjJU=;
        b=BtO3gEgmy4XvHyVM7XelTyiv5l6/L5KTr7pGfNCKAfUw0EACvbyK6PJNFDKh96WRG6
         YpeUL9npP+oOLfdG+VKpjjB9qRtjt0bBTh/rDm0ULuwXahoT7QxHiKcLi/GODT2kIQRe
         dUR0ZruzQsdUrsHtLsRvlY8co/FMetFxEY5ExXn2aET/GxbRxE5sIj6p8rrQ8t9z2FKf
         ZR5hUiksCtzZ6++VwW6U5H1kT8+IbrmvfR01s7CegytKvlTIHTjvutRxxJIlv/fZ0C9N
         SLky13EVOXlJw7/x/KX8ng63u51dUxavZoYi0i79E9hr9SydJCkxlggtz4asQeRpyKbV
         Huqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OF8MBdnWXSzx6N0EtUt90p6XUfp/whHt0ZJzaQUOjJU=;
        b=Kg0bGzSeEG6VNYJrb+OI8Vrfa6MVUtU/oxmZSHTVCPaqbAyDGfv9mOEABAu012XPaq
         fq7pL4dgRtHdZX6SvW3/L2GfbbmGs4UiqLpBTXwdyjK46mttseTsHh4ixXm0c1yONhPX
         iYP2sXa1t6DtydVzei+pRxdtPToBiOuR6aiCEM4GhwWev2pm8ZPexAgUVGB5y1temnXD
         hdzxVwkEz6ek7t+lpQ2BlyKl6Le7kSQoNz6EyHk76HB0eLgisw3Cxczd2DuujaAzi/oB
         eZmNewHaTwr/KdrvOAHD4ZVIdfRMUJKruC0hW/lhWvSFj7Z+dAI9aZLbExWGUzp/v964
         JwYA==
X-Gm-Message-State: ALKqPwfuFDtrie2lurcr3+EyGDS3X8NlhPtzPJiRSDCBVaenCcEvEpJz
        ZVpbRHbbh0z6G37+SmJycrQ=
X-Google-Smtp-Source: AB8JxZod/Bo5kay+xfublCXulHr4tQw06ZeGvVhE1y803sCuJd2oFsVbwI5cNDFDdhEaD0qFKAJOjQ==
X-Received: by 2002:adf:b097:: with SMTP id i23-v6mr260686wra.52.1527212315215;
        Thu, 24 May 2018 18:38:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id k16-v6sm6137724wrh.25.2018.05.24.18.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 18:38:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Subject: Re: "man git-tag" inconsistent about whether you can tag non-commit objects
References: <alpine.LFD.2.21.1805241040400.14773@localhost.localdomain>
Date:   Fri, 25 May 2018 10:38:33 +0900
In-Reply-To: <alpine.LFD.2.21.1805241040400.14773@localhost.localdomain>
        (Robert P. J. Day's message of "Thu, 24 May 2018 10:46:18 -0400
        (EDT)")
Message-ID: <xmqqpo1kpl9i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert P. J. Day" <rpjday@crashcourse.ca> writes:

>   embarrassed to admit i had no idea that you could tag non-commit
> objects, only realized that when i was reading the man page and saw:
>
>   SYNOPSIS
>      git tag [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
>            <tagname> [<commit> | <object>]
>                                  ^^^^^^^^
>
> so i tried it and, sure enough, i could tag a blob object. but if you
> read further into DESCRIPTION, about halfway through, you read:
>
>   "Otherwise just a tag reference for the SHA-1 object name of the
>    commit object is created (i.e. a lightweight tag)."
>    ^^^^^^
>
> which suggests only commit objects. finally, much further down, under
> OPTIONS:
>
>   "<commit>, <object>
>      The object that the new tag will refer to, usually a commit.
>                                                 ^^^^^^^^^^^^^^^^
>
> so to clean this up, is it sufficient to just change that middle line
> to say "object" rather than "commit object"? or is there more in the
> man page that needs tweaking?

As that sentence talks about a lightweight tag (i.e. a reference in
refs/tags/ hierarchy that directly points at an object of any kind),
another possibility would be to say

	Otherwise a tag reference that directly points at the given
	object (i.e. lightweight tag) is created.



