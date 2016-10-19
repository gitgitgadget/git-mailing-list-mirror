Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31BA20986
	for <e@80x24.org>; Wed, 19 Oct 2016 23:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752206AbcJSXg6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Oct 2016 19:36:58 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33420 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbcJSXg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2016 19:36:57 -0400
Received: by mail-yw0-f169.google.com with SMTP id t192so33367979ywf.0
        for <git@vger.kernel.org>; Wed, 19 Oct 2016 16:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UTZKVq9s0dC6O41YXNwddJylbB8k78+TpwGYBzHSnc4=;
        b=vjVXP6mkQdJmHfzOPsuisSzOArzdGW3IF7xCd/x2RJzRSxkGozeddQHJUen4KzR2Y5
         PfgL1cKtxvz3DxgObfAEaMGoaxxL7FgCD5NJskGZ+B1BNJdxpX/3OhWU9vvpwchAYdVO
         QBiJZdAHd1a6SyY82H7AarLPe455vLHyeIUX1xS+ECkduHveF3H8RjoEqJuTLUOqN+9s
         Irpv1u0YOakuXh54AhEQ0bWNasJl1IuzK7W70tgOFH/QpCbF84Ef0raOnUwAnjEooeaQ
         UJ+VtQmogY0fHd5AyQVny4s0hPQSX5gY92ioA2dV5+S1IdZH9QdELrx/IoDa9NMRuCHk
         harg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UTZKVq9s0dC6O41YXNwddJylbB8k78+TpwGYBzHSnc4=;
        b=IQy9oS+zH1CI2JrYVGOrLL8MY+0uFvd5/VW07pGO297c2qxMJol0R1NVCODFmHNcPd
         Kxc4i+k4WlzTEs8MYia6dl+jlidh48GXnUDV5KnUNhhrL3qQMTY92wQwfr5yfveIfBrD
         pNerpk/fzKxqLLq2CiohTd/H2RQoCtzDhMcqQqpn96l8nMk2F5QxMsTlI99dxAnwXblv
         GBlWBWYrqrK74wLWfHmhDUHz4lKxv2O4goDp4wVdcbTCo+xrRlq6OukrC7CgciNCvA9M
         s0gGe8LpHvRJAzHIgn3XccaxN32zFXWSgwF0ROU2pNI3pBkzacyu2KkqcDpQwThsCXEV
         OUhQ==
X-Gm-Message-State: AA6/9Rm5N9BGBLdMVIX67fgcpyP834VfLwp0ZcFpQLjlq35p5IpUp+b9uNQ8f9H3EqZnMsnQS4hpOkwozgRr5A==
X-Received: by 10.129.74.2 with SMTP id x2mr9233556ywa.59.1476920216507; Wed,
 19 Oct 2016 16:36:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.10.2 with HTTP; Wed, 19 Oct 2016 16:36:36 -0700 (PDT)
In-Reply-To: <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
References: <CA+P7+xqFOn4NSfZ2zpa_y1za3uHZrGGG3ktEtuOcvJLCrAYUhQ@mail.gmail.com>
 <20161019224211.k4anavgqrhmunz6p@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 19 Oct 2016 16:36:36 -0700
Message-ID: <CA+P7+xprKV1Y7VShLR9uNgcpVdZk39xoTfkwiin1bVQYTe_TAA@mail.gmail.com>
Subject: Re: tools for easily "uncommitting" parts of a patch I just commited?
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2016 at 3:42 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 19, 2016 at 03:26:18PM -0700, Jacob Keller wrote:
>
>> I recently (and in the past) had an issue where I was using git add
>> --interactive and accidentally did something like the following:
>>
>> # hack lots of randmo changes, then begin trying to commit then separately
>> git add -i
>> # set only the changes I want
>> # accidentally add <file> to the commit
>> $git commit -s <file>
>> # type up a long commit message
>> # notice that I committed everything
>>
>> At this point I'd like to be able to do something like:
>> $git unstage -i
>> # select each hunk to unstage
>
> I'd usually do one of:
>
>   # undo selectively
>   git reset -p HEAD^
>   git commit --amend

AHA! I knew about git reset -p but I didn't know about git reset -p
allowed passing a treeish. Does this reset modify my local files at
all? I think it doesn't, right?

>
> or:
>
>   # roll back the whole commit
>   git reset HEAD
>   # do it right this time
>   git add -p
>   # and steal the commit message from the previous attempt
>   git commit -c HEAD@{1}
>
> -Peff

Also nice to know about git commit -c

Thanks a lot! This should save me some headaches.

I still think it's worth while to add a check for git-commit which
does something like check when we say "git commit <files>" and if the
index already has those files marked as being changed, compare them
with the current contents of the file as in the checkout and quick
saying "please don't do that" so as to avoid the problem in the first
place.

A naive approach would just be "if index already has staged
differences dont allow path selection" but that doesn't let me do
something like "git add -p <files>" "git commit <other files>"

We could even make it work so that "commit --only" doesn't run this so
that way people can easily override, and we can give suggestions for
how to fix it in the output of the message. I can't really think if a
reasonable objection to such a change. I'll try to code something up
in the next few days when I can find some spare time.

Regards,
Jake
