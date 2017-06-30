Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FEF3201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751935AbdF3Rjs (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 13:39:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34997 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751322AbdF3Rjs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 13:39:48 -0400
Received: by mail-pf0-f195.google.com with SMTP id s66so17758277pfs.2
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 10:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZpqkagvHidDoRrjRTLOt6AddqGtNifNJpvbzKDLnUXM=;
        b=cZ8sbmwqsm92y81Kob3FRzeMjTyOQ207kX+4TYAvKbVDM+MLtpMHwE1t5NKLaqWwR0
         JgxCH6hILkQL/28mp/X2PEYzxI/fiXIIfcLK6hxC90JGGWhnAg1ANhlYMepJ/Y1bHLac
         D3NRgKlsbZz1oLlZJsa18Stdd2lUWnC4okXG40yayMKRYnvlxu86TaXiQty391uok641
         ySMk96qfFg50KCWnNWjJN0fU9l6PxzQA+2ctP9+GMQ4MDRrIwQs3EfK16pRQWve+By6D
         NbL4pVYASzkkiYyqqSpe22zVQqU20SYsF1VOpBOtpRiyKSH8dhgxWxTeC+xIot2vbGxm
         MW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZpqkagvHidDoRrjRTLOt6AddqGtNifNJpvbzKDLnUXM=;
        b=EqFNNlb8s+rMaDyYzEtBzfm+mEA7EqIesLSYer1o/9FvfHVj8ee665r8ZUgfEeQ6dp
         yl/IswxDfmvLvS6uBtfhqxo0diIFwbzKKAmu0Mc8C/d4XhA3o8tpVgSORN/p67vmO4X2
         xQq4B7G48b7L6OpcsMLVEB3ObkA8+MEHv/3CQsNbYRZln83sJ99ciptqxYxPv6kdCaIM
         H0QrCI2CBmpUDz/s5qKeDsVZfyG1i8GBu/jxIMeM/AjS15fNkr825AtUPGUKMYzEalXt
         SAmpRVfHGh+uPk8n1IZlzIIXGWrSTchyKKh4/bXv8TPpaP05viEwEZplhXNKOprTR7r+
         ic6Q==
X-Gm-Message-State: AKS2vOzdHP4qcZFkt3kUyLinP3TUSG5ee7K17exevgGVj6FdFmx9lawI
        +mhxDmFwVTxCsA==
X-Received: by 10.99.114.19 with SMTP id n19mr22022031pgc.81.1498844387269;
        Fri, 30 Jun 2017 10:39:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id 67sm19611610pfa.83.2017.06.30.10.39.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 10:39:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, git@jeffhostetler.com
Subject: Re: [PATCHv2 1/2] hashmap.h: compare function has access to a data field
References: <20170629011334.11173-1-sbeller@google.com>
        <20170629235336.28460-1-sbeller@google.com>
        <20170629235336.28460-2-sbeller@google.com>
Date:   Fri, 30 Jun 2017 10:39:45 -0700
In-Reply-To: <20170629235336.28460-2-sbeller@google.com> (Stefan Beller's
        message of "Thu, 29 Jun 2017 16:53:35 -0700")
Message-ID: <xmqqh8yxs7by.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/patch-ids.c b/patch-ids.c
> index 9c0ab9e67a..b9b2ebbad0 100644
> --- a/patch-ids.c
> +++ b/patch-ids.c
> @@ -37,6 +37,7 @@ int commit_patch_id(struct commit *commit, struct diff_options *options,
>   */
>  static int patch_id_cmp(struct patch_id *a,
>  			struct patch_id *b,
> +			const void *unused_keydata,
>  			struct diff_options *opt)
>  {
>  	if (is_null_oid(&a->patch_id) &&
> @@ -57,7 +58,8 @@ int init_patch_ids(struct patch_ids *ids)
>  	ids->diffopts.detect_rename = 0;
>  	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
>  	diff_setup_done(&ids->diffopts);
> -	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp, 256);
> +	hashmap_init(&ids->patches, (hashmap_cmp_fn)patch_id_cmp,
> +		     &ids->diffopts, 256);
>  	return 0;
>  }
>  
> @@ -93,7 +95,7 @@ struct patch_id *has_commit_patch_id(struct commit *commit,
>  	if (init_patch_id_entry(&patch, commit, ids))
>  		return NULL;
>  
> -	return hashmap_get(&ids->patches, &patch, &ids->diffopts);
> +	return hashmap_get(&ids->patches, &patch, NULL);
>  }

This actually makes me wonder if we can demonstrate an existing
breakage in tests.  The old code used to pass NULL to the diffopts,
causing it to be passed down through commit_patch_id() function down
to diff_tree_oid() or diff_root_tree_oid().  When the codepath
triggers the issue that Peff warned about in his old article (was it
about rehashing or something?) that makes two entries compared
(i.e. not using keydata, because we are not comparing an existing
entry with a key and data only to see if that already exists in the
hashmap), wouldn't that cause ll_diff_tree_oid() that is called from
diff_tree_oid() to dereference NULL?

Thanks.
