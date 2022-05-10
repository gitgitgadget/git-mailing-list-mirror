Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622BCC433F5
	for <git@archiver.kernel.org>; Tue, 10 May 2022 03:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiEJDmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 23:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiEJDkh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 23:40:37 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB862F5
        for <git@vger.kernel.org>; Mon,  9 May 2022 20:35:50 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so15655025plh.1
        for <git@vger.kernel.org>; Mon, 09 May 2022 20:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZWQ+Pe+B3RqzbdjEWqBwDGXRbypMtjhswFzD7gpmRJQ=;
        b=aMr5qNNEZaj1E8jPHuCrlKjvgOEvm1Oxm/xJrGx9iH+g4BdY1uZlW48cKA5ThDVIjY
         BiYk+9eHGDPDr8hnRv8xnBGLwDBlI+P/mEd7oVFOZ+fD+oBB7xAyMA7HqE+UaEMP+dFg
         PjixUyWm81AGekTXkYmdP/ztSXKtHKONrLPoSjwmKLQLbZs3WdbaVNGcCy0UbmQPwC2Z
         JcEX89vMgU82g3rFeKB3YHuqBEUyOkQQskmWbMeToaSYL8Gcdw9hjYLd4UcM0rREdNwP
         V3T6O2fFtPQijbM1qVB3Nl6OiCcjSVJJSyPYIJpbgJHy2HUIxNHP+hcdHwkx/4mIWjkQ
         lcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZWQ+Pe+B3RqzbdjEWqBwDGXRbypMtjhswFzD7gpmRJQ=;
        b=b6DHjRzviLqCZjq0oYHKNXl4viCp42JfJclJ99ZfXN6rYtbeM4TEqDnp+oEOPqjGQ2
         wtzbfJ0CkAd8AxF2WTmLRZRv6eVicQ11d5daC7elERZ72szageLehHENiYG26uqQroA0
         kJPzG3TBSlkEmhH30Ucg6O2Fw5/kKv79UZQSwwtydvlDcZz72sHuEtASr4uB4GsSMbPc
         WubCbIAfVAnYLlc2r+p5DKdHNK5iUpLccx2Vuar5sWG/pGSlT8ogase5S+eJpjNP4xE9
         LrE8XXhi2roNSfGsfIkw/1NEQ5Nal0nhzJjfyCgU4RGtjA3lOK9jiGR+ehAFoOSlGtZQ
         uNUA==
X-Gm-Message-State: AOAM532tIV8RKNZst62ZuaEYUHchOR7OwtvuuzjEmGkbqdvlHai9mkLS
        ACTre49cs4kDJgKB9NzXaAWzZFjEGFg=
X-Google-Smtp-Source: ABdhPJxcipAPiCY+Lw0GwPBJ81Mp9spsThNMccVPxjZmHPX4wzMuAS7+E3PBW7r6CQyVGxZ935/Ryw==
X-Received: by 2002:a17:902:f551:b0:15e:999a:2425 with SMTP id h17-20020a170902f55100b0015e999a2425mr18486474plf.3.1652153749671;
        Mon, 09 May 2022 20:35:49 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:1348:7167:3ccb:351d])
        by smtp.gmail.com with ESMTPSA id m2-20020a17090aab0200b001cd4c118b07sm549761pjq.16.2022.05.09.20.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 20:35:49 -0700 (PDT)
Date:   Mon, 9 May 2022 20:35:47 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alice Merrick <amerrick@google.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Subject: Re: Let's have a user experience workshop
Message-ID: <Ynndk0L6r9O7jLVU@google.com>
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(bcc-ing git UX workshop attendees as a heads up)
Hi,

Alice Merrick wrote[1]:

>                    My goal is to 1) gauge interest in improving Git's
> user experience and 2) recruit interested folks in organizing or
> attending a workshop where you can learn more about what UX is and
> discuss ways to bake UX into the process of making changes to Git to
> improve the experience for all users.

