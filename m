Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A9F61F97E
	for <e@80x24.org>; Sat, 18 Aug 2018 21:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbeHSAQi (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 20:16:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34150 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbeHSAQi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 20:16:38 -0400
Received: by mail-wr1-f68.google.com with SMTP id c13-v6so9846555wrt.1
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e6Prv5JUybcot8ulLYRPNkk3aHQmxXGI7LppQ6JBz5w=;
        b=vA3Sch8zg5HnvQtVX9iKgEntiGULtNKdL+AmoYd0sHN0w+7e7bjhDMb6OmwDip+Fod
         0qFy8s/XUfKWTC5F2qCWscUZPBSbUzDTK2ontV+2YGc+v0R44Fp7/JSrco+mRNlLrrP2
         bSeFAr3GnTMAF1W1beh+Vx9zeFzvKTH1HdKZw2z0Logs1bEzFdB43fxDWfYQahr731+M
         PdPm55Kk38AYoDznAyquH+ffC6x9Zgd7KqluisQctD+ED0KqIV5ZesogGAgJJ8i496fw
         bnj7XeGaZ1PGv2z7wF7cCJwkkh1yGPyWswUA0cRQGHDX0VPPzJs5aLsk0SY00YL8jcsL
         FKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e6Prv5JUybcot8ulLYRPNkk3aHQmxXGI7LppQ6JBz5w=;
        b=ow91AUwYRymgyyG4Okeh40XdIcxfHFyUEJ6gCZQo9EBwzWJFvjiJYZuq5+RHZdeFOd
         Q6JTJdzTxc9R7/V+KPYSR/xf5X7vTNYIDrFoPtEUeD3PEeiF+HefNEbAzsVRxFJA/eBP
         m5Kjl1bHz71kYtcUGMgbLsiJFFn7N/GCu2OxqqWKh6YFlROht/GX63lpbLqPiFOV+PZv
         bqppEs4Os7pLCwHymR+bxJfcTHm0dwcGksVi91vEX8onOH4bQv31Lqu95hcQDk8m8wCd
         RcoDsfT0oTaNhZIDaNtamwkB9FGGEIab7TsnRY+U8FImEEFsitdqg7aWry2LrO5mlWiH
         DHtg==
X-Gm-Message-State: AOUpUlGk+fcIvbs6eBL8xt133Zlc4O10n/h71PzO9pVkDeaXhEGepJ01
        GplDdwoTaTPoSjwxH9zF8y2DzdEy
X-Google-Smtp-Source: AA+uWPy4HpgaYa8rqgJHTopPBR3aSGMaYr3XrAFlE6qptuFgmoeSRLTIWVXMxVMxVYNJr2eL8E/NFg==
X-Received: by 2002:a5d:4f82:: with SMTP id d2-v6mr25171172wru.261.1534626455955;
        Sat, 18 Aug 2018 14:07:35 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id j133-v6sm14285803wmd.12.2018.08.18.14.07.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 14:07:35 -0700 (PDT)
Date:   Sat, 18 Aug 2018 22:07:34 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v7 16/26] stash: replace spawning a "read-tree"
 process
Message-ID: <20180818210734.GG11326@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <0683dfe7cf0528c0288b57914e7626b5c7108909.1533753605.git.ungureanupaulsebastian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0683dfe7cf0528c0288b57914e7626b5c7108909.1533753605.git.ungureanupaulsebastian@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08, Paul-Sebastian Ungureanu wrote:
> Instead of spawning a child process, make use of `reset_tree()`
> function already implemented in `stash-helper.c`.
> ---
>  builtin/stash--helper.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/builtin/stash--helper.c b/builtin/stash--helper.c
> index a4e57899b..887b78d05 100644
> --- a/builtin/stash--helper.c
> +++ b/builtin/stash--helper.c
> @@ -984,21 +984,18 @@ static int stash_patch(struct stash_info *info, const char **argv)
>  static int stash_working_tree(struct stash_info *info, const char **argv)
>  {
>  	int ret = 0;
> -	struct child_process cp0 = CHILD_PROCESS_INIT;
>  	struct child_process cp1 = CHILD_PROCESS_INIT;
>  	struct child_process cp2 = CHILD_PROCESS_INIT;
>  	struct child_process cp3 = CHILD_PROCESS_INIT;
>  	struct strbuf out1 = STRBUF_INIT;
>  	struct strbuf out3 = STRBUF_INIT;
>  
> -	cp0.git_cmd = 1;
> -	argv_array_push(&cp0.args, "read-tree");
> -	argv_array_pushf(&cp0.args, "--index-output=%s", stash_index_path.buf);
> -	argv_array_pushl(&cp0.args, "-m", oid_to_hex(&info->i_tree), NULL);
> -	if (run_command(&cp0)) {
> +	set_alternate_index_output(stash_index_path.buf);
> +	if (reset_tree(&info->i_tree, 0, 0)) {
>  		ret = -1;
>  		goto done;
>  	}
> +	set_alternate_index_output(".git/index");

I think this second 'set_alternate_index_output()' should be
'set_alternate_index_output(NULL)', which has slightly different
semantics than setting it to '.git/index'.  Having it set means that
the index is written unconditionally even if it is not set.

Also the index file could be something other than ".git/index", if
the GIT_INDEX_FILE environment variable is set, so it should be
replaced with 'get_index_file()' if we were to keep this.

I was also wondering if we could avoid writing a temporary index to
disk, in 'stash_working_tree', but I don't see an easy way for doing
that.

>  
>  	cp1.git_cmd = 1;
>  	argv_array_pushl(&cp1.args, "diff-index", "--name-only", "-z",
> -- 
> 2.18.0.573.g56500d98f
> 
