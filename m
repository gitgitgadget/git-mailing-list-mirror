Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02D4C20C18
	for <e@80x24.org>; Wed, 25 Jan 2017 21:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbdAYVyk (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:54:40 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33981 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbdAYVyj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:54:39 -0500
Received: by mail-pf0-f182.google.com with SMTP id e4so60725168pfg.1
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 13:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ea5FQSirMNdFmE96C8UJvxaRe7DmE9ZisLLZF7Y75wQ=;
        b=CUCjLqfqwS2qgtFEkMzECOZtbAZKTz/scdF0LdHc9lDYqYpMj7Vf69qOcJNcY0JT3C
         unrnntaHuT45nVLfNTeGuy1i3P1JIv0Q8nkdsDbIKSr9ikR9uIZeI/nzLt5QuPjjGxEC
         tX1iIBzYVXbx2IlOfCLAsUcYwie4yQ+q42mhjzqek3znZLiCgM0URNEVwi/FWlJuBWNA
         co/6uibU1TFjbTyXdmBOyLyrHLpRIanUwmk4Y2ei6IS+YODkj0mtzSNLgXP1FGsTI9bN
         Mqtm0PbhOQjTGH6zuHNr3C0QR55gvqoDRROmLWGKgo7ohhTOOfP2o0ased2IhRtpzMDA
         8GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ea5FQSirMNdFmE96C8UJvxaRe7DmE9ZisLLZF7Y75wQ=;
        b=WTSOMiJUaFZyDckCzBR7e7R+Hy0wYRcs6LfOI7WfgL31RAGl/LZSOgOJb+7oDTOtUr
         Z0VwZf30hqyjeKszd2PRIRupHA95MS8AydMIrGcaaFG/uvY3X34e8BqQaLhClz+7Fhc8
         quiE8f9F0UiO2/mu8eOfxckRHwKw+ip5VWD0ZqPVnf7PtpkCu1fwj3/XRCUUD5Vyj9G+
         7Wg7Sb04OhSRZ0L2MpTu4nOtADbor7r425ejnbbMpFUQxti6EeFpGjeJFFoGw7KoyQzq
         Ko0yiN9uj+BBfX9Eohd5FRR4T7DdgBYA7vWA48bhXGx2L17HmBh/E7NblPW7U+9UunhM
         TK+g==
X-Gm-Message-State: AIkVDXLXdy902Xv14+RDB9+LIgeyKCSW9oDLuLTKFncs7M81XoM6umYdCTkvgdcVmmloElBg
X-Received: by 10.98.13.18 with SMTP id v18mr48989373pfi.62.1485381268211;
        Wed, 25 Jan 2017 13:54:28 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d901:f11e:e93:985])
        by smtp.gmail.com with ESMTPSA id o12sm3363614pfg.15.2017.01.25.13.54.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 13:54:27 -0800 (PST)
Date:   Wed, 25 Jan 2017 13:54:26 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check
 structure
Message-ID: <20170125215426.GB83343@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
 <20170123203525.185058-26-bmwill@google.com>
 <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
 <20170123220614.GA187696@google.com>
 <20170124011135.GB187696@google.com>
 <xmqqinp5p4x2.fsf@gitster.mtv.corp.google.com>
 <20170125195745.GA83343@google.com>
 <xmqq1svqc2ww.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1svqc2ww.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> In my mind, the value of having a constant check_attr is primarily
> >> that it gives us a stable pointer to serve as a hashmap key,
> >> i.e. the identifier for each call site, in a later iteration.
> >
> > We didn't really discuss this notion of having the pointer be a key into
> > a hashmap, what sort of information are you envisioning being stored in
> > this sort of hashmap?
> 
> The "entries relevant to this attr_check() call, that is specific to
> the <check_attr instance, the thread> tuple" (aka "what used to be
> called the global attr_stack") we discussed would be the primary
> example.  A thread is likely be looping in a caller that has many
> paths inside a directory, calling a function that has a call to
> attr_check() for each path.  Having something that can use to
> identify the check_attr instance in a stable way, even when the
> inner function is called and returns many times, would allow us to
> populate the "attr stack" just once for the thread when it enters a
> directory for the first time (remember, another thread may be
> executing the same codepath, checking for paths in a different
> directory) and keep using it.  There may be other mechanisms you can
> come up with, so I wouldn't say it is the only valid way, but it is
> a way.  That is why I said:
> 
> >> But all of the above comes from my intuition, and I'll very much
> >> welcome to be proven wrong with an alternative design, or better
> >> yet, a working code based on an alternative design ;-).
> 
> near the end of my message.
> 
> > One issue I can see with this is that the
> > functions which have a static attr_check struct would still not be thread
> > safe if the initialization of the structure isn't surrounded by a mutex
> > itself. ie
> 
> Yes, that goes without saying.  That is why I suggested Stefan to do
> not this:
> 
> > static struct attr_check *check;
> >
> > if (!check)
> >   init(check);
> >
> > would need to be:
> >
> > lock()
> > if (!check)
> >   init(check);
> > unlock();
> 
> but this:
> 
> 	static struct attr_check *check;
> 	init(&check);
> 
> and hide the lock/unlock gymnastics inside the API.  I thought that
> already was in what you inherited from him and started your work
> on top of?

I essentially built off of the series you had while using Stefan's
patches as inspiration, but I don't believe the kind of mechanism you
are describing existed in Stefan's series.  His series had a single lock
for the entire system, only allowing a single caller to be in it at any
given time.  This definitely isn't ideal, hence why I picked it up.

Implementation aside I want to try and nail down what the purpose of
this refactor is.  There are roughly two notions of being "thread-safe".

1. The first is that the subsystem itself is thread safe, that is
   multiple threads can be executing inside the subsystem without stepping
   on each others work.

2. The second is that the object itself is thread safe or that multiple
   threads can use the same object.

I thought that the main purpose of this was to achieve (1) since
currently that is not the case.

-- 
Brandon Williams
