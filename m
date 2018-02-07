Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BBF61F404
	for <e@80x24.org>; Wed,  7 Feb 2018 12:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753781AbeBGMIS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 07:08:18 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:36972 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753539AbeBGMIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 07:08:17 -0500
Received: by mail-ot0-f180.google.com with SMTP id e64so571908ote.4
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 04:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=I3e6x5H4+k9qXgJY5c4LH8JysiYi/KLQGGpJoLqPmZg=;
        b=OKpLmihDZ2NTN3bA0hUAUPMVG8hrylytVH807lt/CVCNabo6fxbzC/kc9aH16kbJZg
         Ehcx/Mq6qQ4/U0lfznvjKcoZUCBGw71fh/owpJRVfsF12QvCVarMjpWrHRF7kDY2M8m9
         8En3rq0eqEQspGrNRDSKbIVz8aXhyuk+uMb84REIu3hi0z7MWaMLQU6HWUn4wMLsURbA
         G15SGbuqKUuQkowq/MCJG36FZ+0+mO1dPTnf4Y70i4gnSCPvld/Vcz1HyQ5Q6dOnCXhk
         JaM3Hhw3nv/q52myL/5n4TZN+cCAGiitDaiPXcNSfvjVsmRXUNHZkW03mJn+4Z/WR6HH
         l/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=I3e6x5H4+k9qXgJY5c4LH8JysiYi/KLQGGpJoLqPmZg=;
        b=BJqPfOh6hMbowTYhmo9CZmgglpJaP8XCO0WLfC2AVaaZLa6KTyn2aYndU6pvQnI9oN
         z6NfxPjVCl4/BrfUgq9Nqw0I+1DJo5+m0MG7nilwJiumlW9eZGET89SMywuCyPoAYPU7
         E2tW/ja2+/zZ8G89vgZnMB8T2bp3yZL7eGvTTOqRdvtu12hSxwCAnWsiZAjgE6Sxfe8y
         GRWEIAtkZOX0jMYPd4WOLIswnmpsF7osrmykl5LVi4OI+jRVKtyAD6ImX+QarQwh03s+
         UFbcm9DyRCSxrj1JHJ5TmSN0fjKQumal4msVQPn8pCHOzo9Gf0PrA46FllznGg9iMJfH
         5/+A==
X-Gm-Message-State: APf1xPB9/tUdbVoCgqdk4YOvwHrohF6khvNJpJYm3n/zWmPshP0RlzTc
        SiDq5gxn/Bqj1jsZrqVok80zNW1i/M/N5fR6QUw=
X-Google-Smtp-Source: AH8x224N8s8Bd/tz2RNrSMUf8u3yhqyN8rA0PwOvyLpMh065HryFoxizLQaNyPsIZYPenkYjAPmV53IFsOrBlN/fnSk=
X-Received: by 10.157.64.140 with SMTP id n12mr4321929ote.151.1518005296794;
 Wed, 07 Feb 2018 04:08:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Wed, 7 Feb 2018 04:07:46 -0800 (PST)
In-Reply-To: <alpine.LFD.2.21.1802070656020.11183@android-a172fe96dd584b41>
References: <alpine.LFD.2.21.1802070547040.5530@android-a172fe96dd584b41>
 <CACsJy8Dt_TjfRk05oNW8DXrdn6s_QV8NQZKnnrgGkj3WTN_=3A@mail.gmail.com>
 <alpine.LFD.2.21.1802070637190.7359@android-a172fe96dd584b41>
 <CACsJy8CWkjoFvDmB_EEvrJR=4snFqnVGUKvo_vR33asOXB3CWw@mail.gmail.com> <alpine.LFD.2.21.1802070656020.11183@android-a172fe96dd584b41>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Feb 2018 19:07:46 +0700
Message-ID: <CACsJy8Ay4CUF6=R=eay-QTETQMLLP1wjYH=cysO3XXsLv=41bw@mail.gmail.com>
Subject: Re: is http://git-scm.com an *official* git-affiliated site?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 7, 2018 at 6:58 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> On Wed, 7 Feb 2018, Duy Nguyen wrote:
>
>> On Wed, Feb 7, 2018 at 6:41 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> > On Wed, 7 Feb 2018, Duy Nguyen wrote:
>> >
>> >> On Wed, Feb 7, 2018 at 5:54 PM, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>> >> >
>> >> >   i ask WRT whether it should be up to date. i'm currently writing a
>> >> > number of git-related wiki pages, and i want to link to whatever are
>> >> > the canonical man pages for various git commands,
>> >>
>> >> I think this one is updated often by Junio (Git maintainer)
>> >>
>> >> https://www.kernel.org/pub/software/scm/git/docs/
>> >
>> >   whoops, just noticed that there is still no entry for "git subtree"
>> > there; is there something about that git command that makes it so hard
>> > to track down? :-)
>>
>> git-subtree is not an official command, so it's not there.
>
>   i'm going to push back a bit on that since, at the bottom of the man
> page for git-subtree, it states:
>
>   GIT
>        Part of the git(1) suite
>
> so either it's part of the git suite, or it isn't.

It's a template that people use when write document for new commands.
That part should be deleted, I guess, if it's that confusing.
-- 
Duy
