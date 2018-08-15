Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCEC21F404
	for <e@80x24.org>; Wed, 15 Aug 2018 05:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbeHOIkJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 04:40:09 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:42414 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbeHOIkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 04:40:09 -0400
Received: by mail-io0-f173.google.com with SMTP id n18-v6so128624ioa.9
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 22:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TZ3fJdOzhKoftJMlbewmXZw0imgehqpdiORtD0K0YtA=;
        b=l/4XhGuot0URwsDngXQZWRiBo1XFY3xvnrlg3WZXTQKkDUfDxfyA04ZcIund7hvu0X
         dYrIArTFVyXXy/goZTBLkcaj3FFXxqtyHRbgAOGh71+NOv5Y2pqNKk5NiEhPx6ChH+pp
         Bk/8FfGbQqCl7Mh2N2y/Ya8lrqKXjFp9g49zBdbj8U2kWhlPf8n87B+rOqpj7V4TEI+q
         cBZT0eZrPymNet5hkAoIQ34nJGvsKFMiv+n5AjQeVQBq0Dke2wxR01c0TBG/HMJnK6IU
         xLCBlGtJAbztjN9ektdT+tBz8YK8mofns/30RbY7JvOevTzvIczepd1jIfPiOIGFn8xs
         LnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TZ3fJdOzhKoftJMlbewmXZw0imgehqpdiORtD0K0YtA=;
        b=Q5TRlxGDTM9TzKYXbGQWM5xo3D0nXifvfqyYY84Kos0SV29nvjqvgjGkPFiFRGSBim
         bE2hKZO7HyUQr9QmRQONNaljNLeOSgJwExhXvfKjqyR1AloJx3Lcx/lXmtmg4ncda71i
         0t55992zppxvX43CRpRpYnx6CnQtWWHkeSg7FW7ZuhOmo1DSUqlqLksEo49mDskge65t
         IItQIwqaf1+0fPB+o/Y2SZk9eMOgJ28lHcMbUB11/BGq9+xMTddza7S/9JI/1m/H4Z6a
         wyngol7DMdg+PoznSJMg5v9cjUnNT9DdK6LRzRPpXt0OpfiXEnxdaYi+FEmhNAzGtqsD
         rhlQ==
X-Gm-Message-State: AOUpUlG6IIxiYVWzuvUshcWo2rBg6LiR2g0s2CzAYiGyAFj065V9SyI7
        fvN7/lQ4rCwR8f7rDAz1qlPuT32FRjvLMFZGT0sOFgt2
X-Google-Smtp-Source: AA+uWPwyBAPN5YjlhQ+9o0/JNDAyVjk8d4zzrBR8PDMKXPaVuKIMgrKNgZjU+0DCAxpnyfsovj/7aUYMRFkUJCX1J6I=
X-Received: by 2002:a6b:3042:: with SMTP id w63-v6mr20411121iow.223.1534312166183;
 Tue, 14 Aug 2018 22:49:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 22:49:25
 -0700 (PDT)
In-Reply-To: <20180814214723.GA667@sigill.intra.peff.net>
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
 <20180814210616.GA32367@sigill.intra.peff.net> <20180814214723.GA667@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 15 Aug 2018 07:49:25 +0200
Message-ID: <CAP8UFD3S5vgMSuXfj1z0F7f-9SLVEm6boCHwdNwn7ysvXSRMrA@mail.gmail.com>
Subject: Re: Syncing HEAD
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 11:47 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Aug 14, 2018 at 05:06:16PM -0400, Jeff King wrote:
>
>> On Tue, Aug 14, 2018 at 10:09:37PM +0200, Christian Couder wrote:
>>
>> > When cloning with --mirror, the clone gets its HEAD initialized with
>> > the value HEAD has in its origin remote. After that if HEAD changes in
>> > origin there is no simple way to sync HEAD at the same time as the
>> > refs are synced.
>> >
>> > It looks like the simplest way to sync HEAD is:
>> >
>> > 1) git remote show origin
>> > 2) parse "HEAD branch: XXX" from the output of the above command
>> > 3) git symbolic-ref HEAD refs/heads/XXX
>>
>> How about:
>>
>>   git remote set-head origin -a
>>
>> ?
>
> Reading your message again, I see you actually care less about the
> refs/remote placeholder and more about the actual HEAD in a bare repo.

Yeah, I am interesting in updating the actual HEAD in a bare repo.

> In which case "git remote" isn't going to help, though its underlying
> code has the algorithm you would want.

Ok, I will take a look at the algorithm.

>> One tricky thing is that the name "refs/remotes/<remote>/HEAD" is only
>> special by convention, and that convention is known on the writing side
>> only by git-clone and git-remote. So obviously:
>
> And so here the convention is simpler, because we're talking about the
> main HEAD. But we still have know if you want to do that, and not update
> some refs/remotes/ symref in a bare repo.

We could maybe look at the "remote.XXX.mirror" config option. If it is
set to "true", we could interpret that as meaning we are interested in
updating the main HEAD and not some refs/remotes/ symref.

> So all of this really implies to me that you want to be able to say
> "take this symref on the other side and update this one on the local
> side". I.e., some way to tell a refspec "don't update the value, update
> the symref destination". So imagine we made "~" the magic character for
> "just the symrefs" (I picked that because it's not allowed in a
> refname).
>
> Then you could do what you want with:
>
>   git config --add remote.origin.fetch ~HEAD:HEAD
>
> and these two would be the same:
>
>   git remote set-head origin -a
>   git fetch origin ~HEAD:refs/remotes/origin/HEAD
>
> And it would allow more exotic things, too, like:
>
>   # always update the remote notion of HEAD on every fetch
>   git config --add remote.origin.fetch ~HEAD:refs/remotes/origin/HEAD
>
>   # update a non-HEAD symref we track for our own purposes
>   git fetch origin ~refs/tags/LATEST:refs/tags/LATEST
>
>   # or the same thing but using the usual refspec "dst defaults to src"
>   # rule and dwim lookup magic
>   git fetch origin ~LATEST

And `git fetch origin ~HEAD` would sync the main HEAD?

Yeah, that looks like an interesting solution to the problem.

I wonder though if we should restrict the way `git fetch origin ~XXX`
searches the .git/ directory itself.

> In protocol v0 we don't get symref reports from the other side over the
> git protocol (except for HEAD), but we could use the same logic we use
> for determining HEAD for older versions of Git: find a ref that points
> to the same tip. Though I would say that unlike the existing code in
> guess_remote_head(), we'd probably want to treat an ambiguity as an
> error, and not just default to refs/heads/master.

I wonder what `git fetch origin ~refs/heads/*:refs/heads/*` should do.
Could it know which refs are symrefs using protocol v0? Should it
guess that refs with uppercase names are symrefs? Should we allow '*'
at all in those kinds of refspecs?

It looks like making "~" the magic character for "just the symrefs"
might be a good solution in the end, though we might want to restrict
it to protocol v2.
So perhaps something like `git fetch --update-head` that you suggest
in another email would be a good solution for now and for protocol v0.
