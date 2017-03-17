Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE8532095B
	for <e@80x24.org>; Fri, 17 Mar 2017 11:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751268AbdCQLb3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 07:31:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48672 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751049AbdCQLb2 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Mar 2017 07:31:28 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4AA7C20BB3;
        Fri, 17 Mar 2017 07:25:03 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 17 Mar 2017 07:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
        content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=9fgKx9thrMrV3wnYUZ
        s9VjXnPGA=; b=h85AA/EVxtgtjO0mqFPDDHfB+K1zXZL8WWvW+quoYaKDXld6ln
        JefpJ53ENMC9E4ugjZJ32ybHOoVWIh/xdMHsZp1PedgcV2OCXcV76YxL1PV2hgJT
        IESLMztS4zg6FqWwF5ufRNGJN9iDMQk8KFFdn3+wR9KiYFOLNUonhBtYcCeVMlgE
        D8O6W4h+4vhd6Hjo88atBpLkTRAfguRUPmIDXzch+KDXzlItPgwzzFxNCcU8F3Kz
        ordc3y4ifu/FheFWmo/gcnfY1lqEHLcpnwdt27D6Uoh+wC/NFPkKjtfboTU9zkWl
        CwOr6BHjK0F5a+BVe9FBkhbaZjhBHj4j3k7w==
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=
        fm1; bh=9fgKx9thrMrV3wnYUZs9VjXnPGA=; b=ZnEjc4AB5lobbOr4Djhq+d/t
        /LRUthpQ/I6hatccUIRCUNg7Tw+qE5y1/4rsabMoMPnOONWDxtFh3Z4QR+TWBO6s
        +1BBQTZGg6cA9F5ZdLNQ4xUNQNQJhM/7uyW5+1R6U3IdD4S+oj0f9r/rniMR7HR1
        EuRYNp4Pq770tuKLB5kauXgUgJYzE7bEEcLglr0rIPx6H7am6atg1ppi3ASQdW8k
        xexVsjxPplsJd98xMqbBcE1ZSzPwsya7Ougf4HCa4dK90MR9pt+mWpPsH8rIBNUy
        +6PBCfWwv0wxwpcb/k7/wyZaZclGconBakziRbgc1bdLfIy6WoYCGZluELMwtg==
X-ME-Sender: <xms:j8fLWE-MT0c9dKG8NdFZFGfyggJrakBjQRFIjJO6UM2JWO_LPOuu4A>
X-Sasl-enc: 0lkkkI3SMUeGeuk6m8ccLeGgTfPcwAEXmhaS6MMk27GD 1489749902
Received: from UltraSam.fritz.box (dslb-178-011-152-175.178.011.pools.vodafone-ip.de [178.11.152.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E68F245FD;
        Fri, 17 Mar 2017 07:25:02 -0400 (EDT)
Subject: Re: [PATCH 2/2] name-rev: favor describing with tags and use
 committer date to tiebreak
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqd1die00j.fsf@gitster.mtv.corp.google.com>
 <20170315225045.15788-1-gitster@pobox.com>
 <20170315225045.15788-3-gitster@pobox.com>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <ce5252a5-b94a-a389-6b3e-0e4d7b243210@drmicha.warpmail.net>
Date:   Fri, 17 Mar 2017 12:25:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170315225045.15788-3-gitster@pobox.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> hops, without taking the "taggerdate" into account.  As we are
> taking over the "taggerdate" field to store the committer date for
> tips with commits:
> 
>  (1) keep the original logic when comparing names based on two refs
>      both of which are from refs/tags/;
> 
>  (2) favoring a name based on a ref in refs/tags/ hierarchy over
>      a ref outside the hierarchy;
> 
>  (3) between two names based on a ref both outside refs/tags/, give
>      precedence to a name with shorter hops and use "taggerdate"
>      only to tie-break.
> 
> A change to t4202 is a natural consequence.  The test creates a
> commit on a branch "side" and points at it with an unannotated tag
> "refs/tags/side-2".  The original code couldn't decide which one to
> favor at all, and gave a name based on a branch (simply because
> refs/heads/side sorts earlier than refs/tags/side-2).  Because the
> updated logic is taught to favor refs in refs/tags/ hierarchy, the
> the test is updated to expect to see tags/side-2 instead.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

I think that strategy is fine and works as I expected in all tested
cases. Thanks!

> ---
> 
>  * I am sure others can add better heurisitics in is_better_name()
>    for comparing names based on non-tag refs, and I do not mind
>    people disagreeing with the logic that this patch happens to
>    implement.  This is done primarily to illustrate the value of
>    using a separate helper function is_better_name() instead of
>    open-coding the selection logic in name_rev() function.
> ---
>  builtin/name-rev.c | 57 +++++++++++++++++++++++++++++++++++++++++++++---------
>  t/t4202-log.sh     |  2 +-
>  2 files changed, 49 insertions(+), 10 deletions(-)
> 
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index f64c71d9bc..eac0180c62 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -13,6 +13,7 @@ typedef struct rev_name {
>  	unsigned long taggerdate;
>  	int generation;
>  	int distance;
> +	int from_tag;
>  } rev_name;
>  
>  static long cutoff = LONG_MAX;
> @@ -24,16 +25,47 @@ static int is_better_name(struct rev_name *name,
>  			  const char *tip_name,
>  			  unsigned long taggerdate,
>  			  int generation,
> -			  int distance)
> +			  int distance,
> +			  int from_tag)
>  {
> -	return (name->taggerdate > taggerdate ||
> -		(name->taggerdate == taggerdate &&
> -		 name->distance > distance));
> +	/*
> +	 * When comparing names based on tags, prefer names
> +	 * based on the older tag, even if it is farther away.
> +	 */
> +	if (from_tag && name->from_tag)
> +		return (name->taggerdate > taggerdate ||
> +			(name->taggerdate == taggerdate &&
> +			 name->distance > distance));
> +
> +#define COMPARE(attribute, smaller_is_better)	 \
> +	if (name->attribute > attribute) \
> +		return smaller_is_better; \
> +	if (name->attribute < attribute) \
> +		return !smaller_is_better

I find that define pretty confusing. On first reading, the "==" case
seems to be missing, but that is basically "pass" as one can see in the
later code.

Also, the comparison ">"  and "<" is used to switch between the cases
"tag vs. non-tag" and "non-tag vs. tag" which happen to be encoded by
the from_tag attribute beeing "1 vs. 0" resp "0 vs. 1" in the following:

> +
> +	/*
> +	 * We know that at least one of them is a non-tag at this point.
> +	 * favor a tag over a non-tag.
> +	 */
> +	COMPARE(from_tag, 0);
> +

But in the next two instances you use it to do "actual" comparisons
between distances and dates:

> +	/*
> +	 * We are now looking at two non-tags.  Tiebreak to favor
> +	 * shorter hops.
> +	 */
> +	COMPARE(distance, 1);
> +
> +	/* ... or tiebreak to favor older date */
> +	COMPARE(taggerdate, 1);
> +
> +	/* keep the current one if we cannot decide */
> +	return 0;
> +#undef COMPARE
>  }

So, while I do understand that now, I'm wondering whether I will next
time ;)

