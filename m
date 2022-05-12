Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC847C433F5
	for <git@archiver.kernel.org>; Thu, 12 May 2022 22:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356452AbiELWX2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 May 2022 18:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240450AbiELWX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 May 2022 18:23:27 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7E05FF0E
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:23:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id l19so8196673ljb.7
        for <git@vger.kernel.org>; Thu, 12 May 2022 15:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6H5pOhPX1HoMW8R+61CjrmdtigNtt9QbzcWSXgGS85g=;
        b=q0EbZ403GJrNlc+tKKdftNfUJqBmODbbtUbLS3wXNbK4sOuhX6I377iffYDGIf/Evo
         EpDly54d2SgFWwppVJP+uzadpMWFKHVTVDtOk6yozGLmqGpOwIc1x2zUAw+Jp5bV+LSs
         D6VMJ0rgx3SCYn58LystM/yYjdgcMvAYGY+l+nx5IL0/uIxYFCRP2nl3lOi6PlDyinac
         hGEDo2X2VyymT1wUTG0NxTiFA7yFvm069YqJwSv3txRx5dUfCvuycecS1gx8siegLG2j
         4dMyj0InrrWXAHrGUqYmSVAICtSFKeEsBCDzLx3nvJxM+qaj/UGoB8PA5LDNEnFNjBPQ
         /aaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6H5pOhPX1HoMW8R+61CjrmdtigNtt9QbzcWSXgGS85g=;
        b=tCc3VE56tNq29y9QZRWSKNfSJekttx/jCxbbbACK/SDFYnruybYfuSf5JXD7UJe9tm
         tM8xOUa0YgKy8zJsnCEy7/bNiFBz0WrjuR/ku/8oI6ocpmE5qi8kkDE2BKTgakr+JVdA
         FjXrlRYROR7WrngD2gcUK48ZHI0RRIQYgaqfkqdEyVOtBXdjxAD/59J9nIsym/dcBDlP
         rxOE18UDRwA9nSHlkGimiZhQTvQE3uGK6hHMl58dUIhs2T5QhePkWx1DSLtn8z12uFYh
         76P6e56bOvmJTW7lDOTpJAEsG3opvdaeyWF4r35V+2uau1syZiIRS4xwgE4wA44aQhC8
         JUbA==
X-Gm-Message-State: AOAM532N5XWoRQaJ3WlNWOFnTxyYAwnORkDB6gRylYSWHO7beRoS9qUT
        J+ncDPutOju2kqDfH7Txauuh+DnV7K6bVHn3hO6afg==
X-Google-Smtp-Source: ABdhPJz4OiQpp/L2YgACJ8BEkguH1Rv4PHHLbxFR0ElB5rMuL1JwNxsJ3hbFuBCnr6rl7CoqIOYJGolRC9LaLyJuKxQ=
X-Received: by 2002:a05:651c:1506:b0:250:6459:d6d4 with SMTP id
 e6-20020a05651c150600b002506459d6d4mr1304156ljf.271.1652394204399; Thu, 12
 May 2022 15:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+Yb-VSaeKy-g_ywkZzQuEX=k3EXM+Ky-rHOb2az0SHGVbdaVw@mail.gmail.com>
 <Ynndk0L6r9O7jLVU@google.com>
In-Reply-To: <Ynndk0L6r9O7jLVU@google.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Thu, 12 May 2022 15:23:12 -0700
Message-ID: <CAJoAoZ=t=BEfsfHBay1K7CY2MYEwcvPYKYxvgv_BvLL3SMcf_A@mail.gmail.com>
Subject: Re: Let's have a user experience workshop
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Alice Merrick <amerrick@google.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 8:35 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
> A few bits I took away:
>
> 0. Examples
>
> The examples Alice gave, especially from the Go project (generics as a
> UX project!) were interesting and helpful.
>
> 1. Continuing the conversation
>
> I and some others (e.g. David, cc-ed) ended the workshop wanting to
> discuss a little more --- when deciding (1) what to work on and (2)
> settling on a design for that work, what has worked well for us in the
> past?  What didn't work?  What research methods have we tried?  What
> would we like to try?  We mentioned wanting to continue that
> discussion on-list, so trying that now. :)
>
> 2. Sharing research
>
> Some of us are already doing some research, in the form of surveys,
> metrics collection, testing with prototypes, analyzing user issues in
> internal bug trackers, and so on.  It would be nice to share that
> more, so different participant's studies can build on each other.
>
> I'm curious about what a good form for that is in an open source
> project.  Should we send findings as papers to the mailing list?  Do
> we want some kind of repository (using git, Figma, or some other tool)
> of findings that we build together collaboratively?  Whatever we do is
> likely to involve some extra work to deal with confidentiality; how do
> we notice when something is worth the work of jumping through that
> hurdle?
>
> 3. Testing ideas with users
>
> It's not unusual for there to be a question on-list about some facet
> of the UI such as an option name, that ends up being decided as a
> matter of taste.  Alice mentioned that we have a chance to make more
> user-focused decisions by just talking to a few users, which can be as
> simple as recruiting five users from #git on IRC and sending them a
> private message asking questions like "Suppose you have just run this
> command; what would you run next? What would you expect that command
> to do?"  This seems like a straightforward addition to our workflow
> that we could get better at over time.
>
> Do you agree?  If this is a good idea, how would we like to go about
> it?  (E.g., how do we notice when there's a question that could
> benefit from that kind of experiment, how do we come up with the
> questions for users, and how do we present the results?)
>
> 4. Stating assumptions about users
>
> Another theme was that when we choose what to work on and form designs
> for our work, we regularly make numerous assumptions about users'
> desires and goals, habits, what will be intuitive for them, and so on.
> Stating these assumptions would have a few benefits:
>
> - they would make the rationale behind a design clearer, which makes
>   it easier to continue to honor that design in the future;
>
> - when those assumptions turn out to be false, it would be easier to
>   revisit early design decisions;
>
> - they could give interested people ideas for how to follow up and
>   check those assumptions;
>
> - over time a clearer model of the user would emerge that could be
>   useful to make use of in later designs
>
> The downside, of course, is that it can be embarrassing to make
> assumptions that turn out to be wrong, but that seems like a small
> downside relative to those benefits.  So I am thinking it could make
> sense for us to make a concerted effort to describe these kinds of
> assumptions in commit messages more often.  If this seems like a good
> idea, I'd be happy to send or review a patch to SubmittingPatches
> saying as much.  What do you think?

For all 4 of the above - I wonder whether it really makes sense to try
and organize those things asynchronously. If I'm being honest, what
I'd much prefer would be a monthly-or-so working group meeting with
other folks interested in performing research, making recommendations,
learning how to improve Git's UX, etc. I'd absolutely make time to
attend such a thing, and I believe it would be the easiest way to
organize research and concert our efforts. Would other folks be
interested in showing up, too?

I'd envision it as something between a working group and a book club -
we could learn different aspects of UX design and research, and apply
them in various ways. It might be nice to have Alice along for at
least the first couple of sessions to answer questions and help us
learn in a bit more targeted direction than we got at the workshop.

 - Emily
