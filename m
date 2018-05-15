Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C64C1F406
	for <e@80x24.org>; Tue, 15 May 2018 18:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752491AbeEOSBc (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 May 2018 14:01:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46479 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEOSBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 May 2018 14:01:31 -0400
Received: by mail-pf0-f193.google.com with SMTP id p12-v6so416196pff.13
        for <git@vger.kernel.org>; Tue, 15 May 2018 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=7vcre2TqdNiOEXjxydI0aBATektqcsdAVlXv6KWOZVQ=;
        b=k56eiAiHWDUMBDNYwqUGdGQpYW4IDvhwB3dwEuqYPPAvWtVSQX0icweSjknwOWX2UZ
         h0Mamma1LSWtBuHStmGdDYdVpW6YOVWw1x9iFp3kRSFM/nvIDOcQaUhbY2mzPqGUyksg
         vCFn0ZkdsRjqbuPPCtUMyxJT63CJxm0/0oGt35m17/YlBUUkPkL7BdU0WypzY3ORGEJk
         eoxCqOXpr4UhNzdoqRVjPrYjx4NqQiIh5mJSGjjIKNcDn5H/Eo1hDA+L1Fv6FYnjrNP9
         T8V6M1n0aPINlHS/tuNIv+mdx1EiRvFfAwROSKE1r4EcGHTSpD1WmB2RtM7fFMbXOjd2
         kJeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7vcre2TqdNiOEXjxydI0aBATektqcsdAVlXv6KWOZVQ=;
        b=NFiXJFJXyRZ/ACX1S54fEhc5WJEQxqqqz2c/Gc2FIeblDk2Q8sicdZqK+qO3gOdjCA
         bV7px/X8TB9oS841CC27VEjzka5d0AwymGmaxeuJX/8CUZ8aYJ9P8yJUYSOXq/34C1bB
         LYdq3HbVpux9+2mmk8YytbMFwZxo2o2tibcR/mczIklYKxzevhKu8ICCC2nLTig1tYux
         6t+NS82j1i7lsuXXqwDCCMjRPACozZh1EEuqB5Cv/sMRvonbNqrsC8ZnfK6fEWUl+Du2
         sXYfQX42WiHtR/3SN39Brjmcw6lm4/X3EXwIGyIFR7xiTpy7LTdmxLbnow+WziMiUl+I
         23Ow==
X-Gm-Message-State: ALKqPwe1AZCDP8UalLLAw7TTDfmCF0Byp9v4+g2Zn1p3zWP+vq2m0XLx
        BCRS0/AzfC3iZSkrzafb6E7+3FZ71jE=
X-Google-Smtp-Source: AB8JxZowoUXGWYnoGI0Am3cX+Bfg+GN4oZiYi4fnRTFHgaiwC2qHG+C+DD/doMv+aPteLG3+yuFEoQ==
X-Received: by 2002:a63:4143:: with SMTP id o64-v6mr7688724pga.280.1526407290546;
        Tue, 15 May 2018 11:01:30 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id u14-v6sm916615pfa.101.2018.05.15.11.01.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 May 2018 11:01:28 -0700 (PDT)
Date:   Tue, 15 May 2018 11:01:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/35] refactoring refspecs
Message-ID: <20180515180127.GE72551@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
 <87h8n92tzb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h8n92tzb.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/15, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, May 14 2018, Brandon Williams wrote:
> 
> > When working on protocol v2 I noticed that working with refspecs was a
> > little difficult because of the various api's that existed.  Some
> > functions expected an array of "const char *" while others expected an
> > array of "struct refspec".  In all cases a length parameter needed to be
> > passed as a parameter as well.  This makes working with refspecs a
> > little challenging because of the different expectations different parts
> > of the code base have.
> >
> > This series refactors how refspecs are handled through out the code base
> > by renaming the existing struct refspec to refspec_item and introducing
> > a new 'struct refspec' which is a container of refspec_items, much like
> > how a pathspec contains pathspec_items.  This simplifies many callers
> > and makes handling pathspecs a bit easier.
> 
> This looks really good to me. The API you're replacing is one of the
> worst I've had a chance to encounter in git.git (as noted in my
> https://public-inbox.org/git/87in7p2ucb.fsf@evledraar.gmail.com/ but
> maybe I haven't looked widely enough), and now it's really nice.

