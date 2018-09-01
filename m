Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35FEB1F404
	for <e@80x24.org>; Sat,  1 Sep 2018 07:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeIALWr (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Sep 2018 07:22:47 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:35502 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbeIALWr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Sep 2018 07:22:47 -0400
Received: by mail-io0-f180.google.com with SMTP id w11-v6so12184110iob.2
        for <git@vger.kernel.org>; Sat, 01 Sep 2018 00:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M+5FBZy6LwkZHhjL+EXfz529Yb106u7YbYKIMBABwo0=;
        b=uEtXT53hoDcv/j+KpxNSY1izVMfZI+3a0rHNAhLffstNQJNZYctjSKmtln5R5wiwu5
         9T0w0k2OuhUTCa/+uA0CUuJMfysWoltV8DpJr+k6+b0BSEmA42B9CoXDMdMenCqM3/lI
         ZRU4oZpLwmYrLCoh/u4a/UlhdmBjWgtnC0HaIEXLMEwKoNNfQFjV1yGwzZE3a+9otprj
         Ye1jRu8/NK+3fSqESq0Mn+/GrNzWkp0oPnz9exJ1WpTczRXax0X/H6nqrGm8B+e7WnkA
         eKeNVFIXjUXYvDC2Wpg5pP/un1HZEbzX1zPEvyT4YWU5pTt1pqwHBRsc6uDYcq09bhMe
         Gyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M+5FBZy6LwkZHhjL+EXfz529Yb106u7YbYKIMBABwo0=;
        b=r8bGnLFQ6xppbhwVA4ZuhcRbXmgWnac1mFbCKN+kkN+iQhQoTZgubUHUWb+Me5s6Uz
         zq7P4XnfvCUsWtGvBzBfB5buZuZRXdyY5f8jmeyM9uudaAG8juEX6+kZqTZOJJseOghF
         mqIkfG7BusFEXMMVlSACryHV+EdmEhMm84YuR2RRsEBLhyAs28VNPMVXBYhQfZ7ykrIv
         3ZzQeqmoTGnlaxJX6ztGODbEeNuU0khev9oHxaRaH8VprrIFwRnjot3i7FdN7v4qKox4
         WtFzmjHkzn5TfAU/zAcVRyTomDoq6ZTuadES06146qBEp7rzxQ74cMbPuERNHQx2Iho2
         Hj5Q==
X-Gm-Message-State: APzg51CIjwZqR2DaTOje56JcXpwS7HvR8r1laUQODdZmUbbyn31S0SLa
        QNaxmyDtjxTaxLjBlqLJTmINIiBdxwSBDZ6irUs=
X-Google-Smtp-Source: ANB0VdZvyl2o7tzyqJJN8cS7Uph7NB6PllAljtaRS47KTY9ETWo10G25MJEBgzC8pfwmVQtrachbbmGaCKXHpcbcIDY=
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr11326620iob.5.1535785908385;
 Sat, 01 Sep 2018 00:11:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Sat, 1 Sep 2018 00:11:47 -0700 (PDT)
In-Reply-To: <CAL21BmmmD1V+EWFevNT1t9M+nwrN9GR_PTx981ji_zGwfbpd_A@mail.gmail.com>
References: <20180828151419.GA17467@sigill.intra.peff.net> <8736uxe2pm.fsf@evledraar.gmail.com>
 <20180830031607.GB665@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1808301340280.71@tvgsbejvaqbjf.bet>
 <20180830192453.GC19685@sigill.intra.peff.net> <CAP8UFD0AnS1Zp2QdqtLTqBrsUiogODC_apG-vumxRuoijW=r4A@mail.gmail.com>
 <CAL21BmmmD1V+EWFevNT1t9M+nwrN9GR_PTx981ji_zGwfbpd_A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 1 Sep 2018 09:11:47 +0200
Message-ID: <CAP8UFD0v32h+Ls_skvNHeq2n-Ep01KmrRghAy0u9NA3hu2R0gw@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Olga,

On Fri, Aug 31, 2018 at 12:30 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> Hi everyone,
>
> I was Outreachy intern last winter. I guess I need to speak up: I will
> be happy if my feedback helps you.
> At first, I want to repeat all thanks to Outreachy organizers and Git
> mentors. That was unique experience and I am so proud of being a part
> of this project. But, I need to say that my internship wasn't ideal.
> Mentors, please do not feel guilty: I just want to improve the quality
> of future internships and give some advises.

Thanks a lot for this feedback! I think it can be very useful and I
don't feel guilty as I think no one is really to blame in these kinds
of situations. We all have to learn how we can improve.

I think a part of the problem as just that the work is really very
difficult for interns even if it doesn't seem that it should be so
difficult which makes the intern/mentor relationship tricky.

> I guess some of the problems aren't related to Git, and it's Outreachy
> weak points. Please forward this email to Outreachy organizers if you
> want.
>
> 1. The main problem of Outreachy internship is positioning. I mean, I
> had strong confidence that it's an internship for newbies in
> programming. All my friends had the same confidence, and that's the
> reason why 2 my friends failed in the middle of the Outreachy
> internship. Load was so big for them, noone explained this fact in the
> beginning, noone helped with this situation during the internship. I
> was thinking I could be overqualified and I took someone's place (I
> had 2 other SWE internships before Outreachy). The truth is that my
> skills were barely enough.

