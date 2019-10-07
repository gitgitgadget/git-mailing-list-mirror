Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48B711F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 10:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbfJGKqb (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 06:46:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45386 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfJGKqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 06:46:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id r134so8874158lff.12
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 03:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+cvZ4wKdwDkEplEOUZ6ERtFeKYIzfZ+SV15+1btv+8o=;
        b=eWXBQ6xa59aP8IEpnwN2ZXiNYSpJp4KdFn2tD7muo1TjQz43vUbH6XIY6CU7JzkM3C
         IHtVIZjZOf7y6uT30fzLPYpQVEO9jMhTdhbn1mWznpYd+uPGW+SshzYmWz+L2xY3DyL2
         AdxYfEDlxG5qr3eqI03kxRg/Xt6c5WMxInLwYAzYwc0xH4Ylfa3BfQm6ZvNsFLxKukcz
         yko2xim43iNYIpI2+039PgUo+EuwvPQJTJ9hZECvTq2q/r32TSxJseIhANl7rP6/RvFO
         IcNLkYHJUdhwAw1gEYajNR6p6BZJGEW091c3OAQ8jF4uizs83lx8dGMgOPeb4v6n2Adx
         bQ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+cvZ4wKdwDkEplEOUZ6ERtFeKYIzfZ+SV15+1btv+8o=;
        b=iXyHuOmkCOocDCkHY6fTOZuzFXCeCLxOI64srtPXws3JB93kIxLEuzMw09OQyC9dHF
         3y/+sbqD0ev/pIwQE5dey3LuBGgLIYMrcMxSm8ckuM026+zjfpw2YoYPH6lvejZmrT5b
         3n05tLdIV3t2/dJ06DMqvwEmbSLH/De2QM1J/K1FMMmMLbrbuDTIg2GsIQw115NmxhtN
         hhTJabGfFk8phYzua0T0RbGVbhJDTcifmLwx8IcoZAVdZ5a5fRtpoGbWLtaAybf2L1Dr
         +Lj/ONJpHyt9xS6bFEImqnStP8yxAeIJlWZz7hlDJnBPmb6JPCfbzx3XOuY7ruVt2mul
         Vlpw==
X-Gm-Message-State: APjAAAWQp19GwkbW2Z18Ya4BwNJ9AcmVVCynK6qPKvf6Cei8qZLz56kP
        83Gwq6+6P6EOlBcEuxE4Gf/A7qxvzhlFy/pKM/s=
X-Google-Smtp-Source: APXvYqyjbZTIszFuFfMI2YFg4iP972DOZQn6t8i8IOEptZ/eTA/pCiQ3IrbJxEx+LAMfdhqX1SJnYaUZ0Vn6u3j8rnE=
X-Received: by 2002:ac2:5445:: with SMTP id d5mr16058853lfn.43.1570445188237;
 Mon, 07 Oct 2019 03:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <CACV9s2MFiikZWq=s8kYQ+qwidQ=oO-SHyKWAs4MUkNcgDhJzeg@mail.gmail.com>
 <CACV9s2MQCP04QASgt0xhi3cSNPSKjwXTufxmZQXAUNvnWD9DSw@mail.gmail.com>
 <20191003214422.d4nocrxadxt47smg@yadavpratyush.com> <nycvar.QRO.7.76.6.1910041046000.46@tvgsbejvaqbjf.bet>
 <20191004120107.kpskplwhflnsamwu@yadavpratyush.com> <149a83fd40b71896b134b16c2b499ff472c6234e.camel@gmail.com>
 <20191005210127.uinrgazj5ezyqftj@yadavpratyush.com> <nycvar.QRO.7.76.6.1910061054470.46@tvgsbejvaqbjf.bet>
 <20191006183948.5n23sdy2l4uwl6kb@yadavpratyush.com> <nycvar.QRO.7.76.6.1910062208460.46@tvgsbejvaqbjf.bet>
 <20191006210647.wfjr7lhw5fxs4bin@yadavpratyush.com> <nycvar.QRO.7.76.6.1910071101590.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910071101590.46@tvgsbejvaqbjf.bet>
From:   Birger Skogeng Pedersen <birgersp@gmail.com>
Date:   Mon, 7 Oct 2019 12:43:30 +0200
Message-ID: <CAGr--=JpC88+Bnc233aJRe1XDgPzZxThxHQShoDobBA6hcYChQ@mail.gmail.com>
Subject: Re: GitGUIGadget, was Re: [PATCH] Feature: custom guitool commands
 can now have custom keyboard shortcuts
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Harish Karumuthil <harish2704@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems this topic has kindof derailed(?). But I feel like voicing my
opinion nonetheless.

I have to say I absolutely agree with Johannes Schindelin here. I
would really prefer a more modern way of contributing to this project
(any software project, really) than using emails. Be that Github,
Gitlab, bitbucket or whatever else.

But no it's not *impossible* to learn how to send patches by email.
But IMO it is a less efficient way to develop and maintain an open
source project. If getting more people interested in contributing,
there is no doubt in my mind that using Github would be better.

My biggest gripe with not using Github is how to keep track of replies
(comments) to a topic. I have to navigate through multiple emails to
get and overview of what everyone has been saying, when it should just
be a single collection of replies from everyone (like in a Github
issue). Where each issue has their own thread, and they can be linked
to each other or to PRs.


Just felt like chiming in,
Birger

On Mon, Oct 7, 2019 at 11:21 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Pratyush,
>
> On Mon, 7 Oct 2019, Pratyush Yadav wrote:
>
> > On 06/10/19 10:27PM, Johannes Schindelin wrote:
> > >
> > > On Mon, 7 Oct 2019, Pratyush Yadav wrote:
> > >
> > > > On 06/10/19 11:49AM, Johannes Schindelin wrote:
> > > > >
> > > > > On Sun, 6 Oct 2019, Pratyush Yadav wrote:
> > > > >
> > > > > > On 06/10/19 01:46AM, Harish Karumuthil wrote:
> > > > > > >
> > > > > > > From
> > > > > > > https://www.kernel.org/doc/html/v4.10/process/email-clients.html,
> > > > > > > I understood that, my current email client ( that is gmail
> > > > > > > web ) is not good for submitting patches. So I was tying to
> > > > > > > setup a mail client which is compatible with `git
> > > > > > > send-mail`. But I was not able to get a satisfactory result
> > > > > > > in that.
> > > > > >
> > > > > > You don't need to "set up" an email client with
> > > > > > git-send-email.  git-send-email is an email client itself.
> > > > > > Well, one which can only send emails.
> > > > >
> > > > > It also cannot reply to mails on the mailing list.
> > > > >
> > > > > It cannot even notify you when anybody replied to your patch.
> > > > >
> > > > > Two rather problematic aspects when it comes to patch
> > > > > contributions: how are you supposed to work with the reviewers
> > > > > when you lack all the tools to _interact_ with them? All `git
> > > > > send-email` provides is a "fire and forget" way to send patches,
> > > > > i.e. it encourages a monologue, when you want to start a
> > > > > dialogue instead.
> > > >
> > > > Well, I started with email based patch contribution when I was
> > > > first got started with open source, so I might be a bit biased,
> > > > but in my experience, it is not that difficult to set all these
> > > > things up. Most of the time, all you need to tell git-send-email
> > > > is your SMTP server, username, and password. All pretty easy
> > > > things to do.
> > >
> > > Okay, set it up with a corporate Exchange server.
> > >
> > > I'll be waiting right here.
> >
> > I admit, I've never had to do that. And by how you word it, hope I
> > never have to do it in the future either.
>
> And I hope that you make peace with the fact that you prevent any
> corporate developer from contributing easily.
>
> > > > And you add in your email client (which pretty much everyone
> > > > should have), and it is a complete setup. I personally use neomutt
> > > > as my email client, but I have used Thunderbird before, and it is
> > > > really easy to set it up to send plain text emails. All you need
> > > > to do is hold Shift before hitting reply, and you're in plain text
> > > > mode. And you can even make it use plain text by default by
> > > > flipping a switch in the settings.
> > >
> > > How intuitive. And of course Thunderbird still messes up the patches
> > > so that they won't apply, unless you *checks notes* do things that
> > > are quite involved or *checks notes* do other things that are quite
> > > involved.
> >
> > Ha! Made me chuckle. You got me there :). I suppose it isn't _that_
> > simple and I'm just biased because I am so used to it.
>
> I assumed that you were comfortable with it, and a bit oblivious about
> the hurdle that this represents to the majority of potential
> contributors.
>
> Remember, one of the beautiful things GitHub has given the world _on
> top_ of Git is how easy one-off contributions are.
>
> > > > So while I agree with you that there is certainly a learning curve
> > > > involved, I don't think it is all too bad. But again, that is all my
> > > > personal opinion, and nothing based on facts or data.
> > >
> > > Let me provide you with some data, then. Granted, it's not necessarily
> > > all Git GUI, but it includes Git GUI patches, too: Git for Windows'
> > > contributions.
> > >
> > > As should be well-known, I try to follow Postel's Law when it comes to
> > > Git for Windows' patches: be lenient in the input, strict in the output.
> > > As such, I don't force contributors to use GitHub PRs (although that is
> > > certainly encouraged by virtue of Git for Windows' source code being
> > > hosted on GitHub), or send patches, or send pull requests to their own
> > > public repositories or bundles sent to the mailing list. I accept them
> > > all. At least that is the idea.
> > >
> > > I cannot tell you how many contributions came in via GitHub PRs. I can
> > > tell precisely you how many contributions were made _not_ using GitHub
> > > PRs. One one hand. Actually, on zero hands.
> > >
> > > So clearly, at least Git for Windows' contributors (including some who
> > > provided Git GUI patches) are much more comfortable with the PR workflow
> > > than with the mailing list-based workflow.
> >
> > I never said email is better that GitHub PRs. It isn't. My point was
> > that using email isn't _that_ hard. When I first did it, it maybe took
> > me 3-4 hours to figure everything out, and then I was set forever. I
> > carry around the same '.gitconfig' file to all my setups, and everything
> > "just works".
> >
> > So yes, GitHub PRs are certainly easier, but email wasn't too difficult
> > in my experience. But then I'm a kernel developer, so I'm a minority to
> > begin with.
> >
> > I suspect you've had this debate more than once, because you come in
> > guns blazing ;)
>
> I come in guns blazing because these obstacles that are put in the way
> of contributors are the opposite of what I consider inclusive and
> welcoming.
>
> The fact that I am blessed with a lot of privilege (which, let's face
> it, I did nothing to earn) does not mean that I want to discount those
> who do not have that privilege. I have the time to contribute to Open
> Source, which is a privilege. I have the education to do so, with is a
> privilege. I even have the time to struggle with a mailing list-based
> code contribution process, which is a privilege I imagine only
> preciously few people enjoy.
>
> So I work as hard as I can against obstacles that are essentially big
> "Keep Out" signs (or, if you will, a big middle finger) to contributors
> without these privileges.
>
> > > > [... talking about GitGitGadget...]
> > > >
> > > > One  feature that would make it complete would be the ability to
> > > > reply to review comments.
> > >
> > > And how would that work, exactly? How to determine *which* email to
> > > respond to? *Which* person to reply to? *What* to quote?
> >
> > GGG already shows replies to the patches as a comment.
>
> Yes.
>
> (I know, I implemented this.)
>
> > On GitHub you can "Quote reply" a comment, which quotes the entire
> > comment just like your MUA would.
>
> On GitHub, you can also select part of the comment and press the `r`
> key, which results in the equivalent of what I am doing right here:
> quoting part of your mail and responding to just that part.
>
> You can also just reply without quoting.
>
> These are three ways to reply to comments on GitHub, and in my
> experience the rarest form is the full quote, the most common form is
> the "no quote" form. (Which makes sense because you already have
> everything in that UI, you don't need to quote unless you need to make a
> point about only a certain part of what you are replying to, and only if
> that point might be otherwise missed.)
>
> Something I also saw often enough is to accumulate quotes from multiple
> comments in the same reply.
>
> > Then you can write your reply there, and the last line would be
> > '/reply', which would make GGG send that email as a reply. You would
> > need to strip the first line from the reply because GGG starts the
> > reply with something like:
> >
> >   > [On the Git mailing
> >   > list](https://public-inbox.org/git/xmqq7e5l9zb1.fsf@gitster-ct.c.googlers.com),
> >   > Junio C Hamano wrote ([reply to
> >   > this](https://github.com/gitgitgadget/gitgitgadget/wiki/ReplyToThis)):
> >
> > GGG also adds 3 backticks before and after the reply content, so those
> > would need to be removed too.
>
> Apart from the problems to identify the correct mail to reply to
> (unless, as you suggested, the Message-ID is part of the quoted part by
> virtue of including that public-inbox URL), I think it would make it
> cumbersome to require the `/reply` command. Quite honestly, I would
> prefer it if GitGitGadget would simply send replies whenever it can
> figure out to who to send, and which Message-ID to reply to.
>
> > > > This would remove the need for an email client (almost)
> > > > completely. I have never written Typescript or used Azure
> > > > pipelines ever, but I can try tinkering around to see if I can
> > > > figure out how to do something like that. Unless, of course, you
> > > > or someone else is already doing it.  If not, some pointers would
> > > > be appreciated.
> > >
> > > Feel free to give this challenge a try.
> >
> > The first challenge is learning Typescript :)
>
> I learned Typescript to implement GitGitGadget. It maybe took me 3-4
> hours to figure everything out, and then I was set forever. :-P
>
> Ciao,
> Johannes
