Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAC3B1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 08:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbeG1KMj (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 06:12:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41275 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbeG1KMj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 06:12:39 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so7330539wrr.8
        for <git@vger.kernel.org>; Sat, 28 Jul 2018 01:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oYvHYExJTrueq6bxx3YfMMOSmN+3rLMojspLfe2p67E=;
        b=KfsXonHibd3+29OBJ4t1hI5P/DxNf3WWbODHrrbRkzcaOyDuZepAtdQ0s+dSSBDPVp
         CQlG2+f8P5y/Azg7xiZKCs2cXRM8B70c9JJl8yKdOWOg7NCI4eqacH8+QZ+Kg0sGFIK/
         RF487hkCXPDjjB6/luEY87r6VVt9pIKRZ4rroTLLjF7stG9etQ1Fa9F1fukeOnAUOBfz
         TEuEQ/bxSdB0s48hluWHz9M11O95QOWSX9N67QB84Swf44WH/uMDbzTRW0rkPce8ZerI
         o5pmaHfFDpXNXtV+1LINLO8V0oDFuk2wRf9tqVEDMuzgZva1h5YKWPQZ2Iu/EmXUv8kP
         AW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oYvHYExJTrueq6bxx3YfMMOSmN+3rLMojspLfe2p67E=;
        b=QBxBBxfRSgswbooeSINx72qLxovIlXeiwo9TTBKz12Zp2Lr5UPtgQ1+W+4j5mY1qQ0
         dSgEd0YyYEm/XgzDaJcNagb15hWEwc0YVIbZRwBEHW/wkChi8LQzFp7Xz4LOEQw7h8cM
         l1AWbe/MIH+tsqjPBK0iSFg9cop+ZtBYJ8CmNOSWdcPFSM90mhc1YEpvg5H9piTmeS+7
         JnZERXuen8HXB+6F/qmbmAFxvAcm1FYHW62obzLO3d1gX+iuMid+8cpoCC+pbsoaHLcN
         azSbzMtgnk0dMYmknoqNtSGgi/z7h87j/YLQc4zx+P67FokjJQe9CEVZbuSFbXhVKEfS
         zL4Q==
X-Gm-Message-State: AOUpUlGp+hN9ImWBDMfNfsULijywxqrf6x7rXcmqUk1w/HoAv5EBzg6n
        NPZ1KGQswe2uRt2ZQ+/H0cM=
X-Google-Smtp-Source: AAOMgpcHBvOdbSTsgHOnLHWkORX8k5wsiLER0TusNELkCpy7g7tB5wmVb8z+VF8brLPG6S4oILNQMg==
X-Received: by 2002:adf:8296:: with SMTP id 22-v6mr8307156wrc.252.1532767614511;
        Sat, 28 Jul 2018 01:46:54 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id s124-v6sm7597632wmf.47.2018.07.28.01.46.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 01:46:53 -0700 (PDT)
Date:   Sat, 28 Jul 2018 09:46:52 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 01/21] linear-assignment: a function to solve
 least-cost assignment problems
Message-ID: <20180728084652.GB2734@hank.intra.tgummerer.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
 <pull.1.v4.git.gitgitgadget@gmail.com>
 <f7e70689efcbeb8341c19fa3940c818142a2cddf.1532210683.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7e70689efcbeb8341c19fa3940c818142a2cddf.1532210683.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/21, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The problem solved by the code introduced in this commit goes like this:
> given two sets of items, and a cost matrix which says how much it
> "costs" to assign any given item of the first set to any given item of
> the second, assign all items (except when the sets have different size)
> in the cheapest way.
> 
> We use the Jonker-Volgenant algorithm to solve the assignment problem to
> answer questions such as: given two different versions of a topic branch
> (or iterations of a patch series), what is the best pairing of
> commits/patches between the different versions?
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  Makefile            |   1 +
>  linear-assignment.c | 201 ++++++++++++++++++++++++++++++++++++++++++++
>  linear-assignment.h |  22 +++++
>  3 files changed, 224 insertions(+)
>  create mode 100644 linear-assignment.c
>  create mode 100644 linear-assignment.h
>
> [...]
> 
> diff --git a/linear-assignment.h b/linear-assignment.h
> new file mode 100644
> index 000000000..fc4c502c8
> --- /dev/null
> +++ b/linear-assignment.h
> @@ -0,0 +1,22 @@
> +#ifndef HUNGARIAN_H
> +#define HUNGARIAN_H

nit: maybe s/HUNGARIAN/LINEAR_ASSIGNMENT/ in the two lines above.

> +
> +/*
> + * Compute an assignment of columns -> rows (and vice versa) such that every
> + * column is assigned to at most one row (and vice versa) minimizing the
> + * overall cost.
> + *
> + * The parameter `cost` is the cost matrix: the cost to assign column j to row
> + * i is `cost[j + column_count * i].
> + *
> + * The arrays column2row and row2column will be populated with the respective
> + * assignments (-1 for unassigned, which can happen only if column_count !=
> + * row_count).
> + */
> +void compute_assignment(int column_count, int row_count, int *cost,
> +			int *column2row, int *row2column);
> +
> +/* The maximal cost in the cost matrix (to prevent integer overflows). */
> +#define COST_MAX (1<<16)
> +
> +#endif
> -- 
> gitgitgadget
> 
