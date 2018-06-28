Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C841F516
	for <e@80x24.org>; Thu, 28 Jun 2018 19:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbeF1TSM (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 15:18:12 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:33871 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933853AbeF1TSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 15:18:11 -0400
Received: by mail-yb0-f194.google.com with SMTP id e9-v6so2440671ybq.1
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 12:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jM6zHd/fQFKkmiKq0LOCDBUDIVQYZC2GBhAjZylAKJw=;
        b=alMIgPdfzSaYVYMkVCHte0cRaD9ipDiejN13xe3oABACcMAek78f9cHZ1c3F3rDhJd
         Ap+A3LuKmTohQK5tmZSLAvp4HJOsBIQU9jPxB4qlHvxZdXByqxTI0NB+p7yyFI/+tQaw
         cAVXUj4Ndp/qZXHbLsBSSzX72eN6QEbE1Pc0xzsbUn6BpZmmdXnwjydkOYHAyZ+Niogb
         GtN0oouxJVjUd1pceKr61KQsD67wYQyocTaa7x8KcmuzyyJDJpueTAEi58VMIIlNe0zw
         Nw9l+T/Kvs91FUC4xEPl5Sr1yjDp89ATIkCDm+liGtTIPIG93PnA3Um/29mqo9pntnpC
         rStw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jM6zHd/fQFKkmiKq0LOCDBUDIVQYZC2GBhAjZylAKJw=;
        b=j18NJKPDDr8I8rlqok4/8C8NcXCJjO2fNuJCWkuR72iPhnsK7VGwrfB1ZODn/Lgygy
         8re9dr3nP3G0ZKRhDVrRM9NiT0qnEKG/F9Nq17SD/ktBtCmHIVbpct1Xek6Rr+89voSq
         Fp8fkWxSbV0sCHamjTMnB8BJpHFfOP186dwRk5i8q1c+kuEyewwWSajSWtP3XMbY4hIR
         cq3OrAdHQGdlXUugJsVl/kpx7TE6AEuvdOBYOZAVLlBgC7+4PGbfjKkN/IN49lYss6f2
         3/SO27VfNe/6r9AVNtROG5NOKH43im+BvycFNQLmbLEU0OKXjVjwqFhUh0YLaLtkkzkK
         RhKQ==
X-Gm-Message-State: APt69E0nciBLjK5e/GYNVs4pksUx/bTs7YPYkoeI58aNT8BAlBZgLe/c
        jzG82czxO+dl1itJEUl3KuiTum2UjFkz2S86U2PPCw==
X-Google-Smtp-Source: ADUXVKL46+i1xBkAgVOP7AdAcLsGnXznoZw3d/a5HbXFxByf0x01rn2cKTbt8mpDdC+53GGno92QdtxzPgBhI1sRslU=
X-Received: by 2002:a25:c04:: with SMTP id 4-v6mr6139657ybm.247.1530213490505;
 Thu, 28 Jun 2018 12:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180628074655.5756-1-predatoramigo@gmail.com> <20180628074655.5756-4-predatoramigo@gmail.com>
In-Reply-To: <20180628074655.5756-4-predatoramigo@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 28 Jun 2018 12:17:58 -0700
Message-ID: <CAGZ79kaVXVu9BWtQfpNturhLMJtCuc7MSuTa6aRwwC8q=nXsgQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] rebase: refactor common shell functions into their
 own file
To:     Pratik Karki <predatoramigo@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 28, 2018 at 12:48 AM Pratik Karki <predatoramigo@gmail.com> wrote:
>
> The function present in `git-legacy-rebase.sh` are used by backends
> so, this refactor tries to extract the functions out so that, the

it not only tries to, it actually does. :)

> `git-legacy-rebase.sh` can be retired easily as the
> `git-rebase--common.sh` will provide the functions for now.
>
> The motivation behind this is to call the backend functions
> *directly* from C, bypassing `git-rebase.sh`. Therefore those functions
> need to live in a separate file: we need to be able to call
> `.git-rebase--common` in that script snippet so that those functions
> are defined.

Makes sense.

I applied the patch (and checked the move via the --color-moved option
to see if there are discrepancies that slip in easily via rebases as there is
more work currently going on in the rebase area) and the found the functions
were moved as-is, just reordered. Can you give a hint on why you choose a
different order for the moved functions (not as an email reply, but as part
of the commit message, later on people may ask the same question only
to find this commit via git-blame or git-log for example)

Thanks,
Stefan
