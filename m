Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 089171F453
	for <e@80x24.org>; Wed, 20 Feb 2019 22:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfBTWae (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Feb 2019 17:30:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39481 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfBTWad (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Feb 2019 17:30:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id z84so8008292wmg.4
        for <git@vger.kernel.org>; Wed, 20 Feb 2019 14:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LmAcCHnXs1wenn3Eo8ckc4I0pJ7XLLc27I0pPV/Odds=;
        b=VuWqi6khdc0b19LUpLUtoOgaTvoZWz2yYvKc9UTngQIKTboD2UXmS+m8gJmAhML+Q9
         TS+zK+x0QZ04GR+ore1DIkCTVDAEDd1L1M7S7L3yaWou4nA4NOhdZ6LRWqsWlAmyBqJ1
         m/4fIwtQ73KqBxeOzixFGQAcFMI3TI6DaWeVjIOmx8a82WIDrVgNqtkfbxTVTy2/xYhS
         fotxdsJ1tOFulw1rWEM+tHyqwtYSOl/l9l7k470dk6xm8GAzbMdVEDahGJ/yjUDZnRnQ
         NpVSLL3n6KMYgO4D6OUV+ob3eVwryglJTtNzTZAvCCM9+ylj3YLqfSf2NeKqJagKg9pE
         wH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LmAcCHnXs1wenn3Eo8ckc4I0pJ7XLLc27I0pPV/Odds=;
        b=mNM2rVPZIUXvlezlA1/flUnXMQJUo77FEou+4hpnEJhyD6Zjz+weAD8IGhmiSsOdRo
         bniO1Qkbpw5/9q2ricnrO9fnR4JVl6MbxarcgZpczEDGEVuHf0OmawWuEOW2AliZO6Ml
         9siBDPgib5RcwD4blZm0zk+WVVwkZRF4t2fzKUONJ3inNd22mgHhW7zLCVs3Xtg52IJ6
         5S3RhYdL8LM6zKS0WpoKWV1IVPNR5Zd0G/EhBduLdCaxyXPCXgdbGzYlcwIDCKsFzP2F
         nkhGY3LJbjPXZcn3qvGgWz0PgB0tf7cI7z704ai21amsMKlahWAgE9JPx9rbm3Nkr9UM
         5pWg==
X-Gm-Message-State: AHQUAuaWhF3RiR1b4lA9BUSu7zfOUXNl+dEHvV0gaZuAAxEoAciJcvx7
        MFmgO57qSy/PXFOV5F41reRHyys8
X-Google-Smtp-Source: AHgI3Iby5bLlH/VDJj1OI59BfHlnVIUBi12AYd/kwFFqg3m8V5SKdNMHB580VaRXVXBEE2n40gjBVg==
X-Received: by 2002:a1c:ce06:: with SMTP id e6mr8403970wmg.41.1550701831247;
        Wed, 20 Feb 2019 14:30:31 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id a74sm4766652wma.22.2019.02.20.14.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Feb 2019 14:30:29 -0800 (PST)
Date:   Wed, 20 Feb 2019 22:30:29 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v12 18/26] stash: convert push to builtin
Message-ID: <20190220223028.GN6085@hank.intra.tgummerer.com>
References: <cover.1545331726.git.ungureanupaulsebastian@gmail.com>
 <a6692eef2ca7c9d9e4701f087269d537248a4941.1545331726.git.ungureanupaulsebastian@gmail.com>
 <20190208113059.GV10587@szeder.dev>
 <20190210221712.GA9241@hank.intra.tgummerer.com>
 <20190211011306.GA31807@szeder.dev>
 <20190212231837.GI6085@hank.intra.tgummerer.com>
 <20190219002336.GN1622@szeder.dev>
 <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190219235913.GM6085@hank.intra.tgummerer.com>
 <xmqqmumrvzwk.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmumrvzwk.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/19, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> >> Now, I seriously believe that we missed the best time to move
> >> ps/stash-in-c into `next` for cooking. The best time would have been just
> >> ...
> >> Anyway, that's my plan for now.
> >
> > I must say I am not very happy about this plan.  The series has been
> > marked as "Will merge to 'next'" in previous iterations, but then we
> > found some issues that prevented that.  However I thought we were fine
> > fixing those on top at this point, rather than starting with a new
> > iteration again.
> 
> First before going into anything else, let me thank, and let me
> invite readers of this thread to join me thanking, Paul (Sebi) for
> sticking with this topic for this long.  It is above and beyond what
> GSoC calls for.

Indeed, thanks for all your work on this Paul-Sebastian!

> Having said that.
> 
> I too was somehow led to believe that the topic was in a good enough
> shape, with some room for clean-up by reordering the patches to make
> them into a more logical progression and squashing an existing and
> recently figured out "oops, that was wrong" fixes into the patches
> where the breakages originate.
> 
> And that was where the "Will merge to" originally came from.  Thanks
> to tools like range-diff, a topic that goes through such reordering
> and squashing of patches should not have to "waste" a lot of review
> cycles out of those who have seen the previous round.

Right, I had the impression that we were okay with doing the cleanups
on top of what is already in 'pu'.  Especially since the topic with
Johannes Sixt's patch on top was marked as "Will merge to 'next'" at
one point if I remember correctly.  I didn't think that it being in
'pu' vs. it being in 'next' would make too much of a difference there,
and that it's just a by-product of where in the development cycle we
are rather than an indication of which way we are taking the branch.

> It however is a totally different matter if the topic was so
> unsalvageable that it needs a total rewrite---that would need
> another round of careful review, of course, and it would be
> irresponsive to merge a topic in such a messy state to 'next'.  But
> my impression was that the topic was not _that_ bad, so Dscho's
> message and the plan were something that was totally unexpected to
> me, too..

Indeed, the topic did not get any worse over the time it was in 'pu',
indeed it got a couple of fixes on top.  And my impression was that
Dscho still would have wanted to get the topic merged to next much
earlier, so I don't quite understand what changed since then, other
than getting a few fixes on top.

> > I was always under the impression that once the problem that was
> > discovered here was fixed we'd advance the series to 'next' with the
> > patch that comes out of this discussion on top.  Whether it's in next
> > shortly before 2.21 or not doesn't seem to make much of a difference
> > to me, as this wasn't going to make the 2.21 release anyway.  My hope
> > was that we could get it into 'next' shortly after 2.21 is released to
> > get the series some further exposure (which may well turn up some
> > other issues that we are not aware of yet, but such is the life of
> > software).
> 
> I was hoping similar, but also was hoping that people would use the
> time wisely while waiting for the next cycle to polish the topic with
> reordering and squashing, so that it can hit 'next' early once the
> tree opens.

I'd be happy to do this myself, but as mentioned above I thought we
were okay with just having the patches on top, and leave the work
Paul-Sebastian sent until now as it was.  If that impression was wrong
I'm happy to put in some work to help with the cleanup.

> Anyway.
> 
> I actually have a different issue with this topic, though.  It is
> wonderful to see a GSoC student's continued involvement in the
> project, but it is not healthy that we need so much work on top of
> what was marked "done" at the end of the GSoC period.  Especially
> the impression I am getting for the post GSoC work of this topic is
> not "we are already done converting to built-in during GSoC, and now
> we are extending the command", but "we ran out of time during GSoC;
> here is what we would have seen at the end of GSoC in an ideal
> world."
> 
> I wonder if this is an unfortunate indication that our expectation
> is unrealistically high when we accept students' applications.
> Being overly ambitious is *not* students' fault, but those of us on
> the list, especially those who mentor, have far deeper experience
> with how our code and project is structured than any students do.
> We should be able to, and should not hesitate to, say things like
> "that's overly ambitious---for such and such, you'd need to even
> invent an internal API---can we reduce the scope and still produce a
> useful end result?"
> 
> One suggestion I have is to have success criteria (e.g. "gets merged
> to 'master' before GSoC ends" [*1*]) clearly spelled out in the
> application.  Something like that would help managing the
> expectation and biting way too much for a summer, I'd hope.

[Adding Christian and Olga to cc here as this discussion should be
interesting to them as well as GSoC mentors]

I think one thing we underestimated at least here is how long it takes
from "everything that we intended to do is done" to "this is reviewed
and ready to merge into 'next' and 'master'".  This is partly my fault
as well because it took me quite a while to review the series on the
list, which certainly didn't help in moving things along.

While having set criteria is a good idea, I think we should still give
some leeway to the mentors in terms of the actual success/fail rating
in the program.  Not getting things merged is definitely not a good
experience, but it would be much worse to not get it merged, and also
fail GSoC and not getting paid for the efforts over the summer.  We
shouldn't punish students for the failure of the mentors to estimate
projects correctly.

One thing we should do I think is to say the project should be
"complete" at least a month before the end of GSoC, and that the last
month should only be dedicated to polishing the patches.  I don't know
how to make sure the students still have enough work to do during that
last period while they are just waiting for reviewers.

An other alternative (just thinking out loud here) is to make sure the
project has a few deliverables that can and will be merged
individually, even if they later build on top of eachother.  This
would mean getting students to send multiple series, when the patches
may normally go better in a single series, but I think it would help
moving the review cycle along faster.

Dunno, maybe there are other alternatives that I'm missing as well.

>     Side note *1*.  Of course, depending on the alignment of the
>     stars ^W our ~10-12 week development cycle and the end of GSoC,
>     getting merged to 'master' might become impossible if it
>     coincides with the pre-release freeze period.  But we on the
>     list and the mentors know how the project works, and can help
>     stating a more realistic success criterion if the development
>     cycle and other quirks specific to this project gets in the way.
> 
> Thanks.
