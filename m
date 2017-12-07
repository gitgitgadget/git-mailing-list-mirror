Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58AAE20954
	for <e@80x24.org>; Thu,  7 Dec 2017 19:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbdLGTS4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 14:18:56 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:42145 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdLGTSz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 14:18:55 -0500
Received: by mail-it0-f68.google.com with SMTP id p139so17368255itb.1
        for <git@vger.kernel.org>; Thu, 07 Dec 2017 11:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9BnhvqHWLmmlXV7NmlJtaqqbGss24+pgThl0nUKePMc=;
        b=HwkSTiYZ0KFzWBmZ1VkdEDgrNyX0Hcu0uoI6xWKpGW2/az+UvC3vQpA5roUrTY4sXE
         7RqEcpPPLMYI78HGfusylDv/RFfJqvfRAKA51N32VnpNcFSWloOWCIOZx97fqX4SRJAf
         VDqM1firD/IBE4VbDhaGWkkc7Ia868X2UMwFzyy5eflBkGofhsVOCJoL8ee5RAi/FOt/
         5zRNES38YEJEcew1Jn7ilJudpHxAbJkKdaTBxoTJK2aH3dtXDQhtr84Ep48Yey4klGzc
         DP792/ToDKnqH1HGzojgGkaHTcpU27GC0dK/ikfgXzlMPAU+SHbLcb0nk3bbhF43ND/D
         JVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9BnhvqHWLmmlXV7NmlJtaqqbGss24+pgThl0nUKePMc=;
        b=c5W6KyvCVeq2D5ke0CJ4jxQpvhXngtozF4pVqfE72uprl70d0Pg8r4N2hMW7q8Q59w
         gG8umUZnNZiaenuuixwSusvrG2eAZfWr+Aid41BvVw8grjaIATs1F1xDTPTKUNEEd0Y6
         MD/QuOhLwUyPJp9+Q9PfoPGKNNMvd7AzFaA7s9llSAaSjUdOP2+dHbryraSWmQc30Wjl
         jq2f93QJY7gDGJXZfi2g0a1xZS3k0F4LPAbpASvFD66Ljt8uoyO43qCazviOqbvUJQ8z
         Zhcn7I5Yl1YOvSQys9OHhuxcF/7S+Zrzja8rwLrig0HscHtPX8Gtjf50RMWtaGw2iObb
         J2DA==
X-Gm-Message-State: AKGB3mJUKgdC31mtjAyGat8n8VWBBJdi+A/MDVPM9eKapgk5Vkt81P6+
        VKkkP1c+IM8WUlsDYMkVNapxFpfaalw=
X-Google-Smtp-Source: AGs4zMZ29Nk4g58OwcoOYIQ+xMhjV2/Xgjd6afE4XNCVb7vs5TWSMQq3kTSsS3sN5nmouNwceBUYoQ==
X-Received: by 10.36.71.83 with SMTP id t80mr1977001itb.48.1512674334601;
        Thu, 07 Dec 2017 11:18:54 -0800 (PST)
Received: from google.com ([2620:0:100e:422:949a:89bd:af08:7a9c])
        by smtp.gmail.com with ESMTPSA id x82sm3163501itb.36.2017.12.07.11.18.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 07 Dec 2017 11:18:53 -0800 (PST)
Date:   Thu, 7 Dec 2017 11:18:52 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        jonathantanmy@google.com, christian.couder@gmail.com
Subject: Re: [PATCH v6 03/12] fsck: support refs pointing to promisor objects
Message-ID: <20171207191852.GC152943@google.com>
References: <20171205165854.64979-1-git@jeffhostetler.com>
 <20171205165854.64979-4-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205165854.64979-4-git@jeffhostetler.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Jeff Hostetler wrote:
> From: Jonathan Tan <jonathantanmy@google.com>
> 
> Teach fsck to not treat refs referring to missing promisor objects as an
> error when extensions.partialclone is set.
> 
> For the purposes of warning about no default refs, such refs are still
> treated as legitimate refs.
> 
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fsck.c           |  8 ++++++++
>  t/t0410-partial-clone.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
> 
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 2934299..ee937bb 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -434,6 +434,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
>  
>  	obj = parse_object(oid);
>  	if (!obj) {
> +		if (is_promisor_object(oid)) {
> +			/*
> +			 * Increment default_refs anyway, because this is a
> +			 * valid ref.
> +			 */
> +			 default_refs++;
> +			 return 0;
> +		}
>  		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
>  		errors_found |= ERROR_REACHABLE;
>  		/* We'll continue with the rest despite the error.. */
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index 3ddb3b9..bf75162 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -13,6 +13,14 @@ pack_as_from_promisor () {
>  	>repo/.git/objects/pack/pack-$HASH.promisor
>  }
>  
> +promise_and_delete () {
> +	HASH=$(git -C repo rev-parse "$1") &&
> +	git -C repo tag -a -m message my_annotated_tag "$HASH" &&
> +	git -C repo rev-parse my_annotated_tag | pack_as_from_promisor &&
> +	git -C repo tag -d my_annotated_tag &&
> +	delete_object repo "$HASH"
> +}
> +
>  test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
>  	test_create_repo repo &&
>  	test_commit -C repo my_commit &&
> @@ -78,4 +86,20 @@ test_expect_success 'missing reflog object alone fails fsck, even with extension
>  	test_must_fail git -C repo fsck
>  '
>  
> +test_expect_success 'missing ref object, but promised, passes fsck' '
> +	rm -rf repo &&

Instead of requiring that every test first removes 'repo', maybe you
want to have each test do its own cleanup by adding in
'test_when_finished' lines to do the removals?  Just a thought.

> +	test_create_repo repo &&
> +	test_commit -C repo my_commit &&
> +
> +	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> +
> +	# Reference $A only from ref
> +	git -C repo branch my_branch "$A" &&
> +	promise_and_delete "$A" &&
> +
> +	git -C repo config core.repositoryformatversion 1 &&
> +	git -C repo config extensions.partialclone "arbitrary string" &&
> +	git -C repo fsck
> +'
> +
>  test_done
> -- 
> 2.9.3
> 

-- 
Brandon Williams
