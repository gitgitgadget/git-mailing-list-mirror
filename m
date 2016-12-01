Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB1EA1FF40
	for <e@80x24.org>; Thu,  1 Dec 2016 00:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754505AbcLAAIl (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 19:08:41 -0500
Received: from mail-pf0-f173.google.com ([209.85.192.173]:33429 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751500AbcLAAIk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 19:08:40 -0500
Received: by mail-pf0-f173.google.com with SMTP id d2so41917372pfd.0
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 16:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IUWDSq5w7yWXG55jBEcSe+XkwVSAZY8K6bAm8rW/XAE=;
        b=DrwcssQC5w4sXLUq44uJVZpc88kXDx57pNfBKKzywacbnMysMocU+AtHUJjuPiSInh
         SbkuLAYoO0QZ1fFrm9EAq8JIA1BkT1s0CAufWpjwF9CTJ+bh9znxUoXiUl13bLTD/MGq
         pdqOu7rF00ujYXIEF5QFkvfh7SotjNb8FZzFJ/hNz03M0wWRWXEecCycR56brCwiIEFD
         R1+AQciJrd9wah5H6Hv3AkLwLnLFasMyPmIXKbit5bHrGynEX7kTOfQNPHvkCa2QCm5x
         sFfSegB7yp5PbZ3m1TbT0E3RzS8ZPO9BRTCgeWciaukmgvwW7kjUA/wD9ATZawM6JgPz
         vVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IUWDSq5w7yWXG55jBEcSe+XkwVSAZY8K6bAm8rW/XAE=;
        b=THfX0bDKE6JTIOBAw1BXkXMLMX0vJ9NlOc7DjYDsmMmZU4Sc9Ro3clXAZ8spsRQMvr
         lK/OKFGLk+giT3kqHhQd3tk/595M4ZcPHwpfqcffOSrrx1n5zRoIAW+kM4eQFvf4cnFx
         5wdrP6Za2v3VKOKQQe2jxOlrYrU9MpUbZyIBhLzd6KHexW0OZDIROpShn+B/0aymUtmb
         raqcLrjQv/+DP0UbDIQYo6Y7UtvQ6+N9eyytya1Ia196k0V5ju/FtK2wSMFEZHGLuO0v
         5iluWog6Ouauh64liM6QUcpQT5LzQClX/gDVKUFS/PEJapbz5/7w45nf9poCM41cce+I
         I04Q==
X-Gm-Message-State: AKaTC00glXoS+tuHgZzcEhCHDptSgpAjfFW6IIOzROulB8CYUaN38frgndI7kdpzcCl7tiHM
X-Received: by 10.99.230.83 with SMTP id p19mr62995425pgj.138.1480550907003;
        Wed, 30 Nov 2016 16:08:27 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ddc5:5173:1b11:9434])
        by smtp.gmail.com with ESMTPSA id u23sm105360566pfg.86.2016.11.30.16.08.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 16:08:25 -0800 (PST)
Date:   Wed, 30 Nov 2016 16:08:24 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
Message-ID: <20161201000824.GE192901@google.com>
References: <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net>
 <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com>
 <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net>
 <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
 <20161130234248.GB192901@google.com>
 <20161130234636.6az7xfywzprpn6ly@sigill.intra.peff.net>
 <20161130235952.4j63gkdlbobjitdb@sigill.intra.peff.net>
 <20161201000437.altjlcsn4u7rwe5c@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161201000437.altjlcsn4u7rwe5c@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/30, Jeff King wrote:
> On Wed, Nov 30, 2016 at 06:59:52PM -0500, Jeff King wrote:
> 
> > So I think there is some other chdir(). I'm not sure if there is an easy
> > way to get a backtrace on every call to chdir() in every thread. I'm
> > sure somebody more clever than me could figure out how to make gdb do it
> > automatically, but it might be workable manually. I think the chdir was
> > in the main thread.
> 
> Ah, that turned out to be quite easy. The culprit is probably:
> 
> (gdb) bt
> #0  chdir () at ../sysdeps/unix/syscall-template.S:84
> #1  0x00005555555fe259 in real_path_internal (path=0x5555559f6b30 "su:b/../.git/modules/su:b", die_on_error=1)
>     at abspath.c:84
> #2  0x00005555555fe48a in real_path (path=0x5555559f6b30 "su:b/../.git/modules/su:b") at abspath.c:135
> #3  0x00005555556d09e6 in read_gitfile_gently (path=0x5555559f6ac0 "su:b/.git", return_error_code=0x0)
>     at setup.c:555
> #4  0x00005555556d19cf in resolve_gitdir (suspect=0x5555559f6ac0 "su:b/.git") at setup.c:1021
> #5  0x00005555556e7e34 in is_submodule_populated (path=0x5555559f5ec8 "su:b") at submodule.c:244
> #6  0x00005555555a0f05 in grep_submodule (opt=0x7fffffffd8b0, sha1=0x0, filename=0x5555559f5ec8 "su:b", 
>     path=0x5555559f5ec8 "su:b") at builtin/grep.c:619
> #7  0x00005555555a12ac in grep_cache (opt=0x7fffffffd8b0, pathspec=0x7fffffffd880, cached=0) at builtin/grep.c:700
> #8  0x00005555555a36cb in cmd_grep (argc=0, argv=0x7fffffffdf40, prefix=0x0) at builtin/grep.c:1257
> #9  0x000055555556603b in run_builtin (p=0x5555559b3ad8 <commands+984>, argc=4, argv=0x7fffffffdf40) at git.c:373
> #10 0x00005555555662bc in handle_builtin (argc=4, argv=0x7fffffffdf40) at git.c:572
> #11 0x000055555556641a in run_argv (argcp=0x7fffffffddfc, argv=0x7fffffffddf0) at git.c:630
> #12 0x00005555555665a8 in cmd_main (argc=4, argv=0x7fffffffdf40) at git.c:702
> #13 0x00005555555fde47 in main (argc=7, argv=0x7fffffffdf28) at common-main.c:40
> 
> So is_submodule_populated() needs to take a lock. But what's really
> gross is that the _other_ threads need to lock just to call lstat().
> Presumably it could be done as a reader/writer type of lock where many
> "reader" threads can take the "I need to lstat()" lock simultaneously,
> but block when an "I'm going to chdir()" writer holds it.
> 
> -Peff

Oh interesting, I wonder if there is a way to not have to perform a
chdir since taking a lock to lstat wouldn't be ideal.

Thanks for helping out with this!

-- 
Brandon Williams
