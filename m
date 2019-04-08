Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8431120248
	for <e@80x24.org>; Mon,  8 Apr 2019 17:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfDHRLy (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 13:11:54 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:48386 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbfDHRLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 13:11:54 -0400
Received: by mail-vk1-f201.google.com with SMTP id l85so7170559vke.15
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 10:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8PYJOS4bY9YQr1i7k8iEN2Q/RBJp/C2QiIFskcmrs6I=;
        b=XcFry7D9CxfaIGvHTjuVGLMCSOaPsGtb21JdRI7zRv+/uhosCs+JWAgmjdu0IjXkXo
         UTaSmGLbQvhN6+0Msolis1eE7cjQ3a7paDRx9og3ew1GWFDnr9aOHhynC4L2KC+UTDan
         AbWRWGnSkUujXdLFPer7UxoOLdMwnY82ltX3BczBZ2APwY3NkhC96cHOGaYYrJ0x/3gP
         RYZCx8mIhuv09hXxEgSIiajrqP421uDsdRCMle7rbKr+ireWawrjZO0uN6/FNgHn1rjJ
         WittBj4bA1QslTCHC/IM8LhXV0zSLUWRW7CfphZszJeaOrQYLb7WeqdCtwbDJE+0ws0h
         qOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8PYJOS4bY9YQr1i7k8iEN2Q/RBJp/C2QiIFskcmrs6I=;
        b=YujowZuamgJUlATFVFG9zRow0qSvMH3HA9ppRaEyl0XhfRsl9HRhckz/zZK3v6lP2O
         dhyXVke+fOIROrryZtu5z7L2wYzoaAEO2JySeAIAOi8hQXwj0NCLtR0G9vzC8o0SM3sh
         VzgcJ4fecqJ2t1geOfyssJ+wwl7fo1CdXeYWxM9O0+HTOhYrRS9uFijZoYRoTTo9Mz2F
         bc35ECQ8ntQ58GyBDs8bMBvYTVfAl1Q26tc+sDbHnu8TZRIAl8LT844P63vSiadtOtkl
         iqXNYyxabUMI7SUEWCcqbT/nwbYlgWB+IaH+FYI0UqksBG2HWME/6m06K+jD56f5/21L
         IiqQ==
X-Gm-Message-State: APjAAAWXGhKql/cre2J63EpLbGt/uMzS/OYe38lS4vlmbgr98B6+Z3AK
        YPwhRkD6jusPvsIv7GSJYhIzxPXrEuq+rb2dBNZn
X-Google-Smtp-Source: APXvYqx5WNTYF7gfyEuwMqmNIAJEL6Ch/MRL6trL1wqO6HyJZ4vi1in4FusObBT3O6bwU3055y7Hy2H4N7b6Bw96/ukd
X-Received: by 2002:a1f:6095:: with SMTP id u143mr3382521vkb.13.1554743513125;
 Mon, 08 Apr 2019 10:11:53 -0700 (PDT)
Date:   Mon,  8 Apr 2019 10:11:49 -0700
In-Reply-To: <20190406115728.GB219876@google.com>
Message-Id: <20190408171149.125872-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190406115728.GB219876@google.com>
X-Mailer: git-send-email 2.21.0.392.gf8f6787159e-goog
Subject: Re: [PATCH] clone: send server options when using protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jrnieder@gmail.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Teach "clone" the same ability, except that because "clone" already
> > has "-o" for another parameter, teach "clone" only to receive
> > "--server-option".
> 
> Can you give an example of what this would be used for?  An example I
> can think of might be
> 
> 	git clone --server-option=priority=batch <url>

protocol-v2.txt says that it is server-specific, so I don't think I can
give any meaningful examples here.

> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > @@ -66,6 +66,7 @@ static int option_dissociate;
> >  static int max_jobs = -1;
> >  static struct string_list option_recurse_submodules = STRING_LIST_INIT_NODUP;
> >  static struct list_objects_filter_options filter_options;
> > +static struct string_list server_options = STRING_LIST_INIT_DUP;
> 
> The other string-list options in this file all use NODUP.  Is there a
> reason this one uses DUP instead?  (Just curious --- I suspect either
> would work fine, since nothing here does tricks with modifying argv
> entries after option parsing.)
> 
> The same question applies to the corresponding option in
> builtin/fetch.c, so while it is not likely to matter in practice, it
> would be nice for readability to find out.

I guess it could be either. It's true that I just copied it from
builtin/fetch.c. I'll change it to NODUP if a reroll is needed for
another reason.

> > +	OPT_STRING_LIST(0, "server-option", &server_options, N_("server-specific"),
> 
> nit: long line

I'll change this if a reroll is needed for another reason.

> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> 
> Thanks for a pleasant read.

Thanks for your review.
