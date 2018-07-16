Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E72781F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeGPWBQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 18:01:16 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:54242 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeGPWBQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 18:01:16 -0400
Received: by mail-it0-f73.google.com with SMTP id u140-v6so14489081itc.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 14:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ZleMgcMY5mIy/ourJMI8cwTgjPqNIe2wVHuHvZbZq2M=;
        b=TLPIWbsFVkfAm79m9FHokQRcYCyjsZmoyRB0SRvQTqXR1Jm2fPICho+Dtc+dMzwN3h
         sWQzDEqD4U+0DtySlJWIK6xzKLtP3C6iQK4F2zE0nklKOn0CHxjc/DRaQiz9asqFaRbk
         e5UEv3kV6ONJ+HOnQNYkBwA/jwMqkCNHaieJQ+NpAdPkBn9cWkIjcuBL7BX0+gd8loY7
         tY/WRShxAegxPM+dCWPvYDK2W0LTMVYky+Qa5jSP8RvNC/YjTEWuB9BTo+lLi10h8kiJ
         VWcqpn0WIeyoMvxgPgFqDWFtYK0WLMOo0TazSp1/Z4pqHv43PFl5TX498+YJd0yF6vRQ
         KxsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ZleMgcMY5mIy/ourJMI8cwTgjPqNIe2wVHuHvZbZq2M=;
        b=U8uVqr4BtctGzXnedlaIboxo5xOF/l4zm205aEprj0JTyBTIG9EtwAbdB50aTMsdIC
         M14TihiNFn4nkxozTd8HobWSm6WnW8wkeoWZhMAE8bnH7sXyxpvXAU4jTwEbtz/Fk1Hu
         ep1JP+q6lfTW5UEdUbw8TQgySmm5OWl/RUcmchWlqTtYWPIhPV3v5pkqtZ96VQFH/cWx
         ChVHDCkGkqncqd0MvhTcI9F5R+umeJlDa1Fm8NCdKk0FzR3Ed7r54YqAumqEw8nKm7BF
         2wZNTO82PmKhRvebF5cgNXiAeTcAMqPYVTWqbWMOi8nv2qtg+sOUHEYj/pxTkRkOVga/
         AkJg==
X-Gm-Message-State: AOUpUlHx5Zn23F/8QFLZvy5Sn8DuEAKfCPU4fbNEh1aLZHCfy+rGMY8S
        qPbICabLl7S4++ULXhlSF2pbvZMzOzDBtnONo+11
X-Google-Smtp-Source: AAOMgpfCUVYWeasV9XpBP4VXyR/hBM92T1ObOELYSjZ/QWNPMMFmDjb1jUQZAIRVGYEDXoMIXSnBfnfCKAjEZPxPRL7w
MIME-Version: 1.0
X-Received: by 2002:a24:5c8f:: with SMTP id q137-v6mr7471195itb.38.1531776719373;
 Mon, 16 Jul 2018 14:31:59 -0700 (PDT)
Date:   Mon, 16 Jul 2018 14:31:53 -0700
In-Reply-To: <01bef3d654845236e9115ebc33d80673b7b4a5a2.1531746009.git.gitgitgadget@gmail.com>
Message-Id: <20180716213153.242065-1-jonathantanmy@google.com>
References: <01bef3d654845236e9115ebc33d80673b7b4a5a2.1531746009.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.18.0.13.g5a7731b13
Subject: Re: [PATCH 01/16] commit-reach: move walk methods from commit.c
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, dstolee@microsoft.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +/* Remember to update object flag allocation in object.h */
> +#define PARENT1		(1u<<16)
> +#define PARENT2		(1u<<17)
> +#define STALE		(1u<<18)
> +#define RESULT		(1u<<19)

Update object.h to point to commit-reach.c instead of commit.c also.

> diff --git a/commit-reach.h b/commit-reach.h
> new file mode 100644
> index 000000000..244f48c5f
> --- /dev/null
> +++ b/commit-reach.h
> @@ -0,0 +1,41 @@
> +#ifndef __COMMIT_REACH_H__
> +#define __COMMIT_REACH_H__
> +
> +#include "commit.h"
> +
> +struct commit_list *get_merge_bases_many(struct commit *one,
> +					 int n,
> +					 struct commit **twos);

<snip>

Should the declarations in commit.h be deleted also?

Thanks for copying it over verbatim - it makes it much easier to see
what's going on with --color-moved.
