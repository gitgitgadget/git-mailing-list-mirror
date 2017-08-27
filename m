Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9AB208DB
	for <e@80x24.org>; Sun, 27 Aug 2017 11:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751135AbdH0LeD (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 07:34:03 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:36348 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbdH0LeC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 07:34:02 -0400
Received: by mail-wr0-f172.google.com with SMTP id p14so10940843wrg.3
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 04:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o068rmfFj0V4T4m/mx9UQmtY94JgQVqTkcFKNeCwDgM=;
        b=uP8zJw5/aKpblDvpeWcboRANTAZ3oWLjwW008PFTJd2fxgjiS0wg7S9xLx2yF5zbSZ
         XjK8dX8MYoLvuQZ3GxGLsMusTBOGu7y0yn8VL/cKz5ArjoyROkzvoEIMQ04oyzFt1IG9
         wxJHV8603A36AKjuqZxpFLIwo8KwWhnow5aXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o068rmfFj0V4T4m/mx9UQmtY94JgQVqTkcFKNeCwDgM=;
        b=tSKj1oxZc8T54c1cL1454mj6OpYKIorHShMwZqGHM0+HRArUNsOtAqgNznwRy5RY8R
         lKPTKDhkyaFzEmlyvjOanEuaLFrAtrTz8YHiBjd+B9vdX5gRgVQqTMgDa3OyvJHN9eVh
         yp58iHEB1Yu3J945yHjg0SETnVRMa4xueVpsK1OqoXqYN/srbOtjyKvlPa6ygFflHOTO
         4dzf9Hj6Ka9Kc2KLeMnNVinAlklXcjRBoPXqgGt6u913nDH+Is0fDN9M9/jDdaTXpVNa
         99i7FCRQbKvPlUak5O51b+V/+O/0z9/PkTE0YkS+87MdL/5VwDZrMDS860uMCXterkTa
         th6Q==
X-Gm-Message-State: AHYfb5hO5KGEkKjEHeVwAwNzgvP91RbA+MMToMqGtzA2J2BH4E+izsjl
        GeKyGtkAgjkY6lN+
X-Received: by 10.223.138.204 with SMTP id z12mr2469735wrz.195.1503833641221;
        Sun, 27 Aug 2017 04:34:01 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id 64sm6374312wrj.68.2017.08.27.04.34.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Aug 2017 04:34:00 -0700 (PDT)
Date:   Sun, 27 Aug 2017 12:33:58 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: cat-file timing window on Cygwin
Message-ID: <20170827113358.GF10378@dinwoodie.org>
References: <20170825112529.GA10378@dinwoodie.org>
 <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
 <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
 <20170826185337.hrcswjuunon54kgj@sigill.intra.peff.net>
 <20170826211104.GC10378@dinwoodie.org>
 <c5f3fe2d-6d76-7c08-2a50-fb10c66adc48@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5f3fe2d-6d76-7c08-2a50-fb10c66adc48@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 27, 2017 at 03:06:31AM +0100, Ramsay Jones wrote:
> On 26/08/17 22:11, Adam Dinwoodie wrote:
> > On Sat, Aug 26, 2017 at 11:53:37AM -0700, Jeff King wrote:
> >> Interesting. I find it a little hard to believe there's so obvious a bug
> >> as "fflush(NULL) flushes stdin", but well...that's what it seems like.
> >>
> >> If that's truly what it is, this is the minimal reproduction I came up
> >> with:
> >>
> >> -- >8 --
> >> #include <stdio.h>
> >>
> >> int main(void)
> >> {
> >> 	char buf[256];
> >> 	while (fgets(buf, sizeof(buf), stdin)) {
> >> 		fprintf(stdout, "got: %s", buf);
> >> 		fflush(NULL);
> >> 	}
> >> 	return 0;
> >> }
> >> -- 8< --
> >>
> >> If this really is the bug, then doing something like "seq 10 | ./a.out"
> >> would drop some of the input lines.
> > 
> > ...yep.  It does.  Specifically, I consistently only get the firsts
> > line:
> > 
> >     $ seq 10 | ./a.exe
> >     got: 1
> >     
> >     $ 
> > 
> > If I introduce a delay between the lines of stdin (which I tested by
> > just typing stdin from the keyboard), it works as expected.
> > 
> > Looks like this one will need to go to the Cygwin mailing list; I'll
> > take it there shortly.  Thank you all for your help getting this far!
> 
> This is apparently fixed in cygwin v2.8.3 [see commit 78ade082fe,
> ('Revert "errno: Stop using _impure_ptr->_errno completely"', 19-07-2017),
> commit 9cc89b0438 ("cygwin: Use errno instead of _impure_ptr->_errno", 19-07-2017), commit a674199fc9 ("cygwin: Bump DLL version to 2.8.3",
> 19-07-2017) and commit d2ae2f00b8 ("cygwin: add fflush fix to release
> notes", 19-07-2017)].
> 
> I haven't had a chance to try v2.8.3 yet (it's 3am and I'm about to
> go get some sleep).

Cygwin 2.8.3 hasn't been released yet, but I've just tested the latest
development snapshot with Jeff's simple test case, and it works as
expected, so I'm going to assume the Git test will start passing once
that version of the Cygwin DLL is released too.
