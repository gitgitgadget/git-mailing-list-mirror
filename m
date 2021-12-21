Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60735C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 17:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236628AbhLURvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 12:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbhLURvb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 12:51:31 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4FAC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:51:31 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 8so12451661pfo.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 09:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5spcxK6Nm0sC7S6OU+MGF2fzFwsEh2lmRtUlrQFryQk=;
        b=pPvwHBJJNk7v8jwXGP6r8krclsRGwrO5OjTj8ThvodY0069NvjrdsJ3dC+yGHcqNdB
         J0EZqe7R07Yl0c3FxldIJUhmecHvjccicJG3z7t/e/NEEEEohcl3XX4oAUZPdYz1P0xG
         XJxChPpROsnF7SvGoAqmesNAqhul5UZ/LLFmp+1de0t3hgHSYdiU6nKQSjKH/tPf3KVD
         7foE3NCMwHrR6GCihka617uYXvcFh/l0cnWfabCmBPqGrrcnJeaid7NP7VvY6PKAOHbM
         FrLihom7la0XQun/ts1N5nCzMud36Y/sVch5r9V1jFu+Bvc+H/ZNaNSfadKyusBEb7l0
         JB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5spcxK6Nm0sC7S6OU+MGF2fzFwsEh2lmRtUlrQFryQk=;
        b=GMePpA2RNaOKQZpehIgAyXEGp1A41Is3ITDTUNP2pRoTVPkE47XLzJ3G5H5O5pjA1Z
         7IE0ZmHVmpWwzC8t8o5PgiYOLPx3SD5XOLslvAQ3d+K6UkXzgXgh1RU7Zc2rrmHtJSWT
         SAhkImsC/YpVOvKTcrFkxdwMD8R/WMPTnLDYEuW4Q+VbsbASYpcONao16XhGwSqojgor
         ivatfc+HRQoRlHdfrERGJp7bIMwr37exHlGOkmGKxL7LRMyBOxE8eyp3IznXAG71RMJx
         3TFj7V3Vk14c8c5x60Se4CN4d+41UlBnHb0qbCpPYvk++2rFvxyG+i6MUM8osUfbxOk3
         IxEw==
X-Gm-Message-State: AOAM533XbXQ7eIzNUf0HJ8LrznTkj56bCCOgcoJTMWsPKGZ1NZrV20j6
        bWsqTzJky8N37CPLkmZ73RFlbtR0lu7dc9pO63/Y5TxriGw=
X-Google-Smtp-Source: ABdhPJyOvVl/CWcRcvp4V+bASRbzhNVleIrF2cFE2pYMt9KwmecVaOYywX712htaNie2SiMfYLdtKFG4QgPsIzfv1io=
X-Received: by 2002:a63:e657:: with SMTP id p23mr3857055pgj.337.1640109090629;
 Tue, 21 Dec 2021 09:51:30 -0800 (PST)
MIME-Version: 1.0
References: <CALRdAfcyfesNqfLhhe2GW_5V9s2hf++i6mZS1Lw5hqQYTca85w@mail.gmail.com>
 <xmqqlf0dq3t3.fsf@gitster.g>
In-Reply-To: <xmqqlf0dq3t3.fsf@gitster.g>
From:   Daniel Vicarel <shundra8820@gmail.com>
Date:   Tue, 21 Dec 2021 12:51:19 -0500
Message-ID: <CALRdAffjmvHao8TRfB9YJez1acwHDAq2ZqiqaCRRr5MaWzhxig@mail.gmail.com>
Subject: Re: Why does "merge --continue" expect no arguments?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you so much for the detailed response! Brief side note...this is
my first time posting on the git mailing list (or any mailing list of
this kind!), so please educate me if I'm incorrectly quoting, using
reply/CC, or formatting lines (not sure if the mail server
automatically wraps lines after 72 chars)...

Junio C Hamano <gitster@pobox.com> writes:
> Compared to a merge that cleanly auto-resolved, in a conflicted
> merge, you have one more thing worth explaining to future readers of
> "git log"---how and why the work on the side branch conflicted with
> the work on the mainline, and how you chose to resolve it.

Fair point. I would argue that in my own personal projects, where I am
the only contributor, sometimes I just want to accept the default
merge message and move on.  However, one could apply that reasoning to
_every_ commit message in a personal project, and I certainly don't
believe in that... so yeah, you've given me something to think about.

Junio C Hamano <gitster@pobox.com> writes:
> The way to finish a conflicted merge has always been to run "git
> commit" before "merge --continue" was added, and it still is not
> just accepted but is the right way to finish a conflicted merge.

