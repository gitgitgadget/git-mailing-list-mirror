Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ECE572021E
	for <e@80x24.org>; Wed, 16 Nov 2016 00:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbcKPAGZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 19:06:25 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32909 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752263AbcKPAGY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 19:06:24 -0500
Received: by mail-pg0-f51.google.com with SMTP id 3so72193997pgd.0
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 16:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEbnpoxuy5GP2lk2MK2lbFmkJ2hxhB0zYKKh/7J+rkA=;
        b=kzzGsKp22cgpE8UB/E5HXmWA4wrLbjjlqN3NDy2WE9vb8+2T6Y+J/JDnvnn9qqyFXH
         HuJvJ+4pNWWhTaoYTfNWyyGMINAC30R47IpsmChZr441tJ928GbRrcq5QbAGOfT0Z/KU
         DLHQfGiQcNS9pxjz23FwUSH+fyO/iaNpHJopa44LXzFU9rzWCFWfQ3YTcqihe6pVdxlA
         YLu3g3VPqHUUv4JFT1TlDQ6OBJiQ9Syog/SyBv+DZfmpwzcw+fXlKqTw3Oz6m7WWIi6Y
         xjlsE8GQYaHAg9hZrNbpPWBnhSTrB98NmBSNZeThckEKhPqE/8PXl9VDRF2cS9jDpsBY
         2CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEbnpoxuy5GP2lk2MK2lbFmkJ2hxhB0zYKKh/7J+rkA=;
        b=TCYIFte3Mi39KFyhDLSWsBdBj3cfRweZvTqK1s2is1KN3IHhPx+/0o6LvVpQ8wfIck
         DK2anqH20gFrW/JgHWrsTA2xvj4MhuumVhk9iWE/6ML+iFswxQ7y/wK9cICSMYxTO+0V
         0N7KXhM+lv1mIMc/xeC9JLE0l3qw6fIGZ7qwqnz6pdVkHyuqlXpRhqNLYKQekZUxatFs
         E/Bt+BRhN1YXT5/qqfgEe/bXkn929r80kkmX1r1S+a3AQ7aZkNJcgjZUDSyK5X3+Yb82
         f9q02zWE5IkvTE4iRV46BVCh8PPJ76V6LWM/Y9jzkyB+Ji02JtzJchxISVIKPkdqp+F2
         Wq5A==
X-Gm-Message-State: ABUngvfPpRsHo0BsXFuNMVdhmtNzFZD52YbxOvWJIFZJG/1E7ukdJCnqClF1Q7qIZ538Sje3
X-Received: by 10.98.147.93 with SMTP id b90mr358856pfe.170.1479254783299;
        Tue, 15 Nov 2016 16:06:23 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:f0a8:aad3:5a98:9829])
        by smtp.gmail.com with ESMTPSA id s8sm46540419pfj.45.2016.11.15.16.06.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 16:06:22 -0800 (PST)
Date:   Tue, 15 Nov 2016 16:06:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jrnieder@gmail.com,
        mogulguy10@gmail.com, David.Turner@twosigma.com
Subject: Re: [PATCH 10/16] update submodules: is_submodule_checkout_safe
Message-ID: <20161116000621.GG66382@google.com>
References: <20161115230651.23953-1-sbeller@google.com>
 <20161115230651.23953-11-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161115230651.23953-11-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/15, Stefan Beller wrote:
> In later patches we introduce the options and flag for commands
> that modify the working directory, e.g. git-checkout.
> 
> This piece of code will answer the question:
> "Is it safe to change the submodule to this new state?"
> e.g. is it overwriting untracked files or are there local
> changes that would be overwritten?
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule.c | 22 ++++++++++++++++++++++
>  submodule.h |  2 ++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index 2773151..2149ef7 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1201,6 +1201,28 @@ int ok_to_remove_submodule(const char *path)
>  	return ok_to_remove;
>  }
>  
> +int is_submodule_checkout_safe(const char *path, const struct object_id *oid)
> +{
> +	struct child_process cp = CHILD_PROCESS_INIT;
> +
> +	if (!is_submodule_populated(path))
> +		/* The submodule is not populated, it's safe to check it out */
> +		/*
> +		 * TODO: When git learns to re-populate submodules, a check must be
> +		 * added here to assert that no local files will be overwritten.
> +		 */

When you mean local files do you mean in the situation where we want to
checkout a submodule at path 'foo' but there already exists a file at
path 'foo'?

> +		return 1;
> +
> +	argv_array_pushl(&cp.args, "read-tree", "-n", "-m", "HEAD",
> +			 sha1_to_hex(oid->hash), NULL);
> +
> +	prepare_submodule_repo_env(&cp.env_array);
> +	cp.git_cmd = 1;
> +	cp.no_stdin = 1;
> +	cp.dir = path;
> +	return run_command(&cp) == 0;
> +}
> +
>  static int find_first_merges(struct object_array *result, const char *path,
>  		struct commit *a, struct commit *b)
>  {
> diff --git a/submodule.h b/submodule.h
> index f01f87c..a7fa634 100644
> --- a/submodule.h
> +++ b/submodule.h
> @@ -74,6 +74,8 @@ extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
>  extern int is_submodule_populated(const char *path);
>  extern int submodule_uses_gitfile(const char *path);
>  extern int ok_to_remove_submodule(const char *path);
> +extern int is_submodule_checkout_safe(const char *path,
> +				      const struct object_id *oid);
>  extern int merge_submodule(unsigned char result[20], const char *path,
>  			   const unsigned char base[20],
>  			   const unsigned char a[20],
> -- 
> 2.10.1.469.g00a8914
> 

-- 
Brandon Williams
