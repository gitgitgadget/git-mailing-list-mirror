Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B75711FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 21:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752927AbcHQVON (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 17:14:13 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:32965 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353AbcHQVON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 17:14:13 -0400
Received: by mail-io0-f170.google.com with SMTP id 38so3234801iol.0
        for <git@vger.kernel.org>; Wed, 17 Aug 2016 14:14:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4TfEFcKeX3ZuN8ndZp2xFrlmlFoXoVG9fRGsPRSmg5M=;
        b=K6ge2g4C3GY4QPDl+G04G617gmWf6TgtgI1c8V55TPyOUXbsfKoku7faU0ueNOmN+V
         BqhLPHfRqe3GZgk1boThQMeJ5cdNPtxOjwWqI6riqkLEkz+c7I8M09YA3unR5kQ85kdU
         rlD850W0zvzwxO3hr87G1hdHtTrzI0BIuEQHhMC7FEzg4Z9hDPDsqJRaMCLH1RqXgUWJ
         d8KrFrYqUm20ST63LQMlt+vOqvPeWO5QvsVW1mx4vfP++R5jMpHtyOCV4G4qa8eI8ite
         i8hmBoA06fcsaUoL+0N+GItuR1lKau48RsouwDwum7NHRASGBlf5q4KiDggz+XOehZc7
         PZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4TfEFcKeX3ZuN8ndZp2xFrlmlFoXoVG9fRGsPRSmg5M=;
        b=Kw52rC0Mg3IQZWJN5vmGC5VlQFRuTYEfRj6v4Xc6Jg0ft4tRNWEW9Bo6X5uqeV8zMI
         bKuPuQlhX7KjwTPT6f733QLrH3JbWM0mZYwW3OCCqs6NrCWPCsc8XlHuxWrl8sqKAUWF
         hqyXFm6fntBppSbWMwwXBkMJ/zqoZ1gFCHn1Rn/7g4LXxblEp3xdvRMNLSaJ+RchFFEv
         bwhys/xuwBwo+3Bltyw+LH4+gL9G+oErOS9ox/JdxDsAfY6vnDAY+8/HGMvxUdG2Zwhj
         z0WLuc8B21Z/KtJQPy9ThWUCQxlb61P1id/mnVlbYyL9HZo7lHO6SDZ+f8BKoj6st457
         9xLA==
X-Gm-Message-State: AEkoouuJ3X4sRPImfyCE3n29YcE33dM7QpArvF760NeTPYTLERptrnCxj78ItjLcrW1l9NL1HPP2ZI+Yus5PsGJX
X-Received: by 10.107.178.129 with SMTP id b123mr50193933iof.83.1471468452071;
 Wed, 17 Aug 2016 14:14:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Wed, 17 Aug 2016 14:14:11 -0700 (PDT)
In-Reply-To: <xmqqmvkb85sw.fsf@gitster.mtv.corp.google.com>
References: <20160817204848.8983-1-sbeller@google.com> <xmqqmvkb85sw.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Wed, 17 Aug 2016 14:14:11 -0700
Message-ID: <CAGZ79kbb=oL7b93W-x=dxVh2aBN-H+tg9y5o4RwbepYtijQTXg@mail.gmail.com>
Subject: Re: [PATCH] push: change submodule default to check
To:	Junio C Hamano <gitster@pobox.com>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Fredrik Gustafsson <iveqy@iveqy.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 2:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> If working with submodules, there are more reports of missing submodules
>> rather than the desire to push the superproject without the submodules
>> to be pushed out.
>
> I do not know how you are counting the "more reports" part of that
> assertion, but it is very likely that it is biased by the current
> default.  If you flip the default, you would see more reports that
> say "I know I wasn't ready to push the submodule part out; don't bug
> me".
>
> IOW, those who want to have something different always sound louder,
> because people who are satisified tend to stay silent.

Yeah I thought about this mistake and how to get real numbers, but
I was just misled by some people on #git IRC waving hands. ;)

>
>> Flipping the default to check for submodules is safer
>> than the current default of ignoring submodules while pushing.
>
> That part of the assertion, on the other hand, is justifiable.

ok.

>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  Probably too late for the 2.10 release as I'd propose to keep it in master for
>>  quite a while before actually doing a release with this.
>
> I think you meant 'next' not 'master'.  We have a few "let's keep it
> in 'next' to see if people scream" topics there already--the more
> the merrier? ;-)

Well we put it into next, but that are not as many people as those
running master I would think, so I would want to maximize both times
in next as well as in master, e.g. if you put it into next today (unreasonable,
but let's assume), then it could make it into master next week, and then be
released as part of 2.10 IIUC the release schedule.

I would say that is too fast. rather I'd see this patch transition from next to
master just after a release, such that it lives in master for a full
release cycle
before being actually in a release.

So far for my line of thinking.

Thanks,
Stefan
