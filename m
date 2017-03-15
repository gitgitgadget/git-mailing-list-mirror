Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F24C202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 23:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753833AbdCOXIt (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 19:08:49 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:32964 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753878AbdCOXIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 19:08:37 -0400
Received: by mail-pg0-f45.google.com with SMTP id n190so15738382pga.0
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 16:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGxBVqUjXOWND9eZ4fJzocRGmlFawPjjjxVyCGxr9ik=;
        b=IYFWR1nuE4QvgXXf0rfGvRYfbnGL2aC3RPymfXyGfzyo8nHvorqD0BjeYqSCcrQJ4s
         zgQ0/iqLIDlbR3irREuL8x8U8XLrUZcrrW75NL8olhpyZ9Xr7q8DFhNuJOf41gbqvm1b
         U9jw5yGoo2vI9BbfN+cB4LptMizQCGR8mRanQt5dSJVfxYoZOvRSMhd1/EkLy37xucSO
         c0XIjSgSzqoJkpQY0fLvR1oHNYA3/uLt9wPje6OaQ6lOitW1OLpsunKiI4j8sNuz+W5r
         P3CjuMF6uYkOisCgShSlJnoVi88UaYjBZ1f3PBFHU4I1hFqSkG2MvefRfvhosTVQGtpW
         ulVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGxBVqUjXOWND9eZ4fJzocRGmlFawPjjjxVyCGxr9ik=;
        b=Lzmp5eOs+yRgCdSw5OekIgbOESGUEw6N2hv+5vW59NVC72MJMGTNRUYKT6NTvozNue
         6+zgv8BK7l+Uw8E9xzAXVJ4K5XunZB1+hIqoF6Xx/Sck8uIr/o/MQvI1AzTAfvWrqwod
         C5RuWXyCVODMWDWq8RkbbKFZIzkIRevnbhlNUTDPpGU8Y8mUndKmz0CAdfidp+gXWBv7
         Gr53bseYbBAGTDOKpEnc1qUr9c81IeZnnI4eccxhHywVM/zsYgsGslSB8LpgHZhBEyqr
         ZDIIzs1rDwcB1BZtH3F+trVt1SYqeN847ije6fqg3QXrW8x1bGaa56WYNJUHSiXrP6VC
         rWMg==
X-Gm-Message-State: AFeK/H2xmSURYwAy+oEnrzPF5Em+iCWI0M7FXGOz8PJImsMgCqWf8aI2zJ6jRZaRSd59gNub
X-Received: by 10.98.74.154 with SMTP id c26mr6693876pfj.73.1489619316330;
        Wed, 15 Mar 2017 16:08:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:e5fd:c660:1f84:47a3])
        by smtp.gmail.com with ESMTPSA id t67sm6214860pfd.76.2017.03.15.16.08.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Mar 2017 16:08:35 -0700 (PDT)
Date:   Wed, 15 Mar 2017 16:08:34 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v3 07/10] clone: add --submodule-spec=<pathspec> switch
Message-ID: <20170315230834.GH159137@google.com>
References: <20170309012345.180702-1-bmwill@google.com>
 <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-8-bmwill@google.com>
 <xmqqmvcnir8m.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmvcnir8m.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/14, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > The new switch passes the pathspec to `git submodule update
> > --init-active` which is called after the actual clone is done.
> >
> > Additionally this configures the submodule.active option to
> > be the given pathspec, such that any future invocation of
> > `git submodule update --init-active` will keep up
> > with the pathspec.
> >
> > Based on a patch by Stefan Beller <sbeller@google.com>
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  Documentation/git-clone.txt | 23 ++++++++++-----
> >  builtin/clone.c             | 36 +++++++++++++++++++++--
> >  t/t7400-submodule-basic.sh  | 70 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 120 insertions(+), 9 deletions(-)
> >
> > diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> > index 35cc34b2f..9692eab30 100644
> > --- a/Documentation/git-clone.txt
> > +++ b/Documentation/git-clone.txt
> > @@ -15,7 +15,8 @@ SYNOPSIS
> >  	  [--dissociate] [--separate-git-dir <git dir>]
> >  	  [--depth <depth>] [--[no-]single-branch]
> >  	  [--recursive | --recurse-submodules] [--[no-]shallow-submodules]
> > -	  [--jobs <n>] [--] <repository> [<directory>]
> > +	  [--submodule-spec <pathspec>] [--jobs <n>] [--]
> > +	  <repository> [<directory>]
> 
> Hmph.  Can we then make "--recurse-submodules" an obsolete way to
> spell "--submodule-spec ."?  I am not actively suggesting to
> deprecate it; I am trying to see if there are semantic differences
> between the two.

We can if you think that would be better.  That way if at clone time you
say "I want the submodules too" that your default config tracks all
submodules even new ones yet to be added.

> 
> I am also wondering "--recurse-submodules=<pathspec>" would be a
> better UI, instead of introducing yet another option.

Yeah we could do that, have --recurse-submodules be a repeated option
and if you don't specify a value it defaults to "."

Any thoughts on this Stefan?

> 
> > @@ -217,12 +218,20 @@ objects from the source repository into a pack in the cloned repository.
> >  
> >  --recursive::
> >  --recurse-submodules::
> > -	After the clone is created, initialize all submodules within,
> > -	using their default settings. This is equivalent to running
> > -	`git submodule update --init --recursive` immediately after
> > -	the clone is finished. This option is ignored if the cloned
> > -	repository does not have a worktree/checkout (i.e. if any of
> > -	`--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
> > +	After the clone is created, initialize and clone all submodules
> > +	within, using their default settings. This is equivalent to
> > +	running `git submodule update --recursive --init` immediately
> > +	after the clone is finished. This option is ignored if the
> > +	cloned repository does not have a worktree/checkout (i.e.  if
> > +	any of `--no-checkout`/`-n`, `--bare`, or `--mirror` is given)
> 
> With reflowing it is unnecessarily harder to spot what got changed.
> "and clone" is inserted, "--init" and "--recursive" were swapped.
> Any other changes?

No other changes, it just reads a little bit clearer now IMO.

> 
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 3f63edbbf..c6731379b 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -56,6 +56,16 @@ static struct string_list option_required_reference = STRING_LIST_INIT_NODUP;
> >  static struct string_list option_optional_reference = STRING_LIST_INIT_NODUP;
> >  static int option_dissociate;
> >  static int max_jobs = -1;
> > +static struct string_list submodule_spec;
> > +
> > +static int submodule_spec_cb(const struct option *opt, const char *arg, int unset)
> > +{
> > +	if (unset)
> > +		return -1;
> > +
> > +	string_list_append((struct string_list *)opt->value, arg);
> > +	return 0;
> > +}
> 
> Hmph,  doesn't OPT_STRING_LIST work for this thing?

You're right, I'll change to that.

-- 
Brandon Williams
