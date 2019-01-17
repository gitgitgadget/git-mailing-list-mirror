Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7B4B1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 18:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbfAQSyC (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 13:54:02 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56055 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfAQSyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 13:54:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so2165068wmc.5
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 10:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zqJwHXL2DSIKkBaaoW1ljt6DnwjxWERY1zxi5GWizNI=;
        b=Q56/sffOPI97wlDURh3GII1nupbhXXwvf9iQbK6bNfYqBtlGVxfR7jjqlL/X2lcoNM
         GD3FKlPKc3VTrbe/cRo92rRyooPNiIvTpeqLYRbmfKQvuKNjjfkqONkdPvUNNAzkWbUW
         zsBuwzLhVq/Po9Yp7cgRMbn+BhUlbgYm1YOBOMSSQZX0e52sC2zUoGnn2jPVCj6dDTDV
         1x69K7oxWv9qWRfMF8ufqlmuR3Joxmujc1VCVbW94XhCgXAHs/D4aAHOG7PeYh1ftUIX
         e5VvDVzD9bYuSEj3sVKGMiDiOUHmS1KNGSHh1VdEj5hlLv0PErEI76KILrjM47TaS1RZ
         G3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zqJwHXL2DSIKkBaaoW1ljt6DnwjxWERY1zxi5GWizNI=;
        b=QJebEUAR+JeRKDTyeG8XqnA6uJZeHxfroOhXfGjMOBawer+BUEcq/5HrsLj2/NwrOM
         kQX4rjqCKF682iH3JLDnHJLXrzZ5cAKM2KUFdoRq5uzu4ZzRu1x9r3ElsQ/UhYMqJKq+
         PyiThoEoYJi8fa2rWEPcFfjZqv+Su+qPzVp6DEki4rdoGAIxMp7y7CsXMsq8O8iwKT0m
         PGWR/1UoEuseqsTam/40TQwNhvbbCaaCazySHGn5VjbeuXYWUb4YOY8C77N99MgndWRa
         Xk99g4/e3mvEl2o0vyEg6C6b1yHU3eF/bnYUIBNczi4K6cJWpGLMLBmJKcZOFz4E4wfT
         /Pgw==
X-Gm-Message-State: AJcUukcMxueeSVyBHZuCLOO2K37Fvbgdx7DYwvfdUoh2xTsIeRg21uq9
        H98LLJr52+AFdZefzmM56mM=
X-Google-Smtp-Source: ALg8bN5cR3n4ugbODmi6Tb6BLbRkIFYZ3NTWdGKA0C7cqvGXdjcmOMEYrmXA7+0+Md7esq7s6CQelw==
X-Received: by 2002:a7b:c156:: with SMTP id z22mr12801239wmi.24.1547751240467;
        Thu, 17 Jan 2019 10:54:00 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o8sm78007776wrx.15.2019.01.17.10.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 10:53:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] helper/test-ref-store: fix "new-sha1" vs "old-sha1" typo
References: <20190106154637.10815-1-chriscool@tuxfamily.org>
        <CACsJy8B7ogYEzwDAT7v1z4T-YsTa-e3VPbCfNBmc4v5R=06meA@mail.gmail.com>
        <CAP8UFD2vLhn1_hUefKfsE8+3SDZk6qzf8eS-DUoZLhf41QiyAg@mail.gmail.com>
Date:   Thu, 17 Jan 2019 10:53:59 -0800
In-Reply-To: <CAP8UFD2vLhn1_hUefKfsE8+3SDZk6qzf8eS-DUoZLhf41QiyAg@mail.gmail.com>
        (Christian Couder's message of "Wed, 16 Jan 2019 12:13:10 +0100")
Message-ID: <xmqqa7jznmig.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jan 7, 2019 at 1:53 PM Duy Nguyen <pclouds@gmail.com> wrote:
>>
>> On Sun, Jan 6, 2019 at 10:46 PM Christian Couder
>> <christian.couder@gmail.com> wrote:
>> >
>> > It looks like it is a copy-paste error  made in 80f2a6097c
>> > (t/helper: add test-ref-store to test ref-store functions,
>> > 2017-03-26) to pass "old-sha1" instead of "new-sha1" to
>> > notnull() when we get the new sha1 argument from
>> > const char **argv.
>>
>> Ack. Definitely copy-paste error.
>
> Thanks for confirming.
>
> Junio, it looks like the patch has fallen through the cracks.

Indeed.  I did notice two smallish cleanups from you but did not
spot this one.

Will take a look and queue.

Thanks.


>
> Or maybe I should rework the commit message?

