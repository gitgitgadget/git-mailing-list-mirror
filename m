Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5E8B1F404
	for <e@80x24.org>; Sun, 11 Feb 2018 14:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753364AbeBKOow (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Feb 2018 09:44:52 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35721 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751077AbeBKOov (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Feb 2018 09:44:51 -0500
Received: by mail-wm0-f52.google.com with SMTP id r78so5483555wme.0
        for <git@vger.kernel.org>; Sun, 11 Feb 2018 06:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=C0H3T38IDL0iTOxHpkoAyhpWq1kA92tyamWAbayrEZ0=;
        b=G2a+UCh8B09LOBPP/nt4DbViC/WwbFQRRtUc9m0yhgXVuWCW0MLQVfXi7iK0VuKyux
         doa3A2uIJd5RugJKqEqD7aiXgm5hObgzRLhygcz6NHmvV0zx/GcW7aGAi6AHpgrwNc9W
         R3/JzHMMIssrag6NmhjWP5N6odjHex22gJw9bgjZOOU6+7pgmEHs8jtJgWkwhPOAbXoI
         ZicLFwisa4eOyhn23LpMRow/rciXIoxfBGkt/EHkDQM2dtqtLjxK31qE8B+ueu74YzCv
         iwgps1X0SNnIbbhC1CnOfcYj78vD/cRVUdbOpJEV7/UBT8+LLHN+Cor33pE4KtfxKZ9c
         G/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=C0H3T38IDL0iTOxHpkoAyhpWq1kA92tyamWAbayrEZ0=;
        b=rBIG41V8++/2oDdUef+slJcNRKYTGorXFgJebIuQ3KNAVnaH62p9N/jpdRhVxxVwKk
         AEjmdMcWrIsIJTD1cDmaRvrbUnool5HHMCRcSt1ucENZw8qevX7j/tBsenl/CmhHV5yF
         qsdseh86z4un5NzI9Pme6hsNI4yFW8yHpd4VBsP41RJw2AAX2svMXPe23wy1kp7PKQrb
         Fu8rkDIrOs3TELJww+op/2X8aMk37TL6TQj/tVTqWMAh/MKOEHZLOz4cLwLBH55rzE+c
         38MjO1Ayfm79qbElcgoIMNJFJc1IhYgoRkA1QxKiVe1PSO+D2xwDVzSvFMbRR72I1uiD
         emcw==
X-Gm-Message-State: APf1xPBYAFASlwsvXlQmllB/To1uk2Pvqph5Q5wZ6YWQQxXVV5UsH6rt
        Dhn9L79ZpFU24vRlHq+sGoY=
X-Google-Smtp-Source: AH8x226GI8jy/cFPQM7fXLZ3pxDKJNQFrMKEL4IBwwtYxpHZl1ukIaCJ5+bYU7I7pdJq5/jPvfE3Ng==
X-Received: by 10.28.54.26 with SMTP id d26mr1276191wma.59.1518360290049;
        Sun, 11 Feb 2018 06:44:50 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id x127sm2777966wmb.36.2018.02.11.06.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Feb 2018 06:44:48 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2018, #04; Wed, 31)
References: <xmqqd11pr0he.fsf@gitster-ct.c.googlers.com> <87372am2ls.fsf@evledraar.gmail.com> <CACsJy8BeQ3mD9pReUZKi+=qio5z8an5RyVd=auxPnMZ3uCRhdQ@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
In-reply-to: <CACsJy8BeQ3mD9pReUZKi+=qio5z8an5RyVd=auxPnMZ3uCRhdQ@mail.gmail.com>
Date:   Sun, 11 Feb 2018 15:44:47 +0100
Message-ID: <876073k2lc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Feb 10 2018, Duy Nguyen jotted:

> On Sat, Feb 10, 2018 at 1:37 AM, Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>> On Thu, Feb 01 2018, Junio C. Hamano jotted:
>>
>>> * nd/fix-untracked-cache-invalidation (2018-01-24) 5 commits
>>>  - dir.c: stop ignoring opendir() error in open_cached_dir()
>>>  - update-index doc: note a fixed bug in the untracked cache
>>>  - dir.c: fix missing dir invalidation in untracked code
>>>  - dir.c: avoid stat() in valid_cached_dir()
>>>  - status: add a failing test showing a core.untrackedCache bug
>>>
>>>  Some bugs around "untracked cache" feature have been fixed.
>>>
>>>  Will merge to 'next'.
>>
>> I think you / Nguyễn may not have seen my
>> <87d11omi2o.fsf@evledraar.gmail.com>
>> (https://public-inbox.org/git/87d11omi2o.fsf@evledraar.gmail.com/)
>
> I have. But since you wrote "I haven't found... yet", I assumed you
> were still on it. You didn't give me much info to follow anyway.

Haven't had time to dig further, sorry, and won't be able to share the
repository. Is there some UC inspection command that can be run on the
relevant path / other thing that'll be indicative of what went wrong?

>> As noted there I think it's best to proceed without the "dir.c: stop
>> ignoring opendir[...]" patch.
>>
>> It's going to be a bad regression in 2.17 if it ends up spewing pagefuls
>> of warnings in previously working repos if the UC is on.
>
> "previously working" is a strong word when opendir() starts to
> complain. Sure we can suppress/ignore the error messages but I don't
> think it's a healthy attitude. Unreported bugs can't be fixed.

I mean that for the user it returned the right "git status" info and
didn't print errors, but yeah, the index may have been in some
internally funny state.

> We could perhaps stop reporting after we have printed like ... 5 lines
> or so? That keeps the noise level down a bit and probably still give
> enough indicator to at least repair the cache.
