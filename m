Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01ADB1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 19:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbeKBEu2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 00:50:28 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:45392 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeKBEu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 00:50:28 -0400
Received: by mail-ed1-f47.google.com with SMTP id t10-v6so29148eds.12
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 12:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KvQzr6yx5k2KkS8qvMn3YK4TyZSusBfH73UZ2v92ePg=;
        b=Hd6h6TM39fnUgLPvkG1jq/pyA1fJDzeYwwmEoPOHB+v5BS7F5th7rwXK6RiUvki8vV
         vG0YHeZG9drG9aFW54JPGXJMAGmqjOCiKOGobRwP/Pa2kHZwsbiSPezKiYliSwTslAhn
         vsbNF9tQbXArix8f38s7EwbSnhqX4lYDX91vH9YOdCrivX5+XAAYeX7wPPpXe3yjjQ/a
         hP26M2iZQqvv8Y9W/aCQg5epYxy0RyE8BQ7+NB5UcjF7BzEye28gI19i02IP6pqISM0k
         Quubq9y5Dl8X1bhUHDsSejQrndqrYX8GHi+80ixajK4qOk2wKbtdQKTwdW/+QpwT18f/
         ugOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KvQzr6yx5k2KkS8qvMn3YK4TyZSusBfH73UZ2v92ePg=;
        b=CY+VIKirZThti2gLUyqrUZ+PjS5cD/IgJ1EuJMU9oYpejVZuXpxNR+xbjq9Vb8dwW6
         nKeuImdyiazrrg4SsfIXu+d6UvDw3YSBA0GWXP9YEtnY3DLJTbkLXNp8ynRK1zPh6vf3
         pdFIgTJVP+h9aeDTN/7aHZGdRxiCOkJ3LASc80Gs2FqqVgix6cJHtmvu5vl1situlu7j
         qzr/nHeosfsBt8tCU29nsiucxY0YHOogppq/lPnCF2w/cy6vAZKwS8lvHgTWok8xOX8e
         nro2dLGOERdk8UX++YEoHRALiV5PGtj66kaKTtVTQ1zJAmH32ADVQNIvCb7xipJWO8Fb
         pMrQ==
X-Gm-Message-State: AGRZ1gItiY8I2bXjuPJqKaasxg2YX67xVxqUMXQKROQYG0R6pvUlhFLO
        srTSlerMaTp7czeIS+ze0pCuxeH6cTdd8evi18xYjA==
X-Google-Smtp-Source: AJdET5eV7X5Jp0UPiWaEJDcVGcKKZJkVekbifGZny5tfyLib4hNCXDQrVfsh3dnxA1uQhtdol1f1mk9XjkSXhz6oGlI=
X-Received: by 2002:aa7:df12:: with SMTP id c18-v6mr6259855edy.85.1541101564145;
 Thu, 01 Nov 2018 12:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181030220817.61691-1-sbeller@google.com> <xmqq4ld2wrcq.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4ld2wrcq.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Nov 2018 12:45:52 -0700
Message-ID: <CAGZ79kacJLv7Eimgs82W_tEJR57o5HoDvmYfv4T2U9_gs0-Ujg@mail.gmail.com>
Subject: Re: [PATCHv2 00/24] Bring more repository handles into our code base]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 30, 2018 at 11:41 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> > I also picked up the patch for pending semantic patches, as the
> > first patch, can I have your sign off, please?
>
> I find this step quite lacking.
>
> What was posted would have been perfectly fine as a "how about doing
> it this way" weatherbaloon patch, but as a part of real series, it
> needs to explain to the developers what the distinctions between two
> classes are, and who is to use the cocci patch at what point in the
> development cycle, etc., in an accompanying documentation update.

if only we had documentation [as found via "git grep coccicheck"]
that I could update ... I'd totally do that.
I guess this asks for documentation to begin with, now?

> So can we have both sign-off and write-up (perhaps cut&paste from
> the original e-mail discussion)?

I'll see where to put the docs; I assumed commit messages are enough.
63f0a758a0 (add coccicheck make target, 2016-09-15)
is what I found nice.


> >   t/helper/test-repository: celebrate independence from the_repository
>
> It seems that this topic is full of commits with overly long title.

yep.
> > git range-diff origin/sb/more-repo-in-api...
> > [...] # rebased to origin/master
>
> I offhand do not recall what happened during these 100+ pacthes.
> DId we acquire something significantly new that would have
> conflicted with this new round of the topic?  I do not mind at all
> seeing that a series gets adjusted to the updated codebase, but I do
> dislike seeing it done without explanation---an unexplained rebase
> to a new base is a wasted opportunity to learn what areas of the
> codebase are so hot that multiple and separate topics would want to
> touch them.

From the point of view of these large scale refactorings,
all of the code is hot, e.g. the patch that was present in the RFC
"apply all semantic patches" would clash with nearly any topic.

As I do not carry that patch any more, I do not recall any conflicts
that needed to be resolved.

Thanks.
