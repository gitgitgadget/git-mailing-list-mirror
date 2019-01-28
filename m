Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 267EE1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 14:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA1Oid (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 09:38:33 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:39176 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfA1Oid (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 09:38:33 -0500
Received: by mail-wm1-f49.google.com with SMTP id y8so14120545wmi.4
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 06:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IOBeMY7fEh4nlGTRoVfCHMRHT4bv4vkTeDAuc0kyK/Y=;
        b=XKz6sisbs76CjfyrQ4421qQuxwKHt+8tLawb6svLW/6g2dEWKBJ2QspvXm6UxtV7F0
         d2W88CK5IVb2V6DB+jVOYY+lY2VqDeqj35MTBIGe4lVXddKU9gWKBu/EJGmrpxRRG+QC
         ya/ckeAqtEI6y34Jy4Zqcpq6gz7RJ9rxlIFrApALeXdtgPGd7Ak9uRcv4tSfcXV0+fMu
         RTXTld7i1ToIANwNrWxTjukeEZ6RSKgrPGkAvWVuOjNfxY3wRYGZW7r0PvH5Z8D2eNRK
         MbT6NW5a4hIu+3CHcveFj/K1SBrhnKmE50zXhN6zspUfirItvkhENQyt2V/3MjIV+IgF
         eitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IOBeMY7fEh4nlGTRoVfCHMRHT4bv4vkTeDAuc0kyK/Y=;
        b=ZyXnvuU0odeyYWIeYJWwGBgwvbg8XjroRe05emJI0IqanjN+lKFkSTCWyI/Eas1UHm
         hlcsEmbfeNb6nGnVHKIApj8zwcFMlV6aWc9+RuTEczIw9o3u4XgufX6BgRPs0A3QTsKx
         YGqbDzYUILGhOj0/x+85UJueBba3IH2B1DMrDB2xBWUqJoq/GgcJYDMpmntteFU+0fZx
         OssJmplIOOVST2orBPzKicN/JnAsQvOGYO8uSeu2GNIsctU6c2eJdyYgzG5dYqXjtEOQ
         JKhI1fPZBvyByaPbR8SZ1fhfURHgeuq/5u/s1FCdPX4EIMevQIheKRROl5UFXXtmLqV9
         eO4Q==
X-Gm-Message-State: AJcUukcdk/LLXgBKBfsltTIWCCIBGdCAcJS2mQLkWeKOB3ClU4YZ6ruw
        ynTlYvEq3wIhBZzfeyd7ldk=
X-Google-Smtp-Source: ALg8bN5YHM8siZSDPwaq4TNZ8m69Wz3yS4iGDJHbDPXjNdkHkaWTjEw/GDHCgyupGXry0NLfTUZyJw==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr16631504wmj.138.1548686311643;
        Mon, 28 Jan 2019 06:38:31 -0800 (PST)
Received: from szeder.dev (x4dbd8aa4.dyn.telefonica.de. [77.189.138.164])
        by smtp.gmail.com with ESMTPSA id o2sm8725939wmo.33.2019.01.28.06.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 06:38:30 -0800 (PST)
Date:   Mon, 28 Jan 2019 15:38:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] completion: complete refs in multiple steps
Message-ID: <20190128143828.GJ6702@szeder.dev>
References: <20190128094155.2424-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190128094155.2424-1-pclouds@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 28, 2019 at 04:41:55PM +0700, Nguyễn Thái Ngọc Duy wrote:
> This is in the same spirit of f22f682695 (completion: complete general
> config vars in two steps - 2018-05-27). Instead of considering all full
> refs as completion candidates, it completes one "path" component at a
> time, e.g.
> 
>     $ git switch-branch -d j<TAB>

  $ git switch-branch
  git: 'switch-branch' is not a git command. See 'git --help'.

Please use only existing Git commands in the examples.

>     jch/            junio-gpg-pub
> 
>     $ git switch-branch -d jch/<TAB>
>     Display all 154 possibilities? (y or n)
>     jch/ab/            jch/fc/
>     ....
> 
>     $ git switch-branch -d jch/nd/<TAB>
>     jch/nd/attr-pathspec-fix
>     jch/nd/attr-pathspec-in-tree-walk
>     ...
> 
> For refs organized in multiple levels like this (and I've seen refs in 4
> levels), especially when there a lot of refs, incremental completion
> this way makes it easier to get to what you want.
> 
> The cost of course is more complicated completion and also slower on
> systems with slow process creation. So maybe there will be a switch to
> turn this on or off?

Oh, no.  After spending quite some effort to eliminate most of the
processes and big shell loops from the ref completion code path, I
find this patch simply terrible ;)

> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 499e56f83d..d74ee79866 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -742,6 +742,17 @@ __git_refs ()
>  	esac
>  }
>  
> +__git_collapse_refs ()
> +{
> +	local regex="$(echo "$1" | sed 's/[^/]\+/[^\/]*/g')"

Surely this could be done using only shell builtins.

> +	case "$regex" in
> +		'') regex='[^\/]*';;

Should this really escape that '/'?  The 'sed' below would escape it
anyway, so it would be escaped twice.  And the line below doesn't
escape it.

> +		*/) regex="${regex}[^/]*";;
> +	esac
> +	regex="$(echo "$regex" | sed 's/\//\\\//g')"

And this one, too.

> +	sed -ne "s/\\($regex\\/\\?\\).*/\\1/p"
> +}
> +
>  # Completes refs, short and long, local and remote, symbolic and pseudo.
>  #
>  # Usage: __git_complete_refs [<option>]...
> @@ -769,7 +780,7 @@ __git_complete_refs ()
>  		shift
>  	done
>  
> -	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx")"
> +	__gitcomp_direct "$(__git_refs "$remote" "$track" "$pfx" "$cur_" "$sfx" | __git_collapse_refs "$cur_")"
>  }

In general I think it would be much better to rely more on 'git
for-each-ref' to do the heavy lifting, extending it with new format
specifiers/options as necessary.

'%(refname:rstrip=-<N>)' already comes somewhat close to what we would
need for full ref completion (i.e. 'refs/b<TAB>' to complete
'refs/bisec/bad'), we only have to figure out how many "ref path
components" to show based on the number of path components in the
current word to be completed.  Alas, it won't add the trailing '/' for
"ref directories".

For "regular" refs completion we would need to combine 'rstrip=-<N>'
with 'lstrip=2' to remove the 'refs/(heads|tags|remotes)/' prefix, but
ref-filter doesn't support things like that, it allows only one format
option.  And, of course, the lack of trailing '/' is an issue in this
case as well.

So perhaps a new format option like '%(refname:path-components=3,2)'
to show two ref path components starting with the third with a
trailing '/' appended if necessary, e.g. to turn
'refs/remotes/jch/nd/attr-pathspec-fix' into 'jch/nd/'.


Note that we also have __git_head() and __git_tags() to complete only
branches and only tags.

