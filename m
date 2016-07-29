Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340A31F858
	for <e@80x24.org>; Fri, 29 Jul 2016 01:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbcG2B0r (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 21:26:47 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37574 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716AbcG2B0p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 21:26:45 -0400
Received: by mail-it0-f45.google.com with SMTP id f6so95190961ith.0
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 18:26:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0bP1zrz5rNPU2Sa6+OcteLUDLc/Ki23ERD4bjbrqaaE=;
        b=YLDSxIGR7jzIi0nQPId8kkQSuiPeNHU3YSIiOeKzaAi32dyUW1mF+j4ggLKiqjuhfo
         znSvM+C1Pc6sqq/f2m5687ZlHWR+knD8j0Xd+jWgI5DOy2ijbsY2ndeamWl2fvz5ODyC
         suyhEz+zvxZdIdZqE+U9adz5RN4nvRC7KwAsAaKGjW/HSvcGUjHl9+NyGBN5jFWHPeVj
         Uh4wVz4rB9hkt4lcynF4/PEAa1qRySeEEJMHXsD3Z3vcMm1CYpN1vStVFbmfr9lh+DD2
         85pgo0t+rhEFX1WgDPba78ZHH66TnVWV8S2S9enIxuHMGzVAcaJ71lVpEMhkzWH4lilz
         uc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0bP1zrz5rNPU2Sa6+OcteLUDLc/Ki23ERD4bjbrqaaE=;
        b=kGtimhroYQyiolRvkOjuNhLJUmTwDkfWja24zgm1WUvK5RzZGq+bIHzdN/uScNmKWm
         DQJhwdXk/urEEScrxew936hHBaWpGY8wykclPoVi+8QTGHWpfmFvpXn3bssvoFg9pM9l
         G77DT5Bf+Ub7nFnDLuIJThMl7W8i6lQjGs2C/Fg5LNBOQ0U2i1u16kQ5K7bD527UV2h8
         763fVOweDjSC2g0UuGsMFc2/A6MdE/zF55BgG+PVhBEZ0u5uh9noDnpS9AjecTSyiv0B
         MPNXfCvAsp5Wm5U3ggo+S6cxCSxYTbshv2JthCxSBBCyOEPOthy1HmJYJEQk8qJ7SviV
         4DFA==
X-Gm-Message-State: AEkoouts6HQoqUtKPndSEfI6UVNQbiPh6p/aRpzk7hTkaIM7LSl6YGbc8trraKt7/XiLSu0WnTbeC3/BoHTao8l/
X-Received: by 10.36.6.148 with SMTP id 142mr9986itv.0.1469755604461; Thu, 28
 Jul 2016 18:26:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 28 Jul 2016 18:26:43 -0700 (PDT)
In-Reply-To: <xmqqshutspfc.fsf@gitster.mtv.corp.google.com>
References: <20160727083406.10241-1-judge.packham@gmail.com>
 <xmqqshuvvvxb.fsf@gitster.mtv.corp.google.com> <xmqqoa5jvven.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka0kvr9RAkGHbgrZ7fery8436dH8Nu4bwG0t3K5FprgKA@mail.gmail.com> <xmqqshutspfc.fsf@gitster.mtv.corp.google.com>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 28 Jul 2016 18:26:43 -0700
Message-ID: <CAGZ79kbCTQx_FAeGkJRRyDotAsdJT6J+4Ab9BHW-YFw6rOqaqQ@mail.gmail.com>
Subject: Re: [PATCHv1] completion: add option '--recurse-submodules' to 'git clone'
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Chris Packham <judge.packham@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 28, 2016 at 9:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Anyway, I'll apply the "addition to the completion" patch.
>>>
>>> Thanks.
>>
>> Thanks for this patch!
>>
>> Note: if we ever decide to resurrect sb/submodule-default-path,
>> we run into a merge conflict. The reasoning for using
>> "--recurse-submodules" instead of a plain "--recurse" makes sense
>> as well, so that merge conflict will be resolved in favor of this patch.
>
> Thanks for an advance warning.  My rerere database has already been
> taught about this conflict ;-)
>
> As to sb/submodule-default-path topic, which has been blocked on
> still-in-flux attribute work, I am tempted to declare that the
> attribute work is not yet thread-ready but it is in a good enough
> shape to base other works on, and have them advance to 'next'.

I am tempted to ask for delaying sb/submodule-default-path
a bit more and see if there is an alternative solution.

Inspired by Duys series on submodules and worktree I found a new
way how to do the submodule management (separation of the submodule
URL as a flag indicating the existence and the actual URL), and that
will be very similar to what is implemented in sb/submodule-default-path
just even more streamlined. (That said the state of that new series
is still vapor and not yet solid, so ... it's hopes and dreams.)

>
> The traditional pattern of allowing the callers to randomly allocate
> an array of "struct git_attr_check" and passing the pointer to its
> first element to git_check_attr() function was impossible to extend
> without having to update the callers, but we have migrated away from
> the pattern and the attribute subsystem can be enhanced without
> impacting the callers too much.
>
