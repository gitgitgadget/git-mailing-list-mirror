Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21701F404
	for <e@80x24.org>; Mon,  9 Apr 2018 13:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeDIN7G (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 09:59:06 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:39678 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeDIN7G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 09:59:06 -0400
Received: by mail-pf0-f173.google.com with SMTP id c78so5806785pfj.6
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 06:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eP4GQv39UpDwVf4CeeY5UIDsSSPzMyB0o4bGxlCX6x4=;
        b=mOo4ij9MOi+iJfS1zSo1Zln3G8WYrytTpY/9HcFABaADe0HK2wqBic7X90G6gB//ys
         DQOdBynKQwzuHbZmo2yHxv0SWpzUD8tR3bVXtM+Q9VaAuAHDnTBpHGU6aE+xo6dy78E8
         /nu9PfipbznoECEA39t5hDnCsWg/RY9Z2Csx67Vs1YJ9VsCgliDiowGbQWWc4rRYwF1i
         g+oHt49K0Rakiau3psrsefdKoxhHz8xdTkefWe8X880Tz/8yWyazezgUZCs9vzbAxk6j
         iZCAl4J7rXgKr78cNvM/XvMptcUI3rumSa5DiO8jfI6EJTFyc40A/Djc8WERkZjcAOeq
         /s1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eP4GQv39UpDwVf4CeeY5UIDsSSPzMyB0o4bGxlCX6x4=;
        b=VZTBgjKfPFR3WTGh+nF4fLLNyxviF32kGBtUnDk+Lgy7KZKH4XglIZVD7Mp8RByXVu
         6YwOFG+6Jsp8wxQTZr6J3EDzSPp+XckfMdyL+s3lk3WixJARwa9RD9WvxWVCFxsqZ+6A
         PC38rTfAYt+P69QbLayGj2tSaJ6I814cACdTtzzm5sd7+dqHn9qkpiGoDaxMRXlOBTyS
         BkP0yWSFkB6b5pKDrYjpIVcxbfy7x39So3soi8tyxK3mLDlOJlYhPFjw8uxL/kNPdKTH
         Xg13gBuATM/B8A9IDmn2GUImI8j7W0i8ItWU/CJGMZpV2Q83pWy5wqhKuVJWFdTiH/Ci
         Xf2A==
X-Gm-Message-State: AElRT7H0oNHvhIm+V3QfoHeiyZ00bViJJww0b23oRyJN+31cNzmcUlhZ
        KbPvQxOMnvYX6J4unAvTrmgQr+4J
X-Google-Smtp-Source: AIpwx49AL+WRu0rQlNmT3ZzreYE0UAwyvsunihuT/cETpmFW10qIyck3ASHX3NWqGrkV37HlrY834A==
X-Received: by 10.99.179.68 with SMTP id x4mr20629857pgt.132.1523282345294;
        Mon, 09 Apr 2018 06:59:05 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id v23sm951688pfn.65.2018.04.09.06.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 06:59:04 -0700 (PDT)
Subject: Re: [RFC PATCH 00/19] object-store refactoring 3 (replace objects,
 main ref store)
To:     Stefan Beller <sbeller@google.com>, jonathantanmy@google.com
Cc:     git@vger.kernel.org
References: <20180406232136.253950-1-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <6c319100-df47-3b8d-8661-24e4643ada09@gmail.com>
Date:   Mon, 9 Apr 2018 09:58:59 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2018 7:21 PM, Stefan Beller wrote:
> This applies on top of 464416a2eaadf84d2bfdf795007863d03b222b7c
> (sb/packfiles-in-repository).
> It is also available at https://github.com/stefanbeller/git/tree/object-store-3
>
> This series will bring the replacement mechanism (git replace)
> into the object store.
>
> The first patches are cleaning up a bit, and patches 6-19 are converting
> one function at a time using the tick-tock pattern with the #define trick.
> See cfc62fc98c (sha1_file: add repository argument to link_alt_odb_entry,
> 2018-03-23) for explanation.
>
> Thanks,
> Stefan

I looked through these patches and only found one set of whitespace 
errors. Compiles and tests fine on my machine.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
