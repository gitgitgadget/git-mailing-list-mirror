Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8C2F1F428
	for <e@80x24.org>; Fri,  5 Jan 2018 20:36:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeAEUgB (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 15:36:01 -0500
Received: from mail-yw0-f171.google.com ([209.85.161.171]:42040 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751699AbeAEUgA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 15:36:00 -0500
Received: by mail-yw0-f171.google.com with SMTP id z132so2205271ywd.9
        for <git@vger.kernel.org>; Fri, 05 Jan 2018 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VB0lFJXARi/4LzJYifEf6YZnSeDWpvJoDWTQRk8Pyhw=;
        b=itmo70x60zuNBkzof1HT9UNaMYiCgTR41yhO5GKhJMhfmlZWC/Cg7FrGlh0/KaIukd
         irZmCnACWELdji/n5O9hqUTz3wZv2Js4v6HSIYcZXEtEeiIvVL43lBQtLv2CHn/ssgJh
         iunImnOD0h2SOpUmQjZrvjEgTHZOejfv/fdUeXaisK0hdRNsDdbYXlS5mTDDslM9GifK
         1YwtbQRZ7lfJzw7Cl5PcmRCp157TlYFFrBcqEmcwCXdsJk0L94pyU+FY+9H9fwubxrsZ
         ZhSqJVGFiPzETMT1OT90vfLe3m3vvjK1G7dQkVMrDdP5aZITmvyURTwEe2wZ8x00iUCt
         5DwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VB0lFJXARi/4LzJYifEf6YZnSeDWpvJoDWTQRk8Pyhw=;
        b=q1/CIo23b48Rja7PQuMRUAw2MAwi9fuEpvI2xdf5dOQ8BjDySt1sKqA222GGSII2fb
         6gNo/pSP4KirXxBqace/Y44n2PL5aMFj3mFyQbsVnVZ+DwWcRfrdil37igkE03qR46Ju
         SnahrbPLGBBqKXTq6Ybn5sX21oA2cbMI2w9N75oKTHccN1YfTtPXpgg6TzKJGN0QDvqF
         23WdXc+FiuorltfUVXQ1gNukpCmLEp177ZFmof7am9BO6FNnfwG1Y1ol+Fm2vpuAqet9
         1OVPGEA3El+EXbQtXX2Y03IuTOh0Xtw1k8t7SIzDvRm9f8U6lkffUTjCZfvUtEd02rUd
         7q8Q==
X-Gm-Message-State: AKGB3mJut+3/ZjH/ji/lSO7y4wcbKgOwjAjP0sXqRVNdxBUk7sDpK0KK
        3nJRwQybCnEj6b4t2popCk2P905IgCZPtd2QBJsxQA==
X-Google-Smtp-Source: ACJfBosPFXl+z89US1UObA/RIu3KI+z0ZITeIXeiExSKEMhwjxUYwzzfCd00fLWsdjyy8u2nNSbWhJsPVeXYdzNxUTI=
X-Received: by 10.129.93.65 with SMTP id r62mr3849501ywb.49.1515184559959;
 Fri, 05 Jan 2018 12:35:59 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.129.103.65 with HTTP; Fri, 5 Jan 2018 12:35:59 -0800 (PST)
In-Reply-To: <1515183976.21764.114.camel@mad-scientist.net>
References: <CAHd499C=3Y-ykgYZhSJzk=e-Pi6BUFeN8C89krd5T7T5fRB91g@mail.gmail.com>
 <CAGyf7-FHyO9pkEFFguea+B+VMTodF=mg8wJNedvjYdL7e7ORqQ@mail.gmail.com> <1515183976.21764.114.camel@mad-scientist.net>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 5 Jan 2018 14:35:59 -0600
X-Google-Sender-Auth: C0pXWnsxP2BtUQU25S-1GAaOO7g
Message-ID: <CAHd499A_ANzFA8HSQLJWakzzWanbmVGnur=um=kquYHu0aCBcQ@mail.gmail.com>
Subject: Re: Can't squash merge with merge.ff set to false
To:     paul@mad-scientist.net
Cc:     Bryan Turner <bturner@atlassian.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 5, 2018 at 2:26 PM, Paul Smith <paul@mad-scientist.net> wrote:
> On Fri, 2018-01-05 at 12:12 -0800, Bryan Turner wrote:
>> On Fri, Jan 5, 2018 at 11:59 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> > Not sure if this is intended or a bug, but with the following
>> > configuration:
>> >
>> > $ git config --global merge.ff false
>> >
>> > I am not able to merge my topic branch into master with squash
>> > option:
>> >
>> > $ git checkout master
>> > $ git merge --squash topic
>> > fatal: You cannot combine --squash with --no-ff.
>> >
>> > I'm not sure why a non-fast-forward merge would prevent a squash
>> > merge, since by its very nature a squashed merge is not a fast
>> > forward merge (or maybe it is if you only have one commit).
>
> Hah!  I was just thinking of checking the latest Git RC I built
> yesterday to see if this pet peeve of mine has been fixed yet.  I guess
> not!
>
>> The easiest way to move forward is probably to pass "--ff" on the
>> command line to override the config, when you're using "--squash".
>
> That's what we always have to do.  Very annoying; we use squash-merge
> extensively but also want to require ff merge by default.
>
>> As for why the two aren't allowed together, my assumption would be
>> because if you're only squashing a single commit "--squash" and that
>> commit is fast-forward from the target, a new commit is not created
>> and instead the target branch is fast-forwarded. With "--no-ff", it's
>> questionable what "--squash" should do in that case. Fast-forward
>> anyway? Rewrite the commit simply to get new committer details and
>> SHA-1?
>
> If it only failed when you were squash-merging a single commit that was
> also fast-forwardable, I guess that would be one thing.  But even if I
> have multiple commits and I want to squash-merge them, which clearly is
> a separate operation giving different results, I get this error.
>
> I don't think Git should try to be clever here (if that's what it's
> doing--I always assumed it was just a missing configuration case in the
> error check).  If I asked for a squash-merge then Git should give me a
> squash merge.
>
> So in answer to your question, --squash should give me a squash merge
> and the setting of --ff / --no-ff should be completely ignored, as it's
> irrelevant.
>
> My $0.02.

Seems like --ff works, but is also misleading since in my case (more
than one commit) I'm not doing a ff merge and there's no possibility
of it. I think your idea of the 2 being distinctly separate makes
sense. Basically, --squash takes precedence and if the mechanism to
implement squash in certain scenarios (such as single commit) is
fast-forward merge, then that decision is made for the user and is no
longer something they can control.
