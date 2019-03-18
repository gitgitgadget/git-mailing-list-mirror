Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B8B720248
	for <e@80x24.org>; Mon, 18 Mar 2019 02:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbfCRCMS (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 22:12:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40769 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfCRCMR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 22:12:17 -0400
Received: by mail-wm1-f66.google.com with SMTP id u10so8563910wmj.5
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 19:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vP3aAG4+2w176tDKMbR1ZmEWOK/bUt2rms5IVPWBMVQ=;
        b=Ge+wP/Cc4V4aqTRiIE9enmi68AJGkW4KzT1zKfMq3JmFlwRRdsL62ahUbSwjL9lhgw
         VQ4p9C0TQBSK+qp6l/7Y4BVG9pN4ei8jgZmpYydOZ3dlromCfyo04wwi9ufHAPhWSzl/
         MXAgE0FOKNODFj3sP0eOJCghL3cHqUsgmvyiRAtZVGvO4KNKzspA5H6/k0COzazmrAny
         56XBUhEvzxu29tNkzA3mk+Se8XbnJ9/2c5O/aECHMfmsr/ZBZSAAfqL3xcWIWG+xWBc3
         /Ezf2lj3JzIDcQRjUbuDMfKb1jI1KY+zjyJ8ltVE6/rHtsEB+Wtdm1VBeEL+4A2x2FjW
         qsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vP3aAG4+2w176tDKMbR1ZmEWOK/bUt2rms5IVPWBMVQ=;
        b=UPuJ5elRUNLrNuG4PjU5DLL6jYfnKas6TWRmjNa/td+WXVa6IOxaVhm8ag3qKwJtFZ
         CtkYh2gEMvFlTO51HoGoNffq9vPRqzcF4cel2XAqxCv5KDJvdyuf8EQ40fhMDuq8LVmE
         r7AMlSotpTBdhjnbx5nIyk0LEu7vDMTX7TgAI45k4GeUhHXZaPqOV2LSfD0o0dLx0leR
         GTqx0Cys8NtBmCBiQ6MCqXOUs57gV0bibVsFwcGSpw6Id/Va3aTwt/XCZV/ZbNRriEUM
         HJ8XDiFK5opQTkqXNMps2y7Nav1f3HzUCAOaf2X6RrL51yRDOaGJMQiVR+yKOwOIro17
         El/Q==
X-Gm-Message-State: APjAAAX5zDhN0W0OHNBo+Qu3xGJGr2B9fVmz0H0il5Es/7Ig9iReIJSj
        BzgS0y3KoO7Tu2V3uGCVtXQ=
X-Google-Smtp-Source: APXvYqx6uxigBCPUg4yGS5/gIRfyWDM/uT7NAiBYBT9MqaJxEeUzrKFog9ZKcdod8Fo3wQI9P21ycw==
X-Received: by 2002:a05:600c:2143:: with SMTP id v3mr9181993wml.14.1552875135438;
        Sun, 17 Mar 2019 19:12:15 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id d15sm19300501wrw.36.2019.03.17.19.12.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 19:12:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Nickolai Belakovski <nbelakovski@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v8 3/3] branch: add worktree info on verbose output
References: <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
        <20190219083123.27686-4-nbelakovski@gmail.com>
        <20190221125952.GB13403@sigill.intra.peff.net>
        <CAC05385Q0EQWX8B5PfR2m6N7o573NTF+a0HyXS+zqYAAdgTVOw@mail.gmail.com>
Date:   Mon, 18 Mar 2019 11:12:14 +0900
In-Reply-To: <CAC05385Q0EQWX8B5PfR2m6N7o573NTF+a0HyXS+zqYAAdgTVOw@mail.gmail.com>
        (Nickolai Belakovski's message of "Wed, 13 Mar 2019 22:58:06 -0700")
Message-ID: <xmqqmult6idd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nickolai Belakovski <nbelakovski@gmail.com> writes:

> On Thu, Feb 21, 2019 at 4:59 AM Jeff King <peff@peff.net> wrote:
>>
>> On Tue, Feb 19, 2019 at 05:31:23PM +0900, nbelakovski@gmail.com wrote:
>>
>> > From: Nickolai Belakovski <nbelakovski@gmail.com>
>> >
>> > To display worktree path for refs checked out in a linked worktree
>>
>> This would be a good place to describe why this is useful. :)
>>
>> I do not have an opinion myself. Patch 2 makes a lot of sense to me, but
>> I don't know if people would like this one or not. I don't use "-v"
>> myself, though, so what do I know. :)
> I threw this one in because I thought it wouldn't be clear to the
> average user why some
> branches are in cyan. By putting the worktree path in cyan on the next
> level of output
> I thought this would help the user make the connection, but actually I
> don't have strong
> feelings about this one.

I am moderately skeptical on 2/3, but together with 3/3 I think it
makes sense.

The fact that two branch names painted in different colors from the
other ones, without knowing which one is checked out in what
worktree, will not give enough information to allow the user to
actually start working on one of them.  All the user gets with 2/3
alone is "don't touch it---it is used elsewhere and I am not telling
where", isn't it?


