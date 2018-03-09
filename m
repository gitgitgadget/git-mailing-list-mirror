Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243851F404
	for <e@80x24.org>; Fri,  9 Mar 2018 17:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932070AbeCIRRC (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 12:17:02 -0500
Received: from mail-ot0-f179.google.com ([74.125.82.179]:43224 "EHLO
        mail-ot0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751184AbeCIRRC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 12:17:02 -0500
Received: by mail-ot0-f179.google.com with SMTP id m22so9319178otf.10
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 09:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=JFF8tIcvY+cKDdAuB/wY7zE/SGyMD8dhGqT8Qx0wGe4=;
        b=WYRQG2cuC2TCmuKyQtKhLpIHFqDz1tYV2DO/9yFeyoBD7VQjm6XPzfy+GI+RXAkIbu
         WJgrwXSG9xKiL+UK9Z/ySsQBoaJayCcB9jeIDsh662Q/YE8GAwtR5VJXXPy8YQnyAA0f
         OTCTpjKA2lYzA5kmJweFSSm2WRfFbeWTQ+HQL5M/q1kXqMroRcVkBaq6j9x7/4SZ3OGX
         JSq/lOLvrLrFKbcQNc9PeU+SS0B3S9Axe6UC8+jPdWP+jdFCifqHQTG3UDRqdC0+82Vs
         WrGIRfALHmAWnZT+Hp/VdJWYYfK09RKPxukHP+DN/CMntZQiiSFzTjNQuG8ANshB5D1T
         ZbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=JFF8tIcvY+cKDdAuB/wY7zE/SGyMD8dhGqT8Qx0wGe4=;
        b=Y0bcCqnnvobLGtV5vgWlAdwCsuXZKaaWzbhkQtmQbIpHb+dSSrzQf06DrmBoGsWHYF
         T8QOK7PlAjvhFhoyasgaPQN6MgcoyGh2MoB2swKWM4BCkmWhsn9JLwn59yuoAAjhL/c3
         +GehjQ+yVdp5hXHjJ4/V9kflR5FxXRkNxdNb7BgeDapaDX3PBnMfYMIHhU7ktOisYq/O
         5876Rq+Kc9NwgYYHaH8xvqyBlwG58lJld9/eqQk1alDGjrskOrzXSLRC3lkJkeUWiG/A
         D31fb8cVw7PslqWVd5x4l8eptK2V5JJCaKJ0uvUGk2WSeJWlUeEEJ7LzyFz8k+mxj7wc
         2xng==
X-Gm-Message-State: AElRT7GIS1sZAoCknfVhmz/UT34CDps3grsrZSyVCzLlsBG9qXFOL5oh
        tkMhd1nVnHaItYbMI0cKHeuOmXQjmPVAPXuq9rQ1YFvV
X-Google-Smtp-Source: AG47ELscz3ldw5AgIv1azw3TuA7Rus8I+qM77i+e2xo8uoPdGe1ecweC/PR/IFnh1F/2nDmLynKfFFrQ9Tp3YAcEffU=
X-Received: by 10.157.46.193 with SMTP id w59mr15881734ota.231.1520615821109;
 Fri, 09 Mar 2018 09:17:01 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.52.162 with HTTP; Fri, 9 Mar 2018 09:17:00 -0800 (PST)
In-Reply-To: <1520601834.2474.27.camel@hellion.org.uk>
References: <P56D58$52E406B139FE9D3C295CB5ABAB5C8893@locati.it>
 <87zi3inckw.fsf@evledraar.gmail.com> <1520502026.23648.29.camel@hellion.org.uk>
 <CAGen01hYG40jKQSu7ZJpb8TXROC74NfVXVT82wNjYqx1yKYD=w@mail.gmail.com> <1520601834.2474.27.camel@hellion.org.uk>
From:   Michele Locati <michele@locati.it>
Date:   Fri, 9 Mar 2018 18:17:00 +0100
X-Google-Sender-Auth: O-OwLK4YZPxyiN06IWhgj85C3wA
Message-ID: <CAGen01iRQgxibxmc88ogvgk2_gq-DNNdHMs1N+BfoM5rwWasqA@mail.gmail.com>
Subject: Re: How to use filter-branch with --state-branch?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2018-03-09 14:23 GMT+01:00 Ian Campbell <ijc@hellion.org.uk>:
> On Fri, 2018-03-09 at 14:04 +0100, Michele Locati wrote:
>> Just a couple of questions:
>>
>> 1. it seems to me it's not possible to process all the branches in one
>> go. Am I right?
>
> I'm not sure, I've never done such a thing, in fact I didn't know you
> could.
>
> Really all this feature does is record the `.git/rewrite-map` (or
> whatever the correct name is) at the end of the rewrite and reinstate
> it again the next time, so it shouldn't really interact with many of
> the other options.
>
> My method for storeing "last version processed" in a branch does
> conflict I suppose (since that branch would be rewritten) but that's an
> artefact of the surrounding scaffolding -- you could equally well keep
> the record in some file on the local system or in a non-branch-ish ref
> (I guess).
>
>> 2. Why do you have this line in filter.sh?
>> `rm -f .git/refs/original/refs/heads/${UPSTREAM_REWRITTEN}`
>
> TBH I'm not really sure. I originally wrote this patch many years ago,
> it's just recently that I got around to upstreaming, so my memory is
> more fuzzy than might be expected.
>
> I think perhaps I was trying to avoid this error:
>
>     A previous backup already exists in $orig_namespace
>     Force overwriting the backup with -f"
>
> which comes if there is an existing backup (a safety feature in the
> non-incremental case).
>
> Note quite sure why I didn't use `-f` as the message says, but I guess
> because it forces other things too which I didn't want to do?
>
> Perhaps what I should have done is make that check conditional on the
> use of --state-branch.
>
> I wonder if you could use the `original/refs/...` as the "last version
> processed"? Would be a lot less manual messing around than what I do!
>
> Ian.


I managed to get a general script that seems to work: see
https://github.com/mlocati/incremental-git-filter-branch

Thanks again, Ian.

--
Michele
