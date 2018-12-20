Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 269F01F405
	for <e@80x24.org>; Thu, 20 Dec 2018 16:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731955AbeLTQsk (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Dec 2018 11:48:40 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:44536 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbeLTQsk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Dec 2018 11:48:40 -0500
Received: by mail-ua1-f51.google.com with SMTP id d19so765168uaq.11
        for <git@vger.kernel.org>; Thu, 20 Dec 2018 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uf1rywh5Hf7S3j7XvFA0qf0hIbp/ZmLEd7ukZZizkU4=;
        b=Werbx1wBn95edd2qGPw+7awzFePDjfaU/4GZjMzp3A8Pjzt7UqRlzyYgMXGcKJIyxr
         9rPOaWFi0mXdnFfinQ1B4IYNOKofgsnIFOmt1qCGKh+3i/gkH8s9za8yNxwjujgHbQrW
         DaOMuY1tSZOucFmqhFRsbD/cNzhuS+cQodhgAvSrsUu5tuwldbOjXIjxmEtvJxK6PPGj
         dG1IlI2LrNse6MpwHGaZzrDV/dS4NMJ9fPB/kYeJw0XzyVrKua2AQDhvNzI+4GtockYk
         87gpIQMVQ/tcd7li2uAw4gJMWPvxxKuD4njAt+WHzreDFEFneNvzMryGtQu8ViD5DWia
         6Wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uf1rywh5Hf7S3j7XvFA0qf0hIbp/ZmLEd7ukZZizkU4=;
        b=E/q4eUMOdkCnk3sIh8WCw76+Maqc55mVsgSGO2xeX7XL5XncsN2TJQC/haoh4p9/6I
         U5UgauFO1U9ZyTKJMx5Yq1YxihP4kAQ3QeAk9PrggsCKKO+TTdcWpfhZ49imODkNodWh
         742FioN1OpXPLOUqV4YelFRavqRXjlsd5lwatyhlII4MA4Z5VGP4XvN7tV88bHPSdCN2
         5r23CHh6rvbjeSY8HvZx3kBBuF6HrE8dUB1YXoEMD0QyFPkVeYIOQ5f0otFHZCDDVOub
         5LEV3vn1xZ0y6xTK603vJvFtl+HOW3NMKM15+zVhjbsmoqkZ2nfE9BK7MJnPTCJUo5sl
         LSpA==
X-Gm-Message-State: AA+aEWZD0gJjxPtxdcY38Y8Pi/dsN8em8qD6x3RhLuntF/L6v9aNqsR0
        hkvozK0tM0IbboYWCvP6Y98W4JgariMJeJqQYhk=
X-Google-Smtp-Source: AFSGD/XYvqaw4BK9NYWos/LvX05YyWJYhcT5a2+2VE4Dr3hcvxOdG9UkAxS3JW251xLPWRFOlfBXfMuAYmKOjM63wvE=
X-Received: by 2002:ab0:744f:: with SMTP id p15mr5694138uaq.19.1545324519056;
 Thu, 20 Dec 2018 08:48:39 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxiB1uDfg4iPFjh2dNibEZa5mJ0RwhCzt0R2b87NTVqWfA@mail.gmail.com>
 <20181219232200.GB21283@sigill.intra.peff.net> <CALjAwxg2E_48kQYt1GHkcXvVmaFyPY3PGG9rHZNMp+++UqKfow@mail.gmail.com>
 <20181220151037.GC27361@sigill.intra.peff.net>
In-Reply-To: <20181220151037.GC27361@sigill.intra.peff.net>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Thu, 20 Dec 2018 16:48:13 +0000
Message-ID: <CALjAwxjyS5raGbib5KyUPZzS+9UyB1fpCN2fybYoYOctXe7iyA@mail.gmail.com>
Subject: Re: Periodic hang during git index-pack
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 20 Dec 2018 at 15:11, Jeff King <peff@peff.net> wrote:
>
> OK, that's about what I expected. Here we have clone's sideband-demux
> thread waiting to pull more packfile data from the remote:
>
> > (gdb) thread apply all bt
> >
> > Thread 2 (Thread 0x7faafbf1c700 (LWP 36586)):
> > #0  0x00007faafc805384 in __libc_read (fd=fd@entry=5,
> >     buf=buf@entry=0x7faafbf0ddec, nbytes=nbytes@entry=5)
> >     at ../sysdeps/unix/sysv/linux/read.c:27
> > #1  0x000055c8ca2f5b23 in read (__nbytes=5, __buf=0x7faafbf0ddec, __fd=5)
> >     at /usr/include/x86_64-linux-gnu/bits/unistd.h:44
> > [...coming from packet_read / recv_sideband / sideband_demux...]
>
> I assume fd=5 there is a pipe connected to ssh. You could double check
> with "lsof" or similar, but I don't think it would ever be reading from
> anywhere else.

I checked and in all cases git was reading from a pipe.

[snip]

> with each blocking on read() from its predecessor. So you need to find
> out why "ssh" is blocking. Unfortunately, short of a bug in ssh, the
> likely cause is either:
>
>   1. The git-upload-pack on the remote side stopped generating data for
>      some reason. You may or may not have access on the remotehost to
>      dig into that.
>
>      It's certainly possible there's a deadlock bug between the server
>      and client side of a Git conversation. But I'd find it extremely
>      unlikely to find such a deadlock bug at this point in the
>      conversation, because at this point the client side has nothing
>      left to say to the server. The server should just be streaming out
>      the packfile bytes and then closing the descriptor.

I think it's highly unlikely too given how many good runs we generally have.

>      You mentioned "Phabricator sshd scripts" running on the server.
>      I don't know what Phabricator might be sticking in the middle of
>      the connection, but that could be the source of the stall.

I think you're right. I set up a seperate sshd on a different port on
the same machine where there were no Phabricator callouts and the
problem never manifested...

>   2. It's possible the network connection dropped but ssh did not
>      notice. Maybe try turning on ssh keepalives and seeing if it
>      eventually times out?

I had already done this but the problem still manifested. I went so
far as checking if the problem would happen over the loopback device
on the same machine (via localhost) and the problem continued
happening so I'm fairly sure that rules out networking issues.

-- 
Sitsofe | http://sucs.org/~sits/
