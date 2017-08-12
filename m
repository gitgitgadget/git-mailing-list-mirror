Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DADAA208B8
	for <e@80x24.org>; Sat, 12 Aug 2017 12:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750885AbdHLMaI (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Aug 2017 08:30:08 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:36705 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdHLMaH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Aug 2017 08:30:07 -0400
Received: by mail-wr0-f171.google.com with SMTP id y43so21220591wrd.3
        for <git@vger.kernel.org>; Sat, 12 Aug 2017 05:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6kxMHrw8EUNJMJm6XTDLt+UDL950MsTewE5YkUT9MUk=;
        b=MxWGJ4aI7zXRdGYO4X/X9XrjP7EK7/diMEuchAiKhN+UErRg6hwEurmoDdqVD9u4C+
         NA1ljUYxebevk9jFk64oH/8gZlNZHzjyL2CEkNjkg6jONITUAAnEvQo7ay5hLGp1XDHb
         mIbyC0goHnCLYgRmabwTxIcvMtlVoyo48+ZRPsZkxTpLN9eB8rQ2okYpH149utVNSQrl
         g+VxK3ZaEzglAhSWC4c7hFDvs3ZGEjR8vKbgl0sf8mKNRvHm1/pF8+a0fJkVmSoOcHEx
         oJU0JAjD2F9/6QvMdy88LPB2GU7MFzHkF05FPzTm5k47OlSVmwO4TOufUuoWNI/tQnzj
         4rRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6kxMHrw8EUNJMJm6XTDLt+UDL950MsTewE5YkUT9MUk=;
        b=Wbi+QxYzJ8fG9R8BFAgAfTsJd9JHPHsHRoblEY8g/cOePYDGzZFg+7TxYPHUH/icwC
         YGkhACclE9Yz63I03K2CMkhd0iX6zDigZgTPBCWLfZdIpolbeaoCXlxwJqFiGknD9Ft4
         DMKIYB7eZc0iRiH9jZLmX2s/TZ9JB1odhXN4CrAPZHE1fJPPloWQmBFpcA7Pj+rfWx6o
         +xs79uqlKOBT4wGwfLTGRGOjulGUt9t86jeXbjyCg7LIR3IB/S2E9brgY2E0PDugabaV
         BLtu3amqu52u2lqfMd+q/P0zaCHkDopMKs023BQhMqY5dXJ8JXDrambq5PimzvC76+Ht
         XPQg==
X-Gm-Message-State: AHYfb5iifnf4MSjchDcuKE0uLaqhkyNDK0X1jQjpDeOUP1513pMgQ1to
        oEXRsfzhxt0PNw==
X-Received: by 10.223.147.164 with SMTP id 33mr14195504wrp.107.1502541006228;
        Sat, 12 Aug 2017 05:30:06 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id e198sm1119221wma.15.2017.08.12.05.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Aug 2017 05:30:04 -0700 (PDT)
Date:   Sat, 12 Aug 2017 13:30:10 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 4/4] add: modify already added files when --chmod is
 given
Message-ID: <20170812123010.GA4304@hank>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
 <20160914210747.15485-1-t.gummerer@gmail.com>
 <20160914210747.15485-5-t.gummerer@gmail.com>
 <3c61d9f6-e0fd-22a4-68e0-89fd9ce9b944@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c61d9f6-e0fd-22a4-68e0-89fd9ce9b944@web.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/07, René Scharfe wrote:
> Am 14.09.2016 um 23:07 schrieb Thomas Gummerer:
> > When the chmod option was added to git add, it was hooked up to the diff
> > machinery, meaning that it only works when the version in the index
> > differs from the version on disk.
> > 
> > As the option was supposed to mirror the chmod option in update-index,
> > which always changes the mode in the index, regardless of the status of
> > the file, make sure the option behaves the same way in git add.
> > 
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> 
> Sorry for replying almost a year late, hopefully you're still interested.

Thanks for still replying :)

