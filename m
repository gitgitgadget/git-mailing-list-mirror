Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DBEB1F454
	for <e@80x24.org>; Thu, 31 Oct 2019 22:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfJaWxO (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 18:53:14 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41867 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfJaWxO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 18:53:14 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so3409015plr.8
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 15:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a+KFNtCEXL0oeLlN1KxMc/M1QbTLLJePQqcnUW1hAKs=;
        b=nkP4T35mILeaas7kMLrh8oDkj4Fsx+8lrNc8zKCLjxFQ37iPXVFyKHJSwie2HFIvsX
         lyqAT9v6YjO3+wv9lxVuLEoNGT6zHlMxv3j2e8leiFxzkjBKCSgQDJEUcDpK6GArmDKl
         0KXObY5XivBzJ9cPDgDw8hfAXZsYAInJoKxefz1OLQWRreVF7cNeBtQY2o+QYXHm+SHg
         2EpHFVvEvJhFCDW9FGXx0+PWzMEs6o5rX/Kz7WwKvayEvyNKIvsHYuhVk4nL1I15/lcc
         piG+nEsGI7TLfPivZQW8/1oDMeNgmyD0q0oD9AQN57fLa7SK1xUHE1BezoK4J8nlyPIm
         rayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a+KFNtCEXL0oeLlN1KxMc/M1QbTLLJePQqcnUW1hAKs=;
        b=rotmvhOzaRX9RQmkcT/maNNRjjxID968pEqq4Ux6Xc9PhQ+eINsh6hwrhUmj1NKfqb
         mJ+l9mNcYivMcNBcwSnJtlbbN8b5GVKA82tILLMfYtjRgsPuxw3K7ma8Amnij1k1zqhC
         aaoKyg8VcUBXPEYu7WAiI9HvHUq3UBZFnk+aRk4QL1f/HLq37eejDtRkhPvGpWCq6psy
         yy7KmbsUwPZOA9Jpd9a9QTlvtnxCs0+I8xJJvy7AtLbt1YVLOOnedAMAnE2+29Qow1Vp
         76CfXIRTNOsbY6PoOJzfiDCCCSmhD4el215ml+FVGwzbWQUtT7jTWYQcmZUg9dFSNAZr
         z7wQ==
X-Gm-Message-State: APjAAAXrBO0Z+wTMCg0/RH1aMN+8HSVMVIkO7g1HjY3qM+8YlVyB1kYH
        Flp8Z3Kf7HTHlBY3LxJsoEs=
X-Google-Smtp-Source: APXvYqwOHcfQVMU/jxIoGKdKOkxwxVSEAZY3VrlfeUz48Lidn1iaOWf7cX7PG309toQuAsZVjECKww==
X-Received: by 2002:a17:902:ff0e:: with SMTP id f14mr8961664plj.17.1572562393032;
        Thu, 31 Oct 2019 15:53:13 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 205sm1751579pge.56.2019.10.31.15.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 15:53:12 -0700 (PDT)
Date:   Thu, 31 Oct 2019 15:53:10 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] fetch.c: fix typo in a warning message
Message-ID: <20191031225310.GA211076@google.com>
References: <pull.441.git.1572554506.gitgitgadget@gmail.com>
 <70f10fe44716e50765a9d8f7794116f390f09dbc.1572554506.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70f10fe44716e50765a9d8f7794116f390f09dbc.1572554506.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ralf Thielow wrote:

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  builtin/fetch.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> Noticed this while reviewing German translation.

This kind of context tends to be useful in a commit message --- it
helps clarify the motivation behind the change.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 0c345b5dfe..f9a934f098 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1411,7 +1411,7 @@ static int do_fetch(struct transport *transport,
>  		for (rm = ref_map; rm; rm = rm->next) {
>  			if (!rm->peer_ref) {
>  				if (source_ref) {
> -					warning(_("multiple branch detected, incompatible with --set-upstream"));
> +					warning(_("multiple branches detected, incompatible with --set-upstream"));

Long line.

I wonder what this warning is trying to say.  How would I go about
triggering this message?  The comment before says

	The relevant upstream is the fetched branch that is meant to
	be merged with the current one, i.e. the one fetched to
	FETCH_HEAD.

So is this about when I'm fetching with a wildcard or something?

Thanks,
Jonathan