Thanks, Alice!  I enjoyed the workshop.  There are some notes at [2],
which perhaps someone may want to summarize for the mailing list.

A few bits I took away:

0. Examples

The examples Alice gave, especially from the Go project (generics as a
UX project!) were interesting and helpful.

1. Continuing the conversation

I and some others (e.g. David, cc-ed) ended the workshop wanting to
discuss a little more --- when deciding (1) what to work on and (2)
settling on a design for that work, what has worked well for us in the
past?  What didn't work?  What research methods have we tried?  What
would we like to try?  We mentioned wanting to continue that
discussion on-list, so trying that now. :)

2. Sharing research

Some of us are already doing some research, in the form of surveys,
metrics collection, testing with prototypes, analyzing user issues in
internal bug trackers, and so on.  It would be nice to share that
more, so different participant's studies can build on each other.

I'm curious about what a good form for that is in an open source
project.  Should we send findings as papers to the mailing list?  Do
we want some kind of repository (using git, Figma, or some other tool)
of findings that we build together collaboratively?  Whatever we do is
likely to involve some extra work to deal with confidentiality; how do
we notice when something is worth the work of jumping through that
hurdle?

3. Testing ideas with users

It's not unusual for there to be a question on-list about some facet
of the UI such as an option name, that ends up being decided as a
matter of taste.  Alice mentioned that we have a chance to make more
user-focused decisions by just talking to a few users, which can be as
simple as recruiting five users from #git on IRC and sending them a
private message asking questions like "Suppose you have just run this
command; what would you run next? What would you expect that command
to do?"  This seems like a straightforward addition to our workflow
that we could get better at over time.

Do you agree?  If this is a good idea, how would we like to go about
it?  (E.g., how do we notice when there's a question that could
benefit from that kind of experiment, how do we come up with the
questions for users, and how do we present the results?)

4. Stating assumptions about users

Another theme was that when we choose what to work on and form designs
for our work, we regularly make numerous assumptions about users'
desires and goals, habits, what will be intuitive for them, and so on.
Stating these assumptions would have a few benefits:

- they would make the rationale behind a design clearer, which makes
  it easier to continue to honor that design in the future;

- when those assumptions turn out to be false, it would be easier to
  revisit early design decisions;

- they could give interested people ideas for how to follow up and
  check those assumptions;

- over time a clearer model of the user would emerge that could be
  useful to make use of in later designs

The downside, of course, is that it can be embarrassing to make
assumptions that turn out to be wrong, but that seems like a small
downside relative to those benefits.  So I am thinking it could make
sense for us to make a concerted effort to describe these kinds of
assumptions in commit messages more often.  If this seems like a good
idea, I'd be happy to send or review a patch to SubmittingPatches
saying as much.  What do you think?

5. Bug tracker

For many open source projects, a bug tracker is what allows someone to
follow a particular effort without having to "drink from the firehose"
of the full mailing list.  That's particularly likely to be helpful
when bringing in contributors such as designers who do not necessarily
live the same mailing list based lifestyle.

In [3] we (somewhat tongue-in-cheek) suggested using Bugzilla as a bug
tracker that would be equally undesirable to everyone, but it doesn't
seem to have gone anywhere.

I suspect GitLab's issue tracker might be fine in that respect as
well.  Would it be worth setting up a bug tracker there?  (Just like
with the Linux kernel's and with the existing crbug.com/git, I'm
imagining a bug tracker would mostly consist of pointers to the
mailing list, but it would still be useful for someone wanting to
following along and help with an issue.)

Thanks,
Jonathan

[1] https://lore.kernel.org/git/CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com/
[2] https://docs.google.com/document/d/1KDThcte2NHnzZBVXG7lHlqCQNzict6EIpOe9Z1iXEMg/edit
[3] https://lore.kernel.org/git/20211021134105.ziqmcknnpdsg6cvc@meerkat.local/
