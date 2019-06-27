Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946721F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfF0RJi (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:09:38 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:44603 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfF0RJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:09:38 -0400
Received: by mail-qk1-f194.google.com with SMTP id p144so2349230qke.11
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=c5/envfdXUTTZzBZrEfIGikP/xIVmsRm7rFuomQ0XH4=;
        b=L1rkqG+vVr8qke/U+L0vbpYvxltcH2a1FQbRVQB6S4PxI3dN1iNzdhHlvKuGSq+gp/
         k9rOYtR2/Pf9PsjSNhF0LZO95ax86RRUoJCs4r2PUmAPZJ3/aZ/Hrso05aBd89dOAcwp
         leHcmCbNBUyHb9LYinrrp0ruziuAR/s9CvuJvim5GP9/SPHWkmtt8p0JCc0JYzr+vuv4
         XsSNwKziVfOirpEv0SSgtJz/sT4PGuSn3SMqpfDk3kYiLwauKFSdzp9JNHZ2cdA2mPK5
         iOlROcuxPQbOQ9QnCv8UQtaTk+UG+88rXC3jLj4oYgZfBg67ji0rYJ9xMs9WXlSx2j5A
         EG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c5/envfdXUTTZzBZrEfIGikP/xIVmsRm7rFuomQ0XH4=;
        b=Fl6yeSG3cQHISQSK2IHlJBb3dVWQVEVtGBCu/fo2u/LalAXH2YqfQlIhKcUgRlgUGs
         q7/wuNTt29CDvKty9vDZQ42ht27cxmAYdI4ICCSkcsie2esN2LXoDesk2NWpRx0qs+BB
         4UJIN7cnEgTaFSKBuDdqbIpDQdl6ikc4CzE/G7XFM8/R5s4dVMzOAPNPE//FqGSN1oQ2
         UX8cyLO9PWdTgDqqbcYlZ+iKnzOlmUGyzPXrIY1Ct6cM2/rW5wGFMOnZTg/LZjij8vzU
         ORAlIwbrH/ukWjxuM2b2YWzXz3D0hgsMlN6/zFufmtCBL35MiHt7+MUgznaSs4+pXjUf
         lhKg==
X-Gm-Message-State: APjAAAVqkbTwuUZRrBuQ7p/B30ajTNOUao+He7r5mdfli2oDNWpnIV4z
        x+eeBCoyftXRlSqC96eEJsp1MzK3
X-Google-Smtp-Source: APXvYqxXN8fUzvToAFoArVC8atRVqk+MHUsw5/G00jL+WqjKjLuGNzdZH/6VkyFtdZUI7HTQJkpeqw==
X-Received: by 2002:a37:b8c:: with SMTP id 134mr3908864qkl.160.1561655377271;
        Thu, 27 Jun 2019 10:09:37 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9905:3db8:5a6f:f512? ([2001:4898:a800:1010:4a3b:3db8:5a6f:f512])
        by smtp.gmail.com with ESMTPSA id g5sm1281566qta.77.2019.06.27.10.09.36
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 10:09:36 -0700 (PDT)
Subject: Re: [PATCH 0/6] Kill the_repository in tree-walk.c
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190624095533.22162-1-pclouds@gmail.com>
 <xmqq5zose00p.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906271458240.44@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <7fbc8fc5-b834-c3f6-5d73-27caa55b01d9@gmail.com>
Date:   Thu, 27 Jun 2019 13:09:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1906271458240.44@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2019 9:04 AM, Johannes Schindelin wrote:
> Given that this bug was only caught by a failing CI build, it does make me
> wonder what other bugs are hidden and would slip into our code base just
> because of gaps in the code coverage.

Here are the lines introduced by this series that are not covered by the
test suite. I'm not asking you to write tests to cover these lines, but
please re-examine the lines to be sure the correct conversion was made.

Thanks,
-Stolee

> Uncovered code in 'pu' not in 'jch'
> --------------------------------------------------------
> 
> archive.c
> 47f956bd 421) err = get_tree_entry(ar_args->repo,
> 47f956bd 422)      &tree->object.oid,
> 
> fast-import.c
> 35d7cdbe 2565) char *buf = read_object_with_reference(the_repository,
> 35d7cdbe 2566)        &n->oid,
> 
> match-trees.c
> 3fe87a7f 294) if (get_tree_entry(r, hash2, del_prefix, shifted, &mode))
> 
> t/helper/test-match-trees.c
> 3fe87a7f 23) shift_tree(the_repository, &one->object.oid, &two->object.oid, &shifted, -1);
>
> Nguyễn Thái Ngọc Duy	35d7cdbe sha1-file.c: remove the_repo from read_object_with_reference()
> Nguyễn Thái Ngọc Duy	3fe87a7f match-trees.c: remove the_repo from shift_tree*()
> Nguyễn Thái Ngọc Duy	47f956bd tree-walk.c: remove the_repo from get_tree_entry()

