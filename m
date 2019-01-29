Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 80B7B1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 18:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbfA2SLJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 13:11:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53331 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbfA2SLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 13:11:09 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so18900379wmb.3
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 10:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Us7E74fP8dhak1CFsqlnWOebv8NHHa7BvZdk+GyDwAE=;
        b=OyB3kH86tZckHTYZ7zVbsIrkdEaUd/fGml0hdUpHG9Tw7yECOgZ6+H1nDxXLAIcBXM
         iqa3pGludAY1mgwnNJ64LpV2390p1aAkKXQ1eRKvpd3qv5OLBk6qESFLD83xnzv62X50
         DlFcRNYk0Wm+vaQH2UEBMRUnS0ItFsNattIIgREQ7xiFvJtZY29b2OTzgp+/JcAxFZf8
         bl09A1pso2aBISwLiCG0Er3754pcyonSOMVcu71P0ZVmUxZ/Z7ITUSIc72mHIAyyZOQE
         Ilyl9A1nb0s8+iaRAWp7v+dzRUo+hOyFgAGrpqCoSEUB4TuSWU4JAdKKg7hlGPgJOV3o
         cUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Us7E74fP8dhak1CFsqlnWOebv8NHHa7BvZdk+GyDwAE=;
        b=ZFR/TUnZbmX6rc9UvwRaNot60pgk1m9hm+T5GU88LDG/c8+324N8WWjJp3iu0UowLP
         B55Xu9LAxLJ5kk7m32zG4WGRwmqAEnWlCrkvd/1AziSAi2WI6IaJS9Trz77Gd2W1ffEw
         0dOnzjHip4IdFTJqs1U7fu+Y/Z/z9lzR1AG7jIXQuHw0Onn6cz/J0qDxqFgCZBbfkdsU
         HhAeZpJcbh/LZ1scFCUyqWFH8NI4FqsFlhcrF3/Yq6XRIvtVjmQ7ey2OeDLriwvaaZeP
         CF3a3/WsXnnqT4ymMKfciQ/ny4TS6suamO4u2wYl0h359E5A1vRlZwMyRgSDn2SXHgIT
         g5GA==
X-Gm-Message-State: AHQUAuaYmSrlmtLm7Y1k8uNq5dT8OfUeD1eGp/YieRSsNk9l7UjvxLZ0
        jSQguNoNYtqLTQK22Z45dXg=
X-Google-Smtp-Source: AHgI3IYy+RlDo5AzizpjXaY9g1HGtOS8wM5u07KvtvIQ1ROWN+GWE+DcDsVI0Oo4Upre1Rd1Sh0AmQ==
X-Received: by 2002:a1c:44c5:: with SMTP id r188mr2983862wma.151.1548785466998;
        Tue, 29 Jan 2019 10:11:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 202sm4533838wmt.8.2019.01.29.10.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 10:11:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: pw/rebase-x-sanity-check, was Re: What's cooking in git.git (Jan 2019, #04; Mon, 28)
References: <xmqq4l9s9zee.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1901291353340.41@tvgsbejvaqbjf.bet>
Date:   Tue, 29 Jan 2019 10:11:05 -0800
In-Reply-To: <nycvar.QRO.7.76.6.1901291353340.41@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 29 Jan 2019 13:54:55 +0100 (STD)")
Message-ID: <xmqq7een8hc6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 28 Jan 2019, Junio C Hamano wrote:
>
>> * pw/rebase-x-sanity-check (2019-01-28) 1 commit
>>  - rebase -x: sanity check command
>> 
>>  "git rebase -x $cmd" did not reject multi-line command, even though
>>  the command is incapable of handling such a command.  It now is
>>  rejected upfront.
>> 
>>  Will merge to 'next'.
>
> I offered two suggestions: to use a more readable `strchr()` check for the
> forbidden embedded newlines, and to not bother with special-casing the
> empty command but instead handling it the exact same way as an invalid
> command-line would be handled.

Thanks for stopping me with a prompt response.


