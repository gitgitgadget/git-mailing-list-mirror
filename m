Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE9D81F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752663AbdAYXTp (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:19:45 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35796 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdAYXTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:19:44 -0500
Received: by mail-pf0-f182.google.com with SMTP id f144so61344327pfa.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6jKbkhOTJtDgZeYuj8rddmFXZSw7N6XHbtGyAewl1aY=;
        b=K8g7cavrMR6wWuyHUmxwE4SjBKE0GWifR25sj7vNjOm+kvVthJDu3MUVFPS/xUzaDd
         2jbtz21IBd/H0//snl62cU7VlEjxrEIK00zhSNi8Bkxl5Z4GNgkVhOiyUzKB9mDwKqxT
         0pv0dlxq9Ov7QqeV8TYTQVzBw6Q+WpseNj2+7bjcJrJnMYehzacLqRsQIL10NoeHAxmD
         Vi2Z4UT8TRQJKpEloxvrqYjI5dx4WGDpt31/BpFrBf78bL3KFPoZuRQ3md326Gly4e+V
         82wUSeT7EtumrC0Ur1oLP44jB52C4ay792uRFaGUIKcntZqLExXS79Vpn5ksjEjzKzip
         IXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6jKbkhOTJtDgZeYuj8rddmFXZSw7N6XHbtGyAewl1aY=;
        b=FYBgQZFyP1SobN41VNILCWauKHfSotLgrBpFQqcZhKGzmwJB6oD9WGUpI4kGepwege
         JPYcWQxxYT8S/Qu8n1Nj8JcQU/kdzCvypCU6NDLq4jeQmLrHz+2bpZB5X7+iLACYK33g
         IdxsCV2KZ8S3A+Ym5D+rufwKgI2wiRZ77LkjI1OaBENtjYRT4iK9e7EXBH22RCr0A376
         XMTQQ99tE2bP2ZMZoGcU+9tTvpOlu+2fJWpSYVF6caTd0GtonOiQrmYQbMBL7ys6pQ8h
         vVU+k9y/VDPWH1HHyy0Wqpn0Z14xWDM+hPeurycpFoRCJcJUlzHK22OhFrtrEIuHstu5
         QNbw==
X-Gm-Message-State: AIkVDXI0qG8RLNIftDJKPIoNstBY6f6ylJzigI768N5swUJcsDO+PkZAHJTXML0NVeu7DpgQ
X-Received: by 10.99.188.10 with SMTP id q10mr2061037pge.106.1485386378688;
        Wed, 25 Jan 2017 15:19:38 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d901:f11e:e93:985])
        by smtp.gmail.com with ESMTPSA id n8sm3566950pgc.0.2017.01.25.15.19.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 15:19:37 -0800 (PST)
Date:   Wed, 25 Jan 2017 15:19:36 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 25/27] attr: store attribute stack in attr_check
 structure
Message-ID: <20170125231936.GC83343@google.com>
References: <20170112235354.153403-1-bmwill@google.com>
 <20170123203525.185058-1-bmwill@google.com>
 <20170123203525.185058-26-bmwill@google.com>
 <xmqq37g9qwr2.fsf@gitster.mtv.corp.google.com>
 <20170123220614.GA187696@google.com>
 <20170124011135.GB187696@google.com>
 <xmqqinp5p4x2.fsf@gitster.mtv.corp.google.com>
 <20170125195745.GA83343@google.com>
 <xmqq1svqc2ww.fsf@gitster.mtv.corp.google.com>
 <20170125215426.GB83343@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170125215426.GB83343@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25, Brandon Williams wrote:
> On 01/25, Junio C Hamano wrote:
> > Brandon Williams <bmwill@google.com> writes:
> > 
> > >> In my mind, the value of having a constant check_attr is primarily
> > >> that it gives us a stable pointer to serve as a hashmap key,
> > >> i.e. the identifier for each call site, in a later iteration.
> > >
> > > We didn't really discuss this notion of having the pointer be a key into
> > > a hashmap, what sort of information are you envisioning being stored in
> > > this sort of hashmap?
> > 
> > The "entries relevant to this attr_check() call, that is specific to
> > the <check_attr instance, the thread> tuple" (aka "what used to be
> > called the global attr_stack") we discussed would be the primary
> > example.  A thread is likely be looping in a caller that has many
> > paths inside a directory, calling a function that has a call to
> > attr_check() for each path.  Having something that can use to
> > identify the check_attr instance in a stable way, even when the
> > inner function is called and returns many times, would allow us to
> > populate the "attr stack" just once for the thread when it enters a
> > directory for the first time (remember, another thread may be
> > executing the same codepath, checking for paths in a different
> > directory) and keep using it.  There may be other mechanisms you can
> > come up with, so I wouldn't say it is the only valid way, but it is
> > a way.  That is why I said:
> > 
> > >> But all of the above comes from my intuition, and I'll very much
> > >> welcome to be proven wrong with an alternative design, or better
> > >> yet, a working code based on an alternative design ;-).
> > 
> > near the end of my message.
> > 
> > > One issue I can see with this is that the
> > > functions which have a static attr_check struct would still not be thread
> > > safe if the initialization of the structure isn't surrounded by a mutex
> > > itself. ie
> > 
> > Yes, that goes without saying.  That is why I suggested Stefan to do
> > not this:
> > 
> > > static struct attr_check *check;
> > >
> > > if (!check)
> > >   init(check);
> > >
> > > would need to be:
> > >
> > > lock()
> > > if (!check)
> > >   init(check);
> > > unlock();
> > 
> > but this:
> > 
> > 	static struct attr_check *check;
> > 	init(&check);
> > 
> > and hide the lock/unlock gymnastics inside the API.  I thought that
> > already was in what you inherited from him and started your work
> > on top of?
> 
> I essentially built off of the series you had while using Stefan's
> patches as inspiration, but I don't believe the kind of mechanism you
> are describing existed in Stefan's series.  His series had a single lock
> for the entire system, only allowing a single caller to be in it at any
> given time.  This definitely isn't ideal, hence why I picked it up.
> 
> Implementation aside I want to try and nail down what the purpose of
> this refactor is.  There are roughly two notions of being "thread-safe".
> 
> 1. The first is that the subsystem itself is thread safe, that is
>    multiple threads can be executing inside the subsystem without stepping
>    on each others work.
> 
> 2. The second is that the object itself is thread safe or that multiple
>    threads can use the same object.
> 
> I thought that the main purpose of this was to achieve (1) since
> currently that is not the case.

Ok, so I discovered a very good reason why we should do as Stefan
originally did and split the question and answer (beyond the reasoning
for using the reference as a hashkey).

One motivation behind making this API thread-safe is that we can use it
in pathspec code to match against attributes.  This means that a
pathspec structure will contain an attr_check member describing the
attributes that a pathspec item is interested in.  Then the pathspec
structure is passed to match_pathspec() as a const pointer.  To me, when
passing something as 'const' I expect none of the members should change
at all.  The struct should remain exactly in the same form as before I
invoked the function.

Requiring the attr_check structure to be modified in the process of a
check_attrs() call would violate this "contract" when calling
match_pathspec() as the attr_check structure would have modified state.
The compiler wouldn't catch this as the "const" modifier isn't passed on
to struct members.

-- 
Brandon Williams
