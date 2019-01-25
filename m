Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EC751F453
	for <e@80x24.org>; Fri, 25 Jan 2019 23:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAYXYb (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 18:24:31 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42010 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfAYXYb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 18:24:31 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so4801361pga.9
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 15:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=66aE8UGiRszRLqzWUvlOP+G04EDWwGIQ0Guw2rJ9o5Y=;
        b=AlsRrWkM1cf82IPtFZBvlnG3WTxFqW4i4cvtuT5znaxfDkCY7NQgzCc0DY/kutn1Rh
         KSNstl9jn2a1liqblwDTsv38s9Cegl6pexu9oDxCqWhos5RFmsowOd9cVyl0BFLmIuTi
         xC1l1+w07Kpd/6mgSyaurkRKXpsIwxIQGBrR+w/wtqjZ1bgmuPe7IcA5Zy9y2UDqgt/X
         P0DVniTDw7tJSFBNplSGFDwlkDAbZsYNza5MZgMQjYCyBufjoJp6NnyGARIF+/LjbUTr
         a/5+JvL2z6xMRuqTEVFLomX7fxtqzGVmPbqiCct3o2sI2Em1mecocsTWM9DkqmHYRVZ6
         ojEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=66aE8UGiRszRLqzWUvlOP+G04EDWwGIQ0Guw2rJ9o5Y=;
        b=RAaq8eOvBSOR0aqnQCj/wmf7tk02WL+6u/FfRUdOhSN7JU/uxKrLDWHS9Q5DsDh7Mg
         gMmtXePKxslhaspXteFeYeBfbDQcAn5CcLCqLcN7aR6Ltu+/1Z6SqADD0vcaYvzvmLjJ
         F6Q9MhQKZRdnxLPXRvzqijjJVbc7j16V42Pw/eE7Gr+4g1I0W7iJUzjLMSNvoTYGCXxU
         91ryPcJ0oxuT73uvSQ2n033qiAZeaxhMZYtZpzJSVDO8Kz1z6Fen81S4WhlkiFc6wBPT
         bPnolefPztzGT4BROJyKnAiv0R9vR5VNfAlN1p+BmwmXMaJMoSj6E9o3eItbLtKGv1Gi
         FNnA==
X-Gm-Message-State: AJcUuke5Y0TNPF/WMgoKMldqFamZhkw99SgT/JzO/6mgCqABCo6R3zCJ
        PCOWdsBI4O2i1ugDbvA+WY+QAg==
X-Google-Smtp-Source: ALg8bN4NwVo8BotxpYYgfaNNgC3Zs7xLG7WT0xP5BAKbN0sw1eIjVq9zUIc+XvbateGnD2/3/BUjmQ==
X-Received: by 2002:a62:53c5:: with SMTP id h188mr12666030pfb.190.1548458669354;
        Fri, 25 Jan 2019 15:24:29 -0800 (PST)
Received: from google.com ([2620:0:100e:913:5bb:3076:546:99b0])
        by smtp.gmail.com with ESMTPSA id n70sm40556488pfi.185.2019.01.25.15.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Jan 2019 15:24:28 -0800 (PST)
Date:   Fri, 25 Jan 2019 15:24:22 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 07/10] multi-pack-index: prepare 'repack' subcommand
Message-ID: <20190125232422.GC72177@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, jonathantanmy@google.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.92.v3.git.gitgitgadget@gmail.com>
 <pull.92.v4.git.gitgitgadget@gmail.com>
 <f5a8ff21dda5b29d8fe75b3b52be873bdb4b3031.1548366713.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a8ff21dda5b29d8fe75b3b52be873bdb4b3031.1548366713.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.01.24 13:51, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <dstolee@microsoft.com>
