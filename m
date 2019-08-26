Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C96A1F4B7
	for <e@80x24.org>; Mon, 26 Aug 2019 17:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732382AbfHZRKa (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:10:30 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33605 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729951AbfHZRKa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:10:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id p77so470330wme.0
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 10:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Un5Rher3CYLKomFHHtJCpEFIVIqQPTAZ9Rjixp7cQ7U=;
        b=JVTMfry+SPdK03CT9ewqKlhEIQvxskTzY4L22HVWd+2phJrnckJ4HZ/MIY5TVwFIlj
         iMQATJU43cgHuuO0Pojz+lNFIbMzzbFB1+db1AyZSCutMDPqUEEx+Inm7bgdEa0oZsKU
         0g29j4hH8/hKVISbSTS6ZjNVWOuY5NaCbOBz0DFEaIHpvWy6peb6UYnWoFz+dPRjTM9A
         BtX9IyoYjADKwDlc5a+bxGwqgKvrz8AQSstjapS1iXMZBgdxQggZhXQCANLZexlzz5vG
         stTLrT1Ybx+69uc6/hyssDWT3LRRvCGKHumOcyVwaC8FNMAYZUFPmdDtd23C7JL6ti3f
         XZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Un5Rher3CYLKomFHHtJCpEFIVIqQPTAZ9Rjixp7cQ7U=;
        b=WDAFvlLojNyG3p8q02rtk0ckG/V7bbAxBgL0setSpwtsgpqszcO/sWC09Z9jFt553+
         p2rjHhqRdPpefFMsfQQUETwY8AgM4xEy3ey+p6bPodCHnwCtz3Rjq80pqOJ4dV5bO3N6
         4Ck73hqJcjzmiBFzWXYo1W6rj+HhhCO52Bpj4NSwaNksM8WhGqj5mLqhGVbo7OBj+U2h
         JtS3ISE3XMTHnHo6IJsoXlxylTfcJ2vUAF6y6KrZez1b3gQo6qc8XAKR0IgjiMGM10ta
         0bkii5PEX7Qrm09KR1aQJm3trTAvYVoN7pMcytvWuPzRx2Vh4k9cRfvIXP5XcF65ZfRB
         JIUQ==
X-Gm-Message-State: APjAAAXRaNl/E7lfFPV1ZjVoPH+uAP+KLq8d7rykmgbwiHSJ5ZI/SJba
        +89jzaXPxCjvhP49kNYewCk=
X-Google-Smtp-Source: APXvYqzFeadgCe/kPB3BX7na7OvkXq2GQx/6GIbLv9TPAVbRtyGv9hehnAANYxjdLS1bDKhOiqGd5g==
X-Received: by 2002:a1c:eb06:: with SMTP id j6mr23973123wmh.76.1566839428138;
        Mon, 26 Aug 2019 10:10:28 -0700 (PDT)
Received: from szeder.dev (x4db5125e.dyn.telefonica.de. [77.181.18.94])
        by smtp.gmail.com with ESMTPSA id z2sm178430wmi.2.2019.08.26.10.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Aug 2019 10:10:27 -0700 (PDT)
Date:   Mon, 26 Aug 2019 19:10:24 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Wijen <ben@wijen.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/1] rebase.c: make sure the active branch isn't moved
 when autostashing
Message-ID: <20190826171024.GR20404@szeder.dev>
References: <20190821182941.12674-1-ben@wijen.net>
 <20190826164513.9102-1-ben@wijen.net>
 <20190826164513.9102-2-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190826164513.9102-2-ben@wijen.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 06:45:13PM +0200, Ben Wijen wrote:
> +test_expect_success 'never change active branch' '
> +	git checkout -b not-the-feature-branch unrelated-onto-branch &&
> +	test_when_finished "git reset --hard && git checkout -" &&

I think it would be safer to explicitly spell out the branch that
should be checked out at the end than to rely on 'git checkout -'
always being able to figure that out, even in case of a breakage.

> +	echo changed >file0 &&
> +	git rebase --autostash not-the-feature-branch feature-branch &&
> +	test_cmp_rev not-the-feature-branch unrelated-onto-branch
> +'
> +
>  test_done
> -- 
> 2.22.0
> 
