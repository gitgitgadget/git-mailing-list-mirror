Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7CB21F955
	for <e@80x24.org>; Fri, 29 Jul 2016 15:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbcG2Pf1 (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 11:35:27 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33098 "EHLO
	mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbcG2Pf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 11:35:26 -0400
Received: by mail-io0-f193.google.com with SMTP id y195so9885993iod.0
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 08:35:25 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IHckrKv04g/ILKM8UtTHGLLmZtWYUoyj1jD+vaDEn8I=;
        b=lHk229UsJTt7A+4+ytvsLbqusrggmS4KTLHuoODIkxG8rWwo0Mbxu0oYVGqXdPDI9k
         f5z21T8guF4vyX3mMC+jCkMPcx4TyIPSJwGTSCbF3MHc1EA06rEBMoq5NN0WD8uw+kyO
         1CSnoy76cywILa/Cy46FgSe9rMZr9nYVgiAe0s+UZ+/e8FzoSfeYuqrIKWrXLmmOd1wb
         qvnNWuTK1MKWeSMzRpO3LgQfY744OjPm/VvpG4sa/tclbQCBSmfrxgf+a0aeA4hAwkIx
         2DO6W9ipLkyT+1D96zAuboRg4L0OSixWhCuhVk82KIyyjOw9qVFM9wFnQk2rjU1dmHcU
         JDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IHckrKv04g/ILKM8UtTHGLLmZtWYUoyj1jD+vaDEn8I=;
        b=WfRP0tlWOH7a20RvtehkymUu2QxIG+KsR9Q8KCbDdm3IdSXtM2le5FYj3/mN/GDncL
         WcGs+/aMKEvktSgwi5URsaNwz4MA2eyNS6x1aZnYOgTdMf8/g6VrL2cGGfuziLQjJfYK
         oHXZDytjwIHU3jJ0i7vquVQOZy2uaN6l4T8o7kr3oMbjOxZ35AfrtxDUeqCM/9KM4b/r
         4XWWDyyaT1hOeDH0fZd3WG2OOzNZbzckEcwZycDl9PjNpc2sz1+ru4NZSD1XpwfxxcZg
         DpsBpU0wUDUmTJW1rL/+gVIq0KRhSNR+i7xwnany+FR4v1Z0b7bIbliD5EiW02VPf74b
         e7Ng==
X-Gm-Message-State: AEkoouth2ugjIZXSbfDMjISwutYyyGSZAT1SsLzDaBqApXhDxtQs42RdZYJkXJzl6uQfWBvCGcoRhpEAs9uwmQ==
X-Received: by 10.107.2.78 with SMTP id 75mr44440234ioc.128.1469806525132;
 Fri, 29 Jul 2016 08:35:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Fri, 29 Jul 2016 08:34:55 -0700 (PDT)
In-Reply-To: <CAP8UFD1SSjSGV+1e+zP4s=p+ohgSz6mct3EhPXqbde_y48ST7g@mail.gmail.com>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
 <20160627182429.31550-33-chriscool@tuxfamily.org> <xmqqinvs19ng.fsf@gitster.mtv.corp.google.com>
 <CACsJy8Bi00yBb6UPm7_x8BDnwQKCXXpOPbswKtayRofmSOstcg@mail.gmail.com> <CAP8UFD1SSjSGV+1e+zP4s=p+ohgSz6mct3EhPXqbde_y48ST7g@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Fri, 29 Jul 2016 17:34:55 +0200
Message-ID: <CACsJy8CT2r1MKE_bQotPzKEWi10QB81sNn6w7H23GxRkEYRFfg@mail.gmail.com>
Subject: Re: [PATCH v8 32/41] environment: add set_index_file()
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 4:21 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>> I agree we should avoid this. There's a bunch of cache_name_pos() (and
>> even read_cache()) in the libified apply.c, those will need to be
>> converted  to take struct index_state* directly (read_index_from or
>> index_name_pos).
>
> There is a lot of other "libified" code that is calling these functions:
>
> $ git grep -l cache_name_pos -- '*.c' | grep -v builtin
> apply.c
> diff.c
> dir.c
> merge-recursive.c
> pathspec.c
> rerere.c
> sha1_name.c
> submodule.c
> wt-status.c

Irrelevant?

> $ git grep -l read_cache -- '*.c' | grep -v builtin | egrep -v '^t/'
> apply.c
> check-racy.c
> diff.c
> dir.c
> merge-recursive.c
> merge.c
> read-cache.c
> rerere.c
> revision.c
> sequencer.c
> sha1_name.c
> submodule.c
>
> and some of that code is perhaps directly and indirectly called by the
> libified apply code.

Yeah. If the libification movement is going strong, we can start
converting and at some point should be able to define
NO_THE_INDEX_COMPATIBILITY_MACROS globally (and avoid the_index along
the way)

Without that, there is a risk. I looked at 'nm apply.o | grep ' [Uu]
'' and I don't see any external functions that would potentially
access the index, except ll_merge. Again there's a good chance I may
have missed something.

> So it looks like it is a very big and different project to make the
> current libified code be explicit about which index it is using.
> And by the way perhaps this other project should just remove the
> "the_index" global altogether.

This is probably the way to go. But it's the boring sort of work that
nobody wants to do :(
-- 
Duy