That makes sense. TBH, I assumed that `merge --continue` _was_ the
preferred way to finish merging after conflicts simply b/c the option
exists! `commit --no-edit` definitely meets my immediate needs though,
so thank you for that suggestion.

Junio C Hamano <gitster@pobox.com> writes:
> [...] possible next steps, i.e.
>
> * deprecate and eventually remove "merge --continue"
> * deprecate and eventually rename "merge --continue" to "merge --finish"
> * add "--no-edit" to "merge --continue"
> [...]
> * document more clearly that "merge --continue" is a mere synonym
>  for, and hint that there is no reason to favor it over, "git
>  commit".

I agree that some clearer documentation around `merge --continue` is
worthwhile, to prevent other developers from thinking like myself.
Maybe a warning from the CLI after running `merge --continue`,
recommending `commit` usage instead? Such a warning suggests that the
option _should_ still be deprecated and removed in the future though.

I am still interested in making a contribution to git, so let me know
which option you would like me to move forward with at this time:
adding the CLI warning, or going straight to a deprecation. Unless of
course you're already on it. :)


On Tue, Dec 21, 2021 at 12:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Daniel Vicarel <shundra8820@gmail.com> writes:
>
> > There are several git commands that take a "--continue"
> > option...`merge`, `rebase`, `cherry-pick`, etc. From looking through
> > the source though, only `merge --continue` seems to expect no other
> > arguments. Suppose that you have just resolved some merge conflicts,
> > and then want to run `git merge --continue --no-edit` to accept the
> > default merge commit message. Having to open/close the configured text
> > editor still is mildly annoying. I'm interested in submitting a patch
> > to "fix" this `merge` behavior, but I wanted to check if this was
> > really the intended behavior first, and if so why.
>
> The answer lies somewhere between "it is very much deliberate" and
> "'merge --continue' is so unimportant that nobody bothered".
>
> Originally, our "merge" did not open an editor to give you a chance
> to explain why you are merging a side branch when recording a
> cleanly auto-resolved result.  In fact, it didn't even have an
> "--edit" option to optionally allow you to edit.  This changed at
> f8246281 (merge: use editor by default in interactive sessions,
> 2012-01-10); its log message is worth a read to understand the
> issues.
>
> Compared to a merge that cleanly auto-resolved, in a conflicted
> merge, you have one more thing worth explaining to future readers of
> "git log"---how and why the work on the side branch conflicted with
> the work on the mainline, and how you chose to resolve it.
>
> So, in that sense, we would very much want to do whatever possible
> to encourage you to write a good log message.  Opening an editor is
> one step in that direction.
>
> Among the commands with "--continue", "merge --continue" came much
> later, and it did not even need to exist.  The other commands with
> "--continue", e.g. "rebase", deal with multi-step operations, and it
> is worth to have a way to say "I am finished with this step, let's
> CONTINUE WITH THE REST".  But in "merge", there is no remaining
> thing to do after you are done with the conflict you saw.
>
> In hindsight, we probably should have resisted the urge to add
> "merge --continue", just for the sake of misguided "consistency"
> perceived on non-existent similarity with other commands that truly
> need "--continue".  What is called "merge --continue" should have
> been called "merge --finish", if we needed to add something back
> then.
>
> The way to finish a conflicted merge has always been to run "git
> commit" before "merge --continue" was added, and it still is not
> just accepted but is the right way to finish a conflicted merge.
>
> So, in that sense, "merge --continue" is so unimportant that it is
> understandable that nobody bothered.
>
> So I guess that makes two discouraging factors against adding
> "--no-edit" to "merge --continue".  It encourages a wrong behaviour
> of under-explaining the result of your work, and "commit" is a much
> shorter way to say "merge --continue" anyway.
>
> In fact, "merge --continue --no-edit" is much longer to type than
> "commit --no-edit".
>
> merge --continue
> commit --no-edit
>
> Having said all that, among various things that the above discussion
> suggests as possible next steps, i.e.
>
>  * deprecate and eventually remove "merge --continue"
>  * deprecate and eventually rename "merge --continue" to "merge --finish"
>  * add "--no-edit" to "merge --continue"
>
> I think the last one might be the change with least impact and
> resistance.  Those who are unaware that "commit --no-edit" suffices
> would end up typing a lot more and wasting their keyswitches' life,
> but the damage is limited ;-)
>
> Or we could throw in another
>
>  * document more clearly that "merge --continue" is a mere synonym
>    for, and hint that there is no reason to favor it over, "git
>    commit".
>
> which happens to be my favourite so far after thinking the above
> through.
>
> Thanks.



-- 

Dan Vicarel
