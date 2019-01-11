Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C0B211B4
	for <e@80x24.org>; Fri, 11 Jan 2019 22:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbfAKWFz (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 17:05:55 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35732 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfAKWFy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 17:05:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id v11so20562633qtc.2
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 14:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=F84ryD9YoINp3dFUs4uuJZOB980N6oZpYV+jYKSIjKw=;
        b=gY3UoXeakdwawD15JUS6zTuadXvBNIV/Q7b5QBvdQAmuk+ypuP4Xm+yOX5T7LMr+Cz
         QEOJyYSZ0z8Jtj76yDTkb6yy4eeFaXok/kqbSD2HzJnYENZeBEbr/WV6/vFClCkg1eQl
         JqsgioxdiO8o81kEEE+kXeZTgdCzeEou6rdRK0Y3GUTMCPvhngap7sP2gxztXfvhR2t4
         oXqRcP/TGusQhvNoFLtpUbEZpLwztABgmY6prSO9mmHA/i1JWhjOkugmsndk4iFNsu6Q
         NJNlRaZYmsh+WQfPBULbuNipdj0FZM3W4GDXt2eLT+LoVegS4vJmWN+KEC71RWDY8iqm
         XGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=F84ryD9YoINp3dFUs4uuJZOB980N6oZpYV+jYKSIjKw=;
        b=YLh+fYP5wtDZ4dwYFGUe5cnFJ5lGs2GM9xF362C6L6wQo9Z78+3yZqYGRod8fE7cxh
         g5UIi8IuII+Li06I/xsOhD9D4vhLUAAXncId9HC+gq8L67zI7M/3ssqbEHWPs9CPbL/u
         iIJV/MtU2jkGN7zy4c8q2on6CZ6NwAezxNsI23FDKPr65TVtCbgVr2drvVCMFo6KoExR
         SxvnT3dhf78jxcLZHrcRkf/3OqSAM7wx31fbdnctBlXqiMUEDC2ga1Uakicj2QCgnNAx
         eIhIGkFp8ntUg7uoe82Lc+M90JDLRm8OH7JOe+BMJcf9avSd1HfqNNrUcUJXpVMnc6Fg
         G6hQ==
X-Gm-Message-State: AJcUukcy9/dw8z6/GEE4ESJNB2b9t8fWzPQiBAchSVqJh4ExyM7anZAr
        5w6zIvu0LGVF3WJjD9N8GKb56mmH
X-Google-Smtp-Source: ALg8bN7b2iI6FWnzXfoBSQ47+wUZ/L0c9z7zFZBap04NSQTMk+xpppzib8Qz9KnuTQUgjAM8znPFQQ==
X-Received: by 2002:a0c:aca7:: with SMTP id m36mr15305458qvc.237.1547244352276;
        Fri, 11 Jan 2019 14:05:52 -0800 (PST)
Received: from [10.0.1.15] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id w22sm47872054qtw.71.2019.01.11.14.05.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 14:05:51 -0800 (PST)
Subject: Re: [PATCH v4 1/6] revision: add mark_tree_uninteresting_sparse
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        jrnieder@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
 <pull.89.v4.git.gitgitgadget@gmail.com>
 <817e30a287e12ce8e94ce41fcb969dd8ae53b9ce.1544822533.git.gitgitgadget@gmail.com>
 <xmqqzhs7x9nm.fsf@gitster-ct.c.googlers.com>
 <xmqqva2vx7p2.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <5a25813e-32f6-34a4-9f24-b65415b75dda@gmail.com>
Date:   Fri, 11 Jan 2019 17:05:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <xmqqva2vx7p2.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/11/2019 3:25 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
> So, I assumed that the implementation was wrong, but it is the other
> way around.  You do mean to pick only already uninteresting trees
> out of "set" and mark its reachables.
>
> One thing that would make me worried is what help the callers of
> this function will get (or they may have to devise the way
> themselves) to avoid having to traverse the same tree number of
> times.  A tree can be made uninteresting after a traversal of
> another tree that contains it, but the logic in this function
>
>> +		if (tree->object.flags & UNINTERESTING) {
>> +			/*
>> +			 * Remove the flag so the next call
>> +			 * is not a no-op. The flag is added
>> +			 * in mark_tree_unintersting().
>> +			 */
>> +			tree->object.flags ^= UNINTERESTING;
>> +			mark_tree_uninteresting(r, tree);
>> +		}
> ignores the fact that it is already UNINTERESTING (in fact, in a
> sense it is even worse---it cannot be used to make a not-yet
> UNINTERESTING one into UNINTERESTING), drops the UNINTERESING bit
> and forces the traversal of that tree.  The only thing I see that
> would work as a saving grace is that mark_tree_uninteresting()
> itself would honor existing UNINTERESING bit and refuses to recurse
> into its subtrees, but that means blobs at the top-level of such a
> tree would be marked UNINTERESING while those in its subtrees can be
> left not-UNINTERESING, which sounds like inviting a mess.
>
> It does *not* immediately mean this function is misdesigned.  It
> just means that the caller needs to carefully follow whatever
> calling convention this series will establish in the later patches
> (which we haven't seen yet at this point).
>
I'm sorry that this implementation is particularly confusing. It is 
created only as a placeholder so we can wire up the --sparse option to 
use this method without being "wrong" but is then removed entirely in 
PATCH 4/6:

...

void mark_trees_uninteresting_sparse(struct repository *r,
  				     struct oidset *set)
  {
+	unsigned has_interesting = 0, has_uninteresting = 0;
+	struct hashmap map;
+	struct hashmap_iter map_iter;
+	struct path_and_oids_entry *entry;
  	struct object_id *oid;
  	struct oidset_iter iter;
  
  	oidset_iter_init(set, &iter);
-	while ((oid = oidset_iter_next(&iter))) {
+	while ((!has_interesting || !has_uninteresting) &&
+	       (oid = oidset_iter_next(&iter))) {
  		struct tree *tree = lookup_tree(r, oid);
  
  		if (!tree)
  			continue;
  
-		if (tree->object.flags & UNINTERESTING) {
-			/*
-			 * Remove the flag so the next call
-			 * is not a no-op. The flag is added
-			 * in mark_tree_unintersting().
-			 */
-			tree->object.flags ^= UNINTERESTING;
-			mark_tree_uninteresting(r, tree);
-		}
+		if (tree->object.flags & UNINTERESTING)
+			has_uninteresting = 1;
+		else
+			has_interesting = 1;
+	}
...

You are definitely correct that "set" is not a valuable variable name. It could instead be "tree_oids" to be slightly more informative.

Thanks,
-Stolee

