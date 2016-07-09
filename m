Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A6962018E
	for <e@80x24.org>; Sat,  9 Jul 2016 16:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026AbcGIQqO (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 12:46:14 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:34960 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579AbcGIQqN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 12:46:13 -0400
Received: by mail-it0-f52.google.com with SMTP id u186so31666081ita.0
        for <git@vger.kernel.org>; Sat, 09 Jul 2016 09:46:08 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZIE9HNVM+OEmmF/85psIwJb+7K7J8UjtI8c5ItWYxWU=;
        b=h/MBuyVX6TfAHfgCTmOzHZJmJsHtpXm1309PJ6AzqQCx3xHMB+8YG9WqAuw9VVpaD/
         pv3ZL7o+eYEOnrM3sBFZY2m88t/IPy0D0DLR7eJKrURp9Pt+SFnD6dMd/a+j7EyZlLOk
         leCfTPmcUZlDcobb4lZfHhsOgvOGCl75G7VXo3PuF+lm3U6cIx/8cjYw0Ca2pkSA7+9x
         woReppSFt0YXi1y5n0TqBwuY5MpSZHLvjZEguB83gy3AXAXHpd8dL88gdQg0dLkditZv
         /l9Q5comZ/HVMlAxxNbydWR0DUil8ry8D5smaj1/NwClk8bHK69C+9VGUTPL/1A9O6Mu
         7AmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZIE9HNVM+OEmmF/85psIwJb+7K7J8UjtI8c5ItWYxWU=;
        b=SvuKl7uZcv8Va890oPFyiCG7NkHAuZSk9twepaIY/3dzD/A7UnQq6pgFQMyQhxo3PA
         iSss2GpNAAJbLsctGe5tQQFnEMrWB++lJkhEn7mSyRp11wjdS741ipJ7p/Q2LySxcsY6
         mzJvdgTj96Rg7g0Xq02yjSjasE5XuIEPhLxfVPTv9iHBe44szlje8ZmscICse2kiFdcf
         4th9YWcqnMsizq8zixrhABoKl7hc389qhGI6SLo+rK4mnFaY2GaOtB+oMoh6v/NCRRF5
         pnyJMcbM4H9xAaJU96A9Q6TpW31dhrCIxm80i9n0dUArDh2gVjuxfK9j9itrI2advQcO
         YJuA==
X-Gm-Message-State: ALyK8tLz/PKME5/tdUipWR28PcTPFWuZdOQEO/gwBf+Xn55KFY7oOHcLsIRume7bny0RVK6USzoKMywcOk7cOA==
X-Received: by 10.36.33.22 with SMTP id e22mr3786583ita.42.1468082767799; Sat,
 09 Jul 2016 09:46:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 9 Jul 2016 09:45:38 -0700 (PDT)
In-Reply-To: <20160709140931.GA3185@x>
References: <20160708025948.GA3226@x> <xmqq1t34oiit.fsf@gitster.mtv.corp.google.com>
 <20160708064448.GA18043@x> <xmqqa8hsm4qu.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1607090928500.6426@virtualbox> <20160709140931.GA3185@x>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 9 Jul 2016 18:45:38 +0200
Message-ID: <CACsJy8A6fiPUtNZow_oOEQSi64GMxA2Jy84h4OznaSxBMePtbQ@mail.gmail.com>
Subject: Re: gc and repack ignore .git/*HEAD when checking reachability
To:	Josh Triplett <josh@joshtriplett.org>
Cc:	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 9, 2016 at 4:09 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Sat, Jul 09, 2016 at 09:35:24AM +0200, Johannes Schindelin wrote:
>> On Fri, 8 Jul 2016, Junio C Hamano wrote:
>> > Josh Triplett <josh@joshtriplett.org> writes:
>> >
>> > > That sounds reasonable.  And if they *do* end up taking any time to
>> > > traverse, it's because they weren't reachable from other anchoring
>> > > points, so taking the extra time to traverse them seems fine.
>> >
>> > The only thing that is hard is to clearly define _what_ are the new
>> > anchoring points.
>> >
>> > It cannot be "anything directly under .git that has all-caps name
>> > that ends with _HEAD".  The ones we write we know are going to be
>> > removed at some point in time (e.g. "git reset", "git bisect reset",
>> > "git merge --abort", etc.).  We do not have any control on random
>> > ones that the users and third-party tools leave behind, holding onto
>> > irrelevant objects forever.
>>
>> Please note that bisect already uses the (transient) refs/bisect/
>> namespace. So I do not think we need to take specific care of the
>> BISECT_* files.
>>
>> If we had thought of it back then, we could have used such a transient
>> namespace also for FETCH_HEAD, CHERRY_PICK_HEAD and also for detached
>> HEADs (which we should have called "unnamed branches").
>>
>> Now, how about special-casing *just* these legacy files in gc: HEAD,
>> FETCH_HEAD, MERGE_HEAD and CHERRY_PICK_HEAD? Any new transient refs should
>> live in the refs/ namespace, which is already handled.
>
> That seems workable as well; in that case, we should also document this
> (in the git-gc manpage at a minimum), and explicitly suggest creating
> refs in refs/ but outside of refs/heads/ and refs/tags/, rather than
> directly in .git/.

Not just outside refs/heads and refs/tags. It has to be in a specified
namespace like refs/worktree/ or something (we are close to be ready
for that). We could update the man page about git-gc shortcomings now,
but I think we should wait until refs/worktree (or something like
that) becomes true before suggesting more.
-- 
Duy
