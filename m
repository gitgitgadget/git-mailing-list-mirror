Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167E020401
	for <e@80x24.org>; Tue, 13 Jun 2017 01:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbdFMBXm (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 21:23:42 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36721 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753157AbdFMBXl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 21:23:41 -0400
Received: by mail-pg0-f41.google.com with SMTP id a70so52509533pge.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 18:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zX54jXQyArG4m3oTsiqRGKpYLxZq7l64pjoVWx+PAEQ=;
        b=YLT4jJdWV4QVa9a4KgxAnPYbs3Z9oSadi7pybjuTfM82yjOwW7w5ngxhFZUxhRd4PH
         GIZtKA1NjXmsw7nSAFnzlx/v1PYE5SnvuVC53gsbwTqPtygl1mNl6Qnu9+SGfQDiF63p
         UjNyHO7R+Qs0bN4kAUE3GGtZwsPzntRNB9emKCutIGpnRdd8FolqQITXmnNzR20mou4O
         ZJPalNGMZghp1JHmsvZV/hoLvBQYbCqIfvU8OWHi2w3skC4MEE1vHSF/AcrXA+ZCi7O7
         6zc3VoIgZbLCYyrU7srTW5aI5IxevTNOhG2QZVqOBmD2+nwa26a2UfMTHoo0xSCG8MMr
         6YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zX54jXQyArG4m3oTsiqRGKpYLxZq7l64pjoVWx+PAEQ=;
        b=ZpxLQ6Pl8RkWrHjVOLfMrQfvcygZgI6zTGadSV4eNYqgCc9rLsdAfu/koITfSZjcJV
         msoDLNRG/Qk21lNtxbFkKYw8IpkzBQ5hZmkbprUXBoq50nwjF9FivYaA4cC1JNDs9fhL
         vHaqoV6Ot7Q53qwBOQtW+Eib12LQIS2ksqWNPaWXViXK/r3iOhu2Hwf6dkKBqeF7nydx
         Bfb+l4ROXfY6Zm7PP52wVrQdGi35qhr1+KXQXvEQ49VybFqYzSIIhdBJjg2r2D3VR+kq
         B3Y+8TZYujum0SfKrFrWMmtH0qo+XEyB642aLDeLA1FCEyzJLFvhxA2QVu39p0VaIEfd
         CmJw==
X-Gm-Message-State: AODbwcC0lyiw9xMYf8BkC9MIyxtM0PoK27/ijjmqs7QwwdrFuEH/dR5A
        SKeHkQnQArWH/Xr825V6pw==
X-Received: by 10.84.215.148 with SMTP id l20mr34598945pli.79.1497317020418;
        Mon, 12 Jun 2017 18:23:40 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:9d75:7c5f:d212:fb28])
        by smtp.gmail.com with ESMTPSA id q6sm20620907pfi.129.2017.06.12.18.23.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 18:23:39 -0700 (PDT)
Date:   Mon, 12 Jun 2017 18:23:37 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH 4/4] config: don't implicitly use gitdir
Message-ID: <20170613012337.GH154599@google.com>
References: <20170612213406.83247-1-bmwill@google.com>
 <20170612213406.83247-5-bmwill@google.com>
 <20170613010518.GB133952@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613010518.GB133952@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/12, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Commit 2185fde56 (config: handle conditional include when $GIT_DIR is
> > not set up) added a 'git_dir' field to the config_options struct.  Let's
> > use this option field explicitly all the time instead of occasionally
> > falling back to calling 'git_pathdup("config")' to get the path to the
> > local repository configuration.  This allows 'do_git_config_sequence()'
> > to not implicitly rely on global repository state.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  builtin/config.c | 2 ++
> >  config.c         | 6 ++----
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> Unlike the previous 3, this one makes me pause for a moment: it means
> that "gitdir:" includes and .git/config discovery would stop working
> if the caller does not remember to set git_dir in their
> config_options.
> 
> So we have to inspect callers.
> 
> Callers that set respect_includes = 1:
> 
> - read_early_config carefully sets git_dir *phew*
> - git_config_raw doesn't and is used approximately everywhere.
> 
> do_git_config_sequence call chain:
> - called by git_config_with_options, which is called by
>   - read_early_config
>   - git_config_raw
>   - various callers in builtin/config.c, using &config_options
> 
> > --- a/builtin/config.c
> > +++ b/builtin/config.c
> > @@ -539,6 +539,8 @@ int cmd_config(int argc, const char **argv, const char *prefix)
> >  		config_options.respect_includes = !given_config_source.file;
> >  	else
> >  		config_options.respect_includes = respect_includes_opt;
> > +	if (have_git_dir())
> > +		config_options.git_dir = get_git_common_dir();
> 
> nit: because of the context, this 'if' can be "if (!nongit)".

Will do.

> 
> [...]
> > --- a/config.c
> > +++ b/config.c
> > @@ -219,8 +219,6 @@ static int include_by_gitdir(const struct config_options *opts,
> >  
> >  	if (opts->git_dir)
> >  		git_dir = opts->git_dir;
> > -	else if (have_git_dir())
> > -		git_dir = get_git_dir();
> >  	else
> >  		goto done;
> 
> I wonder if this should have a sanity-check:
> 
> 	else if (have_git_dir())
> 		BUG("caller forgot to set opts->git_dir");
> 
> Alternatively, could this patch rename git_config_with_options?  That
> way any other patch in flight that calls git_config_with_options would
> conflict with this patch, giving us an opportunity to make sure it
> also sets git_dir.  As another nice side benefit it would make it easy
> for someone reading the patch to verify it didn't miss any callers.

That kind of defeats the purpose of the patch.  The point is to not rely
on global repository state and with the BUG statement we still are
relying on global state.

And I don't know if I agree with renaming a function just to rename it.

> 
> > @@ -1548,8 +1546,6 @@ static int do_git_config_sequence(const struct config_options *opts,
> >  
> >  	if (opts->git_dir)
> >  		repo_config = mkpathdup("%s/config", opts->git_dir);
> > -	else if (have_git_dir())
> > -		repo_config = git_pathdup("config");
> >  	else
> >  		repo_config = NULL;
> 
> Likewise: either this should get a sanity check
> 
> 	else if (have_git_dir())
> 		BUG("caller forgot to set opts->git_dir");
> 
> or the public interface git_config_with_options should be renamed.
> 
> > @@ -1613,6 +1609,8 @@ static void git_config_raw(config_fn_t fn, void *data)
> >  	struct config_options opts = {0};
> >  
> >  	opts.respect_includes = 1;
> > +	if (have_git_dir())
> > +		opts.git_dir = get_git_common_dir();
> 
> curious: Why get_git_common_dir() instead of get_git_dir()?

Needs to be commondir since the config is stored in the common git
directory and not a per worktree git directory.

-- 
Brandon Williams
