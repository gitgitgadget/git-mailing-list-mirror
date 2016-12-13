Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DEAC203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 19:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbcLMTIB (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:08:01 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:34760 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752112AbcLMTH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:07:58 -0500
Received: by mail-qt0-f182.google.com with SMTP id n6so116402294qtd.1
        for <git@vger.kernel.org>; Tue, 13 Dec 2016 11:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uyGTLoWD1sG2TUS2Q4RxY1+zNm7vD/FFp+xK42Y0RGc=;
        b=EISvrNlVLH+ZlbI6ofOSXp0g2X+bRByEtaYKzSbNFLz484zHi2fN+8mZlvGJJWrFM5
         WyEy8cqQKHtDmz0hkna1Id8eKvMi4NKD5TbWgChYbLE9fbLw5RHbwJERrWtbYUYXqtrH
         FQEGamF6revDSe9/YvbtTOhcwXvKk/zyX0nvoDwHakdLZ6AOP49vqc1nC1ONnRCt5On0
         Kug20CT0fjhXA8L8Z7pB67CvAamwr6V2rT+Bpbkk0kc0/i5tcWMWRHNw/7LJyaUjipch
         7lUOiM3TjWSKc3POk/U9LO2TQtVTVfcBhzPZq6x9045NKM/WCovyHTeQAmLuInorPNLu
         pJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uyGTLoWD1sG2TUS2Q4RxY1+zNm7vD/FFp+xK42Y0RGc=;
        b=kZmcw/12cOBfsDm8ljiKFdi5XNLzXr4AtPJhSYoCBaykZ2oIJDtobQ0xp2VYN++krJ
         PFpfEkl5zKn1sQvahwlmJL4ueCJ+BiRJ6SWrHuamW6dRDhGHWHTRKCtGHv3A0me0lQZM
         9kb1JbgfE96/9/HO8rwqCLvPzpvzeETlNFK9gbOX+gfXvQi+LJPSQz1qNa046HsAOIfw
         fXVmYKRBT1XyKt7FNpKCs3qjtPHZsbrO1ZbQkXSdzE0EXI9ECWl3xJAeE5uUpHIQzi8h
         8+iQDAKu5qpBZwXmEEr9mK2XEdjCKkoHlq+94iLu20Cg+3tDPxzO9uslGv3jPCsmlEIu
         6jdQ==
X-Gm-Message-State: AKaTC01jluIxjqQvNJ5oSVV/BER6WZP6YX1el91nGHbgNAfn8VXOuxmEU65VtKbTpshSgWFX01GbVDNVUfP2r9ZW
X-Received: by 10.200.49.235 with SMTP id i40mr95996296qte.170.1481656052578;
 Tue, 13 Dec 2016 11:07:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Tue, 13 Dec 2016 11:07:32 -0800 (PST)
In-Reply-To: <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com>
References: <20161213014055.14268-1-sbeller@google.com> <xmqqr35c5luq.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kbmtYzFmEKrxHKx-_WY=0NDJM=QZYJziim-eh-w4WzDKw@mail.gmail.com> <xmqq37hr4q5t.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Dec 2016 11:07:32 -0800
Message-ID: <CAGZ79kY_E8xnOpCAFQo_91FeQCs9X3fkassFYunG=adx81AcBg@mail.gmail.com>
Subject: Re: [PATCH 0/6] git-rm absorbs submodule git directory before deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        David Turner <David.Turner@twosigma.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 10:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Mon, Dec 12, 2016 at 11:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Stefan Beller <sbeller@google.com> writes:
>>>
>>>> The "checkout --recurse-submodules" series got too large to comfortably send
>>>> it out for review, so I had to break it up into smaller series'; this is the
>>>> first subseries, but it makes sense on its own.
>>>>
>>>> This series teaches git-rm to absorb the git directory of a submodule instead
>>>> of failing and complaining about the git directory preventing deletion.
>>>>
>>>> It applies on origin/sb/submodule-embed-gitdir.
>>>
>>> Thanks.  I probably should rename the topic again with s/embed/absorb/;
>>
>> I mostly renamed it in the hope to settle our dispute what embedding means. ;)
>
> I do not think there is no dispute about what embedding means.

double negative: You think we have a slight dispute here.

>  A
> submodule whose .git is inside its working tree has its repository
> embedded.
>
> What we had trouble settling on was what to call the operation to
> undo the embedding, unentangling its repository out of the working
> tree.  I'd still vote for unembed if you want a name to be nominated.

So I can redo the series with two commands "git submodule [un]embed".

For me "unembed" == "absorb", such that we could also go with
absorb into superproject <-> embed into worktree


>
>> Note that sb/t3600-cleanup is part of this series now,
>> (The first commit of that series is in patch 6/6 of this series, and patch 5 is
>> the modernization effort.)
>
> Well, "t3600: remove useless redirect" has been in 'next' already;
> do you mean that you want me to queue this series on top of that
> topic?
>

I need to reroll this series any way; the reroll will be on top of that.

Thanks,
Stefan