How about something like

/* favor tag over non-tag */
if (name->from_tag != from_tag)
	return from_tag;

at least for the first instance and possibly

/* favor shorter hops for non-tags */
if (name->distance != distance)
	return name->distance > distance;

/* tie-break by date */
if (name->taggerdate != taggerdate)
	return name->taggerdate > taggerdate;

>  
>  static void name_rev(struct commit *commit,
>  		const char *tip_name, unsigned long taggerdate,
> -		int generation, int distance,
> +		int generation, int distance, int from_tag,
>  		int deref)
>  {
>  	struct rev_name *name = (struct rev_name *)commit->util;
> @@ -57,12 +89,13 @@ static void name_rev(struct commit *commit,
>  		commit->util = name;
>  		goto copy_data;
>  	} else if (is_better_name(name, tip_name, taggerdate,
> -				  generation, distance)) {
> +				  generation, distance, from_tag)) {
>  copy_data:
>  		name->tip_name = tip_name;
>  		name->taggerdate = taggerdate;
>  		name->generation = generation;
>  		name->distance = distance;
> +		name->from_tag = from_tag;
>  	} else
>  		return;
>  
> @@ -82,10 +115,12 @@ static void name_rev(struct commit *commit,
>  						   parent_number);
>  
>  			name_rev(parents->item, new_name, taggerdate, 0,
> -				distance + MERGE_TRAVERSAL_WEIGHT, 0);
> +				 distance + MERGE_TRAVERSAL_WEIGHT,
> +				 from_tag, 0);
>  		} else {
>  			name_rev(parents->item, tip_name, taggerdate,
> -				generation + 1, distance + 1, 0);
> +				 generation + 1, distance + 1,
> +				 from_tag, 0);
>  		}
>  	}
>  }
> @@ -184,9 +219,13 @@ static int name_ref(const char *path, const struct object_id *oid, int flags, vo
>  	}
>  	if (o && o->type == OBJ_COMMIT) {
>  		struct commit *commit = (struct commit *)o;
> +		int from_tag = starts_with(path, "refs/tags/");
>  
> +		if (taggerdate == ULONG_MAX)
> +			taggerdate = ((struct commit *)o)->date;
>  		path = name_ref_abbrev(path, can_abbreviate_output);
> -		name_rev(commit, xstrdup(path), taggerdate, 0, 0, deref);
> +		name_rev(commit, xstrdup(path), taggerdate, 0, 0,
> +			 from_tag, deref);
>  	}
>  	return 0;
>  }
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 48b55bfd27..038911f230 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -398,7 +398,7 @@ cat > expect <<\EOF
>  | |
>  | |     Merge branch 'side'
>  | |
> -| * commit side
> +| * commit tags/side-2
>  | | Author: A U Thor <author@example.com>
>  | |
>  | |     side-2
> 
