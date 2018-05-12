Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 827921F406
	for <e@80x24.org>; Sat, 12 May 2018 20:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeELUuY (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 16:50:24 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:33368 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeELUuX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 16:50:23 -0400
Received: by mail-pf0-f178.google.com with SMTP id a20-v6so304724pfo.0
        for <git@vger.kernel.org>; Sat, 12 May 2018 13:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+sCvjUZSyyPlwAIVwTTr4k+t54BnURzTUPLC+Jun1O4=;
        b=CvOgnZ7CBCrItDG+32dca71lcw0zhxMpOeYnPkUMHGq2Fy3wNP/gE1E75Zl4+lc+lj
         hkDx1pwX0zH738U6qteTP9zwTYFDZWimEb+hmczrT6bAGp9c9novr7LunsSfSQ8nxIY4
         I0VUK5djJnzXW8ATqWgV4UV8zQeQ/IOKjMxgxO6qjM8zI2YC87qq9z13L9R9m8qnCXwy
         HfDgh4d/Q7K3EmrFVB8yOd5WkrhyuOibrASwKgdiXLVQnJam33/iXwXzlGe7g6uV2Xdi
         8U5zvDcwtfPWs9/81/wT0zxfOHtlgaFiyjYw2mlQdW1NvutfbmYOsuWfXeqWs5qhZt5s
         Huyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+sCvjUZSyyPlwAIVwTTr4k+t54BnURzTUPLC+Jun1O4=;
        b=f0ykDp5+koaFM0AOWVtL3LLwZI5YvYBbKoj+9XuLSc8cTi79KPCn2U0zdfJdblkISA
         LPaVuQWKj9Q9jUF8QXR8bkKQnGCbIEdcUFVnD/VzmoF3gHUeB+MSUlErtSUDiY/emMpT
         VDcj4/UPKT9dkFEakO+nGgp+Vmdr95qRa9DHhlKLXkM7by57g6B9X7SfjxreTqXLGl8c
         cRUBK9oerHy5qa1B+Kd2KTnXNQZhr87Hgj0HXyC1B5Bvq0vlbfUl1L9Sjb5J16bgxM01
         oZizTiU5KSR4okVqCcf4pjV5EzRjf6STfXYoIQh1USDGa0sG8duT1RHBZEQgzk734uxw
         1adg==
X-Gm-Message-State: ALKqPwf4WawH8V2/SW49J4bh74a9X+kVvxa9psT1uKiVA5m3BUz3jr+H
        8iKtGD3E7RFv08uwOiRyJLXsRZzbVMdnoCEz2wQ=
X-Google-Smtp-Source: AB8JxZqIkCAidtd6mTmzP8540lCa6FytaPNRFaTOR6wtHKE2Q79tuJtTdmdzBMIVAKuyHENk8TzVJY5F277AVBWXja0=
X-Received: by 2002:a62:5050:: with SMTP id e77-v6mr4418976pfb.16.1526158223241;
 Sat, 12 May 2018 13:50:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Sat, 12 May 2018 13:50:22 -0700 (PDT)
In-Reply-To: <20180511211504.79877-5-dstolee@microsoft.com>
References: <20180510173345.40577-1-dstolee@microsoft.com> <20180511211504.79877-1-dstolee@microsoft.com>
 <20180511211504.79877-5-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 12 May 2018 22:50:22 +0200
Message-ID: <CAN0heSqHPYjZJbzgFbvJTLH0UZFB2uUhxKBNPxMX5ufYqMXKaw@mail.gmail.com>
Subject: Re: [PATCH v2 04/12] commit-graph: parse commit from chosen graph
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> -int parse_commit_in_graph(struct commit *item)
> +int parse_commit_in_graph_one(struct commit_graph *g, struct commit *item)

I think this function should be static.
