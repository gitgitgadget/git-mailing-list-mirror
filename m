Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E4EB1F428
	for <e@80x24.org>; Sun, 12 Aug 2018 21:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeHMA1I (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 20:27:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37127 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbeHMA1I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 20:27:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id n11-v6so6919012wmc.2
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kO6uYy60ulRRCExzgDW83DUx3o+XaKcnZ6bvEHuzlsI=;
        b=VO59zZ5SIHxXwdHncydlXNHHgI8Ybh8BhM6U1VD1dD2Rl92rfTQ0xA2zQu69rDL2Zz
         d00yHqlTkICjZyLyfPS8fNkX/GwEWmlFFATFslVjBBymdanH15skZ5XuXCvUJkOYZzmk
         eQVAlI0JvTLhf8yhrK51/JX32FBwcAPCzB8qdzH7gepbuwAvtq4uvakxNoEEelbTpN+I
         UlZlwBQ0V7ABirRDz5mZdIpMRHrJpRl6w3bkQIPLKajpPZXMy6Qyx6Oj8exPr17N5k7V
         Oz/AZKa61Sb37gxGTSkv34RPKbBudlWPkkbfZ6paRXIbAApFOq6ooOwhctf3LYmnxH+V
         B1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kO6uYy60ulRRCExzgDW83DUx3o+XaKcnZ6bvEHuzlsI=;
        b=OwXiPimhXqvJi6oOFwAPqqjH8S8cC2YiWMMhgbcHwD2TDTP+PrNjvYblxvLoGg2Eqm
         DrPddUgbIASguD3uK0sFER5KFYTsXkglUsy8SEr4QtYZONrGzpRwKmXLoVYu5PXm2K7+
         tHeaGhVDCqmw6kNd4l1yFnjUHp3U0ZpnqvZyf4bRzmyJVC9IISRICr9wRE6e4I0eG7uL
         +I93UmWzvD14KESv7dr6xYkSrXZQwwaRTWieZGCEi2Jf+D6xjKIczR1FwBlnbHVh8ygV
         AU+hquOnkgd23mbo3+dAE6yMYRIp+3gVEf2970DKr+Y7klC3bqyyO/5FdDYtsIgRyeUN
         yeBg==
X-Gm-Message-State: AOUpUlHDBk91WHn3eX+z8tvisUgKYAVF/7604TJQDl4QHyL7GwMXPYEW
        x/7USNPMHGrzPQlrG/CIyRY=
X-Google-Smtp-Source: AA+uWPzhM+scdVUJF07LTujicFrx01Qg0N8QDMiHEeAs4jxXcykMjLHXkhILuNFHzdB+BlUDV699RA==
X-Received: by 2002:a1c:c14:: with SMTP id 20-v6mr6955801wmm.117.1534110464072;
        Sun, 12 Aug 2018 14:47:44 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id p14-v6sm19550876wru.0.2018.08.12.14.47.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Aug 2018 14:47:42 -0700 (PDT)
Date:   Sun, 12 Aug 2018 22:47:41 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v5 05/21] range-diff: also show the diff between patches
Message-ID: <20180812214741.GB13316@hank.intra.tgummerer.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
 <pull.1.v5.git.gitgitgadget@gmail.com>
 <9e1e660077d41c479ae46eb07371204c01dff4cd.1533939264.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e1e660077d41c479ae46eb07371204c01dff4cd.1533939264.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On 08/10, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> [..]
> 
> @@ -13,15 +14,38 @@ NULL
>  int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  {
>  	int creation_factor = 60;
> +	struct diff_options diffopt = { NULL };
>  	struct option options[] = {
>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("Percentage by which creation is weighted")),
>  		OPT_END()
>  	};
> -	int res = 0;
> +	int i, j, res = 0;
>  	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
>  
> +	git_config(git_diff_ui_config, NULL);
> +
> +	diff_setup(&diffopt);
> +	diffopt.output_format = DIFF_FORMAT_PATCH;
> +
>  	argc = parse_options(argc, argv, NULL, options,
> +			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
> +			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
> +
> +	for (i = j = 1; i < argc && strcmp("--", argv[i]); ) {
> +		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
> +
> +		if (!c)
> +			argv[j++] = argv[i++];
> +		else
> +			i += c;
> +	}

I don't think this handles "--" quite as would be expected.  Trying to
use "git range-diff -- js/range-diff-v4...HEAD" I get:

    $ ./git range-diff -- js/range-diff-v4...HEAD
    error: need two commit ranges
    usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>
       or: git range-diff [<options>] <old-tip>...<new-tip>
       or: git range-diff [<options>] <base> <old-tip> <new-tip>

        --creation-factor <n>
                              Percentage by which creation is weighted
        --no-dual-color       color both diff and diff-between-diffs

while what I would have expected is to actually get a range diff.
This happens because after we break out of the loop we don't add the
actual ranges to argv, but just skip them instead.

I think something like the following should be squashed in to this
patch.

--->8---
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index ef3ba22e29..132574c57a 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -53,6 +53,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
                else
                        i += c;
        }
