Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CADF81F424
	for <e@80x24.org>; Thu, 12 Apr 2018 09:23:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752492AbeDLJXG (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 05:23:06 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:39282 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751611AbeDLJXF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 05:23:05 -0400
Received: by mail-wr0-f182.google.com with SMTP id c24so4385195wrc.6
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 02:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=3ov2/CUuSgbGqK7N3pb1XWBnEVq/dj9UB21b9guTFX8=;
        b=DCsM3vNh+P1kGd+w60lWF1HWs90QDsvWCUhQVVAfGPu8g1gGCaT6iLfQt0WXsjf0az
         hWsWc/9E0us20kGCNjW4X/J45dpZeZ85kb8vLgQnlsh5isj1cQN3TIrdEUfsoKNoailQ
         Um1qpCARyeJ4CdVjgoB2N2ShDTXZgqgtjSzxIh02JHAfLVgCfPsdziiKNfGsdmEHqkV7
         x77ygmVXsY8N8Tb9Fi1a2ZbW6bU9NN+5cWEC3Eo5267MHibWIynaU2Tfijq1U1wdGow6
         FI6mADHE1U8F0E8hZNRu0WfNErUCfOlAIDwNvmKpoIy+fn2z3lvjqm6Du86Jt6ZGJ0i3
         VckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=3ov2/CUuSgbGqK7N3pb1XWBnEVq/dj9UB21b9guTFX8=;
        b=LsAmlLXGhHrKejGVEBawmAhCPQxPQRts7wwhYLl52CPIdr9GNvDmqRlz2wpcfXhoui
         Y5Ee3NQtsmhNxJ2muHRTlWTneOSjaAM0pfZnhcd95J+sII3fp9Um6yTY9aqz0u3ZPt66
         KPM24cFNbPm5vaxQ9Iptzz8RQntWlP8p0wRAHYiYdFNhMJEInj8zgI5iLwymV0ZImkzB
         aaHq3QmREXhp9KQahHpzlZSYfpW0DhvQZjDa2OpqxoLR6OmYQYnFb/+cJd3I7V/NPuWf
         2VpriCjy0Qsat3RS9TW1jNMY3mE+QGR5tzhJuSNVfs1cMjQoMEAQrlf/ZfXD6a98muVi
         kTCw==
X-Gm-Message-State: ALQs6tB2VDgrbLvrjCX4QhPElDKQabmNQCtR1neLPAaAFCo8ejuqqrwJ
        T7M1u2hzqjVPa+ajo3rDx6Q=
X-Google-Smtp-Source: AIpwx4/t3fb2vIn467JxrgyR8faDVcUlTYhG3uKBCgKPcGAY9AyH+9kXToaa3BXH0ze0OSTuU4cc+Q==
X-Received: by 10.223.173.35 with SMTP id p32mr155164wrc.80.1523524984262;
        Thu, 12 Apr 2018 02:23:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v13sm561240wrf.90.2018.04.12.02.23.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Apr 2018 02:23:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Alexandre Julliard <julliard@winehq.org>,
        Dorab Patel <dorabpatel@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>,
        Kyle Meyer <kyle@kyleam.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ami Fischman <fischman@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v4] git{,-blame}.el: remove old bitrotting Emacs code
References: <20180327165751.GA4343@aiede.svl.corp.google.com>
        <20180411204206.28498-1-avarab@gmail.com>
        <xmqqk1td2ml2.fsf@gitster-ct.c.googlers.com>
        <87fu40c3xe.fsf@evledraar.gmail.com>
Date:   Thu, 12 Apr 2018 18:23:02 +0900
In-Reply-To: <87fu40c3xe.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 12 Apr 2018 08:52:13 +0200")
Message-ID: <xmqqa7u83hjd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> On the other hand, the 6-lines of e-lisp you wrote for git.el
>> replacement is something the packagers could have written for their
>> users, so (1) if we really want to go extra mile without trusting
>> that distro packagers are less competent than us in helping their
>> users, we'd be better off to leave Makefile in, or (2) if we trust
>> packagers and leave possible end-user confusion as their problem
>> (not ours), then we can just remove as your previous round did.
>>
>> And from that point of view, I find this round slightly odd.
>
> I think the way it is makes sense. In Debian debian/git-el.install just
> does:
> ...
> RedHat does use contrib/emacs/Makefile:
> ...
> But they can either just do their own byte compilation as they surely do
> for other elisp packages,...

In short, Debian happens to be OK, but RedHat folks need to do work
and cannot use what we ship out of the box, *IF* they care about end
user experience.

That was exactly why I felt it was "odd" (iow, "uneven").  We bother
to give a stub git.el; we do not bother to make sure it would keep
being installed if the packagers do not bother to update their
procedure.

If we do not change anything other than making *.el into stubs, then
it is a lot more likely that end user experience on *any* distro
that have been shipping contrib/emacs/ stuff will by default
(i.e. if the packagers do not do anything to adjust) be what we
design here---upon loading they'd see (error) triggering that nudge
them towards modern and maintained alternatives.  If we do more than
that, e.g. remove Makefile, then some distros need to adjust, or
their build would be broken.

I suspect that the set of people Cc'ed on the thread are a lot more
familiar than I am with how distro packagers prefer us to deliber,
so I'll stop speculating at this point.

Thanks.
