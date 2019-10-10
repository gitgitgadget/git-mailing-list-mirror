Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2105A1F4C0
	for <e@80x24.org>; Thu, 10 Oct 2019 19:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfJJTCd (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Oct 2019 15:02:33 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:33834 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfJJTCc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Oct 2019 15:02:32 -0400
Received: by mail-pf1-f201.google.com with SMTP id a1so5467726pfn.1
        for <git@vger.kernel.org>; Thu, 10 Oct 2019 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LGk90fkFCYehzSxnhNRSWh1ARup2fFdBQzgOJteob5w=;
        b=g7zZPQ1kKwZ+bxMlKG84uygX97pqpkALw9/W/7eOuaWuP+GFuW9x1aoC2DyMOL/Z5Z
         SE0FCIcDXzZf7wdot5lOvBL7GzoPbRVxt0Ue48C048xW+Jzx4tFmUY7+jy7gT0CZwpUC
         kNPVZU+QWQqYyA88NnJWSKBqMFfWh5SB6wJH9jeRLWdWr1Gmwm8Alf9BUqnteN3DdDBK
         E5B90xuUiXevIeGjoPyN86NTLCkltYfx6nLYEiUQ517NYifiW+tcOJEHtntjJ+PqEK/n
         frQFkT6C2ugLVq03yJ+R+2xRkmtQiVmVM55+yu40ZLhRIluntKnVhhdTfz+5GQrEIr1T
         8Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LGk90fkFCYehzSxnhNRSWh1ARup2fFdBQzgOJteob5w=;
        b=nAUGLYO74iavX5u07ne8DUtn7cKCum2ZkjeKBajchZ9+vFa1kUwh0fTMTJlN1y5S0b
         j3265EuVD9ybA93bcTcEUUnEXdMEAxcs897Gqnc5hrtT7YxjAqSeekxAx8ZKtz0qaHk0
         YodGivbJNaPh6Lv2Ys2npjtfhT6jCW+xHyHxK28OwcjcxIowDZ/5PvO45Mzy1VJW9PzS
         uo5a8iBSVoMHSHxtm9BiX+bTccpQyvZZgC78ah0hPUatl6Z/AVwPbAxpCYz5sZ/wjcti
         bZACPKYrwb9J+tdYdtW7laT7AU6ys7uwdhycjJAx2Npj+3lr/CtcAWfafubud7ZBOety
         JZ/w==
X-Gm-Message-State: APjAAAUS1UFWPqxIgg2nxGgI9fIJ344kua3/JCj4XWBT9/t7pcUMjscf
        X7kfXbptIhxECxDP3HSvq4U3f8Mz1yrRSlKhUpYM
X-Google-Smtp-Source: APXvYqyCcMAbNJn/iPU1F7Ew0G56CAumswOS+x/mLVynK+Agz5pzgs9UIjTukYqDMNJfmDmSVP8CbaxY3vH+MLg0YjNv
X-Received: by 2002:a63:81:: with SMTP id 123mr12975998pga.47.1570734152082;
 Thu, 10 Oct 2019 12:02:32 -0700 (PDT)
Date:   Thu, 10 Oct 2019 12:02:29 -0700
In-Reply-To: <67ca2f70-361a-bebd-7590-37337959552c@gmail.com>
Message-Id: <20191010190229.100750-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <67ca2f70-361a-bebd-7590-37337959552c@gmail.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [PATCH 3/6] index-pack: remove redundant child field
From:   Jonathan Tan <jonathantanmy@google.com>
To:     stolee@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, peff@peff.net,
        mh@glandium.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 10/9/2019 7:44 PM, Jonathan Tan wrote:
> > Instead, recompute ancestry if we ever need to reclaim memory.
> 
> I find this message lacking in important details:
> 
> 1. Where do we recompute ancestry?
> 2. What are the performance implications of this change?
> 3. Why is it important that you construct a stack of deltas in prune_base_data()?

Thanks for taking a look at this. My original plan (as I perhaps badly
explained in the cover letter [1]) was to show the individual small
steps that I took to reach the end goal, each step still passing all
tests, in the hope that small steps are easier to understand than one
big one. Hence why I didn't explain much in this commit message (and
others), because I thought that I might have to squash them later. But
perhaps that is too confusing and I should have just squashed them in
the first place (and explain all the changes in the commit message -
it's +177 -198, which is not too big anyway).

To answer the question anyway, the short answer is that it doesn't
matter because I'm going to replace this mechanism in later patches. But
a longer answer:

 1. In prune_base_delta() (the stack of deltas you mention in question
    3).
 2. Slightly fewer pointer management during the normal course of
    operation, but an allocation if we ever need to reclaim memory.
 3. To recompute the ancestry. We have ancestry using the "base"
    pointer, but I need to iterate from the oldest to newest, so I
    create an array of all the "base" pointers and iterate in reverse.

[1] https://public-inbox.org/git/cover.1570663470.git.jonathantanmy@google.com/

> >  static void link_base_data(struct base_data *base, struct base_data *c)
> >  {
> > -	if (base)
> > -		base->child = c;
> > -	else
> > -		get_thread_data()->base_cache = c;
> > -
> >  	c->base = base;
> > -	c->child = NULL;
> >  	if (c->data)
> >  		get_thread_data()->base_cache_used += c->size;
> >  	prune_base_data(c);
> > @@ -408,11 +416,6 @@ static void link_base_data(struct base_data *base, struct base_data *c)
> >  
> >  static void unlink_base_data(struct base_data *c)
> >  {
> > -	struct base_data *base = c->base;
> > -	if (base)
> > -		base->child = NULL;
> > -	else
> > -		get_thread_data()->base_cache = NULL;
> >  	free_base_data(c);
> >  }
> 
> Seems like this method should be removed and all callers should
> call free_base_data() instead.

I agree, and did it in the next patch. Here I left it to preserve the
{link,unlink}_base_data symmetry.
