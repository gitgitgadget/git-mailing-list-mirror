Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8844B20248
	for <e@80x24.org>; Thu, 14 Mar 2019 09:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbfCNJSB (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 05:18:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37588 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfCNJSB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 05:18:01 -0400
Received: by mail-pf1-f195.google.com with SMTP id s22so3419238pfh.4
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mwjY6qNGwA6EGXN1485tgt+jMZ9iCRmZo+IpvmpDshM=;
        b=gmIWpIwi3QBEiGydAcOSYvBImYmjfdYy53QpGYnLygg9BCDV0A+fNEPD5unHeVhgH7
         LjhUKYgvW88zlIymWWWBzhXQVxzk6ungwrOgn0mKU29brSGSvxjBtTtZK/pNqDEdclzE
         R1bIJ3C+htAcQEMrbgcd7aMi5GUxifNJsf62A7P0x0tRgGVDbSh8XIqseVSIFdxvAiT0
         Fo+u+vE05MReQD10SSZgQtJAE9gzhE4li6dBySTPXKR+hI/zyDvyjpVP0KFcIRBqetip
         x3vD01m2wyevA6sn1CgqkZBvHtXeRpRM7+6gWq0XJtktL2748LZ3blQNbTsUgA72rth1
         duNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mwjY6qNGwA6EGXN1485tgt+jMZ9iCRmZo+IpvmpDshM=;
        b=hGXSYPpsJl811KLiepgGL6Dzux3lKM9zTnxfrCyyETHD8cJZYz2c62BQjGO6lf3Zoe
         TvpUNXI7sB8urYNb7Bapq6h0arwhMNEFpd4Uzq3WfneNcl3KDDb4Ns9sJdniHNLrZ4hz
         afuPdHyMgKu1MjB7sVt/RJotQkpe+/HNOyhW5MQpMZMTTsv1XlOjkinft/qlLzgxM9bA
         dOno6ut+1IbCMgtA9/9gwwdX1MQXGqNBhvblNQHjtqy1+tZPvEaoIxN6cJd7ZRfPw/7E
         8JMp+83H8wMkdkbRZDq2A5cxCX0a/S3LNpf3/BX26GedujcGJUwGb9BkkQeTnN+Fj4KK
         q89w==
X-Gm-Message-State: APjAAAWc6qXLX6SHu/eVkEMBk/nX+PrXpuFdqOjxIZdUn2/yKVsVqI5w
        huCcv2q9Hl5ZBQL64XSdwQA=
X-Google-Smtp-Source: APXvYqzZwB4qcDZ5a1L97gUnttz5CUjIEqx4AkKPfQ1zNgV95Y1zeQzbiifTTbuORJNK+6LCUbS5fA==
X-Received: by 2002:a17:902:bf05:: with SMTP id bi5mr23565670plb.252.1552555080133;
        Thu, 14 Mar 2019 02:18:00 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id u18sm31853133pfa.176.2019.03.14.02.17.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 02:17:59 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Thu, 14 Mar 2019 16:17:53 +0700
Date:   Thu, 14 Mar 2019 16:17:53 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 10/21] checkout: split part of it to new command
 'switch'
Message-ID: <20190314091753.GA9852@ash>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190308095752.8574-11-pclouds@gmail.com>
 <7d3742d6-73e4-2750-6ecb-9edf761d96dd@gmail.com>
 <CACsJy8DrrEg++wUszU2B1zJ_gvO1WC8MXXa53ZpMnObgqy=AeQ@mail.gmail.com>
 <CABPp-BFStPOtA_OGrS3HCe_XqWN1roBnzss3nefcHdQg=9eYLQ@mail.gmail.com>
 <d78392c3-7282-43ab-b88c-aa13fb5f937a@gmail.com>
 <CACsJy8DxOeKEAygiEa644pcQw-zTsnLyrtPL4sKWmPFEdNWpcQ@mail.gmail.com>
 <CAPig+cRN_cKhu2UQSiJHOK-bgk+g7897_2Acb_kgNK7w6_fS5g@mail.gmail.com>
 <CABPp-BHpoa+tNW=7+6TOmoQTvbap3iavqApEGny4E-rwv1gZVQ@mail.gmail.com>
 <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSe-v-GU=UG_PyUjf9itz_Ddqq4-Ni4h=2TtbLDXr5WJA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 12, 2019 at 01:28:35PM -0400, Eric Sunshine wrote:
> > > Again, not much of a datapoint, but I do use --orphan periodically.
> > > The idea of "fixing" the behavior so that --orphan starts with a clean
> > > slate is certainly appealing (since it matches how I've used orphan
> > > branches in each case).
> >
> > The only three people who have commented on --orphan in this thread
> > all apparently feel the same way: the current behavior is wrong.
> > Maybe we can switch it to start with an empty index after all?
> 
> Starting empty may match intuition better. (More importantly, perhaps,
> it's harder to come up with a use-case for --orphan which doesn't
> involve starting with a clean slate.)

OK so the new --orphan description would be like this, right?

--8<--
--orphan <new-branch>::
	Create a new 'orphan' branch, named `<new-branch>`. If
	`<start-point>` is specified, the working tree is adjusted to
	match it. The index remains empty (i.e. no file is tracked).
-->8--

I was wondering if instead of the empty index, we mark on files from
<start-point> as intent-to-add. That way "git commit -a" achieves the
same as before, but you could still carefully craft the new index and
"git commit". Dunno. Not going to implement it unless somebody says
something, since I rarely (if ever?) use --orphan.

I may need someone to come up with a convincing commit message
too. All I've got is "I've been told this is a good thing to do" :)
--
Duy
