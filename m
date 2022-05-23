Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE00C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiEWNO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbiEWNOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:14:01 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5172B388E
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:13:36 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id j7so9786274ila.1
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VvoYGNeOSE1+SKxPfw6HwD1TwWREsD48jnFS51BzPAM=;
        b=YUkfBKX+5H/tTkYQjBS0uTnKN3+f0v07ls5YuoD9CtOhz9DDPPK3pvBMNPdLTVI+z1
         TdyEvMMI67em7Mv4aXB1ra+1ZbWeBaDJXC+y6AnP4LxER9xARzCUin4heO6QCy8695op
         AHTqB9ys37Gu+R1+8wUh1kg0pvD5JyaD6o7pB6AC9ysZFKsI3P4WEHBa7o/FYuEk3yva
         7QqeGwABhL48TlB4Epp943cDlEVKTSdXV0snWhx1bOn54oZQ5qLrIv94LEYK8f5CCsmw
         IneXg4ZNafCKBBobDk5GHRy+Gk1Y2EcqDmyp0qo2wQu7/qgL7E44ycQnyp+p4a1zVtgo
         RpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VvoYGNeOSE1+SKxPfw6HwD1TwWREsD48jnFS51BzPAM=;
        b=oLTRvHIDShL04YzoJrhuXcNq4MSJnEYFurVESrleKCNRePpEQrCC1LsdmN9qEz2fXZ
         73ul+dcapYTctYwkrsBYQBMlRA1LyMH/+M8rKS3k2MqwSiySJq8RF4pusnBdzymP7SXO
         OF96O8cvyeQNBusVd0Al1HIMZ85TTQoEn4JbEmp4LDaRhbe3gE6SvosGjdI4BIMU8iX0
         bMwcHO1TexMXLRxyJhw3tRIWBpA3ap8rZ83CdWLTNB/TVLkRIfg7GH332T7gA0cBUp1p
         WQxfJxXRliEjtg92kBP7DdWkQ3S5WllQUJ1CZ25emqZpa8K/l/C8H7HZSOxf0Smpiggi
         uF0A==
X-Gm-Message-State: AOAM5317ttSWf/MzkpWz44LGZb69yQlr8HE7KOeEP+p/4Oa5PctW8j/V
        Sskxpys613vLmjAAP2B2Wx73
X-Google-Smtp-Source: ABdhPJzH5t6Pq7pJ0zh+y2bJG8prs/32ofLu4Nd+1Tgv+hrdKvrrThc1J2rp8d2AYLMM64ICzNXZfg==
X-Received: by 2002:a05:6e02:12e7:b0:2d1:7bcd:f7c8 with SMTP id l7-20020a056e0212e700b002d17bcdf7c8mr7514251iln.51.1653311615614;
        Mon, 23 May 2022 06:13:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:4800:d130:3923:6cc0? ([2600:1700:e72:80a0:4800:d130:3923:6cc0])
        by smtp.gmail.com with ESMTPSA id z12-20020a02ba0c000000b0032ea33f23a0sm2304405jan.95.2022.05.23.06.13.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 06:13:35 -0700 (PDT)
Message-ID: <5909f466-c323-0874-b175-51fe5e93dc12@github.com>
Date:   Mon, 23 May 2022 09:13:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 08/10] sparse-index: complete partial expansion
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, vdye@github.com, shaoxuan.yuan02@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1208.git.1652724693.gitgitgadget@gmail.com>
 <pull.1208.v2.git.1652982758.gitgitgadget@gmail.com>
 <ed640e3645ba4f60f06bd335b9ac7bf350dd81f9.1652982759.git.gitgitgadget@gmail.com>
 <xmqqsfp3coqy.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqsfp3coqy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/21/2022 3:45 AM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	if (pl && !pl->use_cone_patterns) {
>>  		pl = NULL;
>> +	} else {
>> +		/*
>> +		 * We might contract file entries into sparse-directory
>> +		 * entries, and for that we will need the cache tree to
>> +		 * be recomputed.
>> +		 */
>> +		cache_tree_free(&istate->cache_tree);
>> +
>> +		/*
>> +		 * If there is a problem creating the cache tree, then we
>> +		 * need to expand to a full index since we cannot satisfy
>> +		 * the current request as a sparse index.
>> +		 */
>> +		if (cache_tree_update(istate, WRITE_TREE_MISSING_OK))
>> +			pl = NULL;
>> +	}
> 
> So, if the current index has some irrelevant (i.e. do not match the
> pattern list) subtrees in collapsed form, presense of an unmerged
> entry, presumably inside the cone(s) we are interested in, makes us
> lose the pattern list here, and we end up expanding everything?
> 
> I suspect that is a situation that is not so uncommon.  Working
> inside a narrow cone of a wide tree, performing a merge would
> hopefully allow many subtrees that are outside of the cones of our
> interest merged without getting expanded at all (e.g. only the other
> side touched these subtrees we are not working on, so their version
> will become the merge result), while changes to some paths in the
> cone of our interest may result in true conflicts represented as
> cache entries at higher stages, needing conflict resolution
> concluded with "git add".  Having to expand these subtrees that we
> managed to merge while still collapsed, only because we have
> conflicts in some other parts of the tree, feels somewhat sad.

You are correct that conflicts outside of the sparse-checkout cone will
cause index expansion. That happens during the 'git merge' command, but
the index will continue to fail to collapse as long as those conflicts
still exist in the index.

When there are conflicts like this during the merge, then the index
expansion is not as large of a portion of the command as normal, because
the conflict resolution also takes some time to compute. The commands
afterwards do take longer purely because of the expanded index.

However, this state is also not as common as you might think. If a user
has a sparse-checkout cone specified, then they are unlikely to change
files outside of the sparse-checkout cone. They would not be the reason
that those files have a conflict. The conflicts would exist only if they
are merging branches that had conflicts outside of the cone. Typically,
any merge of external changes like this are of the form of "git pull" or
"git rebase", in which case the conflicts are still "local" to the
developer's changes.

You are right that there is additional work that could be done here,
specifically allowing the cache tree to partially succeed and use the
successfully generated trees to create sparse directory entries where
possible. This was not viable before because we lacked the "partially
expanded" index state. This series establishes the necessary vocabulary to
do such an improvement later.
> By the way, why are we passing the "--missing-ok" option to "git
> write-tree" here?
> 
>> +	cache_tree_update(istate, WRITE_TREE_MISSING_OK);
> 
> The same question here.  We didn't say "missing trees are OK".  What
> made it OK in this change?
 
Both of these additions of WRITE_TREE_MISSING_OK are not needed. I
think I added them in an earlier version, thinking they were needed
due to something in the Scalar functional tests. I confirmed just now
that they are not needed for that. I will remove them.

Thanks,
-Stolee
