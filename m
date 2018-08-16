Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA7AB1F404
	for <e@80x24.org>; Thu, 16 Aug 2018 18:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbeHPVmJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Aug 2018 17:42:09 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:37778 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeHPVmI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 17:42:08 -0400
Received: by mail-wr1-f44.google.com with SMTP id u12-v6so5018460wrr.4
        for <git@vger.kernel.org>; Thu, 16 Aug 2018 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=sMThsX/1ThVdX/n5qHTh3Tww1PR3545JZYuKCoP8DeY=;
        b=cA7BrWbYnrqQcyqkILsUwRyZa688s3MUqf7TZIvxnObctU9Yd5PghRJeXenTghpO6i
         UH12WbQe1v4RhkQkLyBkLPyZ2sirROX5L7Sg+TgQqqoHp5wnf6RQAQAa3YXIwKcYkDTH
         NYHXqK9zgnrw7mbYCbGk5nq1exyJudI3pbOvSO6cAQ5mKcy1DlHdR/3K04IRI3KAB47F
         zNHS5ue+mq/YKPa8VF1A87NsHvoX61kd+d0duoUIO96tyxRRlQqYnWRU49UaTZoQzfyU
         4f1axaQ0aIhGudtfZq++JOMUowFM+jY/mlHr/x1017TSv6ZS9wDcehzBPXr3uBg3TSq6
         D4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=sMThsX/1ThVdX/n5qHTh3Tww1PR3545JZYuKCoP8DeY=;
        b=mn4qXzY6CivzjQYwnVKvdnnuio6PapEuSgisB/6TcCbtOcX1TqrgErmCxy0Z0GE8/q
         msvCoMRvv+fuDDRWPDKILMPejp5RSCdo8sPxYDMfNzs0dKiu8Ml2poG4kwDM8Gf6FcZU
         897qPQHt79sQQcS5z+xIyLA5q5zQ7wRoUHZ5tjPYfQJGp/z5g3pYh7ZYqeEbRFEndZ/k
         FBKtlWIw2t+QP1Ku1xlC4QCvIlam3tMCw6lCjc5s7hc9M5e4/bCnGgtv2IoNFe6Vv/df
         DjcKFFqoCL3h1xjkyg1V8FWmgnLK+MRgoaF0R7u7XgVgDrQKqjozO5K6XLRsdX1Xyt+6
         zx3Q==
X-Gm-Message-State: AOUpUlGSWG6J7fORy91TQ64Fb24YUPubRz6HGdQp0o5SxyNRTmRvRr4/
        pmR7vIwVn4WzFdFwhlgQAatu18H6sdc=
X-Google-Smtp-Source: AA+uWPyvTYNHZhqpdsQ5zMXoZvcsESWq2oIn/jztC+hwEplaNk0SYbp0/PsvdnNR9JhiXWrubmpMlw==
X-Received: by 2002:adf:9a0b:: with SMTP id z11-v6mr18904256wrb.47.1534444919471;
        Thu, 16 Aug 2018 11:41:59 -0700 (PDT)
Received: from evledraar (h98111.upc-h.chello.nl. [62.194.98.111])
        by smtp.gmail.com with ESMTPSA id b13-v6sm32365wrn.17.2018.08.16.11.41.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:41:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Shani Fridman <Shani.Fridman@visionmap.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: submodules : switching to an older commit/Tag in project with submodules
References: <bc9762aaf57e441e95f9eed4e64799b7@EX13.visionmap.co.il> <CACBZZX5QXiAMfP8=bBps26JqSOHYSaK722GcnRjfDX-OcKQ=cw@mail.gmail.com> <xmqqr2iydvk2.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqr2iydvk2.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 16 Aug 2018 20:41:58 +0200
Message-ID: <87d0uiqhl5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Aug 16 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Aug 16, 2018 at 12:54 PM, Shani Fridman
>> <Shani.Fridman@visionmap.com> wrote:
>>>
>>> Hi everybody,
>>>
>>> I've got a question regarding submodules -
>>>
>>> I'm working on a git project with submodules connected to it, and pulling changes from them every month (more or less).
>>> Sometimes I need to checkout older versions of the project (tags or specific commits), that needs the older versions of the submodules as they were when I defined the tag. The problem is, that the checkout only changes the superProject directories, and not the submodules... I have to checkout the relevant submodules commit manually.
>>>
>>> Have you came across the same problem? Any idea what can I do?
>>
>> You run "git submodule update".
>
> The problem is, some people consider that I have to do things
> "manually" X-<.

I may be wrong, but I read that part as e.g. cd-ing into each submodule
dir, and checking out the commit you see in "git diff" from the
top-level, hence the suggestion.
