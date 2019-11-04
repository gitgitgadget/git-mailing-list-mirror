Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAC971F454
	for <e@80x24.org>; Mon,  4 Nov 2019 20:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfKDURJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 15:17:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44249 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfKDURI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 15:17:08 -0500
Received: by mail-wr1-f66.google.com with SMTP id f2so9703963wrs.11
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 12:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Khmy37f1RcWW3vkEm8V1qpZMjOevtQ2WHrnWFKOLzok=;
        b=cExAfXOah4VrD7lomG9k4jOq4QwkFsCwIgbMVsHV5yLehRUdegNmok7ekO6JNe5Is2
         GdGPnmWZ0aZxHizeRT7ietZCa+HAXeERhm6kj5C+BE9b6GmxQpZGDpnhlnaIZDQvTZtK
         BZwJ9eBEBaUT8IS8HXy8v6t2IwLHd+svnn1Gq8fNSCw/F+kn2lGoBlewnRLsLUM3doYV
         IrgZoBFWwVCooaqEjuQAZ7utz8QkyWGDhjNy7RqPv3au2hJBYr4Skt8EeQwhrSVkv3GE
         ML2P77E8Wbd+NRan1ZE9gGMF5Xz6vWCoAW/LyGaDsMfXTUdWFYrgjG+mwdIu+/AAagDc
         r14w==
X-Gm-Message-State: APjAAAUVpoOeLdzxjjnrjSDDH+yNELyoesqh1S/6QeE4R//wA7YOU9Cy
        NdWmbNXG9dOjRQQxwD1HFFBwBOCt4WljfKT3ebi7xg==
X-Google-Smtp-Source: APXvYqzs6NXa4aRwfJWmSLJ5MAicdYCkPY1OBdujpw9nbYbKSXehJNIuP53vcpshhHUd6+2KW6qPytfj9KzCSMg9VLY=
X-Received: by 2002:adf:f010:: with SMTP id j16mr25368884wro.317.1572898627153;
 Mon, 04 Nov 2019 12:17:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572897736.git.liu.denton@gmail.com> <64b6f7c9d7434ba39929220c1aebcd9a1fd0ad6e.1572897736.git.liu.denton@gmail.com>
In-Reply-To: <64b6f7c9d7434ba39929220c1aebcd9a1fd0ad6e.1572897736.git.liu.denton@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 4 Nov 2019 15:16:56 -0500
Message-ID: <CAPig+cRVgf3q6-mHeMgOThCrhseTGtYt+S6x1ikUSEKGbUTz4g@mail.gmail.com>
Subject: Re: [PATCH 7/8] pretty: implement 'summary' format
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 4, 2019 at 3:04 PM Denton Liu <liu.denton@gmail.com> wrote:
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
> @@ -63,6 +63,15 @@ This is designed to be as compact as possible.
> +* 'summary'
> +
> +         <abbrev hash> ("<title line>", <short author date>)
> ++
> +This format is useful for referring to other commits when writing a new
> +commit message. Although by default, '<abbrev sha1>' is used, this can

Why does this talk about "sha1" when patch 1/8 removed references to
SHA-1 in favor of generic "hashes"?

> +be overridden with '--no-abbrev'. In addition, '<short author date>' can
> +be overridden by with '--date='.
