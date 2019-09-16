Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01EA31F463
	for <e@80x24.org>; Mon, 16 Sep 2019 15:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388895AbfIPPD5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 11:03:57 -0400
Received: from mail-qk1-f175.google.com ([209.85.222.175]:40004 "EHLO
        mail-qk1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387854AbfIPPD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Sep 2019 11:03:56 -0400
Received: by mail-qk1-f175.google.com with SMTP id y144so266353qkb.7
        for <git@vger.kernel.org>; Mon, 16 Sep 2019 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=2DiMRAwnQPBtuk+rN6Nzvi3XEatqB+6st/G1sfUXO1A=;
        b=uGN/4iPo+B4JLsjBBQLALZqY+YKe35XgrdfCDpPeOTbvVOvLmFgN8W4wtx+G8zWNRq
         YytGb4J/cLwscXqr9MH+RbxpFFiHVYVMHBZTTIg5xFvQVVI3XkRSy80LwkOShsqaaRX/
         K+78Z2QpVLqgiNDKQqHokdDXCkYy2wDGYMzDbMOsUyF+mGFRinN3JY/2LKHj5Jsp+ARu
         bzPCgzw0WMVC+vFbutLRIQHVKd1451uNhMX37SrkLNpBDBKCznBxcQDOg9hACxi9cQYy
         s6TpEXEJJXOcDwjtq23MMas89/wsBYc6jADGrQwCpyl3HhlmzVe5M7ZXnseaxJUSP5L8
         OYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2DiMRAwnQPBtuk+rN6Nzvi3XEatqB+6st/G1sfUXO1A=;
        b=qVExgXIpR40OGUfx3KbKh+ql8UDl/gj2GeUZUwxlb03NeHAh+CcUvUs7I/SZG6s219
         DBfTwVpmUgmlaFX43jyDUc6zqs21TfUFk6khPz5OF4Z/YbSv+pz96d9r0LkuARMo90Jj
         hcJaCdqyQXOt13B63T7pvYOH3w+IGzXwwlc28E5yiJ8PKMPuIWfOxP1xMytWpra0TSHr
         IDQHqlpV3lZ8sNEv/38cOHliBkh2flDwaUxmUAr37O7JN+ovCb84HT400vO/bK+MhHg4
         vYRgMUJkW9HCpjW9om0LXog2kbxWZvilgbzdbGoQXS3fFWR9GtuTM49Eja+UHGLm/dbK
         Z3hg==
X-Gm-Message-State: APjAAAXCbWtOCcpqKeT2jwfjpO7fkGCOMxAKSzUyOyjWwQJS1duIQhKg
        LB15M5k2+N+3NhhLY6vd5ffj0WTg8Mo=
X-Google-Smtp-Source: APXvYqzNv9FCE4j77sajn8u2pA0/qlje9ENXIhlNDiuX697ydL/2D2uJU5oQiO8jFMPgPhTsDaLJtw==
X-Received: by 2002:a37:498f:: with SMTP id w137mr350085qka.419.1568646235073;
        Mon, 16 Sep 2019 08:03:55 -0700 (PDT)
Received: from ?IPv6:2620:0:1004:a:6e2b:60f7:b51b:3b04? ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id y4sm6505727qkl.107.2019.09.16.08.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2019 08:03:54 -0700 (PDT)
Subject: Re: blame --ignore-rev - add place to specify defaults at repo level
To:     Terry Davis <terry.y.davis@gmail.com>, git@vger.kernel.org
References: <CAEziGD9bWPfV+L5z_-drATT8Fxvj=8hzNAQcNH9f9Ez+ncaEvw@mail.gmail.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <c34159af-f97e-82b3-e2a1-04adae5c10ac@google.com>
Date:   Mon, 16 Sep 2019 11:03:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAEziGD9bWPfV+L5z_-drATT8Fxvj=8hzNAQcNH9f9Ez+ncaEvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi -

On 8/28/19 1:07 PM, Terry Davis wrote:
> The new blame options (--ignore-rev, --ignore-revs-file) and config options
> (blame.markIgnoredLines,  blame.markUnblamables,  blame.ignoreRevsFile) are
> great, and much appreciated. However, for my primary use (one-time
> automated reformatting of an entire repository), there is still some
> friction preventing adoption.
> 
> Adding a default location for the config options (much like .gitignore)
> specified above would have the following benefits:
> 
>     1. New users of a repository would not need to take the extra step of
>     configuring their workspace for blame. This is most impactful for open
>     source projects with many contributors.
>     2. Git services (github, gitlab, etc.) could incorporate this feature
>     into their blame systems automatically.
> 
> If this has already been discussed, please point me to the thread, as I am
> a new member of this list.

Sorry for the delayed response.  In v1 I had a default ignore file:

https://public-inbox.org/git/20190107213013.231514-1-brho@google.com/

The first few responses have some feedback in that area.  The short 
version: don't give the users potentially incorrect results without them 
knowing about it.  Though if in practice users just run a one-time 
script to turn on a default ignore file and then never think about it 
again, that might be less of a concern.

But we do return "incorrect" results from blame ignore.  We have a bunch 
of 'mark' options to help with this, but I don't think there was a 
consensus on what the best ones were.  Some people wanted to see any 
ignored lines, some wanted to see unblamables, some not, etc.  I can 
picture users who are unfamiliar with blame-ignore getting annoyed by 
tracing through a line's history and getting surprised by a wrong answer.

Maybe once the feature gains popularity and gets used a bit more, we can 
learn what good defaults are, and then we can make a particular ignore 
file a default setting.  I'd be fine with that, but then again I had a 
default file in the first place.  =)

FWIW, I just set a single ignore-revs-file globally, though that will 
only work if every project uses the same filename.  I went with 
".git-blame-ignore-revs", which is what ChromeOS did for hyper-blame and 
what I use on some of my projects.

Thanks,

Barret

