Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B43020401
	for <e@80x24.org>; Wed, 21 Jun 2017 23:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbdFUXAN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 19:00:13 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35632 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdFUXAN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 19:00:13 -0400
Received: by mail-pf0-f172.google.com with SMTP id c73so31388552pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 16:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X7M+Bg3p7kmPfhKm3oMchDuKJWde0wRGnfiRLiIbxf4=;
        b=aKCFH/uAIrMEVZbhv10GWqBs7jG+cRbE8eDnQJfAOMyraM//+EXPMKBaiig0qSlDqc
         7VTYI6FdB1lGZtbhsapVvw4tT1iKcygNhFRYCA53VNQEk4qo7I77ieHi+xhXXAqJZGhp
         0WvBBoYmXS5AcXvLfN4LeOJn6Ie1X7pli04bkLW7kYSNdkb7wkqyIUwz+GI9T+UIfutl
         aiq8gFqEzpnSgWHUwXqMP3uDoMFXGfPeubs216jluG/5oOlLGjs8PasTyjHqWai9Mb7j
         O7uwnsYDQF7xVZZxlZgNPY9NC9KBn/rijBCmRKPUNRiyVoN1I1yhclpF2headuAN1XUz
         n86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X7M+Bg3p7kmPfhKm3oMchDuKJWde0wRGnfiRLiIbxf4=;
        b=oAWW6gip9VRwi70ZFo0z7WLOdj3KEuwcHlgAT72ijpXKNtsxhzSJUAO/XB2BvuSs9e
         CJwdzU+vkuqIseA9JxQ5TzkmxDu0n1yncFEikR91CwI3jXZtME1k0RTjsy8VxvpD2wOb
         voUz87qEjq1hu0fIxKXttXg5h4CvQZcn1UcQ/GG3MjsHeLLH7FRY5xm06w2CLqJjBp02
         W2rQLbIsMdJDqJP+mQT8mbs5x3AQsPNDL9evxC1nQ9ZYT00WknocMhgPZQOIur09y/Kg
         y7pNzFr1AqCSdXG4AiWm0FNO7gZPb6be7piIcewCAKAKpNCyK+5AWwBoThBcK6gr3o5K
         G+tA==
X-Gm-Message-State: AKS2vOwXB7rlaI0AvbjGlE4L8rH+GfF9e5BXSrPWwMSMsiov7UxUwDgS
        zwNl8FcNAQwgqkcI
X-Received: by 10.84.231.141 with SMTP id g13mr43603109plk.157.1498086012153;
        Wed, 21 Jun 2017 16:00:12 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a12e:c584:e29b:1036])
        by smtp.gmail.com with ESMTPSA id r85sm37518109pfd.100.2017.06.21.16.00.11
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 16:00:11 -0700 (PDT)
Date:   Wed, 21 Jun 2017 16:00:07 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jrnieder@gmail.com,
        jacob.keller@gmail.com, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, peartben@gmail.com,
        pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
        git@jeffhostetler.com, avarab@gmail.com
Subject: Re: [PATCH v3 19/20] repository: enable initialization of
 submodules
Message-ID: <20170621160007.4976187d@twelve2.svl.corp.google.com>
In-Reply-To: <20170620191951.84791-20-bmwill@google.com>
References: <20170608234100.188529-1-bmwill@google.com>
        <20170620191951.84791-1-bmwill@google.com>
        <20170620191951.84791-20-bmwill@google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 20 Jun 2017 12:19:50 -0700
Brandon Williams <bmwill@google.com> wrote:

> Introduce 'repo_submodule_init()' which performs initialization of a
> 'struct repository' as a submodule of another 'struct repository'.
> 
> The resulting submodule can be in one of three states:
> 
>   1. The submodule is initialized and has a worktree.
> 
>   2. The submodule is initialized but does not have a worktree.  This
>      would occur when the submodule's gitdir is present in the
>      superproject's 'gitdir/modules/' directory yet the submodule has not
>      been checked out in superproject's worktree.

In a recent proposal [1] to update the submodule documentation, an
"initialized submodule" is one that has a working directory, which seems
to have a different meaning of "initialized" (to the paragraphs above).

Or did you mean the "struct repository" is initialized etc.? In which
case, it does not seem strange to me that a repository is initialized
but does not have a worktree, since bare repositories are like that too.

[1] https://public-inbox.org/git/20170621173756.4444-1-sbeller@google.com/

>   3. The submodule remains uninitialized due to an error in the
>      initialization process or there is no matching submodule at the
>      provided path in the superproject.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

[snip]

> +/*
> + * Initialize 'submodule' as the submodule given by 'path' in parent repository
> + * 'superproject'.
> + * Return 0 upon success and a non-zero value upon failure.
> + */
> +int repo_submodule_init(struct repository *submodule,
> +			struct repository *superproject,
> +			const char *path)
> +{
> +	const struct submodule *sub;
> +	struct strbuf submodule_path = STRBUF_INIT;
> +	int ret = 0;
> +
> +	sub = submodule_from_cache(superproject, null_sha1, path);
> +	if (!sub) {
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	strbuf_repo_worktree_path(&submodule_path, superproject, "%s", path);
> +
> +	if (repo_init(submodule, submodule_path.buf, submodule_path.buf)) {

This works because the 2nd parameter (git_dir) can take in either the
Git directory itself or its parent, but it does make the call site look
strange. Would it be a good idea to make it mandatory to specify the Git
directory? That would make call sites clearer but require more code
there.

> +		strbuf_reset(&submodule_path);
> +		strbuf_repo_git_path(&submodule_path, superproject,
> +				     "modules/%s", sub->name);
> +
> +		if (repo_init(submodule, submodule_path.buf, NULL)) {
> +			ret = -1;
> +			goto out;
> +		}
> +	}
> +
> +	submodule->submodule_prefix = xstrfmt("%s%s/",
> +					      superproject->submodule_prefix ?
> +					      superproject->submodule_prefix :
> +					      "", path);
> +
> +out:
> +	strbuf_release(&submodule_path);
> +	return ret;
> +}
