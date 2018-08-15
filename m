Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 053EE1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 06:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728480AbeHOJEg (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 05:04:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45766 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeHOJEg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 05:04:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so103726pgq.12
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 23:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=werleOjS5A/UCzYRsGjCanOSpwdB1K+sb7QOYdYW0uo=;
        b=ks2RXZle9JQhDK4SxWYo47Caw1JLa/zqOM6zlXtORYOcNnHyKFRcksBwghv4Zzyli2
         MJbZiS57bGy0WUq1XJrVu6+07lBP9IJtbpbVESl+WRjeKE7GDvbVdbRD8H+06nqDAHD3
         jj0vyfIOC7DjueRsv1gMqaKnpCN1+wAfAHl8hm9vzIwZCROs8U61/xpAtKkJ7y/fGvlZ
         hmwDuFKXSy7+oMLMt05Mor5vT/NTfY5rf5+/lx1tBxdKXG5PJW2aKb9Tw98PCyv9hi94
         AkSqyf+QVHv6dD8swf5gQa5iK5rpqO+1LJzxDHKqnN9eVOMOxvqH8PkIdE1XkGbKMW7a
         UHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=werleOjS5A/UCzYRsGjCanOSpwdB1K+sb7QOYdYW0uo=;
        b=Rw4X3aABCPbPruH0mnE78iyQsQjxhouMqk/GTaZ0RtpyJskycPqygZRS29/g+k4GRJ
         q+MM28g9nIAj7FRUcO3XVPjqb8wtg3E6meTgmiiH18TkMGK9gxVtabgYZUiG66NDxOoD
         U6sWIJDEZEGfvxYKKNW8ikXiMGMaBNR3PW01f/vTlC8x1J9U+KgEjQf+1qkKGmdwVHJ4
         0ALb+mT9AnwdnoV7y5vE5e72tMlXhmLB/9KVb7dx5ChNJygM5OKmLESlW9D4urb7nsuA
         A/VOwRkxu9jlQ7uB51zkMDOd5vXbWoxJco2eiTCHdcaEFZoFIdOBu0MHgn+bEe/GOFHy
         fQ6g==
X-Gm-Message-State: AOUpUlGjzCTII6liWUsE9GtkiG6VsEy/jpDXagdcwUWnG787XBcQPOi5
        +eqeZOU7LzsyzJn2gFEHCrk=
X-Google-Smtp-Source: AA+uWPxKPNZj3f6t8aLQk1loUPD5XO5iqi86RiLO2RJKj8lpqZ7w20iCe7pQDciLXki7JyIo15ejEA==
X-Received: by 2002:a63:951e:: with SMTP id p30-v6mr23792965pgd.318.1534313628573;
        Tue, 14 Aug 2018 23:13:48 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id u83-v6sm74483344pfj.37.2018.08.14.23.13.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 23:13:48 -0700 (PDT)
Date:   Tue, 14 Aug 2018 23:13:46 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCHv3 1/6] Add missing includes and forward declares
Message-ID: <20180815061346.GJ32543@aiede.svl.corp.google.com>
References: <20180811205024.11291-1-newren@gmail.com>
 <20180813171749.10481-1-newren@gmail.com>
 <20180813171749.10481-2-newren@gmail.com>
 <20180815051011.GC32543@aiede.svl.corp.google.com>
 <CABPp-BFk2X5TApYzs3QtdokBs3Hqz9uX737M6RGMtaU+wYUikw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BFk2X5TApYzs3QtdokBs3Hqz9uX737M6RGMtaU+wYUikw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:

> I didn't want to repeat that description in all 6 patches, since all
> six came from that, so I put it in the cover letter.  Since patch #1
> has most that changes though, I guess it makes sense to include it at
> least in that one?

Yes, that sounds sensible to me.

[...]
> On Tue, Aug 14, 2018 at 10:10 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Is there an easy way to review it?  (Keep in mind that I'm super lazy.
>> ;-))
>
> I guess I could send you my hacky python script that loops through the
> top-level header files and creates the dummy two-line c file, and you
> could inspect it and run it.  But that only verifies that it compiles,
> not that the changes I choose are "correct".

I suppose leaving it as an exercise to the reviewer is not terrible.
Maybe some reviewer will be inspired to make a test tool we can check
in, or configuration for an existing tool like iwyu.

[...]
>> enums are of unknown size, so forward declarations don't work for
>> them.  See bb/pedantic for some examples.
>
> structs are also of unknown size; the size is irrelevant when the
> function signature merely uses a pointer to the struct or enum.  The
> enum forward declaration fixes a compilation bug.

My rationale may miss the point but the standard and some real compilers
don't like this, unfortunately.

For structs, having an incomplete type is fine, but for enums we need
the full definition.  E.g. C99 sayeth (in section 6.7.2.3 "tags")

	A type specifier of the form

		enum identifier

	without an enumerator list shall only appear after the type it
	specifies is complete.

[...]
>>> --- a/commit-graph.h
>>> +++ b/commit-graph.h
>>> @@ -4,6 +4,7 @@
>>>  #include "git-compat-util.h"
>>>  #include "repository.h"
>>>  #include "string-list.h"
>>> +#include "cache.h"
>>
>> We can skip the #include of git-compat-util.h since all .c files
>> include it.
>
> Good point.  Should I go through and remove all the inclusions of
> git-compat-util.h in header files?

It's orthogonal to this series but might be a good change.

[...]
>>> --- a/pathspec.h
>>> +++ b/pathspec.h
>>> @@ -1,6 +1,11 @@
>>>  #ifndef PATHSPEC_H
>>>  #define PATHSPEC_H
>>>
>>> +#include "string.h"
>>> +#include "strings.h"
>>
>> What are these headers?
>
> The original patch[1] had explanations of why I added them:
>
> +#include "string.h"   /* For str[n]cmp */
> +#include "strings.h"  /* For str[n]casecmp */

Ah.  Please remove these #includes: they're part of the standard
library that we get implicitly via git-compat-util.h.

I was tripped up because they were in quotes instead of angle
brackets.

Thanks,
Jonathan
