Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CE0220960
	for <e@80x24.org>; Thu, 13 Apr 2017 23:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbdDMXoX (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 19:44:23 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35829 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752940AbdDMXoW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 19:44:22 -0400
Received: by mail-io0-f179.google.com with SMTP id r16so95243295ioi.2
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 16:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Uzq7h7dSfPUkZ3yyvd120dvrQhJD/Vpw7ERe/XtwqqI=;
        b=lD8REj1/hns2EjzNCJT/PQFVGgDiDfG3dwf9EQMfqSAfIgymuAipd8c4Y1y4+D1BF+
         jz1pYEvbB0bhv5l4+oIitDhdXjQHLuT5wOThj1lwkIbMvt/FDDustK2Senxs87UTWfp0
         ZVpE7tsvOXZVpEPLeCHCC3FmfDprJ1sA2attcqS7natAr72iFZ+NFj7ZTAnvi5/3LJQG
         cjiSMB/+rC/7mawed3LYVXPWnfn5yJ5KdRgzXkGJGmXxykh7CZ6te23v2gmvO0MHGc1n
         oibCCZZJVOLWUH/nT15BXtRfbBn+lr1XU4RfyG3FK4UfsT4jv/q4tK1mlhqLFNgk1Fc0
         vzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Uzq7h7dSfPUkZ3yyvd120dvrQhJD/Vpw7ERe/XtwqqI=;
        b=rQbW/TWys8VpGnZd0Tw+aXZzqlIQ65vBH/KxhNJdMQReTJ93jCOzISGTBdalUAEE9V
         2Tcl8j6ODOQY9H2Gs/ZYiaRzwXtebkGpQ1P0Fp/EBJbijO73sQ/grhc8l2fz9rtLaC++
         L1fqzE7o2BZaRR2lOu05jcMmuHtFx3IVSs5ZZMzdZt68E09enspnaMEEJfutPfltiVnz
         vk41yjbkcUYl44glgBlKsjw8x3OXpGaUdkgx+D+y9xJoRbetvHXkx/ooLyO/zVGlA6qy
         z6IDqcxSo+01q8OiafICGboO7UPRW+j+jY2PiMKffLK+b9gGHG5slfbAcDfRIxLvDquq
         kJbA==
X-Gm-Message-State: AN3rC/7wZqdVnUZ/5r5lGJhYD5qCev7kWD+SDfHhCjdTtK0nBOMj9m4V
        qKXip9Is6A6+NYKd
X-Received: by 10.107.58.9 with SMTP id h9mr5620241ioa.226.1492127059928;
        Thu, 13 Apr 2017 16:44:19 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id i11sm2325214itf.10.2017.04.13.16.44.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 16:44:19 -0700 (PDT)
Date:   Thu, 13 Apr 2017 16:44:18 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, e@80x24.org
Subject: Re: [PATCH v2 0/6] forking and threading
Message-ID: <20170413234418.GB13936@google.com>
References: <20170410234919.34586-1-bmwill@google.com>
 <20170413183252.4713-1-bmwill@google.com>
 <20170413205008.GB10084@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170413205008.GB10084@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > From what I can see, there are now no calls in the child process (after fork
> > and before exec/_exit) which are not Async-Signal-Safe.  This means that
> > fork/exec in a threaded context should work without deadlock
> 
> I don't see why the former implies the latter.  Can you explain
> further?
> 
> You already know my opinions about fork+threads by now.  I continue to
> think this is heading in a direction of decreased maintainability that
> I dread.

I disagree here.  No one thought it was a bad idea back when I was
implementing grep to fork while running with threads.  Id rather fix the
problem in run_command so that we don't ever have to worry about this
again, especially for contributors who are unaware of this issue while
threading.

> 
> That's not to say that this is wasted work.  I would prefer an approach
> like the following:
> 
>  1. First, make grep work without running fork() from threads.
>     Jonathan Tan's approach would be one way to do this.  Another way
>     would be to simply disable threads in --recurse-submodules mode.
> 
>     This would be the first thing to do because it would make tests
>     reliable again, without having to wait for deeper changes.

I'm not much of a fan of Jonathan Tan's suggestion, id rather just fix
the problem at its root instead of adding in an additional hack.  If
this series crashes and burns then yes, lets just shut off threading in
grep with --recurse-submodules is uses, otherwise this series will fix
that case.

> 
>  2. Then, teaching run_command to prepare the environment and do $PATH
>     lookup before forking.  This might make it possible for run_command
>     to use vfork or might not.
> 
>  3. Teaching run_command to delegate chdir to the child, using -C for
>     git commands and 'cd' for shell commands, and using a shell where
>     necessary where it didn't before.
> 
>  4. Switching run_command to use posix_spawn on platforms where it is
>     available, which would make it possible to use in a threaded
>     context on those platforms.

After this series it should be easy enough to convert to posix_spawn if
someone wants to follow up with a patch to do that.

-- 
Brandon Williams
