Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60534C433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 19:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382909AbhLCUCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 15:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353557AbhLCUCX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 15:02:23 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42400C061751
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 11:58:59 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id gu12so3831382qvb.6
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0YOGM+AxYzYeV6t1voNY2R6XMJvB37Yi8xJjwJ+zPAU=;
        b=GjE9L7iTH1SLBpjkhvpd/BsetoZFScP1C9a25Gp29475oFEQ69Wq9UjML4e9lnDus4
         MW4Fx7/oFWaO5j5vQUUVeVQGylOk6H/XOJThoCHDkaZrDY4Dl/fMMrV03ahHmvQS1Uir
         kH9jz/yvEIeVBBINKtfXdnX3ls6lWoaJTdhHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0YOGM+AxYzYeV6t1voNY2R6XMJvB37Yi8xJjwJ+zPAU=;
        b=zjiXfdEkAckL3MR274QlPz4YHkgdbXul0pZaIBPLx6icgEsqMEpetWmZ1Q77oVcsvu
         NzpSMAaC1BMql/AsRadG0/Dyd1fF8viAdeKjcI3+GWuZlsM4Szm+Ap4trS/9dVfE8JCu
         AlR+CJCN6KuFP+FzBV3RZoSPfkJTs3OfnTqQGsCGztQQq9lktbh4vlXgAC2fWFSEI9pE
         mm/IWQKQAyBWyZS952MBUo78xH/6KFJcXGVPXL0DlSxo8bqD7+Ycco1q21b6Lo80Dgnu
         HTBRmcxOzLKXjjFsxUafICaTG9NDlD9Up55IHbTDnwFUUQuGNmkOhu9m3ubvm2NDyuDq
         MxTQ==
X-Gm-Message-State: AOAM5339M+eXsvHo4AIkH0lzUOoxjaBSkIovVimedi02VHDZwlAYosxS
        ltU1/Dbsf9kdC2UiL3HF8gBOlxzou0uXMQ==
X-Google-Smtp-Source: ABdhPJxbO9NtyY1Q2uUY2u5LZdtwU1G/Lv/8Lfh1NvLGxy7iNihd3+oCcDkRgRibhSQc3hD/Xb+1uA==
X-Received: by 2002:ad4:5969:: with SMTP id eq9mr21564774qvb.4.1638561538384;
        Fri, 03 Dec 2021 11:58:58 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id h11sm2666332qkp.46.2021.12.03.11.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 11:58:57 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:58:56 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: Large delays in mailing list delivery?
Message-ID: <20211203195856.7lfcy4gfvheb7lau@meerkat.local>
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 11:52:58AM -0800, Elijah Newren wrote:
> Are there some rather large delays in mailing list delivery these
> days?  Anyone know who to contact to investigate?  [*]

The right person to contact is postmaster@vger.kernel.org, however I can
actually answer your question (despite not actually being in charge of
vger.kernel.org). Periodically, Gmail decides that there's just too much
incoming mail for some accounts and will arbitrarily delay delivery by
returning a "this account is receiving too much mail, please try later."

I am willing to bet that this is what happened to you.

Best regards,
-K
