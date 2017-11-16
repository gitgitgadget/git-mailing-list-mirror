Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3E8201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 00:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933301AbdKPAG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 19:06:28 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:57062 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbdKPAG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 19:06:26 -0500
Received: by mail-qt0-f169.google.com with SMTP id r39so22309603qtr.13
        for <git@vger.kernel.org>; Wed, 15 Nov 2017 16:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sE+KlHztGT7oObDkrB1PQT0z0r06uAMT3abghnUSw+s=;
        b=e4+2yW/9UxdKIecfXxkAw/NAHseN1D7u5wMTWypHwVcm9Ei0iKBZhe1mM4luMtBFe3
         Yjs04HlYzY4g7sEAklKi5dQNFyIKLRYF1fsp0uXo4qq06Y7dT53jyupDRAlAS4pWGjBP
         LR+ehFrYype7+wa4Aq/+w1n06w0Dn4cxb/vmiC+wNWKppx5rKb7O0UwrYoE0QbdzFerx
         RG92du5DacFza06pogUjtuAAf8ZBOHTvU5RVA9o/VRgP9cA7U1x7zdAt156yjLqz0+wl
         8qxHQOblIP/v/D6okbwtra6BmhxV+2Sou09vWQDNQS0T5qG4DzT9WWEqqRphUyOn927i
         Zixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sE+KlHztGT7oObDkrB1PQT0z0r06uAMT3abghnUSw+s=;
        b=kfR+UfoB5/pDaJawf2vOAsMNwF1D2JSD5d6xImsGIFYY40s5TnI2TNgyKOCyWZia9H
         dLpGF+KCzuDcVk68pZ0huhnIGz/Y7U5rI9RD/Pk17hR/r88bqZa68ibKvYrC1M9Khn9u
         /CATWSnD+K8y3DL6kPk0DCC74NBMmEwUAP0d7LGScwba1MBJO4HnnjWeih2MttbxIj5T
         PowVlQ4Bn91zkXdBFxrIddp7QWOfzQi7FHOfHG5PHxCEL5Q1uWnZg9jpdY75wsVsU9LA
         roJBguldyk+Xc/Hv/8rC1kYQ1VpYQLEK9MMBxLHevhFdN1mr9LjGSTizAAOeCbdPqKB8
         G47A==
X-Gm-Message-State: AJaThX6xUV8bh9LkJ+aytDVsC+xndmQFvAPAM3MJQwCzXbQia+yjAz2C
        3T8CGlIgk8gR/+UNNipWLzqfeDHXNXBrPeboEsPjXw==
X-Google-Smtp-Source: AGs4zMZUANysanY56Fdmh94wq9O8M4+Ll5sKFsjlFgs1DGhNPtJ39hkhgRPUwp5cO6AdMKysgOC9aH9cTjnaUGuyumg=
X-Received: by 10.200.27.225 with SMTP id m30mr26672122qtk.260.1510790785734;
 Wed, 15 Nov 2017 16:06:25 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Wed, 15 Nov 2017 16:06:25 -0800 (PST)
In-Reply-To: <xmqq8tf7yxzn.fsf@gitster.mtv.corp.google.com>
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com> <xmqq8tf7yxzn.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Nov 2017 16:06:25 -0800
Message-ID: <CAGZ79kZbm8SGY4rXKZHV82E-HX9qbQ4iyCbMgJEBFQf4fj3u=Q@mail.gmail.com>
Subject: Re: [RFC] Indicate that Git waits for user input via editor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 15, 2017 at 2:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> However, if you configure an editor that runs outside your terminal window then
>> you might run into the following problem:
>> Git opens the editor but the editor is the background or on another screen and
>> consequently you don't see the editor. You only see the Git command line
>> interface which appears to hang.
>>
>> I wonder if would make sense to print "Opening editor for user input..." or
>> something to the screen to make the user aware of the action. Does this sound
>> sensible to you? Am I missing an existing solution to this problem?
>
> My knee-jerk reaction was: for such a user who has EDITOR set to a
> program that pops under, wouldn't any program, not just Git, that
> uses the editor to open a file for editing/viewing look broken?
> Would we care if we are called "broken" by such a clueless user who
> cannot tell a (non-)broken caller of an editor and a broken editor?
>
> But that is true only when the user does realize/expect that the
> program s/he is running _will_ open an editor at the point of the
> workflow.  If s/he types "git merge" or "git rebase -i @{u}", for
> example, it is true that the world would be a better place if s/he
> knows that would ask a file to be edited with an editor, but it is
> unrealisic to expect that everybody knows how to operate these
> commands.  Everybody is a newbie at least once.
>
> I wonder if we can do something like
>
>         git_spawn_editor()
>         {
>                 const char *EL = "\033[K"; /* Erase in Line */
>
>                 /* notice the lack of terminating LF */
>                 fprintf(stderr, "Launching your editor...");

"It takes quite some time to launch this special Git Editor"

As Lars pointed out, the editor may be launched in the background,
that the user would not know, but they might expect a thing to
pop up as a modal dialog as is always with UIs.

So despite it being technically wrong at this point in time,
I would phrase it in past tense or in a way that indicates that the
user needs to take action already.

The "Launching..." sounds as if I need to wait for an event to occur.

>                 fflush(stderr);
>
>                 if (!run_command(... spawn the editor ...)) {
>                         /* Success! - go back and erase the whole line */
>                         fprintf(stderr, "\r%s", EL);
>                 } else {
>                         fprintf(stderr, "failed (%s)\n", strerror(errno));
>                 }
>                 fflush(stderr);
>         }
>
> to tentatively give a message without permanently wasting the
> vertical space.
