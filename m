Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8AC1F462
	for <e@80x24.org>; Tue, 18 Jun 2019 13:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfFRNgN (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 09:36:13 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35297 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbfFRNgN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 09:36:13 -0400
Received: by mail-qt1-f196.google.com with SMTP id d23so15304164qto.2
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=QTjBuHcafUMmK5b0anO35vhzZb0oLwbv/ew+/k51//Y=;
        b=AlJoGmHZUC/qdTJ5vCag2wr80BTo9TYGz2imSWO3hHMTzOc3xP6jgqlIUurV6xMqJc
         7eLpaHLp0wdAM2H5B2bra5+Lf8uGJjqi3v+L8vVUdeytiOlK4MA5cVLgrlDDNQaJrFuH
         6r0AuWw53+T284rsl/0wC23ETZf7c92AwY3Xj515Zo/ljxJUpIo3IvG2qEJm6UppM+aX
         QPriEOCBGetWfuodlX9zCxiCp6Dvmgn+w30Do6qzBbV1MIduDKAV9HYbc9in1AzGJuJK
         Kw1PwFQKt+TXFpkx37Stvcfyd7EWsGPxag9z0baLg9YNv7ekMqLIbbEDTgoIiZomZfmc
         KFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QTjBuHcafUMmK5b0anO35vhzZb0oLwbv/ew+/k51//Y=;
        b=YrBhOAdOMKEZ5oBfia9oEaabBTusOHka6mG8+nllNLMuR6Rc1zFIpkxq8ROZqgQ9eL
         FP4LAREFmAMq2Dd7GEml1HvpdkOy00aE9U+US0qX56iNhCiZ5jqtpBckWGtt/3PDVdZH
         F+a3MTLJyTeI8mJmPJPrXNwUK1D0Gj/VRzvl3UCNAeswqswIyx+1iALcpTtkmlx0CF63
         /r6zatHnTodZzGfJztmP6k5z6y6OeKJJKJZlM7Bum9LrPNcQHeZuwL8WdI1ecATJcyUW
         XOW6l7bK+YxmzQ9fR0MhWPmauPkN3GhZ1wyC+aWlzOV5TEpVJmUijs2TbLobJCG8Yyss
         HwkA==
X-Gm-Message-State: APjAAAWIRo22rYIFriqhM2mRDrH27ImuJIY0X+8Qb8YGg+q9KNRsTZJR
        YV4kBgnRZN0NxqSlkHf9ZqfVVUmW
X-Google-Smtp-Source: APXvYqxS/p2ArIaK+qwKo+sW6LT6EiqTIlOhi/PawuDUz5Uf/Ma4dV0isX2iz3DCUuGOSU9bfb9/fw==
X-Received: by 2002:ac8:32e8:: with SMTP id a37mr24348149qtb.231.1560864971902;
        Tue, 18 Jun 2019 06:36:11 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4422:7ffb:cd0e:3604? ([2001:4898:a800:1010:f557:7ffb:cd0e:3604])
        by smtp.gmail.com with ESMTPSA id x35sm5077597qta.11.2019.06.18.06.36.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 06:36:11 -0700 (PDT)
Subject: ds/commit-graph-incremental (was Re: What's cooking in git.git (Jun
 2019, #04; Fri, 14))
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8690d49e-31f5-e12a-ae8c-dc217a5476cc@gmail.com>
Date:   Tue, 18 Jun 2019 09:36:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqqh88ruc1b.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/14/2019 4:50 PM, Junio C Hamano wrote:
> * ds/commit-graph-incremental (2019-06-12) 16 commits
>  - commit-graph: test --split across alternate without --split
>  - commit-graph: test octopus merges with --split
>  - commit-graph: clean up chains after flattened write
>  - commit-graph: verify chains with --shallow mode
>  - commit-graph: create options for split files
>  - commit-graph: expire commit-graph files
>  - commit-graph: allow cross-alternate chains
>  - commit-graph: merge commit-graph chains
>  - commit-graph: add --split option to builtin
>  - commit-graph: write commit-graph chains
>  - commit-graph: rearrange chunk count logic
>  - commit-graph: add base graphs chunk
>  - commit-graph: load commit-graph chains
>  - commit-graph: rename commit_compare to oid_compare
>  - commit-graph: prepare for commit-graph chains
>  - commit-graph: document commit-graph chains
>  (this branch uses ds/commit-graph-write-refactor; is tangled with ds/close-object-store.)
> 
>  The commits in a repository can be described by multiple
>  commit-graph files now, which allows the commit-graph files to be
>  updated incrementally.
> 
>  Will merge to 'next'.

Please hold on this one. I've found multiple issues while integrating
this with VFS for Git and there are enough to merit a full re-roll.
Please ignore the two patches I sent yesterday as I will incorporate them
into the next version of this series.

Thanks,
-Stolee
