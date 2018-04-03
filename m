Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F3A51F404
	for <e@80x24.org>; Tue,  3 Apr 2018 16:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeDCQ4s (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 12:56:48 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:45982 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752666AbeDCQ4o (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 12:56:44 -0400
Received: by mail-qk0-f181.google.com with SMTP id s9so19308513qke.12
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 09:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=yN6dYCNzoXv4pqrmCFtmu5PowocDzI3eHQxt4QkUT/o=;
        b=XnfyVJxVxgYGg+l83r1+lv87ZvOF6uhSU5ONmMLBMoGWBczE00zeHvsbLgaIBWbkR+
         LzvwJ8JQ4FwkHyVYw2T75LNfh0Z4JN6QnaAOrmYfiHni1umx3VV4JZCBfb3CqlbsL6qk
         Zok7hz4wmZLfeK+gltWhY9hMgVv4i8J0L+AZnVo+xNSOY4izNtR6Uwl0kh9VmSICoWoQ
         g6c+8nn28+B0UT338YMs7/cnJvipcr1FroB+cZhQIa+78/TtTkimAYN6DCv02Y6sOq/y
         8B1Xdknzks59QJBjYXTwqlYojZfD9PtRKzZyOmI+OJBUmdklkTuqPqCjHl9YtEqVszHr
         0r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=yN6dYCNzoXv4pqrmCFtmu5PowocDzI3eHQxt4QkUT/o=;
        b=VSht5GJoxCGWSftO3l4xm8qJ3KrTfIwRaSKb1w12cKArF4EUR+DDGwhYuK9GbQRnlh
         9DYQ7COw9zWEN0vALSureLQrUTP2zUuY+ed/ooMLbbVB/W2eBfkmDQebfqJXpz5WqYGH
         cU1SjtY77lLE3SPgTf0YvdbWOIDXdwe5haz6zDBEnB3Gzq0XOiItA7Ki2Uv45i+f46Xh
         IkAMiwI/3Ua4p0kgsjHRZ53UMVgzVt3biDTBsG2G7wutrOArMHVxGX6Xwbt4Sd+exnkk
         3/85figrdDmwd0FkqaEYdWrwQX4ODir0LC1J23rpcMlRbDh8iTlDqg/9pQUpn8trbFgc
         m1sA==
X-Gm-Message-State: ALQs6tDNc27lBrMX4OBujA+09kniI5qLR7XqwGVC31OtnZRfSmHw+o4a
        sfDkyMhOBWaTcxHwtFb8hbI=
X-Google-Smtp-Source: AIpwx4/Ly5+GSiP8jNhZmW7OSURnK/KmxL2AkQZj1RsGGyHInuelpuLTGCz6dzw0BKDe5VIg5wNmRA==
X-Received: by 10.55.22.28 with SMTP id g28mr19497198qkh.152.1522774603509;
        Tue, 03 Apr 2018 09:56:43 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id d199sm2300221qke.90.2018.04.03.09.56.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Apr 2018 09:56:42 -0700 (PDT)
Subject: Re: [PATCH 0/6] Compute and consume generation numbers
To:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Cc:     avarab@gmail.com, sbeller@google.com, larsxschneider@gmail.com,
        peff@peff.net
References: <20180403165143.80661-1-dstolee@microsoft.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f68ca797-8ea6-ca3f-b940-2f5aa6633938@gmail.com>
Date:   Tue, 3 Apr 2018 12:56:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403165143.80661-1-dstolee@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/3/2018 12:51 PM, Derrick Stolee wrote:
> This is the first of several "small" patches that follow the serialized
> Git commit graph patch (ds/commit-graph).
>
> As described in Documentation/technical/commit-graph.txt, the generation
> number of a commit is one more than the maximum generation number among
> its parents (trivially, a commit with no parents has generation number
> one).
>
> This series makes the computation of generation numbers part of the
> commit-graph write process.
>
> Finally, generation numbers are used to order commits in the priority
> queue in paint_down_to_common(). This allows a constant-time check in
> queue_has_nonstale() instead of the previous linear-time check.
>
> This does not have a significant performance benefit in repositories
> of normal size, but in the Windows repository, some merge-base
> calculations improve from 3.1s to 2.9s. A modest speedup, but provides
> an actual consumer of generation numbers as a starting point.
>
> A more substantial refactoring of revision.c is required before making
> 'git log --graph' use generation numbers effectively.
>
> This patch series depends on v7 of ds/commit-graph.
>
> Derrick Stolee (6):
>    object.c: parse commit in graph first
>    commit: add generation number to struct commmit
>    commit-graph: compute generation numbers
>    commit: sort by generation number in paint_down_to_common()
>    commit.c: use generation number to stop merge-base walks
>    commit-graph.txt: update design doc with generation numbers

This patch is also available as a GitHub pull request [1]

[1] https://github.com/derrickstolee/git/pull/5
