Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA681FE4E
	for <e@80x24.org>; Thu, 30 Jun 2016 23:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752547AbcF3XlS (ORCPT <rfc822;e@80x24.org>);
	Thu, 30 Jun 2016 19:41:18 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37593 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbcF3XlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2016 19:41:16 -0400
Received: by mail-wm0-f49.google.com with SMTP id a66so6799081wme.0
        for <git@vger.kernel.org>; Thu, 30 Jun 2016 16:39:31 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=K10pGXoxiY3iFHupqIcjv6t6F+2VGro0KIG/E6Ch8cw=;
        b=W0uQd3I9M4f4+dEAppBkJQDsIA4WJpqpUw5iKuB9gWsMHuK2Monj0XCZSMaYN7v5WK
         KsJWxLYi4gJbN/J5KEwARCMjobwgPjsQKTBPe2gRH+zM3DyMyHel2nFNuCJ4znwh/qLl
         NKrEDisbQ1MOFczEeXyjxSWz6dzA6/4a/8Y+MBW/GFqIax6kUFI6pYkQ8rztoqOYgeW2
         +MTTSWBaLtLQDEtZZU1OfIOADX4ucZfBZds5HQnOW/U9yDdxuK8XB9PW2vMZXFulNrWJ
         FqV9C2DF/kObVfLs3Ic2h6djHAzpr9DUX8CZgbISvSwd5Ggy1Iy5297wza0R0QMCEG5Y
         MoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=K10pGXoxiY3iFHupqIcjv6t6F+2VGro0KIG/E6Ch8cw=;
        b=b2w1nzRGjKFY+/LQmXhp3MHJdKthb4IgIA6YDoOLuAfICHH9wf5GtndZUlZqaewVaI
         XyIE+ufEzDDTk8AkprzrUxbnG2FG2WkOjsEijzBZNPBiHdhuLLJyh2OuubDGNqfs1OP0
         3ee9WaRcGK+4082hEecnV3fcQ6n6tHI7aP9TjiiPmlwmzzIZJsHaSHXp6Q+k+x/zUETr
         9hjfTMc++eao3pVRrvqO17jm55/CvVWz7B/M7a6W5ifhuklUycVBTBKMu+Jpqh3efYvP
         s2Kb/abVzdtSN5Cf/pmnkSLEVjFBSvdBAUMv4MbgMquLG6eYwt12pJacrzODXahn4n/N
         wP/w==
X-Gm-Message-State: ALyK8tLm9TJ7f6BNWEX4VOdYqoPOKuli6FFwMSwnVHZUufdN1eJEt4rDVVDrEGyQuJ/6jg==
X-Received: by 10.194.120.135 with SMTP id lc7mr596535wjb.42.1467329970614;
        Thu, 30 Jun 2016 16:39:30 -0700 (PDT)
Received: from [192.168.1.34] (enw201.neoplus.adsl.tpnet.pl. [83.20.12.201])
        by smtp.googlemail.com with ESMTPSA id a191sm6028933wme.5.2016.06.30.16.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2016 16:39:29 -0700 (PDT)
Subject: Re: topological index field for commit objects
To:	Linus Torvalds <torvalds@linux-foundation.org>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com>
 <20160629205647.GA25987@sigill.intra.peff.net> <5774426F.3090000@gmail.com>
 <20160629220049.GA4416@sigill.intra.peff.net> <5774F4C7.805@gmail.com>
 <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
Cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Marc Strapetz <marc.strapetz@syntevo.com>,
	Git Mailing List <git@vger.kernel.org>
Newsgroups: gmane.comp.version-control.git
From:	=?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <5775ADA0.3000906@gmail.com>
Date:	Fri, 1 Jul 2016 01:39:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFy2AEe7ew5Px=2Uit6hraGV9zFr=JZ57rSYXWMQ4nMjeg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

W dniu 2016-06-30 o 20:12, Linus Torvalds pisze:
> On Thu, Jun 30, 2016 at 3:30 AM, Jakub Narębski <jnareb@gmail.com> wrote:
>>
>> P.S. Having Git ensure that committerdate (as an epoch) is greater
>> than committerdates of its parents at the commit creation time (with
>> providing warning about time skew, perhaps not doing it if skew is
>> too large) would be not costly. No need to add anything, and it would
>> help future queries to be faster, I think.
> 
> So I think git should check the committer date (ie verify that the
> committer date of a new commit is always equal to or more recent than
> all the parents).
> 
> But we should probably allow some slop for when machines are out of
> sync (think build farms etc automation that may do automated commits,
> but the clocks on different machines may be off by a few seconds). We
> already do things like that in some of the use of committer dates -
> see for example CUTOFF_DATE_SLOP).

The problem with this idea is that the clock skew might be in two
directions, but it does fix/help only one.  If committer's clock
lags behind true time, the automatic bump to have committerdate of
a new commit be greater than committerdates of all its parent is quite
helpful.

However, if some developer has his or her clock misconfigured so that
it gives time in the future, this feature would not help.  Commits from
such developer (from such machine) would screw it up for others.

That's why I think some limit is needed.  For example, if for some
reason commit was created with committer date 3 days in the future,
we would probably do not want for other developers to have to lie
about when they created their commit.


Or did you mean that if the date for new commit is in the past
of committerdates of its parents, its all right when it is within
slop?

> 
> And we should probably allow the user to override the refusal to
> create new commits with bogus dates - think importing repositories etc
> where you may have reasons to just say "that's just how it was".

Right. I was thinking about (ab)using --no-verify flag, or perhaps
prompting user if the terminal is interactive. But perhaps a separate
flag / environment variable would be better...

> And it will take years for that to percolate out to all users, so it's
> not like it will fix things immediately, but then some time from now,
> we can consider commit dates to be more reliably generation numbers.
[...]

That's the idea of the proposal.

-- 
Jakub Narębski