Yeah, but will it be better if Outreachy scares too many people away
from applying? I am not really sure.

Also I think success depends not so much on the students/interns
technical skills but on their willingness to ask questions and their
ability to get the help the need. Maybe Outreachy and Git should state
that more clearly.

For a long time I thought that it could be enough to just tell
students/interns that mentors are here to help, so they should not be
afraid of asking even the most basic questions. But over time I have
been realizing that mentors should actively try to understand what
help the student/intern need.

> 2. Please tell more about minimal requirements: write it down on a
> landing page in the beginning and maybe repeat them in every task. I
> guess it would be the same this year: good knowledge of C, gdb, Git
> (as a user: intern needs to know how to work with forks, git remote,
> git rebase -i, etc), Shell, base understanding of Linux terminal,
> being ready to work remotely. It's good idea to mention that it's not
> 100% requirement, but anyway at least 60% from the list must be
> familiar.

On our project page (https://git.github.io/Outreachy-15/) we tried a
bit to do that, for example there are things like:

    Language: C
    Difficulty: medium to hard

for each project. And there were no "easy" tasks.

So yeah instead of "Language: C" we could have something like:

    Requirements: very good knowledge and practice of C, shell, gdb,
Git, Linux terminal, ...

and for difficulty we could remove "medium" and just select between
"hard", "very hard" and "impossible" :-)

But this could scare possible students/interns away and that's not
really what we want.

We think that if someone can successfully complete a micro project,
they should have enough basic technical skills to get started and then
we can teach them what they need. Maybe we could state that more
clearly?

I also think that the Git project doesn't make enough effort to be
newcomer friendly. Maybe we could start by adding a document somewhere
that could contain basic useful information for newcomers? Perhaps
this could be based on the presentation that Peff gave at the
beginning of the Bloomberg Hackathon last November?

> 3. If you decide to be a mentor - at first, thanks a lot. Please be
> ready to spend A LOT OF time on it. You need to explain not only the
> task to your intern, but also how to split the task into subtasks, how
> to look for solutions, how to work with the terminal, how to debug
> better and many other questions. It's not only about solving
> internship task. It's about learning something new. And I did not
> mention code reviews: there would be many stupid errors and it's a
> talent not to be angry about that.

I think mentors are ready to do that. Often the problem is that we
just don't know how we could help or how we can make the
students/interns confident enough to tell us how we could help or what
is blocking them.

> 4. I fully sure that you need to talk with your intern by the voice. I
> mean regular calls, at least once a week. It's good idea to share the
> desktop and show how you are working, what are you using, etc.
> Ask your intern to share the desktop: you need to feel confident that
> they understand how to work with the task. Help them with the
> shortcuts.

There are interns/students who might not like doing that. So I am not
sure if should make it mandatory, but maybe we should recommend and
advertise that it's a good idea to do these kind of things. Dscho
talked about pair programming in another thread and I think it is also
a good idea.

