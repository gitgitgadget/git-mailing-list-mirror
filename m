Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751C91F4F8
	for <e@80x24.org>; Wed,  5 Oct 2016 13:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754158AbcJENLX (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 09:11:23 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34518 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752754AbcJENLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 09:11:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id b201so19366418wmb.1
        for <git@vger.kernel.org>; Wed, 05 Oct 2016 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=M1oXueUQtiUBlW+YDz2ES6ifgbiITg8YofK6eyftaBg=;
        b=LSpMirFYpx3Y3a+OaWiMO4h394vdQnhVJSiEUA/aLY6qI+buhRaUTmh+2oAmZJuWQH
         62fpLfPSfC68n6FfSdoycqzXfo/gH6cF+vtRv9VksPke2lyN4IXDDuanh/vFSgqLT1zo
         JxAsmyRg7gAy4D2/t/rJbmqGxE4ZnF0JrIVPh4AefPYIgIuBPH8263jH3LMyGX0RrOZE
         rKBRHiIZAlVqmRQ1Su2mzKlDmOJVdM+cG8evmwXe1cxau+pQa14mvzEXxHa4PxWaRDpq
         AIa5Uc3tR9Yn1xT7u2qgCFYEp2faA8SHf4LX21GJv82oTLA6xcQzEdQAKdKCpgJ0+tz8
         MFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=M1oXueUQtiUBlW+YDz2ES6ifgbiITg8YofK6eyftaBg=;
        b=Yp8XM7Gb5UBuziTAaJro9l4TEfOj7tSGG1NSsmp+PXwpDqNVXMq+feLjTyUNCI0aLa
         hTFSQomsxi7NynCiM4nIyw6hrAthud8hImfx3WMs6coR4WSOhlLOvXpcA9auKLYZ4cQG
         G2heF93zYcUBBenBUoLY20R8HxgLDeblnLRavfRl7KUiyEARY8hx04tEqKien9SJMw3G
         Iv5w5n433qKDCyhmxVliEw9JFFZHeNDYXlFnMEZDHZvMShqlYQzKhzeoncY/OaDxRn9X
         LJkLH6fUs/neYNRGk78Z1lxVIVoIdKNIdJ7bns1WzhuTbMV7bs7tTqrP/Uy7NydUQMkx
         eFPA==
X-Gm-Message-State: AA6/9Rm4YlzFQQ+Ppm6V40sh/KPAcGOztpZes1LZKp2iJh9CBVLzKK6sdyK47859r7hb5g==
X-Received: by 10.194.126.133 with SMTP id my5mr9424394wjb.47.1475673080469;
        Wed, 05 Oct 2016 06:11:20 -0700 (PDT)
Received: from [192.168.1.26] (acte13.neoplus.adsl.tpnet.pl. [83.11.58.13])
        by smtp.googlemail.com with ESMTPSA id 74sm9489751wmi.7.2016.10.05.06.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Oct 2016 06:11:19 -0700 (PDT)
Subject: Re: Regression: git no longer works with musl libc's regex impl
To:     musl@lists.openwall.com, James B <jamesbond3142@gmail.com>
References: <20161004150848.GA7949@brightrain.aerifal.cx>
 <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net>
 <20161004154045.GT19318@brightrain.aerifal.cx>
 <alpine.DEB.2.20.1610041802310.35196@virtualbox>
 <20161005090625.683fdbbfac8164125dee6469@gmail.com>
 <20161004223322.GE19318@brightrain.aerifal.cx>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <bc3da1a4-4b99-737f-050e-54ef5844c402@gmail.com>
Date:   Wed, 5 Oct 2016 15:11:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20161004223322.GE19318@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 05.10.2016 o 00:33, Rich Felker pisze:
> On Wed, Oct 05, 2016 at 09:06:25AM +1100, James B wrote:
>> On Tue, 4 Oct 2016 18:08:33 +0200 (CEST)
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>>
>>> No, it is not. You quote POSIX, but the matter of the fact is that we use
>>> a subset of POSIX in order to be able to keep things running on Windows.
>>>
>>> And quite honestly, there are lots of reasons to keep things running on
>>> Windows, and even to favor Windows support over musl support. Over four
>>> million reasons: the Git for Windows users.
>>
>> Wow, I don't know that Windows is a git's first-tier platform now,
>> and Linux/POSIX second. Are we talking about the same git that was
>> originally written in Linus Torvalds, and is used to manage Linux
>> kernel? Are you by any chance employed by Redmond, directly or
>> indirectly?
>>
>> Sorry - can't help it.

Windows is one of the major platforms, yes.  I think there much, much
more people using Git on Windows, than using Git with musl.  More
users = more important.

Also, working with some inconvenience (requiring compilation with
NO_REGEX=1) is better than not working at all.

In CodingGuidelines we say:

 - Most importantly, we never say "It's in POSIX; we'll happily
   ignore your needs should your system not conform to it."
   We live in the real world.

 - However, we often say "Let's stay away from that construct,
   it's not even in POSIX".

 - In spite of the above two rules, we sometimes say "Although
   this is not in POSIX, it (is so convenient | makes the code
   much more readable | has other good characteristics) and
   practically all the platforms we care about support it, so
   let's use it".

The REG_STARTEND is 3rd point, mmap shenningans looks like 1st...

...on the other hand midipix <writeonce@midipix.org> wrote in
http://public-inbox.org/git/20161004200057.dc30d64f61e5ec441c34ffd4f788e58e.efa66ead67.wbe@email15.godaddy.com/
that the proposed fix should work on all Windows version we are
interested in (I think).  Test program included / attached.

The above-mentioned email also explains that the problem was
caught on MS Windows; it triggers if file end falls on the mmapped
page boundary, which is more likely to happen with 4096 mod size
on Windows rather than 65536 mod size on Linux.


On the other hand, while the proposed solution of "add padding as
to not end at page boundary, if necessary" doesn't have the
performance impact of "memcpy into NUL-terminated buffer" that
was originally proposed in patch series, it is still extra code
to maintain.

> 
> I don't think the hostility and sarcasm are really needed here. But
> what this does speak to is that users don't like feeling like their
> platform is being treated as a second-class target, which is what it
> feels like when you have to manually flip a switch to make git build.

You are welcome to send a patch adding to configure.ac detection
of REG_STARTEND support in standard library - setting NO_REGEX if
needed, and/or adding to Makefile uname-based defaults setting
NO_REGEX for compiling with musl.

> This is especially unfriendly when the semantics of the switch come
> across, at least to some users, as "your system regex is incomplete"
> rather than "git can't use it because git depends on nonstandard
> extensions".

Nonstandard but common extension.  As 2f8952250a commit message says
https://github.com/git/git/commit/2f8952250a84313b74f96abb7b035874854cf202

  Happily, there is an extension to regexec() introduced by the NetBSD
  project and present in all major regex implementation including
  Linux', MacOSX' and the one Git includes in compat/regex/: [...]

  [...]

  Since support for REG_STARTEND is so widespread by now, let's just
  introduce a helper function that always uses it, and tell people
  on a platform whose regex library does not support it to use the
  one from our compat/regex/ directory.

Also, as Junio said, the description of NO_REGEX option in the
Makefile now explicitly says:

    # Define NO_REGEX if your C library lacks regex support with REG_STARTEND
    # feature.

Best,
-- 
Jakub Narębski

