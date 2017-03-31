Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79AA91FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 23:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932756AbdCaX0f (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 19:26:35 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36853 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754628AbdCaX0e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 19:26:34 -0400
Received: by mail-pg0-f49.google.com with SMTP id g2so82829460pge.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 16:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RuDntovSHva3RQV6CR9mBnRIJY1kMpsUc8o/XlQPLEA=;
        b=Eaa/PQTSGdIhE7RnRVDslTYyyWfjKxWh+v0zk35wCSSq78eTQ6PS9rqbX+Sczb9FR+
         VX4is/JRpKvUxc6AjaMBPhtdyKXu5FImC1qIj2/HNbTP/jXqL3EzfpoqFUx5wrfPiHWV
         tDz8f6Lys6JjYW5mFf/Nv/L+9bXJFTDFZWQL5Grd7A+Q4FOaleQMTqYWR8DqckYl9ad5
         g+/y606wsHfLjSeCdfth1mZZeMVraMyS4CAbronTeYhA9CJiIJ9AZEgim0r7Xe9jzP6e
         TBtRvDk/KpkviTyYVF05tkEwvyNR6R8uFRnsKGqJ7HfHdOUOJsqMWMvZDvdTxoExD+9w
         DDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RuDntovSHva3RQV6CR9mBnRIJY1kMpsUc8o/XlQPLEA=;
        b=a/hkvwz86428baFTg60xASDUi2e9jy65NbYHR6P2aim6xU9y8+qFB5vNdePtSggPxr
         TXBpU0lv01dOF8FNegj06wGQt2X8IVJnSmqWLSohNv21hFhEZZZoNsFIo8sKNv2t/ANl
         58uJxkjqfLPKlFsOehhzvN4QbrAXcRNNz7LtWfbhi0h9t3zrzJqUjze/TI5id4D/0cwb
         0xo3nJzfnEm3P9c9ILY/qjGD+j0KfJENKydGpWAHN4XzJ4pREnfsA2WfUJsTZhkJE+dp
         7H2pGGf0qQyEcWaNhMrPYDmMwILgnASeKHQxoZASfwmF4cvKYnEbxDA02SaeRYmo6ifm
         RWhA==
X-Gm-Message-State: AFeK/H35DBYnAgJ8fEZVM6sWOlkGzWnMYantjb6esepV4ScAwYb71q1SScHnU4TFcgn4n1al
X-Received: by 10.99.116.18 with SMTP id p18mr5435263pgc.74.1491002793718;
        Fri, 31 Mar 2017 16:26:33 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:6531:bef0:31b8:e5b7])
        by smtp.gmail.com with ESMTPSA id z63sm12430544pfz.70.2017.03.31.16.26.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 31 Mar 2017 16:26:32 -0700 (PDT)
Date:   Fri, 31 Mar 2017 16:26:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] push: propagate push-options with --recurse-submodules
Message-ID: <20170331232631.GA40772@google.com>
References: <20170331231135.195195-1-bmwill@google.com>
 <20170331232030.GA8741@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170331232030.GA8741@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/31, Jonathan Nieder wrote:
> Hi,
> 
> Brandon Williams wrote:
> 
> > Teach push --recurse-submodules to propagate push-options recursively to
> > the pushes performed in the submodules.
> 
> Sounds like a good change.
> 
> [...]
> > +++ b/submodule.c
> [...]
> > @@ -793,6 +794,12 @@ static int push_submodule(const char *path, int dry_run)
> >  		if (dry_run)
> >  			argv_array_push(&cp.args, "--dry-run");
> >  
> > +		if (push_options && push_options->nr) {
> > +			static struct string_list_item *item;
> 
> Why static?  It would be simpler (and would use less bss) to let this
> pointer be an automatic variable instead.

Oops, definitely shouldn't be static! Thanks for catching that.

> 
> > +			for_each_string_list_item(item, push_options)
> > +				argv_array_pushf(&cp.args, "--push-option=%s",
> > +						 item->string);
> > +		}
> >  		prepare_submodule_repo_env(&cp.env_array);
> >  		cp.git_cmd = 1;
> >  		cp.no_stdin = 1;
> > @@ -807,7 +814,8 @@ static int push_submodule(const char *path, int dry_run)
> >  
> >  int push_unpushed_submodules(struct sha1_array *commits,
> >  			     const char *remotes_name,
> > -			     int dry_run)
> > +			     int dry_run,
> > +			     const struct string_list *push_options)
> 
> nit: I wonder if dry_run should stay as the last argument.  That would
> make it closer to the idiom of have a flag word as last argument.

Yeah I can flip the order.

> 
> [...]
> > +++ b/t/t5545-push-options.sh
> > @@ -142,6 +142,45 @@ test_expect_success 'push options work properly across http' '
> >  	test_cmp expect actual
> >  '
> >  
> > +test_expect_success 'push options and submodules' '
> 
> Yay!
> 
> What happens if the upstream of the parent repo supports push options
> but the upstream of the child repo doesn't?  What should happen?

push would fail since the children are pushed first.

> 
> Thanks and hope that helps,
> Jonathan

-- 
Brandon Williams
