Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFE821F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 19:57:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751622AbdAYT5t (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 14:57:49 -0500
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36153 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbdAYT5s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 14:57:48 -0500
Received: by mail-pf0-f176.google.com with SMTP id 189so60433758pfu.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 11:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+pGp5mDw2o2tWkZ+RA8+ONXGaMFiuZd191K8jBvt7fY=;
        b=Rn+d3FpmgnUYLhdxB/1h1X3WumQo1wwRaXqVAAi8t1Bh4Lq+crYffIVWYU6+qCyu7V
         raGh+oEyCLyBfqP8eWRcKXSfClMK9UeaJog9Yb4rTGFIZ5VPvU6YYJPqD/t5RzHvR42R
         fywtlQgxLv/EKh1cjb4l8G4P7rhTiWap9hvqhAPA6Lx6moLZwZO8BwaGELk0ucijAvFC
         +qgfmTnE+PijkoE9hOgeBhntjJ4hlgZg9n2b2AjENZr+2rS9T0yc9rlaKCrs48VeQ/YG
         hlIbTiwgQRLTI2AH2ZXat67zD1HSLL9T2aBd68hv1Fy6mDP3jqG2QS1+yCoUvARUUInH
         YPcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+pGp5mDw2o2tWkZ+RA8+ONXGaMFiuZd191K8jBvt7fY=;
        b=t4prZurhZhap9wOGvv3hCIAUX1FKgDu+aH05oJDSQYsqeh8XA+LSYYzDJ5RRVaQ6xR
         v4FDQ2yOfkrPKSNaGOHT7AmI5Kl0HsB/1Bz4NMRqnq2yw5hBKBS15AV9wmZPPB9TUaqP
         0aWPFA7aq4/NW+LsRysJ7QwRvbrc7+p3I2t+UAUt5xEN+whU4BfYtMBobjnxZjIJ+tz8
         i5Scah8g845+5NpEKgmOtJ14gyPUSYjjss87H7500+qzYPbiYcE110f172BB9mxg6k99
         MXUuEQLqAHYKK1xfy9cv5AsLh0VTYZFKhPGtnibKrQz1tAuoCdk7blX6xmxFcFl7GXZd
         3Fkg==
X-Gm-Message-State: AIkVDXKEaFbvUvQahvoWqqvVBShJjM1T0j3UrSxpBEWl3O7b4g8PxeUmp/hxpWuRWjGtJM0n
X-Received: by 10.99.55.26 with SMTP id e26mr1128022pga.15.1485374267912;
        Wed, 25 Jan 2017 11:57:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d901:f11e:e93:985])
        by smtp.gmail.com with ESMTPSA id u24sm3034706pfi.25.2017.01.25.11.57.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 11:57:46 -0800 (PST)
Date:   Wed, 25 Jan 2017 11:57:45 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check
 structure
Message-ID: <20170125195745.GA83343@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
 <20170123203525.185058-26-bmwill@google.com>
 <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
 <20170123220614.GA187696@google.com>
 <20170124011135.GB187696@google.com>
 <xmqqinp5p4x2.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqinp5p4x2.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/23, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > ... It seems like breaking the question and answer up
> > doesn't buy you much in terms of reducing allocation churn and instead
> > complicates the API with needing to keep track of two structures instead
> > of a one.
> 
> In my mind, the value of having a constant check_attr is primarily
> that it gives us a stable pointer to serve as a hashmap key,
> i.e. the identifier for each call site, in a later iteration.

We didn't really discuss this notion of having the pointer be a key into
a hashmap, what sort of information are you envisioning being stored in
this sort of hashmap?  One issue I can see with this is that the
functions which have a static attr_check struct would still not be thread
safe if the initialization of the structure isn't surrounded by a mutex
itself. ie

static struct attr_check *check;

if (!check)
  init(check);

would need to be:

lock()
if (!check)
  init(check);
unlock();

inorder to prevent a race to initialize the structure.  Which is
something that the attr system itself can't be refactored to fix (at
least I can't see how at the moment).

> Of course, in order to populate the "question" array, we'd need the
> interning of attribute names to attr objects, which need to be
> protected by mutex, and you would probably not want to do that every
> time the control hits the codepath.

While true that doesn't prevent the mutex needed to create/check that
the all_attr array that is used to collect attributes is the correct
size/initialized properly.

> But all of the above comes from my intuition, and I'll very much
> welcome to be proven wrong with an alternative design, or better
> yet, a working code based on an alternative design ;-).

Yeah, after working through the problem the two simple solutions I can
think of are either my v1 or v2 of the series, neither of which allows
for the attr_check structure to be shared.  If we truly want the
"question" array to be const then that can be done, it would just
require a bit more boilerplate and making the all_attr array to be
local to the check_attrs() function itself.  An API like this would look
like:

static const struct attr_check *check;
struct attr_result result;

if (!check)
  init_check(check);

// Result struct needs to be initialized based on the size of check
init_result(&result, check);

check_attrs(path, check, &result);

// use result

attr_result_clear(&result);

>

It still doesn't handle an initialization race on the check structure
but the check pointer would be const and could be used for some future
optimization.  It also will have a bit more allocation churn than either
v1 or v2 of the series.  If this is the route you want to take I'll get
working on it, I just want to make sure we're on the same page before
doing a larger refactor like this.

Thanks for the guidance on this, someday we'll get this right :)

-- 
Brandon Williams
