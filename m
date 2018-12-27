Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1485A211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 18:59:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbeL0S7E (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 13:59:04 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41500 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeL0S7D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 13:59:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id b7so9464483pfi.8
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yiZ1Y/q4SIcv4fnPlTIG7zbC9aalnV3Fx9W8YrTDh+E=;
        b=aC7iLfULL56NuWzBcZiC1Mt/9VQzQaPk1pds16tjbMxfc3NB1+K369lUTWRFS6oP/N
         WmEGl6Sk3xwkzGHlXerBgfy36AoLAfj0K1uRTSqYdmUI6Ksbp6kARFPbPdONp5OoVxXM
         89oRyhMTE3JXLWWd0BHUZxYKzeeNqg4lPCUYQB+9MEN0oATLuyD4LZ55SuJ928occVSu
         s7wTa7esqthYhJOxzH5yYidNda2e63O10D0mU7qNbKO/OnMLbzO9lXH/xwi8jufJglwS
         DNYRNHINL40h35HgCFXdJ8iaRmxmt8SWW46MH9mNxxeN0hq1zW99SU2udxYkrGyk223b
         oKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yiZ1Y/q4SIcv4fnPlTIG7zbC9aalnV3Fx9W8YrTDh+E=;
        b=URsrXiGdsLOyf0+hlPSXLAhkwxHYGp/tNXnvH/6lnuhREijrNwzKpbapAw9wxZWcrW
         7tfCUt+ixyVq3e8NU4kpMqxrsvPt82D9vf/L+bvYlGlEop9s3bX0bfsgoelNPeo80T4+
         8NhuXmks7W76vutOyBzd2pB8EiFDY/lyAFWkpkwt1jNMbYe6ZAKREMUURpb5kJKzxnGD
         NaW3W5EP7c7/J7XAbLKyBtWTq1MbzXWqPgqZ1KrX/s/nUqESxIaJbIEnYzCv0Hf3wKQd
         ofXH7OKHQWlf3UKJcdjcCqG64MfiD2vz1R7IWP6rpU0jcQ3yoVtKdzpYTUiy+Y9ArE00
         khDA==
X-Gm-Message-State: AJcUukf2UfRhA/CywLtNYsBgDRU2yT+eoDTzq/tC7kuISLsxp+UcXUgb
        A2C6BUOEw9cCHUV9GKSWU8+tJvV1
X-Google-Smtp-Source: ALg8bN4yFSsHfAyWamOhYomvkwq11tP+Xv8g0QMd1mA6kdXwwrLfJawN/mWHUj7UIhNfOJc0aVVbHA==
X-Received: by 2002:a63:f552:: with SMTP id e18mr23885456pgk.239.1545937142119;
        Thu, 27 Dec 2018 10:59:02 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id d21sm1777650pfo.162.2018.12.27.10.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Dec 2018 10:59:01 -0800 (PST)
Date:   Thu, 27 Dec 2018 10:59:00 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>,
        Masaya Suzuki <masayasuzuki@google.com>
Subject: Re: [PATCH] config.mak.dev: add -Wformat
Message-ID: <20181227185900.GE146609@google.com>
References: <20181012184037.15076-1-t.gummerer@gmail.com>
 <20181012184549.GC4917@sigill.intra.peff.net>
 <20181012185450.GB52080@aiede.svl.corp.google.com>
 <20181012191531.GA22611@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012191531.GA22611@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc: Masaya Suzuki
In October, Thomas Gummerer wrote:
> On 10/12, Jonathan Nieder wrote:
>> Jeff King wrote:
>>> On Fri, Oct 12, 2018 at 07:40:37PM +0100, Thomas Gummerer wrote:

>>>> 801fa63a90 ("config.mak.dev: add -Wformat-security", 2018-09-08) added
>>>> the -Wformat-security to the flags set in config.mak.dev.  In the gcc
>>>> man page this is documented as:
>>>>
>>>>          If -Wformat is specified, also warn about uses of format
>>>>          functions that represent possible security problems.  [...]
>>>>
>>>> That commit did however not add the -Wformat flag, and -Wformat is not
>>>> specified anywhere else by default, so the added -Wformat-security had
>>>> no effect.  Newer versions of gcc (gcc 8.2.1 in this particular case)
>>>> warn about this and thus compilation fails with this option set.
>> [...]
>>> -Wformat is part of -Wall, which we already turn on by default (even for
>>> non-developer builds).
[...]
>> Thomas, do you use autoconf to generate config.mak.autogen?  I'm
>> wondering if that produces a CFLAGS that doesn't include -Wall.
>
> No, this was all my mistake :)

As discussed in [1], autoconf appears to not put -Wall in CFLAGS:

 $ make configure
     GEN configure
 $ ./configure
[...]
 config.status: creating config.mak.autogen
 config.status: executing config.mak.autogen commands
 $ grep CFLAGS config.mak.autogen
 CFLAGS = -g -O2
 PTHREAD_CFLAGS=-pthread

So this trap for the unwary is still around.

Can we revive this patch?  Does it just need a clearer commit message,
or were there other objections?

>>> I'm not opposed to making config.mak.dev a bit more redundant to handle
>>> this case, but we'd probably want to include all of -Wall, since it
>>> contains many other warnings we'd want to make sure are enabled.
>>
>> Do you mean putting -Wall instead of -Wformat?
>>
>> Should we add -Wextra too?  From a quick test, it seems to build okay.
>
> We do have that with setting DEVELOPER=extra-all.

Even better.  What do you think of making DEVELOPER=YesPlease imply
that?

Thanks,
Jonathan

[1] https://public-inbox.org/git/CAJB1erVmZQd_kLU1fqL7cURrEUz2EJ4Br0kgVQt7T-mk3s95dQ@mail.gmail.com/
