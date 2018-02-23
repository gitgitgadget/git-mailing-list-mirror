Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79931F404
	for <e@80x24.org>; Fri, 23 Feb 2018 17:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751842AbeBWRWc (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 12:22:32 -0500
Received: from mail-lf0-f52.google.com ([209.85.215.52]:46804 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeBWRWb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 12:22:31 -0500
Received: by mail-lf0-f52.google.com with SMTP id r80so13374289lfe.13
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 09:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iig/QkhOJxfLjZYbG3xFNVmRSdOy3WBcQlSQ9mku/C4=;
        b=G7e0tjoubQMZfH+r5wgfQF976llrwfx9JTlCNaOOkF4GMWGtHEYyTZ8EGkVE+/B696
         XqcPRsU+NN7N22HA0eqfdTUSsb1JkyPlO1T4JybW11ThNXv7rRmo3I8CmGrw1GTQSo/Z
         Abo/AdRMnkeiUrdblW4+k5dVhQ516J3PeUTpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iig/QkhOJxfLjZYbG3xFNVmRSdOy3WBcQlSQ9mku/C4=;
        b=fQ/oQZpEQ9V5381rXnN5vASaihqUfxVbK4DekfMGIg7ARyH8zEpZf9DgJQRbR2oe7s
         rwkHL1Wl/CUfGqkc9dZ35s2WrJk/b8OsqbJQwOI0Mq3rVsNThdwjESy78M/nfEwuHq0P
         NekwkOT4ucxEwad2Isaw10RH6PclQ08Oe4BCFlZsq8I9ralQKnu98Vj097/IdPkXCwfW
         68LAPTTVyMIJB6a4j+9Q6vYxkf1WFRXRWPQQRX51mL6+nBNseA5uYkldtZijX4DqKw2w
         NSUjKv+XPuiVAUmYLg7grts6eLe086ZXv7TAlx3lvD1IdIFMEbAHHksDyl/tl/lumS5c
         9koA==
X-Gm-Message-State: APf1xPDT4cAPUkLQo4uAOBNQiop1ZRJnPaJUsDj1gJ1K0OKt1eS+rB3O
        iY/znzjukw1Yvnjc5ximwAGqbtIvzC1JhDmp/IhsBA==
X-Google-Smtp-Source: AH8x2265SNwD6pTG+QBSMPSb8QBJtoq5t7LiFg63tiUxKU4cQU0xYwsejtgyf5XfeaZy9NPzAobovDeXJjoOg//Wkps=
X-Received: by 10.46.84.5 with SMTP id i5mr1829605ljb.83.1519406550377; Fri,
 23 Feb 2018 09:22:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.148.90 with HTTP; Fri, 23 Feb 2018 09:22:29 -0800 (PST)
In-Reply-To: <CAE5ih79E1Z8h+hAgr8zCw7=Dtec6sxT7Xf4cWn8zOLNs=mY1jg@mail.gmail.com>
References: <20180222095022.6227-1-luke@diamand.org> <20180222095022.6227-2-luke@diamand.org>
 <CAKYtbVYe5hHDXf=nQzt6r9N20CrTgbEMbBS0JBBXQLpz+BVu1A@mail.gmail.com> <CAE5ih79E1Z8h+hAgr8zCw7=Dtec6sxT7Xf4cWn8zOLNs=mY1jg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 23 Feb 2018 17:22:29 +0000
Message-ID: <CAE5ih7_=0Vn2J+TRnUfzT8TsyfmUa5PYpzviOf_DD+NTZtUZPA@mail.gmail.com>
Subject: Re: [PATCH 1/1] git-p4: add unshelve command
To:     Miguel Torroja <miguel.torroja@gmail.com>
Cc:     Git Users <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        gvanburgh@bloomberg.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22 February 2018 at 22:28, Luke Diamand <luke@diamand.org> wrote:
> On 22 February 2018 at 21:39, Miguel Torroja <miguel.torroja@gmail.com> wrote:
>> Hi Luke,
>>
>> I really like the idea of creating a branch based on a shelved CL (We
>> particularly use shelves all the time), I tested your change and I
>> have some comments.
>>
>>  - I have some concerns about having the same "[git-p4...change =
>> .....]" as if it were a real submitted CL.
>>     One use case I foresee of the new implementation could be to
>> cherry-pick that change on another branch (or current branch) prior to
>> a git p4 submit.
>
> OK, I think we could just not add that in the case of an unshelved commit.
>
>>
>>  - I see that the new p4/unshelve... branch is based on the tip of
>> p4/master by default. what if we set the default to the current HEAD?
>
> There's a "--origin" option you can use to set it to whatever you want.
>
> I started out with HEAD as the default, but then found that to get a
> sensible diff you have to both sync and rebase, which can be quite
> annoying.
>
> In my case, in my early testing, I ended up with a git commit which
> included both the creation of a file, and a subsequent change, even
> though I had only unshelved the subsequent change. That was because
> HEAD didn't include the file creation change (but p4/master _did_).

Discussing this with some of my colleagues, and playing around with
it, it seems that what it really needs to do is to figure out the
parent commit of the shelved changelist, and use that as the basis for
the diff.

Unfortunately, Perforce doesn't have any concept of a "parent commit".
One option that would be possible to implement though is to look at
the shelved changelist, and foreach file, find the original revision
number ("//depot/foo.c#97"). Then "p4 changes //depot/foo.c" would
give you the changelist number for that file. Find the most recent P4
changelist, find the git commit corresponding to that, and do the diff
against that.

It's pretty clunky, and I'm quite glad I didn't try to do that in the
initial revision, as I would surely have given up!

To do it properly of course you need to handle the case where the
shelved changelist author had some files at one changelist, and others
at another. But I think that's just far too complicated to deal with.

Luke
