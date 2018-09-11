Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EDD81F404
	for <e@80x24.org>; Tue, 11 Sep 2018 20:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbeILBa1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Sep 2018 21:30:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42024 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbeILBa1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Sep 2018 21:30:27 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so29708698qto.9
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uzha5g8dm3A+8wS1/WLncuT5JrUZ864RKb74u7i3kvU=;
        b=aCUscP7pzosxgPVKmJMLHNBxcr3HIl4gR7Z26cXfcoQ3ohn3qj5n12MSfD4Kd3le1n
         aktZVGFhL5RJhh0RgUflndLOR6EtXdEUhs2HtFCEID+TkSspNjdL7J4NIrD548IEjWlr
         WBubOPExSESnSZkY5WMPqRFqaoSZgujzg53R+Z3Ka0TtGse8ge0c9rhkHvH32uJ9pH7n
         ixQfP1AVp9kV87zoaNNgLEaWG/4StBmUzlh/jyERPxfGof8bUSOremla/PSoFoaGvxv2
         a/ikIJk3rI/Q3zz1DqK2jEEJjmygJk9YJSJsKcZBqEwsYGjAVpXP79774Ry+bgGDrFGd
         P+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uzha5g8dm3A+8wS1/WLncuT5JrUZ864RKb74u7i3kvU=;
        b=hNmYjLXiA4Pv4ocFqFSZ3El0B7fDV/sEg39sGjpdLeEQcXTnebx3lNy5k8H2QgCnKC
         LnSq1ov98Wi0uoWn7rpYOXOc31+ap8YHik1stBN/QQElAv6r3hkCZY05QO0c3Tb4CBwl
         CE7ry58v1ZsUyMVjWXort6eZWfK+cUvDwbQJe/27RAfj9Y6OKP66uRZ+8p2mh/NHWJHJ
         897xk2f5RUgVdoXYTokqYWk+oseYf3g5hjm7SmV/NgdShY+SzAWMhOirpwOURdt2l5vI
         YEFJ6AiwJvv89Lk/6QDWCul8gjDYLz3AdX9pamv4HgfkRY1s+RWJYKCty47i2OzKWm6x
         reCw==
X-Gm-Message-State: APzg51CSpAc5ftYdlVbvFZ8toNmNGRMCLnw949BRzaOBkNU/Q6cGNNEK
        2Z7lR0XT3ALVz/OoXaiIn4k=
X-Google-Smtp-Source: ANB0VdZQScHjAz+IhwrfXz3lrgtMPjh046dY4WDgXK0lK8BMrqKpIBbjnMEjyJhXXMJaEFrrUhIKQA==
X-Received: by 2002:ac8:3726:: with SMTP id o35-v6mr20496540qtb.224.1536697768803;
        Tue, 11 Sep 2018 13:29:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:80cf:4a5a:6920:a965? ([2001:4898:8010:0:6a05:4a5a:6920:a965])
        by smtp.gmail.com with ESMTPSA id q1-v6sm7976857qkl.31.2018.09.11.13.29.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 13:29:28 -0700 (PDT)
Subject: Re: [PATCH 0/1] Add coverage for 'git format-patch --range-diff'
 single-patch case
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <pull.37.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <61316ea9-50e9-a57a-291c-34515e1763bc@gmail.com>
Date:   Tue, 11 Sep 2018 16:29:29 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <pull.37.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/2018 4:21 PM, Derrick Stolee via GitGitGadget wrote:
> In es/format-patch-rangediff, we added a '--range-diff' option to
> git-format-patch to automatically add a range-diff. We also added an option
> to write the diff as commentary to a single patch submission. However, this
> check was not tested.
>
> I discovered this test gap by running 'make coverage-test coverage-report'
> on 'next' and then comparing the uncovered lines with those in the diff
> between 'master' and 'next'. I have a script that automates this process,
> and I'm still working on polishing it. You can see an earlier version at
> [1].
>
> Based on es/format-patch-rangediff
>
> Cc: sunshine@sunshine.co
>
> Cc: peff@peff.net

Sorry that these Cc's didn't work (again). Adding them manually and 
investigating the GGG code.

-Stolee

