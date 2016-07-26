Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85522203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757281AbcGZUoK (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:44:10 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37756 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550AbcGZUoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:44:09 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so33479668wmg.0
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 13:44:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=64xdusaCzD1ewPtUHrHsjj+wax+01nlp4IMKVYWm40E=;
        b=x2VahPmyobygdW54KZflrWwwzss6cJ/8XrsCU8/ecJEJ1IsE+RqPyMieeBgCSFzLy4
         MJ2vdNFdjkuGCU7fClrXjOy4PRfmF8P8AI4CCzjbrtxaka0oueMOKRHjo2pknZUSx2tx
         eH7AI6eW6GtlrIIRh0Rq/DPc9rmYoB/C7NOmygBNdmVtf7bH4Pj4wcws0nEDXNlFjfzs
         6OiZs9A7JWOQ2y/Nyu/z8zX3ofYU2qzaLH60BddP7AseFL6gaz02yDYpiD8nGl3DBj6s
         H3aieTNLwjwEk2YaHswQyganpcBpcY6ZtlBBlIVG++ajhScDPWp2x4WXsIjNhF+LCaFX
         2h3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=64xdusaCzD1ewPtUHrHsjj+wax+01nlp4IMKVYWm40E=;
        b=fcWq+Skc0FtjsebEAztRt+UO6NO95QyeXh9YBzycHGtJ7DU777JqSuMwd4IRh6v4Bh
         smoWK41a5+oGw0fIU9BDcljCUM0lKsf9Go0ESvEuxtpZXgEh8axFwCtetsxz7QfiLTL6
         PKZZLNxaIIbvYv95GO/iw9tDJXvvc6CBKIU1Ve2MDvYpdt8gFt94H6ry9VJJBjYMWReq
         hzqGJfs3t6/PIctPIBWLwMavI1oDRytx35C9YuSIfCAO8CnBgQS/SP0s3eM4yLdy3SzC
         KEcK0xQ8CSTBFUCdD1WNwqTdu9fCSAlLppGuckohGfDpl2iP0bcYw9DgWKMXIkkRQXdY
         NN3A==
X-Gm-Message-State: AEkooutqXJhEdyeUa6uS+e+VBWkbD5qgl+hvVjD4tZEsH5gEcWGhra3J5ttgndF3Evp2iTCahZVGeWK/OJEuNw==
X-Received: by 10.194.95.105 with SMTP id dj9mr22961190wjb.20.1469565847592;
 Tue, 26 Jul 2016 13:44:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.154.134 with HTTP; Tue, 26 Jul 2016 13:44:06 -0700 (PDT)
In-Reply-To: <20160726203041.GA4675@sigill.intra.peff.net>
References: <CAH8BJxGZW8eNQogksZ416sVaBkpQ78uYkV7FtN6wxGafzNwjAg@mail.gmail.com>
 <CAGZ79kaop1HB4tQAKxOcq8ZNEc+6VMPB1suwA9jra2BoXc27cw@mail.gmail.com> <20160726203041.GA4675@sigill.intra.peff.net>
From:	Stephen Morton <stephen.c.morton@gmail.com>
Date:	Tue, 26 Jul 2016 16:44:06 -0400
Message-ID: <CAH8BJxH0_RhmDaHWBkFg6QP7WWucUtPSQfsAemdVWkTzN42MPw@mail.gmail.com>
Subject: Re: git cherry-pick conflict error message is deceptive when
 cherry-picking multiple commits
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 4:30 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 26, 2016 at 01:18:55PM -0700, Stefan Beller wrote:
>
>> > Would it be possible to expand the hint message to tell users to run
>> > 'git cherry-pick --continue'
>>
>> Instead of expanding I'd go for replacing?
>>
>> I'd say the user is tempted for 2 choices,
>> a) aborting (for various reasons)
>> b) fix and continue.
>
> Yeah, I'd agree with this.
>
> I think that advice comes from a time when you could only cherry-pick a
> single commit. These days you can do several in a single run, and that's
> why "git cherry-pick --continue" was invented.
>
> So I think we would need to make sure that the "cherry-pick --continue"
> advice applies in both cases (and that we do not need to give different
> advice depending on whether we are in a single or multiple cherry-pick).
>
> I did some basic tests and it _seems_ to work to use --continue in
> either case. Probably due to 093a309 (revert: allow cherry-pick
> --continue to commit before resuming, 2011-12-10), but I didn't dig.
>
> -Peff

The 'git status' text for a rebase/am/cherry-pick is

    fix conflicts and then run "git <op> --continue"
    use "git <op> --skip" to skip this patch"
    use "git <op> --abort" to cancel the <op> operation

(The --cancel text varies a bit actually, but that's the gist of it.)

The rebase/cherry-pick conflict case should really indicate how to
mark the conflict as resolved as that's the specific situation the
user is in. I don't know if there are guidelines to hint line length,
or how many actions should be on one line but if the above text was
changed to have this as the "fix" text, possibly over two lines, I
think that would do it.

    fix conflicts with 'git add <paths>' or 'git rm <paths>'" and then
run "git <op> --continue"

Stephen
