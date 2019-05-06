Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936B81F45F
	for <e@80x24.org>; Mon,  6 May 2019 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbfEFQwY (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 May 2019 12:52:24 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33600 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFQwX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 May 2019 12:52:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id s18so5615812wmh.0
        for <git@vger.kernel.org>; Mon, 06 May 2019 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=jyvSZ7GOrIbr5o4/fQAWTZTlJMTewhnwH0JDXagvgP8=;
        b=D1dUM3Q1ivjROHlCn3CmYRqsAodXVqAz2RfEOl8yjIoB48tr9AnDmoYXwPj5Xko0t0
         3SxOS4TJGP0q6xqKDCH96+sZiQx0k0pWCZhXjwYPd/L0ejprxVpjobCf9eB0EZ1zuR1K
         6edMF/5dm2SO7Rs/8M2zmIj95Ax7Pft/0ohn6Efkew3swQU69j/qg8uOsh/mAs0mXTbF
         Z2gSJ3MDyviu+XVm6SXyGv8JFH0S2e5kgFGWEeEKzm/9ctq++tuCMJzsTcgM532D+XcH
         UsVRo03WWxcJFoVqcvUmiyz27dCldzQZex9PRnh7zq542yWVoyijqbOYaBJmwumBZfSP
         5feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=jyvSZ7GOrIbr5o4/fQAWTZTlJMTewhnwH0JDXagvgP8=;
        b=l0DHhpo7JSRWMhk/pRTGp7FnNSb56XBJoTLbPVLfkPWT3zpH6ZgzerXPiwb9+NCCRz
         w8qlzK3sJN8C+WZgn12hrExa5chW+mkvZBDdVDFZcAxpfz9zmLZxUahqMjIjClMRYfuL
         weeDVihDyeOXFPjDT9+19LXx2lF/XglaHYv4zQnx5N1J/No5bEbpXr4CmDzjjLImoysN
         GFBpmm0wEU/l40QwUTwVKcmCHUVgIM+n3GjOksuWR+d7PPT5lNdTgJn4aetyyszvzlWZ
         s74WjsXt6jdshKNpzh3tuiw9Rp3/omDgMzwfWDxiu6KiJWtHOjM3peoI3xvgyTchQtaT
         TCBg==
X-Gm-Message-State: APjAAAVjEIRRHoELhB2y1Wh+unmVwuBZ1His3rpHkjPSsEiCKGsD+760
        qbm0fdPfJII4fY7uklAMbgjC5Zr5
X-Google-Smtp-Source: APXvYqyhRWbdOh7SlcX/aGWHDGEu9wRZj5/yx1kt8tbYyA0B3n8c93q00ZL2ARUAMLo1cbbsTYuaaw==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr3731195wmj.24.1557161540892;
        Mon, 06 May 2019 09:52:20 -0700 (PDT)
Received: from esm (ipbcc038b1.dynamic.kabel-deutschland.de. [188.192.56.177])
        by smtp.gmail.com with ESMTPSA id l127sm11895037wml.40.2019.05.06.09.52.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:52:20 -0700 (PDT)
From:   "Eckhard =?iso-8859-1?Q?Maa=DF?=" <eckhard.s.maass@googlemail.com>
X-Google-Original-From: Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@gmail.com>
Date:   Mon, 6 May 2019 18:52:18 +0200
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Eckhard =?iso-8859-1?Q?Maa=DF?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
Subject: Re: Merge commit diff results are confusing and inconsistent
Message-ID: <20190506165218.GA21965@esm>
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm>
 <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 06, 2019 at 10:38:12AM -0500, Robert Dailey wrote:
> I feel like you got hung up too much on exact wording of what I was
> trying to describe. I do apologize I don't have the background to
> explain things 100% accurately, especially at a low level. My
> explanations are mostly intended to be as a user, based on what is
> observable, and based on intent. I'll clarify in the quotes below...

I doubt that what is observable is what you described.

> 
> On Fri, May 3, 2019 at 2:12 PM Eckhard Maaß
> <eckhard.s.maass@googlemail.com> wrote:
> > Hold on. Basically, there is no such thing as "committed directly" for a
> > merge. You only have differences of the commit to its parents. What you
> > aim for are changes that you cannot find in either preimage - and this
> > can be observed best with the --cc option. Maybe also interesting would
> > be -c for showing a comined diff and -m for showing diffs to parents
> > after one another.
> 
> "Committed directly" here means that I made some changes, none of
> which is part of a parent commit.

The merge strategy does the same when melding two versions of a file
into one. If one invents a more clever merge strategy, it might appear
that you have "some changes". This is not a mere technicality - you
cannot make a difference between parts that were conflicts in the
original commit and changes you introduced yourself - short of making
the merge again.

> Since no additional commits were
> made following the merge, I assume that within the merge commit is
> some type of diff. If I perform a merge, make some changes, and amend
> those changes into the merge, in mind they ARE contained in that merge
> commit. The underlying machinery doesn't matter here: This is the
> observable state to the user.

Well, they are contained in the merge commit, true. And they would show
in the diffs to the two parents.

> Maybe the machinery, which I have no knowledge of or transparency
> into, is important because it is affecting the behavior I'm seeing
> when I do the diffs? Not sure...
> 
> > There shouldn't be "just the diff of <commit>" - you always have to tell
> > where to diff it too, intrinsically Git does not save patches, but the
> > whole content, after all.
> 
> I do understand this. But again, I'm not trying to be super technical
> here. In plain english, all I'm trying to say is that I want to see
> the changes that 1 commit introduces into the code base.

I do not understand - I especially reiterated on the fundamental design
decision of Git here that one cannot speak of *the* change. This is not
just some small technical detail.

With a merge commit, there is no such thing as "*the change* introduced
into the code base". You can view it a few different ways:

- the content of the merge commit as a whole. However, this is not
  really a change, but the whole content.

- the diff to one of its parents. If you merge a feature branch to
  master, then git diff master^..master does give you the changes
  introduced in master by the merge (given that merge^ is the state
  beforehand)

- all the diffs (or condensed forms) to all parent commits. --cc helps
  you here by ignoring "uninteresting" hunks.

> So when it
> comes to communicating the end result I want, I talk about it in terms
> of 1 commit (the merge commit). The means to get that output is part
> of my question and overall confusion. But as a baseline, I want to
> clarify that I do understand a range is required input for the diff
> command. In the case of merge commits, the way you specify the ranges
> has many forms so I'm not sure based on the results I see, which one
> is correct or what they all mean.

I doubt that the intentions of the revision short hands you gave have
should have some meaningful transition to the diff machinery. For me,
here some technicality strikes and gives results which are
counterintuitive to me - for me, all your calls should result in errors.

> 
> > Somebody else might know better why the diff actually produced the
> > results you were looking for. I admit it is puzzling to me - I would
> > have expected to error it out on the output of git rev-parse as there
> > are three items.
> 
> Actually I can't think of any other command that can show me what
> revision ranges translate to in "raw" commits. To me the raw forms are
> always <sha1> and ^<sha1>, repeated as many times and in as many
> orders necessary. Don't all of the vanity revision specifications
> ultimately boil down to "from this parent" and "not from this parent"?

This seems to be very wrong for calculating a diff - you nee exactly to
points to compare. So it is always a "from one" and "to one".

Greetings,
Eckhard
