Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B04781F4DD
	for <e@80x24.org>; Sat, 26 Aug 2017 15:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751093AbdHZPnL (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Aug 2017 11:43:11 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:35459 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdHZPnK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Aug 2017 11:43:10 -0400
Received: by mail-wr0-f175.google.com with SMTP id p8so7049793wrf.2
        for <git@vger.kernel.org>; Sat, 26 Aug 2017 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ORV/W5xtvYI80HZTn7ak/brdQ5JAJJDkOna4vnDyug0=;
        b=hIbIvLq9G7rxqMHFgfkfsQ3h2si7hahKyZtgVGJDGVSx2kZAS0yzVZHhJE0BfKBV2u
         ArKJkheJKv255Z2ceARuV8zoUyHjOhDCzDUwRKOSoLnZHCeTVCUm1OuEifYSgewznccg
         Yp2J0+N+wnEE+4qpoOJdu6+smGpgpDxI7diuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ORV/W5xtvYI80HZTn7ak/brdQ5JAJJDkOna4vnDyug0=;
        b=WkbLzyvnV/Ba4ptjIlQwMoap7qIHcostJR37svKmRNzkAjqPGXIxPNsL+r4mQtpDkq
         xQjk2Acvrtm8IxuMeIPiajVnSceLTVdxYttV9sIgxz6fe9wtX5z//+54V+YhMEF6uFjj
         CQAxDiLLZKxKBaiOK2lDEzMwh3BxlmCrL2DmELUFD3U20G2+fltZE3q4edyT/Tbquf65
         eiQ6HffWPUKBvTlhIFWlxEUxrtnv0QGDW/SXyRqtEAnOq8OJTmeOGMdA7MHu8AMc9qP5
         wQLocj1lKz5CnVrjWSHHrS+oEPoR7/opAXLbE5eqzcIanjwc+NggGdnoLVdT8ej7aGZN
         7QVA==
X-Gm-Message-State: AHYfb5jEWWaLIJNlQbvBZrzjxREQPly0U51k4N7E1avwjX/VhQCeJXUj
        RdhEd9ZzmMKd5+7CswOu6Q==
X-Received: by 10.223.139.211 with SMTP id w19mr1443509wra.166.1503762189246;
        Sat, 26 Aug 2017 08:43:09 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id i32sm7612622wrf.14.2017.08.26.08.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Aug 2017 08:43:08 -0700 (PDT)
Date:   Sat, 26 Aug 2017 16:43:06 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: cat-file timing window on Cygwin
Message-ID: <20170826154306.GB10378@dinwoodie.org>
References: <20170825112529.GA10378@dinwoodie.org>
 <20170825150819.agxvbjytom7ao6n6@sigill.intra.peff.net>
 <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <253bf111-4e8a-54b7-6e39-2908270aa357@ramsayjones.plus.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 26, 2017 at 01:57:18AM +0100, Ramsay Jones wrote:
> On 25/08/17 16:08, Jeff King wrote:
> > On Fri, Aug 25, 2017 at 12:25:29PM +0100, Adam Dinwoodie wrote:
> > 
> >> As of v2.10.0-rc1-4-g321459439 ("cat-file: support --textconv/--filters
> >> in batch mode"), t8010-cat-file-filters.sh has been failing on Cygwin.
> >> Digging into this, the test looks to expose a timing window: it appears
> >> that if `git cat-file --textconv --batch` receives input on stdin too
> >> quickly, it fails to parse some of that input.
> 
> This has not been failing since the above commit (when this
> feature was first introduced), but (for me) when testing the
> v2.13.0-rc0 build. Please refer to my original email:
> 
> https://public-inbox.org/git/bf7db655-d90f-e711-afc8-6565b71373d2@ramsayjones.plus.com/
> 
> ... where I was reasonably sure this was caused by a change in
> the cygwin dll while upgrading from 2.7.0-1 -> 2.8.0-1.

The failure started at some point when I wasn't paying much attention to
the state of Cygwin or Git due to personal health stuff.  Now I'm
catching up with the backlog from that period, I bisected the Git builds
to get to the commit referenced above, but it's entirely plausible the
behaviour change is in the Cygwin DLL and is merely exposed by the test
that commit added.

> > Hmm. That commit doesn't seem to actually touch the stdin loop. That
> > happens via strbuf_getline(), which should be pretty robust to timing.
> > But here are a few random thoughts:
> > 
> >   1. Do you build with HAVE_GETDELIM? Does toggling it have any effect?
> 
> If Adam builds using the configure script, then yes, else no. ;-)
> I never use configure, so I don't have HAVE_GETDELIM set.

I do use the configure script and do run with HAVE_GETDELIM set.  As you
might expect given that Ramsay doesn't and they see the same behaviour,
toggling it makes no difference to whether t8010.8 passes or fails.

> >   2. Does the problem happen only with --textconv?
> > 
> >      If so, I wonder if spawning the child process is somehow draining
> >      stdin. I don't see how the child would accidentally read from our
> >      stdin; we replace its stdin with a pipe so it shouldn't get a
> >      chance to see our descriptor at all.
> 
> As I said in my previous email, "the loop in batch_objects()
> (builtin/cat-file.c lines #489-505) only reads one line from
> stdin, then gets EOF on the stream."

Testing now, removing --textconv does seem to make a difference.  With
the following diff, t8010 passes:

diff --git a/t/t8010-cat-file-filters.sh b/t/t8010-cat-file-filters.sh
index d8242e467..7c85bef9b 100755
--- a/t/t8010-cat-file-filters.sh
+++ b/t/t8010-cat-file-filters.sh
@@ -54,9 +54,9 @@
 test_expect_success 'cat-file --textconv --batch works' '
 	sha1=$(git rev-parse -q --verify HEAD:world.txt) &&
 	test_config diff.txt.textconv "tr A-Za-z N-ZA-Mn-za-m <" &&
-	printf "%s hello.txt\n%s hello\n" $sha1 $sha1 |
-	git cat-file --textconv --batch >actual &&
-	printf "%s blob 6\nuryyb\r\n\n%s blob 6\nhello\n\n" \
+	printf "%s\n%s\n" $sha1 $sha1 |
+	git cat-file --batch >actual &&
+	printf "%s blob 6\nhello\n\n%s blob 6\nhello\n\n" \
 		$sha1 $sha1 >expect &&
 	test_cmp expect actual
 '

(I am mildly baffled by the necessary change in line endings in the
`expect` file, but that's the output that was being produced, and I
actually think the single CRLF line ending in the file that otherwise
uses LF in the original test is the oddity here.)

A similar test using my live version of Git also works as expected:

    $ { echo $sha1 ; echo $sha1 ; } | git cat-file --batch
    ce013625030ba8dba906f756967f9e9ca394464a blob 6
    hello
    
    ce013625030ba8dba906f756967f9e9ca394464a blob 6
    hello

> >      If we accidentally called fflush(stdin) that would discard buffered
> >      input and give the results you're seeing. We don't do that
> >      directly, of course, but we do call fflush(NULL) in run-command
> >      before spawning the child. That _should_ just flush output handles,
> >      but it's possible that there's a cygwin bug, I guess.
> 
> I suspect so, see previous email ...
> 
> > I can't reproduce here on Linux. But does the patch below have any
> > impact?
> > 
> > diff --git a/run-command.c b/run-command.c
> > index 98621faca8..064ebd1995 100644
> > --- a/run-command.c
> > +++ b/run-command.c
> > @@ -641,7 +641,6 @@ int start_command(struct child_process *cmd)
> >  	}
> >  
> >  	trace_argv_printf(cmd->argv, "trace: run_command:");
> > -	fflush(NULL);
> >  
> >  #ifndef GIT_WINDOWS_NATIVE
> >  {
> 
> I suspect not, but I can give it a try ...
> 
> ... oh, wow, that works! Ahem. (Hmm, so it's flushing stdin?!)
> 
> Also, t5526-fetch-submodules.sh still works as well (see commit
> 13af8cbd6a "start_command: flush buffers in the WIN32 code path
> as well", 04-02-2011).

Likewise, this gets t8010 passing for me.  I've run through the entire
test suite and there are no other new breakages, too.
