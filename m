Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D7C1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732985AbeGKM5t (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 08:57:49 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:40459 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732556AbeGKM5t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 08:57:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id y200-v6so21192386lfd.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uGVZTYghjg4S/cKpdcG1mRWa6y2mvXWo3/ZixoG6f58=;
        b=cUDst41BQTl8hdkfvqL10pDmEN6uybBVeu+w9vNz3OTuSSIErKeRXu/z3gGOzNSx6C
         4LuASon5aAEnJvuTvvfyKUaRM7o2ThFsYyyGzSwT5NF5RthUypB6bKheDleUOumVXXQS
         z/O/Kmp1sI+tjwO0+gx3qisRAn6P3xU6p0nA4yoTja7ysH/FFe5LhAyEGuDfOA7YARzz
         XBb2AtwEtGPRcWoDZ5AunFBbeKPRfTGqoUiQQ1ZQ233mW51TCYsH6yNRtJCLq8p7w4U4
         mPtTPbtrve3B6RfBA6tFcxVpehKFx52w+WN2bq+X7FI7vP/9CwfwjD0mNoRDzr5Na/SG
         57bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uGVZTYghjg4S/cKpdcG1mRWa6y2mvXWo3/ZixoG6f58=;
        b=WWy57jb25I6UOSRyITU43X6X6tjBa05t8/cSaXUdq6+YYn95V/3fjb2GXEqKjdtZqB
         XjX1avQpVRwKi9v/zv/KqENI69y4xeNuHIQqnMCC54NGKvuCs2OXp9ZHuQp/J0YcBNDL
         jklsPkbbPK4pSeRg+zhnsBmnKnrrFkdSQ8Y6Ws6jhHi1VvRx/BnIW8KIGiAXQTeOzbmz
         GI3lcSxruq8J8tvfhwMJUA2xACGs7fUj1FpcaL0iJ0AoT8ZJStjgz7lHlbPH18R50ww5
         5TBfxCOEDCllu6id+v8ZH3urjKj16tIghR8YbEDj/DQXEa/HfDoXZ69TQl5eVNwWWh7U
         uXJQ==
X-Gm-Message-State: APt69E3WZLt9pHw0BioGQerGG+/aRnMKURmPsitG3ZdjVCIxZvUOQ/VH
        DdCDPX0WXM5ZocVDxo9AOZtTZmTrGhEPjQb32YAP3Q==
X-Google-Smtp-Source: AAOMgpc5JqpEGnDQN0qOlqYSnrP+bmU9F05D4vEUGGZOrJq5g4DvQIMh4bA5opU6a065TmJ7MiptsMDNucQiGNrUGGI=
X-Received: by 2002:a19:d942:: with SMTP id q63-v6mr5633427lfg.39.1531313614677;
 Wed, 11 Jul 2018 05:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180614123107.11608-1-szeder.dev@gmail.com> <20180614123107.11608-5-szeder.dev@gmail.com>
 <20180614175325.GA14935@sigill.intra.peff.net>
In-Reply-To: <20180614175325.GA14935@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 11 Jul 2018 14:53:23 +0200
Message-ID: <CAM0VKjmXoOaYFrkNJzNp_wgzReaXSZHiDCtJRADX0RRG123wPw@mail.gmail.com>
Subject: Re: [RFC PATCH 4/4] t/lib-httpd: sort log based on timestamp to avoid
 occasional failure
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 7:53 PM Jeff King <peff@peff.net> wrote:
>
> On Thu, Jun 14, 2018 at 02:31:07PM +0200, SZEDER G=C3=A1bor wrote:
>
> > The last test of 't5561-http-backend.sh', 'server request log matches
> > test results' may fail occasionally, because the order of entries in
> > Apache's access log doesn't match the order of requests sent in the
> > previous tests, although all the right requests are there.

> I've occasionally run into these failures on my local box, too. I'm
> happy somebody is looking into it (I have before, but eventually threw
> up my hands in disgust).

Heh, well, I found it to be one of the more entertaining debugging
sessions... ;)
I'm glad that somebody else saw it, too, and outside of Travis CI.

> > Now, by default the timestamp of a log entry marks the beginning of
> > the request processing, not when the log entry gets written.  Since
> > our requests are sent sequentially, sorting the log entries based on
> > their timestamps would ensure that their order corresponds to the
> > order of our requests.
>
> That's a reasonably clever solution. One thing I wonder, though: are we
> always guaranteed that the log entries are written _at all_ before we
> look at them?
>
> I.e., could we have a situation where we make a request, the client
> finishes, and then we look at the logs, but nothing has been written by
> apache yet?

That's possible, I suppose.  Highly improbable, but possible.  Or the
log entries can be written only partially by the time we look at them.

FWIW, Apache has the 'BufferedLogs' directive, which "causes
mod_log_config to store several log entries in memory and write them
together to disk, rather than writing them after each request."  It
very sensibly defaults to off, and our test config doesn't set it.

I would think that stopping Apache should flush the logs, but I don't
know whether 'stop_httpd' blocks until the web server is indeed
stopped, or it's all async.  Perhaps a SIGHUP would suffice to flush
the logs, but that's definitely async.  Also note that while t5561
checks the access log at the end of the script, t5541 and t5551 do
check the logs in the middle of the script, so we would have to stop
Apache and then start again.

Anyway, I would prefer not to do anything about it just yet, because
I'm curious :) and I'd like to see whether this actually happens in
practice.


> >     I don't really like the fix in this patch.  I think an unfortunate
> >     clock skew during the test run could mess up the sorting added in t=
his
> >     patch and cause test failure.  Or if DST or even a leap second happ=
en
> >     while the test is running.  Do we care?  Anyway, this occasional te=
st
> >     failure apparently happens more often than DST and leap seconds
> >     combined.
>
> We could probably eliminate DST issues by consistently using UTC for the
> timestamps. Leap seconds are probably infrequent enough not to worry
> about. More likely is something like clock adjustment due to ntp. Those
> adjustments are usually small enough not to matter, but if we're talking
> microseconds, it could trigger.

Ok, so admittedly I haven't quite thought through all these potential
clock-related issues that I mentioned.

Setting back the clock at the end of DST is not an issue, because
Apache uses the timezone it finds set in the environment, and our test
environment does set UTC, so as far as the tests and Apache's log
timestamps are concerned there is no such thing as DST.
Leap seconds don't go back in time, they are only added to compensate
for Earth's slowing rotation, so that's not an issue, either.
And I think NTP is supposed to be clever enough to not set back the
clock recklessly, but only advance it slower.

Of course, someone can still set back the clock manually while these
tests run, but I would put that in the "If it hurts, don't do it" box.


However, having said all this, ...

> What if the test script provides the in-order expectation, but we check
> only the unordered version (by sorting both actual and expected output
> on the fly)? That would give us a more relaxed check most of the time,
> but somebody digging in to a failure could run the ordered diff (or we
> could even show it automatically on failure instead of just using
> test_cmp).

this is the fix I'll go for in v2.
