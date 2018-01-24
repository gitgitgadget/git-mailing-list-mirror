Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D8DF1F404
	for <e@80x24.org>; Wed, 24 Jan 2018 19:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932136AbeAXTje (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 14:39:34 -0500
Received: from mail-ua0-f178.google.com ([209.85.217.178]:40390 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932072AbeAXTja (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 14:39:30 -0500
Received: by mail-ua0-f178.google.com with SMTP id t6so3457564ual.7
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QUQ8Lw5dsyrRLp2dH405BXi9564I8Zc+ZAo41W05cRw=;
        b=dOOzvIYx9zeGWIiwQ5MNfvXZ0bUGIzdAaXdSV2leUc3seJGYOC7esMJmC2UAg3KjIg
         Q1iY9seOUxOpOSM4UUqY8779KhpKL90a4gqBH7tKpf1zYRHdHM0Cw7Tr0nGdQnGk7U/V
         0HCq5ECqBE8Usha9298MzzrZZhUoZYLZxJX9fQuRo4FvX9QRw0pteH0uRnAq1LoysO3n
         wGbdthieJWHvxnTr3wXFhk/Yl/05FZPhs4EWngJ5AHl4HQYNna4OlYmBIEeKdrgU1llX
         ktIgGO+lERHcw7/aZC7vKTDnvEbNbANkPgTZQ/n8H+PckEQjn9XmTbQ/FwFsMBrtqMo1
         5lUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QUQ8Lw5dsyrRLp2dH405BXi9564I8Zc+ZAo41W05cRw=;
        b=IaFnNSg94KsIrOitXcNDLr5mp+WUmB4//oTbM7BgbJ60bXEMqYM5s4e9ogB6yth7TA
         6LCx/keLDkI18i2n31RSKwHXODJKQgb7DI9mVNr4w9XPyuyS8dyENeOuyFtldEdztj+Y
         eXxaztfUJzqvr6/LY6Oj0XZTEdT/rBpHo3sjNPZIHhUN1msvDZlvmmoffKuNM+Mzp6FZ
         9BkwbmeYgJ10qjXbN/CZOW0mYG6XqTZxxJvUVzJzm4rdyQc3J22e4Tc3zl1bxyohBFNn
         wxqV/F/CiSmnMu35qqaFeA/UTeAqZK5VW1GuGcyWEKxIWZpYsNN/eT2QYeYuw3tsYJWq
         YJEg==
X-Gm-Message-State: AKwxytcbH2tEawmex45aHUlG4EdkXEzlwlUCzdPDEjXW+85WGFw2VHAC
        Nu2e0/Kwv3pVYYHwuja/dmjD8vsfYXgtYqIze88=
X-Google-Smtp-Source: AH8x224Htl0znF30VCNO9CE4+MtNs49530gVDtjRJbLhsPgJ0SSAyiC5GJ1LfgSagk9maKOv3tfTYAoHvLjRRfFsO+A=
X-Received: by 10.159.40.35 with SMTP id c32mr5549170uac.40.1516822769215;
 Wed, 24 Jan 2018 11:39:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.8.83 with HTTP; Wed, 24 Jan 2018 11:39:28 -0800 (PST)
In-Reply-To: <CA+WKDT3ZsObXc2ENV3gUXbMZU=McBJdiEpvk7y2OM0t+PrqZtQ@mail.gmail.com>
References: <CAFAcib-2fxiVxtVWcbvafY3-Br7Y70HMiHFZoT0VfK6JU0Dp9A@mail.gmail.com>
 <CABPp-BGYs9jo16OZR8NsL-eO9LwEttBxBspvp1-_JjuD2oBYbA@mail.gmail.com>
 <CAFAcib9FGfTe8C7TaOY91kzhUvxXtpx5Y8JMFkqxhRhLJeytxg@mail.gmail.com> <CA+WKDT3ZsObXc2ENV3gUXbMZU=McBJdiEpvk7y2OM0t+PrqZtQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Jan 2018 11:39:28 -0800
Message-ID: <CABPp-BGLt4FEMZYpy5YtimrDDi7MHstfciucUPrnO5HzcOuBTA@mail.gmail.com>
Subject: Re: git merge-tree: bug report and some feature requests
To:     Edward Thomson <ethomson@edwardthomson.com>
Cc:     Josh Bleecher Snyder <josharian@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 23, 2018 at 3:52 AM, Edward Thomson
<ethomson@edwardthomson.com> wrote:
> Indeed, when I added merge to libgit2, we put the higher-level conflict
> analysis into application code because there was not much interest in it
> at the time.  I've been meaning to add this to `git_status` in libgit2,
> but it's not been a high priority.

That sounds pretty cool.  I'm actually dealing with a similar problem
in git itself with my replacement merge strategy; since I try to
perform the merge in-core, and then only try to update the index and
working copy if there'd be no loss of information (no overwriting of
dirty or untracked content), there's a delay between when a conflict
is detected and when I can report it, meaning that I have to store
information about the conflict somehow, and then report later.  So
that means I have to go through the trouble of storing this
information internally, which naturally raises the question of whether
I want to provide this information to the user in some fashion other
than just simple "CONFLICT: ..." messages printed out to the user.

>> This which
>> leaves it unclear what exactly the conflict was, at which point any
>> user (read: porcelain developer) will end up having to recreate some
>> merge logic to figure out what went wrong. And if merge-tree starts
>> doing rename detection, the user might then have to emulate that as
>> well.
>
> That's not a good idea.  Trying to figure out what merge did would be
> painful at best, and likely impossible, since a rename conflict is
> recorded in the main index without any way to piece it together.  eg:
>
> 100644 deadbeefdeadbeefdeadbeefdeadbeefdeadbeef 1       bar.c
> 100644 cafec4fecafec4fecafec4fecafec4fecafec4fe 2       bar.c
> 100644 c4cc188a892898e13927dc4a02e7f68814b874b2 1       foo.c
> 100644 71f5af150b25e3aaaad2d67ff46759311401036f 2       foo.c
> 100644 351cfbdd55d656edd2c5c995aae3caafb9ec11fa 3       rename1.c
> 100644 e407c7d138fb457674c3b114fcf47748169ab0c5 3       rename2.c
>
> This is the main index that results when bar.c has a rename/edit
> conflict, and foo.c also has a rename/edit conflict.  One was renamed
> to rename1.c and the other to rename2.c.  Trying to determine which is
> which _after the fact_ would be regrettable.  Especially since rename
> detection is not static - you would need to know the thresholds that
> were configured at the time merge was performed and try to replay
> the rename detection with that.
>
> libgit2 records a `NAME` section in the index that pairs the rename
> detection decisions that it performed so that you can analyze them
> and display them after the fact.

Ooh, I like that idea.  Could we do the same in git itself?  Having
not messed with the index format at all, what commands do users use to
view this supplementary info?

Also, if you have this NAME section, you could make other commands
smarter.  For example, if you had a normal content conflict on some
file without rename detection being involved, you'd expect the index
to look something like

100644 deadbeefdeadbeefdeadbeefdeadbeefdeadbeef 1       file.c
100644 cafec4fecafec4fecafec4fecafec4fecafec4fe 2       file.c
100644 ba5eba11ba5eba11ba5eba11ba5eba11ba5eba11 3       file.c

and then when you do a 'git add file.c' you expect all the higher
stages to go away, i.e.

100644 5ca1ab1e5ca1ab1e5ca1ab1e5ca1ab1e5ca1ab1e 0       file.c

With your NAME section trick, could one expect 'git add rename1.c' to
delete not only the higher stage for rename1.c but also the two for
whichever of bar.c or foo.c is relevant?

Elijah
