Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CE5C202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdGLSBs (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:01:48 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36068 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751151AbdGLSBr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:01:47 -0400
Received: by mail-pf0-f174.google.com with SMTP id q86so16535734pfl.3
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2TZ/6T3bidqJ76Ndb5t5Q+/zzyj+30zY2ieETX9lGq0=;
        b=JY2awFY2kTFhRWvxpTQ/5dqJ1NO+8A5ajjP1dbXMjaBuOvAaSgwEGibexalIaHE9ET
         zEqF9sCYa6LNOYjh7Ec0dKAb0dA82aIlHTuJoxH7EkTp4EZhtnrvIxsKAKSjhwq+gYiv
         yVn5XitM2itEWpFCzz/7xt7ddn/tcPEzc/pbExIxeGN5//1k/bv+hG1B7+5+dcU6bL5k
         DCEm66OCtdEDK3JfjON/5Crq+nsUcDaD9IxaN4DaaEAyqazpGAWUz4GjL9bfm5gjUC8Y
         L9CV29KSOgYJSJf3r2e3Tiy9CreI7hzSeM531cWuKsuTXg5OV+f3vYIUhwlEMkLL6VY5
         gqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2TZ/6T3bidqJ76Ndb5t5Q+/zzyj+30zY2ieETX9lGq0=;
        b=jgdxCfEhncHGBBK46xbgUWDYBL61w35IAxsFF/dOheLSseyZDHwFG0uWobYxhXAYLs
         wV85QJBn7PGgOOVfd9tSMBka3m4VauNsbBwB0oNsSUae7JunLSBBZZ4m6f6CqXiJc5Ik
         bz1hdht2oWjG1fNGP98i/X56bVwYVgg2JPgTWTpz2kYySQMMTHJxzrcnReGyldfDEUzK
         5dGppjBg7I0hjENPsJQBSCgHG+/cTO+dPYv90OIl1kfRaNrigRj4xzTeGMi4raKm0CuX
         8Fyax/nDGJ0rWW23pNCtp6aromjWrxOmWVUYI8l1AUV4hQpowgQvlL+QnstrdfDANNGB
         BVkA==
X-Gm-Message-State: AIVw11192o0Tqlc+e7kdU6aVpd0EUIC1BSSquM+mSOtbSldiEXEK63La
        TjIVXD/hCJbX9dhu2M7NJQ==
X-Received: by 10.99.152.86 with SMTP id l22mr5056024pgo.93.1499882506618;
        Wed, 12 Jul 2017 11:01:46 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id o73sm7277120pfi.2.2017.07.12.11.01.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 11:01:45 -0700 (PDT)
Date:   Wed, 12 Jul 2017 11:01:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 2/3] setup: have the_repository use the_index
Message-ID: <20170712180143.GD65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-3-bmwill@google.com>
 <xmqqzica1pli.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzica1pli.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> > Have the index state which is stored in 'the_repository' be a pointer to
> > the in-core instead 'the_index'.  This makes it easier to begin
> > transitioning more parts of the code base to operate on a 'struct
> > repository'.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  setup.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/setup.c b/setup.c
> > index 860507e1f..b370bf3c1 100644
> > --- a/setup.c
> > +++ b/setup.c
> > @@ -1123,6 +1123,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
> >  			setup_git_env();
> >  		}
> >  	}
> > +	the_repository->index = &the_index;
> >  
> >  	strbuf_release(&dir);
> >  	strbuf_release(&gitdir);
> 
> I would have expected this to be going in the different direction,
> i.e. there is an embedded instance of index_state in a repository
> object, and the_repository.index is defined to be the old the_index,
> i.e.
> 
> 	#define the_index (the_repository.index)
> 
> When a Git command that recurses into submodules in-core using
> the_repository that represents the top-level superproject and
> another repository object tht represents a submodule, don't we want
> the repository object for the submodule also have its own default
> index without having to allocate one and point at it with the index
> field?

For all intents and purposes the index struct that is stored in 'struct
repository' is an embedded instance, its just stored as a pointer
instead of being a direct part of the struct itself.  As far as
submodules are concerned, thats why 'repo_read_index' exists since it
will allocate the index struct if needed and then populate it with the
index file associated with that repository.  So the 'struct repository'
owns that instance of 'struct index_state'.

Since it is a pointer then using a '#define' to replace 'the_index'
(which is not a pointer) would be a little more challenging.

> 
> I dunno.  Being able to leave the index field NULL lets you say
> "this is a bare repository and there is no place for the index file
> for it", but even if we never write out the in-core index to an
> index file on disk, being able to populate the in-core index that is
> default for the repository object from a tree-ish and iterating over
> it (e.g.  running in-core merge of trees) is a useful thing to do,
> so I do not consider "index field can be set to NULL to signify a
> bare repository" a very strong plus.
> 

I'd probably say that we'd eventually need a bit field in 'struct
repository' which indicates if a repository is bare.  I think we already
have a global variable somewhere which stores this sort of information.

-- 
Brandon Williams
