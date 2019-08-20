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
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D3721F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730501AbfHTT5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:57:19 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:43942 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbfHTT5T (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:57:19 -0400
Received: by mail-lj1-f181.google.com with SMTP id h15so6282957ljg.10
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 12:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Bd5nnP4Q5g0ml4NOQn/XGTNy8GW/+A3OEcMQBpq0WU=;
        b=q5kQxNlMWafPlQcSOjc7GCwoAt83f6mUrGPGS2cJPJFt0p8BfxojVcZTKLXrP9Eotc
         sow25r6AAeDw1allQCGclKyTwAKRcc8bu6FVR9t7hq/nojcXCo22QKHrUbvU9YCG1JyT
         C4G9GZuXSeRvsh6xSot18fen4/PHCBxVJe/WOhctnPlpPwBmkgq4A82GMcXfVtE53nG0
         jJVLEwrbH3vQAYM9U37AHwdoCidFCM5NM/np3V5Avg6NRL/PqvLpR43hv7IBG8YnzyKK
         J73hSs97/kZrDn9VCGIDFytoKcNAb8IkGfN3PvlDW+OzXu2n+Oja+F57miNk4WgJF3wO
         hlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Bd5nnP4Q5g0ml4NOQn/XGTNy8GW/+A3OEcMQBpq0WU=;
        b=Cmfk40InFADLfeGLr+WRZ/Tr3WUY816w7mGulXBQVUx+i1vvW2dLzPBmPm8dSeqd6v
         T8A6Bw1phJZRia/6zUEJGpSBGTCWyEpqzM1VJg/FXpfHBaTo3p85sU9aGfaoWjHkVyB2
         jq35FDzft6xtVe1czimrDA0J6q9FIUv+eQnLjYFi0v1VfdeZvNJTCxSKmqdCSSNU1LXF
         cNGOwn9WGGlXNhxKevUDQpZL2Z+Xd9fvYwmXnAiwDZgroploY0g6y8VB/XkR1bBsNOhG
         vMuRhDlo6uKP2Z6M8I10rP98MQ24qDp9KhkIKiiEeCzR2/IPrTXUsC/Ofvx/e8VGHCPj
         4x5g==
X-Gm-Message-State: APjAAAV8BS+QK0YfKseYUN8rGnekPapHMmt97Vt7Q31u45SgQH91DbdW
        rJlz2hVThK2F4O14t1L+jt6o2p9sMWEAIE776TA=
X-Google-Smtp-Source: APXvYqy+/HTzznMRlWaFnelEmOr3xALCcuvh+aCvWTcAqF9BYnIzz4tdg+NA6HVNjRSSoTzFVtZR2rSD2VOzxGRQC8k=
X-Received: by 2002:a05:651c:144:: with SMTP id c4mr4259079ljd.234.1566331037225;
 Tue, 20 Aug 2019 12:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <87blwq7rn5.fsf@mat.ucm.es> <20190818190032.GA11185@rigel>
 <87pnkzkivn.fsf_-_@mat.ucm.es> <xmqqh86bvgsz.fsf@gitster-ct.c.googlers.com> <87k1b7k4w1.fsf@mat.ucm.es>
In-Reply-To: <87k1b7k4w1.fsf@mat.ucm.es>
From:   Phil Hord <phil.hord@gmail.com>
Date:   Tue, 20 Aug 2019 12:57:04 -0700
Message-ID: <CABURp0qHnzpwr8dPtPZpA+1C=tEsoybh2V00iHpyrJ2AM8XHzQ@mail.gmail.com>
Subject: Re: [problem with name-rev]
To:     Uwe Brauer <oub@mat.ucm.es>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Git <git@vger.kernel.org>, Alban Gruin <alban.gruin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 20, 2019 at 12:35 PM Uwe Brauer <oub@mat.ucm.es> wrote:
>
> Take the following part of what I did
>
> git init
> echo 1 > 1
> git add 1
> git commit -m 1
> echo 1.1 > 1
> git add .
> git commit -m 1.1
> git checkout -b foo master~1
> echo 1.2 > 1
> git add .
> git commit -m 1.2
> echo 1.2.1 > 1
> git add .
> git commit -m 1.2.1
> git checkout master
>
> There are 4  commits.
>
> But
>
> Git --log --graph --decorate
>
> Returns
> * commit 98922f82932cd1bef58bebf0229367922bca45fc (HEAD -> master)
> | Author: Uwe Brauer <oub@mat.ucm.es>
> | Date:   Tue Aug 20 21:19:59 2019 +0200
> |
> |     1.1
> |
> * commit 8f565d59c356a6038e3d8a7f5dcd2e4a39ae1bb4
>   Author: Uwe Brauer <oub@mat.ucm.es>
>   Date:   Tue Aug 20 21:19:59 2019 +0200

Try adding '--all' to include all refs, not just the current HEAD, to
begin logging from. Here is what I see after running your setup
script.

$  git log --graph --decorate --all
* commit 3262040f2d8d5f31b4918bda9987e6b5f788531f (foo)
| Author: Phil Hord <phord@purestorage.com>
| Date:   Tue Aug 20 12:44:32 2019
|
|     1.2.1
|
* commit fc66c4311bf954d455f468581f2913dffa0f9c2b
| Author: Phil Hord <phord@purestorage.com>
| Date:   Tue Aug 20 12:44:32 2019
|
|     1.2
|
| * commit 109e5d4baef4e99cf636189ba1499af817ab0bb1 (HEAD -> master)
|/  Author: Phil Hord <phord@purestorage.com>
|   Date:   Tue Aug 20 12:44:32 2019
|
|       1.1
|
* commit 5c1e93ed7c5b3b241d5adfadb365a6bca5d60d3a
  Author: Phil Hord <phord@purestorage.com>
  Date:   Tue Aug 20 12:44:32 2019

      1


You could also mention only the refs you are interested in instead of
including all of them.
$  git log --graph --decorate foo master