> > ---
> >   builtin/add.c      | 47 ++++++++++++++++++++++++++++-------------------
> >   builtin/checkout.c |  2 +-
> >   builtin/commit.c   |  2 +-
> >   cache.h            | 10 +++++-----
> >   read-cache.c       | 14 ++++++--------
> >   t/t3700-add.sh     | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >   6 files changed, 91 insertions(+), 34 deletions(-)
> > 
> > diff --git a/builtin/add.c b/builtin/add.c
> > index b1dddb4..595a0b2 100644
> > --- a/builtin/add.c
> > +++ b/builtin/add.c
> > @@ -26,10 +26,25 @@ static int patch_interactive, add_interactive, edit_interactive;
> >   static int take_worktree_changes;
> >   
> >   struct update_callback_data {
> > -	int flags, force_mode;
> > +	int flags;
> >   	int add_errors;
> >   };
> >   
> > +static void chmod_pathspec(struct pathspec *pathspec, int force_mode)
> 
> "int force_mode" looks like a binary (or perhaps ternary) flag, but
> actually it is a character and can only have the values '-' or '+'.
> In builtin/update-index.c it's called "char flip" and we probably should
> define it like this here as well.
> 
> > +{
> > +	int i;
> > +	
> > +	for (i = 0; i < active_nr; i++) {
> > +		struct cache_entry *ce = active_cache[i];
> > +
> > +		if (pathspec && !ce_path_match(ce, pathspec, NULL))
> > +			continue;
> > +
> > +		if (chmod_cache_entry(ce, force_mode) < 0)
> > +			fprintf(stderr, "cannot chmod '%s'", ce->name);
> 
> This error message is missing a newline.  In builtin/update-index.c we
> also show the attempted change (-x or +x); perhaps we want to do that
> here as well.

Thanks for catching this, both this and the above are worth changing
imo.  I see Ramsay already provided a patch for this in
https://public-inbox.org/git/aa004526-3e0d-66d4-287f-30abd29758fc@ramsayjones.plus.com/.
Thanks Ramsay!

> Currently chmod_cache_entry() can only fail if ce is not a regular
> file or it's other parameter is neither '-' nor '+'.  We rule out the
> latter already in the argument parsing code.  The former can happen if
> we add a symlink, either explicitly or because it's in a directory
> we're specified.
> 
> I wonder if we even need to report anything, or under which conditions.
> If you have a file named dir/file and a symlink named dir/symlink then
> the interesting cases are:
> 
> 	git add --chmod=.. dir/symlink
> 	git add --chmod=.. dir/file dir/symlink
> 	git add --chmod=.. dir
> 
> Warning about each case may be the most cautious thing to do, but
> documenting that --chmod has no effect on symlinks and keeping silent
> might be less annoying, especially in the last case.  What do you
> think?

I'm not sure about this.  While I do agree that it could be quite
annoying in the last case, it could potentially be a bit confusing to
not get any warning in the first case.  I don't have a strong opinion
either way.

> > @@ -342,13 +354,8 @@ int cmd_add(int argc, const char **argv, const char *prefix)
> >   	if (!show_only && ignore_missing)
> >   		die(_("Option --ignore-missing can only be used together with --dry-run"));
> >   
> > -	if (!chmod_arg)
> > -		force_mode = 0;
> > -	else if (!strcmp(chmod_arg, "-x"))
> > -		force_mode = 0666;
> > -	else if (!strcmp(chmod_arg, "+x"))
> > -		force_mode = 0777;
> > -	else
> > +	if (chmod_arg && ((chmod_arg[0] != '-' && chmod_arg[0] != '+') ||
> > +			  chmod_arg[1] != 'x' || chmod_arg[2]))
> >   		die(_("--chmod param '%s' must be either -x or +x"), chmod_arg);
> 
> That's the argument parsing code mentioned above.  The strcmp-based
> checks look nicer to me btw.  How about this?
> 
> 	if (chmod_arg && strcmp(chmod_arg, "-x") && strcmp(chmod_arg, "+x"))
> 
> But that's just nitpicking.

I think this looks nicer indeed, thanks!  But it's probably not worth
a patch for just this unless we decide to change to not warn as you
mentioned above, and can fix this at the same time?

> René