> 
> In an environment where the multi-pack-index is useful, it is due
> to many pack-files and an inability to repack the object store
> into a single pack-file. However, it is likely that many of these
> pack-files are rather small, and could be repacked into a slightly
> larger pack-file without too much effort. It may also be important
> to ensure the object store is highly available and the repack
> operation does not interrupt concurrent git commands.
> 
> Introduce a 'repack' subcommand to 'git multi-pack-index' that
> takes a '--batch-size' option. The subcommand will inspect the
> multi-pack-index for referenced pack-files whose size is smaller
> than the batch size, until collecting a list of pack-files whose
> sizes sum to larger than the batch size. Then, a new pack-file
> will be created containing the objects from those pack-files that
> are referenced by the multi-pack-index. The resulting pack is
> likely to actually be smaller than the batch size due to
> compression and the fact that there may be objects in the pack-
> files that have duplicate copies in other pack-files.
> 
> The current change introduces the command-line arguments, and we
> add a test that ensures we parse these options properly. Since
> we specify a small batch size, we will guarantee that future
> implementations do not change the list of pack-files.
> 
> In addition, we hard-code the modified times of the packs in
> the pack directory to ensure the list of packs sorted by modified
> time matches the order if sorted by size (ascending). This will
> be important in a future test.
> 
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/git-multi-pack-index.txt | 11 +++++++++++
>  builtin/multi-pack-index.c             | 12 ++++++++++--
>  midx.c                                 |  5 +++++
>  midx.h                                 |  1 +
>  t/t5319-multi-pack-index.sh            | 17 +++++++++++++++++
>  5 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
> index 6186c4c936..de345c2400 100644
> --- a/Documentation/git-multi-pack-index.txt
> +++ b/Documentation/git-multi-pack-index.txt
> @@ -36,6 +36,17 @@ expire::
>  	have no objects referenced by the MIDX. Rewrite the MIDX file
>  	afterward to remove all references to these pack-files.
>  
> +repack::
> +	Create a new pack-file containing objects in small pack-files
> +	referenced by the multi-pack-index. Select the pack-files by
> +	examining packs from oldest-to-newest, adding a pack if its
> +	size is below the batch size. Stop adding packs when the sum
> +	of sizes of the added packs is above the batch size. If the
> +	total size does not reach the batch size, then do nothing.
> +	Rewrite the multi-pack-index to reference the new pack-file.
> +	A later run of 'git multi-pack-index expire' will delete the
> +	pack-files that were part of this batch.
> +
>  
>  EXAMPLES
>  --------
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index 145de3a46c..c66239de33 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -5,12 +5,13 @@
>  #include "midx.h"
>  
>  static char const * const builtin_multi_pack_index_usage[] = {
> -	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
> +	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire|repack --batch-size=<size>)"),
>  	NULL
>  };
>  
>  static struct opts_multi_pack_index {
>  	const char *object_dir;
> +	unsigned long batch_size;
>  } opts;
>  
>  int cmd_multi_pack_index(int argc, const char **argv,
> @@ -19,6 +20,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  	static struct option builtin_multi_pack_index_options[] = {
>  		OPT_FILENAME(0, "object-dir", &opts.object_dir,
>  		  N_("object directory containing set of packfile and pack-index pairs")),
> +		OPT_MAGNITUDE(0, "batch-size", &opts.batch_size,
> +		  N_("during repack, collect pack-files of smaller size into a batch that is larger than this size")),
>  		OPT_END(),
>  	};
>  
> @@ -40,6 +43,11 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  		return 1;
>  	}
>  
> +	if (!strcmp(argv[0], "repack"))
> +		return midx_repack(opts.object_dir, (size_t)opts.batch_size);
> +	if (opts.batch_size)
> +		die(_("--batch-size option is only for 'repack' subcommand"));
> +
>  	if (!strcmp(argv[0], "write"))
>  		return write_midx_file(opts.object_dir);
>  	if (!strcmp(argv[0], "verify"))
> @@ -47,5 +55,5 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  	if (!strcmp(argv[0], "expire"))
>  		return expire_midx_packs(opts.object_dir);
>  
> -	die(_("unrecognized verb: %s"), argv[0]);
> +	die(_("unrecognized subcommand: %s"), argv[0]);
>  }
> diff --git a/midx.c b/midx.c
> index 299e9b2e8f..768a7dff73 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1112,3 +1112,8 @@ int expire_midx_packs(const char *object_dir)
>  	string_list_clear(&packs_to_drop, 0);
>  	return result;
>  }
> +
> +int midx_repack(const char *object_dir, size_t batch_size)
> +{
> +	return 0;
> +}
> diff --git a/midx.h b/midx.h
> index e3a2b740b5..394a21ee96 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -50,6 +50,7 @@ int write_midx_file(const char *object_dir);
>  void clear_midx_file(struct repository *r);
>  int verify_midx_file(const char *object_dir);
>  int expire_midx_packs(const char *object_dir);
> +int midx_repack(const char *object_dir, size_t batch_size);
>  
>  void close_midx(struct multi_pack_index *m);
>  
> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 65e85debec..acc5e65ecc 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -417,4 +417,21 @@ test_expect_success 'expire removes unreferenced packs' '
>  	)
>  '
>  
> +test_expect_success 'repack with minimum size does not alter existing packs' '
> +	(
> +		cd dup &&
> +		rm -rf .git/objects/pack &&
> +		mv .git/objects/pack-backup .git/objects/pack &&
> +		touch -m -t 201901010000 .git/objects/pack/pack-D* &&
> +		touch -m -t 201901010001 .git/objects/pack/pack-C* &&
> +		touch -m -t 201901010002 .git/objects/pack/pack-B* &&
> +		touch -m -t 201901010003 .git/objects/pack/pack-A* &&
> +		ls .git/objects/pack >expect &&
> +		MINSIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 1) &&
> +		git multi-pack-index repack --batch-size=$MINSIZE &&
> +		ls .git/objects/pack >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done

This test failes for me, with the following error:
mv: cannot stat '.git/objects/pack-backup': No such file or directory


> -- 
> gitgitgadget
> 
