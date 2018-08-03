Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 748621F597
	for <e@80x24.org>; Fri,  3 Aug 2018 19:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbeHCVai (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 17:30:38 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:41825 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbeHCVai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 17:30:38 -0400
Received: by mail-pf1-f181.google.com with SMTP id y10-v6so3753741pfn.8
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 12:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vKfuuCWBVaaDmYOMdzQBR8xwu252D1tUiPn/ORCR3Eg=;
        b=TXBf0z4ITOH95uuUMWtTaLbzdMfhc6ZN0snYh+r07QDoZuOik0ii34eAVSfkI89mFA
         bHy2UcPM2G/byL/4GFzYDg6qpqGQQMULvAbEu24Z0aryFtXi6v5kAxzjNmn8ZGWsZMGP
         hmcrPY1AP4/HJvG0wrWjXy21UIC8ReOw39hU1HqC2FfcR0aZuUeAzzZ6SP0GSfOPKR80
         EzI4dG2uE5eUW6ewGhIoqNe9IGP28PWv0riCfgd43tXU6BZjVC+Mzf7u+WOZYNCiC7uB
         fF4wlSoO3kSaxMr7lT/DJV+L4EcqmB/JqXCTKyU33wnM547HaWOVBxx2ZhToZkJiNc73
         w7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vKfuuCWBVaaDmYOMdzQBR8xwu252D1tUiPn/ORCR3Eg=;
        b=ryOTYsULfJo14+F38DmQzg6dKXuCmQbOLCHp53WsuA39cOOjccl0NkNIJJ3YxKulBw
         bTQQRYISujgerld/pxhb+fx0sslxpvOxp6OuOGD/Sdjkf9e2r7hKAUh4sejdpY7cXdq/
         ITLs9Mpp//usPVQQqyDxqZbHjjlD7ISwr86SFF+g9YE9q2fikYzNnoNgzUiIkr1UZH31
         gFgWUYgKapDIOIQmQoUlsDi81ux63aNNCWNpKOVOUzlWlc7C23XwmvbXmIHxyJqlJ9bl
         ys3GMIjxpigbkuh9TZ8UFYYLN3YHklfsbLhDOsjA30xTRTNx6nwXCIADzUcX8YiZN9jw
         4O6w==
X-Gm-Message-State: AOUpUlGyaV15eWEs/54HhXzaQPN5HebpoJro872yksakAOvJ95HUcmKm
        /Kai64p7QQBXQUWjEdPczLthOA==
X-Google-Smtp-Source: AAOMgpcl2o+qFOKbM1tGXkiWJhlTBhzkX8y0dpxnXiB+HsKs5Yx0TjqISANnl6oo4Uc5CC1qSOR5rQ==
X-Received: by 2002:a63:cd4c:: with SMTP id a12-v6mr5099319pgj.15.1533324778768;
        Fri, 03 Aug 2018 12:32:58 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id c131-v6sm5586601pga.69.2018.08.03.12.32.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Aug 2018 12:32:57 -0700 (PDT)
Date:   Fri, 3 Aug 2018 12:32:56 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #01; Thu, 2)
Message-ID: <20180803193256.GA164578@google.com>
References: <xmqq4lgcz81f.fsf@gitster-ct.c.googlers.com>
 <20180803180912.GD106068@genre.crustytoothpaste.net>
 <xmqqwot7wayf.fsf@gitster-ct.c.googlers.com>
 <20180803184508.GE106068@genre.crustytoothpaste.net>
 <xmqqo9ejwag9.fsf@gitster-ct.c.googlers.com>
 <xmqqk1p7wa7t.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1p7wa7t.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/03, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> >> On Fri, Aug 03, 2018 at 11:40:08AM -0700, Junio C Hamano wrote:
> >>> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >>> 
> >>> > On Thu, Aug 02, 2018 at 04:02:36PM -0700, Junio C Hamano wrote:
> >>> >> --------------------------------------------------
> >>> >> [New Topics]
> >>> >
> >>> > I had expected to see
> >>> > <20180729192803.1047050-1-sandals@crustytoothpaste.net> (the refspec @
> >>> > handling) in this list, but I don't.  Were you expecting changes or
> >>> > additional feedback before picking it up?
> >>> 
> >>> Neither.  I just am not all that interested in seeing @ used for
> >>> HEAD in the first place, as I find it quite confusing.

Discussion on our contributor workflow (and potentially adjusting or
changing it) tends to be an area that can result in heated discussion, I
would like to avoid that.  At some point I would really like it if we
could have a constructive discussion on how to improve our workflow as
well as make things easier for newcomers.  Maybe this isn't the time or
place but I find this situation particularly challenging as a
contributor.

Someone sent a patch to the list, they received a review (which doesn't
happen all the time because no one is assigned to review a patches) and
then they wait.  Our project doesn't have a bug tracker (yes jrn you'll
say we have one, https://crbug.com/git/, but its not very discoverable
and the project as a whole hasn't started using it) (and I mention a bug
tracker because that's also a place which could be used to communicate
the 'status' of a series), and it doesn't make use of a code review tool
which has a definitive status of a patch series.  As a contributor I'm
left waiting and unsure of if my patch series needs more review, do I
need to send a re-roll, does the project not like the idea and I should
drop it, or the patch is good as-is and will be merged.

When I started contributing to the project I was told that these "What's
cooking" emails were supposed to be that status[1].  I knew that they
weren't real-time but it meant that I could at least get an idea about
once or twice a week about the various status' of ongoing series in the
project.  When something is just silently omitted, what is a contributor
to think?  Even if someone sends something that the project isn't
interested in taking, shouldn't they at least get informed of that?

Anyway those are just some of my thoughts.  If my thinking is mistaken or I'm
missing something please point it out to me.

[1] https://public-inbox.org/git/CAGZ79kYGS4DvoetyGX01ciNrxxLCqgXoVSpLhmgYZ8B51LzhSg@mail.gmail.com/
This mail seems to counter that indicating that the "What's Cooking"
emails should not be used as a status update.

-- 
Brandon Williams