Thanks! Yeah its one of the rougher edges I've worked with and I'm glad
I finally got around to fixing it.

> 
> > I have some follow on work which I'll build on top of this series, but
> > since this was already getting a bit lengthy at 35 patches I'll save
> > that for another time.
> 
> In addition to my other suggestions for stuff to put on top, which I see
> now you may have just had in your local tree but didn't submit, I think
> this makes sense:

Yes these changes make sense, though I'll need to tweak them to avoid
some memory leaks.  I'll probably go ahead and squash it into the two
patches which effect those two functions.

Thanks for catching this.

> 
>     diff --git a/remote.c b/remote.c
>     index 946b95d18d..cb97e662e8 100644
>     --- a/remote.c
>     +++ b/remote.c
>     @@ -77,16 +77,6 @@ static const char *alias_url(const char *url, struct rewrites *r)
>      	return xstrfmt("%s%s", r->rewrite[longest_i]->base, url + longest->len);
>      }
> 
>     -static void add_push_refspec(struct remote *remote, const char *ref)
>     -{
>     -	refspec_append(&remote->push, ref);
>     -}
>     -
>     -static void add_fetch_refspec(struct remote *remote, const char *ref)
>     -{
>     -	refspec_append(&remote->fetch, ref);
>     -}
>     -
>      static void add_url(struct remote *remote, const char *url)
>      {
>      	ALLOC_GROW(remote->url, remote->url_nr + 1, remote->url_alloc);
>     @@ -261,9 +251,9 @@ static void read_remotes_file(struct remote *remote)
>      		if (skip_prefix(buf.buf, "URL:", &v))
>      			add_url_alias(remote, xstrdup(skip_spaces(v)));
>      		else if (skip_prefix(buf.buf, "Push:", &v))
>     -			add_push_refspec(remote, xstrdup(skip_spaces(v)));
>     +			refspec_append(&remote->push, xstrdup(skip_spaces(v)));
>      		else if (skip_prefix(buf.buf, "Pull:", &v))
>     -			add_fetch_refspec(remote, xstrdup(skip_spaces(v)));
>     +			refspec_append(&remote->fetch, xstrdup(skip_spaces(v)));
>      	}
>      	strbuf_release(&buf);
>      	fclose(f);
>     @@ -302,14 +292,14 @@ static void read_branches_file(struct remote *remote)
>      		frag = "master";
> 
>      	add_url_alias(remote, strbuf_detach(&buf, NULL));
>     -	add_fetch_refspec(remote, xstrfmt("refs/heads/%s:refs/heads/%s",
>     -					  frag, remote->name));
>     +	refspec_append(&remote->fetch, xstrfmt("refs/heads/%s:refs/heads/%s",
>     +					       frag, remote->name));
> 
>      	/*
>      	 * Cogito compatible push: push current HEAD to remote #branch
>      	 * (master if missing)
>      	 */
>     -	add_push_refspec(remote, xstrfmt("HEAD:refs/heads/%s", frag));
>     +	refspec_append(&remote->push, xstrfmt("HEAD:refs/heads/%s", frag));
>      	remote->fetch_tags = 1; /* always auto-follow */
>      }
> 
>     @@ -395,12 +385,12 @@ static int handle_config(const char *key, const char *value, void *cb)
>      		const char *v;
>      		if (git_config_string(&v, key, value))
>      			return -1;
>     -		add_push_refspec(remote, v);
>     +		refspec_append(&remote->push, v);
>      	} else if (!strcmp(subkey, "fetch")) {
>      		const char *v;
>      		if (git_config_string(&v, key, value))
>      			return -1;
>     -		add_fetch_refspec(remote, v);
>     +		refspec_append(&remote->fetch, v);
>      	} else if (!strcmp(subkey, "receivepack")) {
>      		const char *v;
>      		if (git_config_string(&v, key, value))
> 
> I.e. the reason we have add_{push,fetch}_refspec() in the first place is
> because without your series it's tricky to add new ones, but now it's
> trivial, so let's not leave behind wrapper static functions whose sole
> purpose is to just call another exported API as-is.
> 
> I've pushed all the patches I quoted inline in this review at
> avar-bwill/refspec in github.com/avar/git, consider them all signed-off,
> and depending on whether you agree/disagree etc. please squash
> them/adapt them/drop them however you see fit.

-- 
Brandon Williams
