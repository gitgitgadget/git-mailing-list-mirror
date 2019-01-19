Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8FA1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 17:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfASRuw (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 12:50:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43476 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfASRuv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 12:50:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so18683086wrs.10
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 09:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d2/j/5XtBYMjZcnFikjD0xXgVyvQbCunRUaM11eJd9I=;
        b=Z/FfBJWQ6EC34Stdxmfa6LYj+4wzVrQYepyJNXacB5SklvsebFpCNGTXBrl1DVGoCF
         FH2733JkSggSgWhMo/hfz3LE6C81issp4DSF/9qgrTSBNKzWmiJC5fi5iOTX36sCWmRi
         V+l2Ultf9QtpMb7d9BabdFaVRQMQ/4A/OFuqaWE3UeAKFSbDuKAlRy2dkM8P6Z4VZErf
         zUF2Seq0dmmuvWZu0DWa/JNw5V0ObiW4d1xf/Wit0To9mGvCFi+oD/eqnwrE8CbgT2oI
         q7Rhi6jLdOdC2EIPHPBgnGPQmuwMiW/9ot74vXvQdK4iNK9uxrCI/q+5YhEzlweqPUFo
         elPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d2/j/5XtBYMjZcnFikjD0xXgVyvQbCunRUaM11eJd9I=;
        b=NV7Ua1c+8MdvvcYTS+/YppeTrx78/tdIYOolxrJXCNWqkuFlfmMrS6SSxhKvisyvzK
         inOk4nJH38GmDXIZtet9e5qJc0pmXVpbSeAdc3ck/zosIVfRsyPUzXuEw93J0mE/1g/T
         ccFeyhGArjcM9c2mtXEDAu8w8ThowHVwRMlvyEdwM/ruafJtchFhptqGHsTun5hjC/+V
         XK2bVKiq0aCGvYF0QbdZ26AScNB6jZUGnrsER/z062wUa0YvYXyhiXiObqLLMVSAjIEI
         RzlW+8PZ7GUNdD7tqn7aowthlQJPRjkipdzj/1RpWxlQKOObXywh2seB5zZe01cx2IQS
         s/UQ==
X-Gm-Message-State: AJcUukdBuqLVj9i9h8drfJSkNb1xYSwz2oXt5M0DvkHiiEnCFrtSDRIZ
        RBw40ACjqnlLRNI+rtRaTQw=
X-Google-Smtp-Source: ALg8bN4Hu1iAqPnf8FDqCKpDeDS/8NdFkLuTHAyxdlhZxalroQbw/vm2K+7e69FysGbb5u4hL21T8Q==
X-Received: by 2002:adf:a357:: with SMTP id d23mr22209380wrb.195.1547920249501;
        Sat, 19 Jan 2019 09:50:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id o64sm41978959wmo.47.2019.01.19.09.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 19 Jan 2019 09:50:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2019, #03; Fri, 18)
References: <xmqqfttpimdc.fsf@gitster-ct.c.googlers.com>
        <CABPp-BFmYoeiOaB9Pf70TC3XftXjMEHGrPqxS8TgiiXR39q2rQ@mail.gmail.com>
Date:   Sat, 19 Jan 2019 09:50:46 -0800
In-Reply-To: <CABPp-BFmYoeiOaB9Pf70TC3XftXjMEHGrPqxS8TgiiXR39q2rQ@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Jan 2019 17:13:08 -0800")
Message-ID: <xmqqwon0h6yx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>>  On hold.
>>  cf. <CABPp-BFckuONYcGGkCY3BuPypRULmhsk_OFHyYA2E4jM66BfeQ@mail.gmail.com>
>
> Is the "on hold" comment still accurate?

Not anymore.  Back when I wrote it it was unclear to me what the
best way forward was (e.g. should one become dependent on the other
topic?  is it something I can carry a semantic conflict resolution
for, in order to keep the option open to be able to merge one
without the other topic?).  Now the answer is in 'pu' and after
seeing the "Has this been resolved itself?" from Dscho, I checked
the semantic conflict resolution I have can be used when the topics
are merged to 'next' or 'master' by making trial merges, so I think
we are in good shape.

I think these two topics by themselves were both good enough to be
in 'next' for wider testing, as I do not recall any remaning issues
in the code or docs in the patches (please correct me if it is not
the case).

Thanks.