> Remote work is so hard at the beginning, I feel alone with all my
> problems, feel ashamed to ask questions (because they are not "smart
> enough"), sometimes I didn't know what to ask.

I really think that a big part of the problem is that some
students/interns feel ashamed to ask questions or to ask for help.
They might think they will be evaluated based on their skills or
problem solving abilities, so they are afraid to tell that they need
help as they might think that it could be interpreted as not being as
good as they should be.

Maybe we might state more clearly that students/interns are failed
mostly when we think they are not putting in the amount of effort or
communication that is required, and that asking for help is actually
expected and considered good communication and good effort?

Maybe there are some interns/students who would be less afraid to ask
for help privately to someone who is not their official mentor,
because they think it will not count in how they will be evaluated?

> I need to mention that
> I had almost 1 year of remote work experience, and that helped me a
> lot. But other interns do not have such experience.
> Actually, I am sure that the only reason why I successfully finished
> the internship is that my mentors believed in me and did not fire me
> in the middle. I personally think that I failed first half of the
> internship, and only in the end I had almost clear understanding
> what's going on. (My friend was fired in the same situation.)

I cannot tell about why your friend was failed. I think though that
you communicated that you needed help (even if it was not always clear
what kind of help) and you accepted, or maybe asked, to have Google
Hangout calls which helped us find what kind of help you needed, and
then things went much better.

I really hope that students/interns could be less afraid to
communicate that they need help and if possible what kind of help, as
I think it would improve the relationship and the outcome a lot.

What do you think mentors could do to make them more comfortable in
asking for help?

> 5. In the ideal world, I want to force all mentors to get special
> courses (it will solve problems 2-3-4). Great developer is not equal
> to great mentor. And, if you work with really newbie, it becomes so
> necessary.

I agree that mentors can and should improve but it's difficult to know
specifically how.

> I hope that was useful.

Yes, I think it can be very useful.

> In the end I want to say that there's no special requirements to
> involve people from unrepresented groups. I see no racism or sexism in
> mailing lists, my mentors were polite and friendly, I can't say
> anything bad here. Please keep this safe environment and explain your
> colleagues if you see something bad.

Thanks for the kind words and the encouragement.

> In my opinion, the problem is that Git is not friendly with newbies in
> general.

I very much agree.

> We do not have task tracker, regular mentors (without any
> special programs: just some developers that are ready to help with
> first patch).

About developers that are ready to help with first patch, I think
there are many people reviewing patches and they feel like they are
helping not just reviewing which I think is true. Most people try to
give constructive reviews.

Do you think we should kind of "tag" some experienced Git developers
as "regular mentors" to make it clear that they are willing to help
newcomers privately outside GSoC or Outreachy?

> The code is not structured properly, this is additional
> difficulty for newbie. This system with mailing lists and patches... I
> understand that it's not possible to make all processes perfect in one
> moment, but at least we need to help all newbies to solve all these
> problems in the beginning.

There are people trying to help on this, like Dscho with GitGitGadget,
Eric with public-inbox.org, but I agree we should try to do more.

Maybe we could also improve by:

- adding information for new comers (see above)
- making the build clearer about why it failed
- adding information somewhere about how to get help, how to ask for review=
s

> I guess that there are only 2 scenarios how to become Git developer.
> First one is internship. Second is to ask your colleague (who is Git
> developer) to help you.

Again I agree that it is very difficult for new comers (and even
sometimes for long time contributors).

> I don't want to speak on behalf of all women, but I guess many girls
> feel not confident enough to ask for such help. For me the only
> possibility to start was the internship.

Yeah, I think the confidence barrier is very big not just for women by the =
way.

> Some personal info: I am in the process of changing jobs. I wish I
> could help you with mentoring (not as a main mentor, maybe as a second
> or third one - my experience as an intern could be useful, I could
> help other interns to start),

That would be really great!

> but I can't predict my load. If you are
> interested in my help, please write me.

Thanks for this offer! And yeah I understand that it might not be a good ti=
me.

> And, by the way, please delete
> my task from list of internship tasks, I will finish it by myself just
> when I have some free time :)

Great! Yeah we will work on a new task list hopefully soon for the
next internship round.

Thanks a lot,
Christian.