+       if (i < argc && !strcmp("--", argv[i])) {
+               i++; j++;
+               while (i < argc)
+                       argv[j++] = argv[i++];
+       }
        argc = j;
        diff_setup_done(&diffopt);
 
--->8---

> +	argc = j;
> +	diff_setup_done(&diffopt);
> +
> +	/* Make sure that there are no unparsed options */
> +	argc = parse_options(argc, argv, NULL,
> +			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
>  			     builtin_range_diff_usage, 0);
>  
>  	if (argc == 2) {
> @@ -59,7 +83,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  		usage_with_options(builtin_range_diff_usage, options);
>  	}
>  
> -	res = show_range_diff(range1.buf, range2.buf, creation_factor);
> +	res = show_range_diff(range1.buf, range2.buf, creation_factor,
> +			      &diffopt);
>  
>  	strbuf_release(&range1);
>  	strbuf_release(&range2);
> diff --git a/range-diff.c b/range-diff.c
> index 2d94200d3..71883a4b7 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -6,6 +6,7 @@
>  #include "hashmap.h"
>  #include "xdiff-interface.h"
>  #include "linear-assignment.h"
> +#include "diffcore.h"
>  
>  struct patch_util {
>  	/* For the search for an exact match */
> @@ -258,7 +259,31 @@ static const char *short_oid(struct patch_util *util)
>  	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
>  }
>  
> -static void output(struct string_list *a, struct string_list *b)
> +static struct diff_filespec *get_filespec(const char *name, const char *p)
> +{
> +	struct diff_filespec *spec = alloc_filespec(name);
> +
> +	fill_filespec(spec, &null_oid, 0, 0644);
> +	spec->data = (char *)p;
> +	spec->size = strlen(p);
> +	spec->should_munmap = 0;
> +	spec->is_stdin = 1;
> +
> +	return spec;
> +}
> +
> +static void patch_diff(const char *a, const char *b,
> +			      struct diff_options *diffopt)
> +{
> +	diff_queue(&diff_queued_diff,
> +		   get_filespec("a", a), get_filespec("b", b));
> +
> +	diffcore_std(diffopt);
> +	diff_flush(diffopt);
> +}
> +
> +static void output(struct string_list *a, struct string_list *b,
> +		   struct diff_options *diffopt)
>  {
>  	int i = 0, j = 0;
>  
> @@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
>  			printf("%d: %s ! %d: %s\n",
>  			       b_util->matching + 1, short_oid(a_util),
>  			       j + 1, short_oid(b_util));
> +			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
> +				patch_diff(a->items[b_util->matching].string,
> +					   b->items[j].string, diffopt);
>  			a_util->shown = 1;
>  			j++;
>  		}
> @@ -307,7 +335,7 @@ static void output(struct string_list *a, struct string_list *b)
>  }
>  
>  int show_range_diff(const char *range1, const char *range2,
> -		    int creation_factor)
> +		    int creation_factor, struct diff_options *diffopt)
>  {
>  	int res = 0;
>  
> @@ -322,7 +350,7 @@ int show_range_diff(const char *range1, const char *range2,
>  	if (!res) {
>  		find_exact_matches(&branch1, &branch2);
>  		get_correspondences(&branch1, &branch2, creation_factor);
> -		output(&branch1, &branch2);
> +		output(&branch1, &branch2, diffopt);
>  	}
>  
>  	string_list_clear(&branch1, 1);
> diff --git a/range-diff.h b/range-diff.h
> index 7b6eef303..2407d46a3 100644
> --- a/range-diff.h
> +++ b/range-diff.h
> @@ -1,7 +1,9 @@
>  #ifndef RANGE_DIFF_H
>  #define RANGE_DIFF_H
>  
> +#include "diff.h"
> +
>  int show_range_diff(const char *range1, const char *range2,
> -		    int creation_factor);
> +		    int creation_factor, struct diff_options *diffopt);
>  
>  #endif
> -- 
> gitgitgadget
> 
