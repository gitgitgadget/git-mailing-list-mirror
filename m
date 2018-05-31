Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22E31F51C
	for <e@80x24.org>; Thu, 31 May 2018 07:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeEaHmH (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 03:42:07 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32822 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753934AbeEaHmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 03:42:06 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so4699685wro.0
        for <git@vger.kernel.org>; Thu, 31 May 2018 00:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WKZYHNutWmQjGEFPyaS/O0nqsjAtEMKi/nW5VnlQuwo=;
        b=i/nx9S/n8SxKHal4yo5XfhmKVlixQElaAtFnFito4wHoXfrd+JrPQIMMf1rzYlj9Fy
         6R0NI4M6oAxAgtEF+QS97L5hf+QQo8YTR/rWJOCSFcjyZoyV9nmjKLrHHQgBoF1CuRB0
         sNtvsCe4EVDRYmkmm3f7rc/1l6eWB1bPSzX8SddDSHUEZ5oBkJWCu+se7FHuTRQ+1y5m
         /MQ+MkGItgqanGrUwFxDd1KE1CQu5nIFdSSdm5L9VqoDI/150CieU3uags9fYPFSI63M
         orW3JQi6J4VWI7+ii1/c0tsU0bgiIPGyf9BtmbePID0N32Uo6Ea/+F8lL35uPHxiH2Pv
         wj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WKZYHNutWmQjGEFPyaS/O0nqsjAtEMKi/nW5VnlQuwo=;
        b=mbnSptw7xMAqr6wQOYy6//cjIiNzhZB+LsA6d65UH3ruWRThoHk78KeWvB7glhv/6H
         L642sloAta2faKOpDexHf4RrVFB3JVDWTMOC2Wk3dLvXOEstlCupC9WLcRMcpgwoTVBK
         cbs6CY/GK7C7nvrluVwCOCwwtR9jJWwMy9oyzMGRxgTbQStwZVKptn52C/kvX79bQVc3
         zso1dyoLeF1RaE1fMH42TvngKnBLMhVU/UCf88LElEmMNvDVdf03j38O7pDdYORO1VD7
         MczccpOjQX1YuqHVak14RG4QiT3dB9IIjgEBsYKPU9BkI3Pf4yAP3IfetRQNM/M9KLkc
         YnPw==
X-Gm-Message-State: ALKqPwdBLwtxho1kdx9jGMjLalCT6lEAvHk/M4Le0NAC22K2xFI4kKIp
        wEk5j5UvzCMYifRMCzH4Nm4=
X-Google-Smtp-Source: ADUXVKK+eYU5Ymyq5BDuRh3OFrqWuj7A8aLeYkplDt1QHXyV/z7SZHGfvI/5nHWqjqQdZs40s2P9Hw==
X-Received: by 2002:adf:8854:: with SMTP id e20-v6mr4863737wre.30.1527752525479;
        Thu, 31 May 2018 00:42:05 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id 72-v6sm35916683wrb.22.2018.05.31.00.42.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 00:42:04 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Is origin/HEAD only being created on clone a bug? #leftoverbits
References: <87bmcyfh67.fsf@evledraar.gmail.com> <xmqqo9gyey13.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqo9gyey13.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 31 May 2018 09:42:03 +0200
Message-ID: <87bmcw9sqc.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 30 2018, Junio C Hamano wrote:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> If you make an initial commit and push to a remote repo "origin", you
>> don't get a remote origin/HEAD reference, and a "fetch" won't create it
>> either.
>> ...
>> Some code spelunking reveals remote_head_points_at, guess_remote_head()
>> etc. in builtin/clone.c. I.e. this is special-cased as part of the
>> "clone".
>
> Correct.  Originally, there was *no* way in the protocol to carry
> the information, so the code always had to guess.  The point of
> setting origin/HEAD was mostly so that you can say "log origin.."
> and rely on it getting dwimmed down to "refs/remotes/%s/HEAD..",
> and it wasn't a common practice to interact with multiple remotes
> with remote tracking branches (integrator interacting with dozens
> of remotes, responding to pull requests using explicit URL but
> without configured remotes was not uncommon), so it was sufficient
> for "git clone" to create it, and "git remote add" did not exist
> back then anyway.
>
> There are two aspects in my answer to your question.
>
>  - If we create additional remote (that is, other than the one we
>    get when we create a repository via "clone", so if your "origin"
>    is from "git init there && cd there && git remote add origin", it
>    does count in this category), should we get a remote-tracking
>    symref $name/HEAD so that we can say "log $name.."?
>
>    We absolutely should.  We (eh, rather, those who added "remote
>    add"; this was not my itch and I am using "royal we" in this
>    sentence) just did not bother to and I think it is a bug that you
>    cannot say "log $name.."  Of course, it is just a "git symbolic-ref"
>    away to make it possible locally, so it is understandable if
>    "remote add" did not bother to.
>
>  - When we fetch from a remote that has refs/remotes/$name/HEAD, and
>    if the protocol notices that their HEAD today is pointing to a
>    branch different from what our side has, should we repoint ours
>    to match?
>
>    I am leaning against doing this, but mostly out of superstition.
>    Namely, I feel uneasy about the fact that the meaning of "log
>    ..origin" changes across a fetch in this sequence:
>
>      log ..origin && fetch origin && log ..origin
>
>    Without repointing origin/HEAD, two occurrences of "log ..origin"
>    both means "how much ahead the primary branch we have been
>    interested in from this remote is, relative to our effort?".
>    Even though we fully expect that two "log ..origin" would report
>    different results (after all, that is the whole point of doing
>    another one after "fetch" in such a sequence like this example),
>    our question is about the same "primary branch we have been
>    interested in".  But once fetch starts messing with where
>    origin/HEAD points at, that would no longer be the case, which is
>    why I am against doing something magical like that.

We already have to deal with this special case of origin/HEAD being
re-pointed in a repository that we "clone", so we would just do whatever
happens to a repository that's cloned.

I.e. the "clone" sets the origin/HEAD up as a one-off, and then keeps
updating it on the basis of updating existing refs. We'd similarly set
it up as a one-off if we ever "fetch" and notice that the ref doesn't
exist yet, and then we'd update it in the same way we update it now.

So this seems like a non-issue to me as far as me coming up with some
patch to one-off write the origin/HEAD on the first "fetch", or am I
missing something?
