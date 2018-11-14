Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FDEE1F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 19:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbeKOFcd (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 00:32:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46727 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOFcd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 00:32:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so5702194wrt.13
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 11:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A08uOvhYFHS3zBFYTr/qeirVB22XwtcY4puAP1FLjis=;
        b=jUi+SRAXktH0FxN9jTs8q9y3lN8fZsgoq/1CeMvGuQeVzJEjUR8qb8dvZVsV19xy5h
         rCLYkNCA9RMEJKYdqK+gW6ucc/MygSbqpslok13DCyvLWRCscSGKUHZH4wNnGP4xBx4L
         TBYJ+9ZC3DilAeClYeYkgyeZ7DyW/tA/oV80ZV3JiYjeRSP+YrGxH6TSuDpWPvLF64iL
         6eNj4NZnv21CWijOuljNVEsByEypderd1np3oE5gO0qEk9WLhvAf2c4MXBn90iKjGRmh
         oaCg0cJWp4pEmVT4q2ZuxEfcyx1I3SJ++nPdX3YM0m2zCKDJEIOGOYomviVW4HcstWUj
         GtRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=A08uOvhYFHS3zBFYTr/qeirVB22XwtcY4puAP1FLjis=;
        b=ilikzuZ16GHG1NgM/xOOiJh8w1yoyH1UNdtDwGB5t9oJ492SIE5N0vBaN3FC4uDq/0
         dSFvDlWTUsR4b0jgTra5OFdl5rrh4bHWEwRvIQa3mTrLVvcoGOTpCgJCyEiJsVE0WrYw
         T+X3G099DgFFeyLa6lmUggDxztOlGqYVXGqnWZ2Ctn/b2J9DazIMb6D3kwFcgmjRdCzy
         XofcoCxa94+UizVw/lqwjGCmhg7mbHbKuQAoduxFTnquk28M7ylW4OS4ntpRpq8+Eo4K
         qFuQsOcCjx3xQJTAoER/L7jxZFPyMCOzDnv6b7uyLt77WctpJcvU4nODSks7GfObNmpf
         WZgg==
X-Gm-Message-State: AGRZ1gJPaMONbAm6NhB+GhK+ckwUNqKG4vUErwbHTLbxhGwRZ7H/m+TU
        YdDN1sxH1D5SRf0+UGuLWeM=
X-Google-Smtp-Source: AJdET5fkv+ZHnRN2uLC/iGljownZKo8V8vthSBGZY6w1Pc1usIW9ytQ36Du/N/JUbOyCBrsQ9Uw8HA==
X-Received: by 2002:adf:9e87:: with SMTP id a7-v6mr2957191wrf.164.1542223681407;
        Wed, 14 Nov 2018 11:28:01 -0800 (PST)
Received: from szeder.dev (x4db1d05b.dyn.telefonica.de. [77.177.208.91])
        by smtp.gmail.com with ESMTPSA id 201-v6sm13003898wma.3.2018.11.14.11.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 11:28:00 -0800 (PST)
Date:   Wed, 14 Nov 2018 20:27:58 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, larsxschneider@gmail.com,
        sandals@crustytoothpaste.net, peff@peff.net, me@ttaylorr.com,
        jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH v2 08/11] fast-export: add --reference-excluded-parents
 option
Message-ID: <20181114192758.GK30222@szeder.dev>
References: <20181111062312.16342-1-newren@gmail.com>
 <20181114002600.29233-1-newren@gmail.com>
 <20181114002600.29233-9-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114002600.29233-9-newren@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 13, 2018 at 04:25:57PM -0800, Elijah Newren wrote:
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 2fef00436b..3cc98c31ad 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -37,6 +37,7 @@ static int fake_missing_tagger;
>  static int use_done_feature;
>  static int no_data;
>  static int full_tree;
> +static int reference_excluded_commits;
>  static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
>  static struct string_list tag_refs = STRING_LIST_INIT_NODUP;
>  static struct refspec refspecs = REFSPEC_INIT_FETCH;
> @@ -596,7 +597,8 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  		message += 2;
>  
>  	if (commit->parents &&
> -	    get_object_mark(&commit->parents->item->object) != 0 &&
> +	    (get_object_mark(&commit->parents->item->object) != 0 ||
> +	     reference_excluded_commits) &&
>  	    !full_tree) {
>  		parse_commit_or_die(commit->parents->item);
>  		diff_tree_oid(get_commit_tree_oid(commit->parents->item),
> @@ -644,13 +646,21 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  	unuse_commit_buffer(commit, commit_buffer);
>  
>  	for (i = 0, p = commit->parents; p; p = p->next) {
> -		int mark = get_object_mark(&p->item->object);
> -		if (!mark)
> +		struct object *obj = &p->item->object;
> +		int mark = get_object_mark(obj);
> +
> +		if (!mark && !reference_excluded_commits)
>  			continue;
>  		if (i == 0)
> -			printf("from :%d\n", mark);
> +			printf("from ");
> +		else
> +			printf("merge ");
> +		if (mark)
> +			printf(":%d\n", mark);
>  		else
> -			printf("merge :%d\n", mark);
> +			printf("%s\n", sha1_to_hex(anonymize ?
> +						   anonymize_sha1(&obj->oid) :
> +						   obj->oid.hash));

Since we intend to move away from SHA-1, would this be a good time to
add an anonymize_oid() function, "while at it"?

>  		i++;
>  	}
>  
> @@ -931,13 +941,22 @@ static void handle_tags_and_duplicates(struct string_list *extras)
>  				/*
>  				 * Getting here means we have a commit which
>  				 * was excluded by a negative refspec (e.g.
> -				 * fast-export ^master master).  If the user
> +				 * fast-export ^master master).  If we are
> +				 * referencing excluded commits, set the ref
> +				 * to the exact commit.  Otherwise, the user
>  				 * wants the branch exported but every commit
> -				 * in its history to be deleted, that sounds
> -				 * like a ref deletion to me.
> +				 * in its history to be deleted, which basically
> +				 * just means deletion of the ref.
>  				 */
> -				printf("reset %s\nfrom %s\n\n",
> -				       name, sha1_to_hex(null_sha1));
> +				if (!reference_excluded_commits) {
> +					/* delete the ref */
> +					printf("reset %s\nfrom %s\n\n",
> +					       name, sha1_to_hex(null_sha1));
> +					continue;
> +				}
> +				/* set ref to commit using oid, not mark */
> +				printf("reset %s\nfrom %s\n\n", name,
> +				       sha1_to_hex(commit->object.oid.hash));

Please use oid_to_hex(&commit->object.oid) instead.

>  				continue;
>  			}
>  
