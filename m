Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 718CE1F516
	for <e@80x24.org>; Fri, 29 Jun 2018 14:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936363AbeF2OxR (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Jun 2018 10:53:17 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:35114 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935810AbeF2OxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jun 2018 10:53:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id z6-v6so8053712qti.2
        for <git@vger.kernel.org>; Fri, 29 Jun 2018 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=9fjMrFW9OrwExGLoYatoWOIjPL4/ZvhoHM6QIWbRnaM=;
        b=oqM5dWdt/+yyXi13ppEVnE31XNa95KKNu8YrID8/LRdHAC0r1xlxdS3C21ICHEVE5w
         H+WV3RnNoMuTOaNJcBNqKMfZmtcbHDdXSyPm69AeWh6KElVllZqBmQpDlErw65DWxLs3
         jAFUuDDCghZRRcSb7+KgGYnegL6umaSKGDBa7Fz6lr1owB8GpvYCXaMV397ptns7od9J
         l7IsbLByuBvx3zjj4aIFZeYuzo2LvNAaA7cUopEvsdJxiy6x//RiNUs3+q2XL1egBfOG
         6GPMwUnFg6hFdazv1mAw2xHSyTsZ9Jc6lRFZCxrtlzw+DA7Ojdb7X6eIYEOPqoVYfHDN
         RrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9fjMrFW9OrwExGLoYatoWOIjPL4/ZvhoHM6QIWbRnaM=;
        b=DVgT9WF2BMd683hKPK8joW6GJxzql6g8FZhIUs1riNtyAgM+mXlU3imVlTRQj8sKhR
         KouCCptndnH6S2sIH6O8/SxbXdeMjwD9WLZ/Q4ORy8vbBnhGf8LU4av8HrYQVYjzreFP
         AyW3Lej0sZKKCDUU95LALQPVOAoNgZJObNk7t1o/yOGcr6Uj6ZiM4m8U2y69mCjRh2D8
         MaIQ+BFnrKZ1tAOuS+3Hid6lm+g2WEQMVEg0rwgwUBX+9C5qtms3cxlWEuhTbEcH+EcV
         QPSm67z35jeHeMns2wAWiQ3QUMk1w9ETizhLzyItT6EliDA/bMPInLDeJZe7wUZuoL2o
         Dtuw==
X-Gm-Message-State: APt69E1f74+r2qF4m2sZdzhmcAwx6VsQNKfi+daVyIR1efnqtWdf63T5
        RWxLxxYOTTSPaDqxRf5sdbNeL2iY
X-Google-Smtp-Source: AAOMgpfeHhnjyNN7Kvc/DPA71uzOHkQ28UMuOo1Dq4ArGhkyjuKBMu+x5B3YjOKzrRt7G6AmSOJpbQ==
X-Received: by 2002:ac8:2fc6:: with SMTP id m6-v6mr1680297qta.170.1530283995138;
        Fri, 29 Jun 2018 07:53:15 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id t30-v6sm2600808qtt.88.2018.06.29.07.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 07:53:14 -0700 (PDT)
Subject: Re: [PATCH v3 00/32] object-store: lookup_commit
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20180629012222.167426-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <be744bdb-5a98-8b38-37e1-3d5847e5fbf1@gmail.com>
Date:   Fri, 29 Jun 2018 10:53:10 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180629012222.167426-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/28/2018 9:21 PM, Stefan Beller wrote:
> This continues the elimination of global variables in the object store and
> teaches lookup_commit[_reference] and alike to handle a_repository.
>
> This is also available as
> https://github.com/stefanbeller/git/tree/object-store-lookup-commit
> or applies on top of 02f70d63027 (Merge branch 'sb/object-store-grafts'
> into next, 2018-06-28).
>
> Picking a base for this one is really hard, as nearly all series currently
> cooking or in flight collide with it on one or two lines. (lookup_* is used
> heavily, who would have thought?); I really needed 'sb/object-store-grafts'
> to build on; and there is only one other series before that in current next,
> which this series would have conflicted with, if not based on top of it.
>
> In "The state of the object store series" [1], this was tentatively named
> "sb/object-store-lookup".

As usual, this series was easy to review. It has a few places where it 
conflicts with ds/commit-graph-fsck, but they are not hard to resolve. I 
created a merge commit between that branch and your version of this 
series [1]. It passes all tests on my machine.

Thanks,

-Stolee

[1] 
https://github.com/derrickstolee/git/commits/commit-graph-fsck-and-object-store

