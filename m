Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A511F71B
	for <e@80x24.org>; Fri, 29 Jul 2016 08:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbcG2ITI (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 04:19:08 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38071 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbcG2ITE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 04:19:04 -0400
Received: by mail-wm0-f44.google.com with SMTP id o80so140529480wme.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2016 01:19:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kHEj3ueSbLjXAcGB+7gswOOK2KG1E3igh+ukznnQYpA=;
        b=PqwRp4AgZ7FTLMpUwQVYjvMYJCmUZNa/swfSOooZSR66BsSO2/3stvBc/yFx4REaj4
         lBaHT0YL7WGar5n1CmPO4KtUAQFqQti/uqae+hi/kRPz3LPV2L/hrI25GKmI/MU9APvu
         y5bRgAYBb4IXO3OiwcBy9gCdEtKV9x1kCw9sldiCksFe9Wj9WU4q5OYx1Q79xDboKCiY
         Uc3gHW9e5F/X5EITuXvUockh+ncz6OmPK6DpCBZFCjZ5a8l4on1wXeyUDI8LW7BTqti1
         GCco71mIF7CbUfy46uPM0txK+H00C4eW8SVmkaFSnmjd9OKgTQD+R6oDTxEBUB3ome7s
         6qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kHEj3ueSbLjXAcGB+7gswOOK2KG1E3igh+ukznnQYpA=;
        b=kwEiM//xjd5z7TZqGr7SI8sm00jgPh2fVOcB+AUaFYWcKRTrLGb2iIUKp2r+lWDh8i
         GX6d5uHP4HB3h6I/RY2xK2J/ScC6jUHDGX5FrKziBk4E/3x3EtWnIBfHpG2g0Hl1MyL2
         IY6t1sQWI/vXN6n3HRnDMpku2bsWistcmJY7siR4/qYPJP4aqeVUTzekwf3QWefmcrbl
         1TgcpkRokYnGVFaIdaSb//e/5dgAZ8c3uBnwJeydlB98p54DeAbfB4TW6+TJGZ4syQCc
         lKToDY8Ue3pmdSu3jyp4SoQXvWliuWgu8bkJXY2FVAhtXwYByfMH/mrjzeGIc6uOISLu
         N46A==
X-Gm-Message-State: AEkoouvSyHjPdn+3ToOXmxm2U1ir/kO0JVDwhnmx25A49cD2kcBF2F7iIymjOUxPgZg7sDPsHy7GWIFcAyvaRg==
X-Received: by 10.28.103.6 with SMTP id b6mr44575937wmc.89.1469780342466; Fri,
 29 Jul 2016 01:19:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Fri, 29 Jul 2016 01:19:01 -0700 (PDT)
In-Reply-To: <CA+55aFxMZAuY7NY6rSfrMVyEdLuZDHBTs97UUdfk9=yJL1iLjA@mail.gmail.com>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <20160729002140.GC9646@sigill.intra.peff.net> <CA+55aFxMZAuY7NY6rSfrMVyEdLuZDHBTs97UUdfk9=yJL1iLjA@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Fri, 29 Jul 2016 10:19:01 +0200
Message-ID: <CAP8UFD3e7HFkhHbPjGRB9H-5QnqgLApsSPb8o1wTxCi8WVwhYQ@mail.gmail.com>
Subject: Re: Small trivial annoyance with the nice new builtin "git am"
To:	Linus Torvalds <torvalds@linux-foundation.org>
Cc:	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 2:32 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Jul 28, 2016 at 5:21 PM, Jeff King <peff@peff.net> wrote:
>>
>> I do wonder if you would be happier giving each commit a "fake"
>> monotonically increasing time, so they are correctly ordered by commit
>> date.
>
> No, that would be nasty, partly for the corner case you mention, but
> partly because I just think it's wrong to try to lie about reality.
>
> The reason I noticed this in the first place was actually that I just
> wanted to take a look whether things had gotten slower or faster over
> time, and see how many patches per second I get from the patch-bombs
> Andrew sends me.
>
> So getting real time was what I was looking for.

Great!

> Also, before somebody asks: the reason git has always cached the
> "default time" string is because there's a reverse annoying thing,
> which is looking up time twice, and getting a difference of a second
> between author times and committer times just because of bad luck.
> That makes no sense either, and is actually why we have that
> "ident_default_date()" cache thing going on.
>
> So we do want to cache things for a single commit, it's just that for
> things like "git am" (or, like Junio wondered, "git rebase" - I didn't
> check) we probabyl just just flush the cache in between commits.

When Junio wrote:

> I have a suspicion that we would see more and more breakages like
> this in the near future, as there are folks trying to redo multi-commit
> commands in a single process.

he was maybe talking about my patch series to libify `git apply` and
use that in `git am` (which is itself used by `git rebase` when not in
interactive mode):

https://public-inbox.org/git/20160627182429.31550-1-chriscool%40tuxfamily.org/

that will likely mean more patches with the same real time anyway
especially with split-index on (see "Performance numbers" in that
email).
