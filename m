Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5927F1F405
	for <e@80x24.org>; Fri, 10 Aug 2018 00:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbeHJCmJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 22:42:09 -0400
Received: from mail-qk0-f201.google.com ([209.85.220.201]:48842 "EHLO
        mail-qk0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHJCmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 22:42:09 -0400
Received: by mail-qk0-f201.google.com with SMTP id 17-v6so7602880qkz.15
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 17:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=NyNxz7ZonNUksDF55xroJFip0YDdg7dWFxLEf+OOYrw=;
        b=uoyEUjmIijDY8/oUaIRQ68REn6anEv/6eEmcIWi0hxka4BuJTf/YlkMAgX/hBj/dDX
         DJyMy+0qQvaAH/TSvCNR8f1Bjpac6ggv9/uDWvqSjFWo1yytRE7LgqAXFTAJXhi2nqom
         z1hHYCILaAkWp+dkYNzss0+m7Vwf4qEoWhTzKYwViaoslnwtNYyCi0SvJpyvjZNAcpo3
         wF8J5PkqQ+RF8jiv29/vHVXIyIsxVSI1T7Q9E2LxLByWis1BWRGFlev+Lb0potlRKR3p
         hSUtc86OkUvayS0EsDwugyqh4bJ4SoOA4jlf3BcJYQkrDBMCr2eMeoHES0sOcwLiTiYF
         DC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=NyNxz7ZonNUksDF55xroJFip0YDdg7dWFxLEf+OOYrw=;
        b=Kd9D0l1k+eMOGTGzzCJC+Aii8hg2uF3R1sqfVdtDEDxJFm5G+nMFNn9PFwmNWLHfnc
         Pov7rKuOFs1dyYxf+JzxfkGeNiVhbasKBF3qw2WDyA3Ha/DyrZ5hlW0eWBhbXtO51E1L
         KHGavJOh/kUpMAMy3ydl74bCLMyBfikDpAVhDu/81SFbjUcaO55rlCIuGaw5j4fQgqCL
         pyIXPpC9KGDTy3GrCTpfvGwymbrsVbwV0fWz5ukIiNaTAhTHhOR0OTuo6s1rvNRMvluD
         NV7+U2z3W1iSpnyXzfoTUxkkDZkzgqXiJGPD/u+OMM0EOfUCCg7A4YOT3RI6VjaTx4mL
         fA3w==
X-Gm-Message-State: AOUpUlGBNEAtT1Ar01Nm4UdQcwUwr+qR0AIlBa8J/fo1J9LeUiq2EEcy
        26lr7S34MUQu7RQADdaVYb+MlIZLYN8P5enDbxxH
X-Google-Smtp-Source: AA+uWPw+uIJMhyV3gcoCWKVzsfrbhLIQLXiJVkrsRMylURVtrGg+B86nbW7TsNYclCUv2ooapAR8Rw6zoIhQIZ4tL00N
X-Received: by 2002:ae9:e116:: with SMTP id g22-v6mr2414213qkm.31.1533860091192;
 Thu, 09 Aug 2018 17:14:51 -0700 (PDT)
Date:   Thu,  9 Aug 2018 17:14:47 -0700
In-Reply-To: <71619cbd1004d7acf991011fc0c941d4a5716079.1533854545.git.matvore@google.com>
Message-Id: <20180810001447.11257-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <71619cbd1004d7acf991011fc0c941d4a5716079.1533854545.git.matvore@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: Re: [PATCH 2/5] list-objects-filter: implement filter only:commits
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Teach list-objects the "only:commits" filter which allows for filtering
> out all non-commit and non-annotated tag objects (unless other objects
> are explicitly specified by the user). The purpose of this patch is to
> allow smaller partial clones.
> 
> The name of this filter - only:commits - is a bit inaccurate because it
> still allows annotated tags to pass through. I chose it because it was
> the only concise name I could think of that was pretty descriptive. I
> considered and decided against "tree:none" because the code and
> documentation for filters seems to lack the concept of "you're filtering
> this, so we'll implicitly filter all referents of this." So "tree:none"
> is vague, since some may think it filters blobs too, while some may not.
> "only:commits" is specific and makes it easier to match it to a
> potential use case.

I'll do a fuller review tomorrow, but here are my initial thoughts.

I'm undecided about whether "only:commits" or "tree:none" is better -
one argument in favor of the latter is that blobs are not of much use
without any trees referring to them, so it makes sense that omitting
trees means omitting blobs. But that requires some thought and is not
immediately obvious.

>  /*
> - * A filter for list-objects to omit ALL blobs from the traversal.
> - * And to OPTIONALLY collect a list of the omitted OIDs.
> + * A filter for list-objects to omit ALL blobs from the traversal, and possibly
> + * trees as well.
> + * Can OPTIONALLY collect a list of the omitted OIDs.
>   */
> -struct filter_blobs_none_data {
> +struct filter_none_of_type_data {
> +	unsigned omit_trees : 1;
>  	struct oidset *omits;
>  };

I know that it's documented above that blobs are always omitted, but
maybe it's worth it to add a comment /* blobs are always omitted */.

> -	case LOFS_BEGIN_TREE:
> -		assert(obj->type == OBJ_TREE);
> -		/* always include all tree objects */
> -		return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> -
>  	case LOFS_END_TREE:
>  		assert(obj->type == OBJ_TREE);
>  		return LOFR_ZERO;
>  
> +	case LOFS_BEGIN_TREE:
> +		assert(obj->type == OBJ_TREE);
> +		if (!filter_data->omit_trees)
> +			return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +
>  	case LOFS_BLOB:
> -		assert(obj->type == OBJ_BLOB);
>  		assert((obj->flags & SEEN) == 0);

Moving the case LOFS_BEGIN_TREE and removing the assert is unnecessary,
I think.

Also, there's fallthrough. If that's on purpose, add /* fallthrough */,
although I think that it complicates the code unnecessarily here.

> +test_expect_success 'verify only:commits packfile has no blobs or trees' '
> +	git -C r1 pack-objects --rev --stdout --filter=only:commits >commitsonly.pack <<-EOF &&
> +	HEAD
> +	EOF
> +	git -C r1 index-pack ../commitsonly.pack &&
> +	git -C r1 verify-pack -v ../commitsonly.pack \
> +		| grep -E "tree|blob" \
> +		| sort >observed &&
> +	test_line_count = 0 observed
> +'

Bash pipes conceal return codes. Here it's OK, but it might be better to
write the verify-pack on its own line and then '! grep -E "tree|blob"' -
you don't need to sort or test_line_count.

> +test_expect_success 'grab tree directly when using only:commits' '
> +	# We should get the tree specified directly but not its blobs or subtrees.
> +	git -C r1 pack-objects --rev --stdout --filter=only:commits >commitsonly.pack <<-EOF &&
> +	HEAD:
> +	EOF
> +	git -C r1 index-pack ../commitsonly.pack &&
> +	git -C r1 verify-pack -v ../commitsonly.pack \
> +		| grep -E "tree|blob" \
> +		| sort >observed &&
> +	test_line_count = 1 observed
> +'

Similar comment as above, except you can redirect the output of grep to
a file, then test_line_count on that file. No need for sort.
