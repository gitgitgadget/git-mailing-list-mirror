Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A44DC1F661
	for <e@80x24.org>; Wed, 12 Jul 2017 21:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbdGLVIi (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 17:08:38 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33796 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbdGLVIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 17:08:37 -0400
Received: by mail-pg0-f43.google.com with SMTP id t186so18819815pgb.1
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 14:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W+JPw8l9cIya5/7kuJ2hG1oKBa0evyND4pOTtDmshlM=;
        b=mWCk1EnpOSbF3rKHjr5z9d/Fj2KtjBlinJkyQgjUPlabosTMLIpr7yntiCdFkQdI/l
         UjE3ckuzXMbMxs2ih2hHnFpjqGgEKXG0MlXPlUwx3B/z+IxpFoJ6Qrla9Fg6jmR4a4QP
         /QKCR65Psf7yrbDm083r/lKelDxQcEzQyH7j7vWfYlz5bKotCcrLY3+xyIBlwfdIgJxd
         Y9QE4okwbNcJHKNWoL6UODSjTGzJVaJOzzFMHIzlRJ/zO0esPJk+vDCnl92l06dljW44
         E3XdmgttmMOpFUpKw8uC2+RMNafngCb4HklAto92ypTOnyUo1auBtV+7SsF235T99Ag/
         dG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W+JPw8l9cIya5/7kuJ2hG1oKBa0evyND4pOTtDmshlM=;
        b=E0ybTzBpAzWQXZiYQpGsT+/31IuOmsQkkUpWjvEiBKGIN6Le1hWhEjA5kt823v4kaP
         h7TyYH8IN7tV3WcAiMqlN4VqUChtF/ZiRD1CUBOmqu7nJWAoKvuI2UE280SuOWPndfnU
         zQazaYeDerp04Fr/uCKcx1JBUQ7WFkrUHaLN8bcBujOJKjkG9MFG14PNU4b5FMUkXFtv
         caM5+SKazUSzv9Mafp5U3WG0L1tsBNZnROX2AbV7yEe/T1SKAhj4BAtFvYDaqrWwRNJJ
         wqGYL6aDc4X31LxdoW/gXbN8d5p/bj+OsNMcmOyDV5e8zzqR44aN16YKbTZv1oznD79R
         mrfA==
X-Gm-Message-State: AIVw113giCkGRuoGXJUgXzeGh94X3bZgeAlF2Gc3mlP2kj27Ihkz65Hr
        lpP+yrx/3DjtIhxP8n58SCV082pp7Omo
X-Received: by 10.98.81.1 with SMTP id f1mr23419179pfb.94.1499893716376; Wed,
 12 Jul 2017 14:08:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 12 Jul 2017 14:08:35 -0700 (PDT)
In-Reply-To: <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
References: <20170711233827.23486-1-sbeller@google.com> <xmqqinix1j29.fsf@gitster.mtv.corp.google.com>
 <20170712205734.h77fgbbkavwpkr4h@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Jul 2017 14:08:35 -0700
Message-ID: <CAGZ79kYYg6-UMrKRPeJTbHdGR0juZ2OwFZmkuYgeYe5X+cm_sQ@mail.gmail.com>
Subject: Re: [PATCH] RFC: Introduce '.gitorderfile'
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 1:57 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 12, 2017 at 01:44:46PM -0700, Junio C Hamano wrote:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>> >   I want to force myself to think about the design before pointing out
>> >   memory leaks and coding style, so the least I would wish for is:
>> >     *.h
>> >     *.c
>> >   but as we have more to look at, I would want to have the most abstract
>> >   thing to come first. And most abstract from the actual code is the
>> >   user interaction, the documentation.
>>
>> This is exactly why I invented the orderfile in the first place.
>> But such a "policy" is not something a project would want to enforce
>> its users all the time; it is left to personal preference of the
>> participants.
>>
>> Just set diff.orderFile to suit your taste without bothering other
>> people, I would say.
>
> I could see somebody arguing that format-patch should respect a project
> preference, since its primary purpose is to communicate your work to the
> rest of the project.
>
> But then you could make a similar argument for other diff options, too.

This similar argument would be to have a in-tree configuration for
--unified=<N> for example?

This triggers two reactions for me:

(a) We should totally do that.
  Different projects have different coding styles (e.g. opening brace
  in its own new line or at the end of the condition), which very much impacts
  how useful the context is. So, sure, the project knows best what their
  preference is.

(b) It's a rabbit hole to go down.
  Any config option that format-patch respects can be argued to be useful
  to be preset by a project. So in the end we'd have a ".gitconfig"
file offering
  good defaults for people using that project. This may have security
implications.
  And it's a lot of work.

I see your point for (b), I'll think about it more.

Thanks,
Stefan
