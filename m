Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F13720798
	for <e@80x24.org>; Fri, 11 Nov 2016 23:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965167AbcKKXOz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 18:14:55 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:34263 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbcKKXOx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 18:14:53 -0500
X-Greylist: delayed 335 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Nov 2016 18:14:53 EST
Received: by mail-pg0-f48.google.com with SMTP id x23so15160055pgx.1
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 15:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=EW/TRX4Ufzetn0zQTfD3VGla5UH6yT8tQ7gU7XL38As=;
        b=asEUFip0vqj+ro4FAs7enIGzs6kicFELtV1Ijm4NGVulCDPefgQQTO+DNATuORLTCp
         0UDzJbyVXNOwuEW7A/fuh9MHCqeDytSXNpKoTigUP3eJuVlnv1++a0dQlST1BFGXH4vm
         CKshoeOv8HrBwYJ5sYTk/blJ9xXpraGpxGrfWKlvTSA6GvdhWNri4GVSRS6mHKMJOQhW
         J4ncFTGRJaiF5GydqIZX3V9A8zmu01OwAzfKVcQd5gHDsQSrr6MfxXliZZjesKJZmux6
         5Pntc/4Sn+SABKtMdTGc28TGLkfiQtB2u73xVDgw8vY7KC4V3bBPGQmyL8cFjDW+/sk4
         lzdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EW/TRX4Ufzetn0zQTfD3VGla5UH6yT8tQ7gU7XL38As=;
        b=JcVwm52QbIPAvWZx0aNW7qoK1sC7aiaDq/VvTjtrAa9tnF6c7JdKpRvRmNNptyjAQi
         UrqK+WzOyl8Brb+XN5ED7LYDcKb4RQargAWmjaXp6UULHBPGlVKjoYE8o8uvtcO4rtGK
         SJZuBOeEjS0ml+j3xcV8fE4RR9BWMomdgp6aFsensUk64io7x0j1MKSGF6jDDECtpLCN
         T6bgZShUEIF9vKln9uZcCAhk9yPGiiyytxqb7XA51KCXss06EQ2v4AYu3+aSd6T+2lYu
         Seg6EvGk5TO0gYuBQV2nyi0X5y3oNKyW8zLtvqiIpWBoxSLzCvamMnmQnxnMVG7CYb5e
         Urrg==
X-Gm-Message-State: ABUngvevd73Oebll0B2H/pLPxHcg64RofSZcyavRzR/GzGjW+UjKlgglyA4OwH7vh0Y0G/um
X-Received: by 10.99.53.195 with SMTP id c186mr48684979pga.125.1478905758148;
        Fri, 11 Nov 2016 15:09:18 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:f96b:4a56:29b7:f2da])
        by smtp.gmail.com with ESMTPSA id hv3sm17545968pad.30.2016.11.11.15.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Nov 2016 15:09:16 -0800 (PST)
Subject: Re: [PATCH v2 5/6] grep: enable recurse-submodules to work on <tree>
 objects
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org,
        sbeller@google.com
References: <20161027223834.35312-1-bmwill@google.com>
 <1477953496-103596-1-git-send-email-bmwill@google.com>
 <1477953496-103596-6-git-send-email-bmwill@google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <36dd3a9b-39ae-4c5f-90d6-589820501ed4@google.com>
Date:   Fri, 11 Nov 2016 15:09:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <1477953496-103596-6-git-send-email-bmwill@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/31/2016 03:38 PM, Brandon Williams wrote:
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 17aa1ba..386a868 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -26,7 +26,7 @@ SYNOPSIS
>  	   [--threads <num>]
>  	   [-f <file>] [-e] <pattern>
>  	   [--and|--or|--not|(|)|-e <pattern>...]
> -	   [--recurse-submodules]
> +	   [--recurse-submodules] [--parent-basename]

Maybe add something after --parent-basename, since it takes an argument 
(like --threads above).

> @@ -91,7 +91,16 @@ OPTIONS
>
>  --recurse-submodules::
>  	Recursively search in each submodule that has been initialized and
> -	checked out in the repository.
> +	checked out in the repository.  When used in combination with the
> +	<tree> option the prefix of all submodule output will be the name of
> +	the parent project's <tree> object.
> +
> +--parent-basename::

Same comment as above.

> diff --git a/builtin/grep.c b/builtin/grep.c
> index cf4f51e..2f10930 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -19,6 +19,7 @@
>  #include "dir.h"
>  #include "pathspec.h"
>  #include "submodule.h"
> +#include "submodule-config.h"
>
>  static char const * const grep_usage[] = {
>  	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
> @@ -28,6 +29,7 @@ static char const * const grep_usage[] = {
>  static const char *super_prefix;
>  static int recurse_submodules;
>  static struct argv_array submodule_options = ARGV_ARRAY_INIT;
> +static const char *parent_basename;

Can this be passed as an argument to the functions (grep_objects and 
grep_object, it seems) instead of having a file-visible variable?

> @@ -671,12 +707,29 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
>  	enum interesting match = entry_not_interesting;
>  	struct name_entry entry;
>  	int old_baselen = base->len;
> +	struct strbuf name = STRBUF_INIT;
> +	int name_base_len = 0;
> +	if (super_prefix) {
> +		name_base_len = strlen(super_prefix);
> +		strbuf_addstr(&name, super_prefix);

Better to invoke strbuf_addstr, and then set name_base_len from 
name.len. This makes it clear where strbuf_setlen (subsequently) resets 
the strbuf to, and is also a slight performance improvement.

