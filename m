Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F86B1F404
	for <e@80x24.org>; Sun, 16 Sep 2018 06:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeIPLt4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 07:49:56 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:46132 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeIPLtz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 07:49:55 -0400
Received: by mail-pg1-f180.google.com with SMTP id b129-v6so6187058pga.13
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 23:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=da+EHGw7C4rRUkSVH/M/QAj5mzd2uzXApA0MgPXRgPQ=;
        b=hRih1BAS1XVBQF+Z6hRKPEminGVzfZ2I+69yuGG9DIE4x+NOHxwMXUP0jhg+Io3PS0
         FA7DenjmXocH3t3IjhVPdJrB7P2aFBDReSlBWBb1qRgAkCBh+UfhPE9YsYm8Ud/NToWE
         kK/DNsWz1qktVkPpseuvysktlyaLD2HALOy1JWVPmOetq3bqp6CV11vOq65PfWmdhjnu
         feIJ9TUPkCSMxsN/LJGSbGP0zwFO3IxOMDOu6yskjzkVZbz/BQq/8QtCKM7nze93UDXL
         ZdukiMxAHwI3oN3l5f53cqPFRVY3UUIs6H/Z7Fp2hR/8JgaIGz80dNSp/YOI8U45pOjA
         FDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=da+EHGw7C4rRUkSVH/M/QAj5mzd2uzXApA0MgPXRgPQ=;
        b=q+6eywDrkL6oUMbUsyWQMxYEl6CcRLy3gp3twhykI7rw43Ua+ixIorpKXGHPvFU1OK
         RmobxdlkNI63mcgEZ8P8URx/FxHYcv6UZouI1m0ZzzclxuDlM7tlmRqydHR/jyREAZaw
         NWjYDeFH6iJCZEEFdusgbNnOBtEK9/oQDt8V4+dg0+gWvQ9/uPj0GZI8LZCALF7dUw4I
         tsOaYK6j/Wohu9SsV1VaLuFny9mppzoczi1BHgZ66tRXta4vyUIwUC7qP2cac27I820E
         V7XQKfkTttE+s7FbgHTxNZeoCBah+5UaifqLLvZHV4meu4zD0sMHqBs/sKQFWkUr+14/
         KlCw==
X-Gm-Message-State: APzg51B1poYN4xMtfcVKlN6J/uHsyWuTo37kPeXauS+KbjASTPkNelJ6
        n9ec+DFRLMWQQe5Q0MQcvew=
X-Google-Smtp-Source: ANB0VdbPzwu43YFQYfKF8ikitzH4QDZKO5gltTGAodG7OWHuX2Ma97lELRJT6C8GQ8yo2nchkc+tMg==
X-Received: by 2002:a63:f4b:: with SMTP id 11-v6mr18834291pgp.100.1537079284368;
        Sat, 15 Sep 2018 23:28:04 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id f6-v6sm10700739pgf.52.2018.09.15.23.28.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Sep 2018 23:28:02 -0700 (PDT)
Date:   Sat, 15 Sep 2018 23:28:00 -0700
From:   David Aguilar <davvid@gmail.com>
To:     "H.Merijn Brand" <h.m.brand@xs4all.nl>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Feature request: be able to pass arguments to difftool command
Message-ID: <20180916062800.GA18517@gmail.com>
References: <20180828175711.3a0aeacc@pc09.procura.nl>
 <xmqqpny2ffjv.fsf@gitster-ct.c.googlers.com>
 <20180829091838.2eee8a6a@pc09.procura.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829091838.2eee8a6a@pc09.procura.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 09:18:38AM +0200, H.Merijn Brand wrote:
> On Tue, 28 Aug 2018 12:37:40 -0700, Junio C Hamano <gitster@pobox.com>
> wrote:
> 
> > "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> > 
> > > So, my wish would be to have an option, possibly using -- to pass
> > > additional command line arguments to git difftool, so that
> > >
> > >  $ git difftool $commit~1..$commit -- -m -v2
> > >
> > > would pass the arguments after -- transparantly to ccdiff (in my case)  
> > 
> > At the syntax level passing any option after "--" would be a no
> > starter, as I would imagine that "git difftool $revs -- $paths"
> > should still be supported.
> > 
> > At the concept level, however, I can see why such a feature would be
> > useful.  Perhaps
> > 
> >     $ git difftool --backend-option=-m --backend-option=-v2 HEAD
> >     $ git mergetool --backend-option=--foo
> 
> This would mean I can just pass remaining arguments, like this?
> 
> --8<--- ~/bin/git-ccdiff
> #!/usr/bin/env perl
> use 5.18.3;
> use warnings;
> 
> my $commit;
> 
> @ARGV && $ARGV[0] !~ m/^-/ and $commit = shift;
> 
> my @git = qw( git difftool );
> defined $commit and push @git, "$commit~1..$commit";
> system @git, @ARGV;
> -->8---
> 
> > with appropriate way(s) [*1*] to make it easier to type (and
> > implement) would be an acceptable avenue to pursue, I wonder?
> 
> I like it, as long as they are all separate options in the backend and
> not available in one single variable that needs to be split
> 
> I can envision a configure variable like
> 
>   backends.options.separator = U+2063
> 
> so the backend can safely split on that itself. But I also see this as
> overly complex en over-engineering


Personally, I think it'd be better to keep the tool simple.

While I do see the utility, it would be just as easy to configure a 2nd
and 3rd variant of the same difftool and use those as needed instead.

"git difftool -t ccdiff2" or "-t ccdiff3" is the simplest, and there's
nothing stopping the user from creating aliases to shorten it further.

We also already have, "git difftool -x / --extcmd"
for specifying a full-on external diff command.

> 	git -c difftool.ccdiff.opts=-v2 -c difftool.ccdiff.opts=-m difftool

For example, this seems simpler as:

	git difftool -x 'ccdiff -v2 -m'

We already have two mechanisms for controlling the inner command that's
launched by difftool.  IMO we don't need more.

My primary concerns with --backend-opts are as follows:

1. If we add a mechansim for passing -X/--backend-opts, then we
   need to specify a new variable that users will need to be aware
   of when creating custom commands.  (sorry for stating the obvious)

2. All of the built-in commands would need to change to honor that
   variable.

3. The documentation becomes more complex because someone that wants
   to configure a bog-standard custom external tool now needs to
   be aware of this extra external source of arguments.

#1 and #2 are primarily implementation concerns, but #3 suggests
to me that it's over-complicating things.

Furthermore, #2 is not really that simple.
What would the sciplet look like?

	diff_cmd () {
		"$merge_tool_path" $EXTRA_ARGS ...
	}

That implies that we would need to shell quote stuff when
constructing $EXTRA_ARGS internally if we were to support multiple -X
arguments.  That just made it a bit more complex.

IMO we should be working to simpliify, not make things more complex for
rare use cases.  There's no reason the user can't just do:

	V=2 git difftool
	V=3 git difftool

... and let the inner script check for $V (or any other) variable.
While environment variables aren't great, this does seem like the right
place to use them.

Another option -- we already eval the configured command, so if the user
includes a variable ($ARGS) in their custom configuration then they can
specify extra flags today without needing to change the tool.  ex:

	[difftool "ccdiff"]
		cmd = ccdiff $ARGS \"$LOCAL\" \"$REMOTE\"

	ARGS='-v2 -m' git difftool HEAD~1..HEAD


Are these alternatives short and simple enough?
-- 
David
