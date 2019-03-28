Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A668120248
	for <e@80x24.org>; Thu, 28 Mar 2019 22:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbfC1WTO (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 18:19:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39580 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfC1WTO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 18:19:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id j9so177864wrn.6
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XuOQImQQEdg/Lf5yWyiLF6KIpf+FH1UtSKTcamOvRgI=;
        b=uV9762a7YEQDlTDE0gqpJugNeynjQxJp4dQtnIjYfjhYcUometFEsWfNruB84y1Gbq
         eORlCllOzwNVezgpnzInar7XmIMVQlOmxtgDIPbO3HcxcO0TDIKp9mXLImwt/kfVhzHF
         MtT7+1du4NN4fyGsM6qOtFzN8mQNZ6jJJ6SxRUNIy0t/EDBcmbLMvTjDBS+DUO3MG03n
         OBN2h7TWGK26mvMjzJ6rbQnCRL8oxlJbeIL+QY3ycoLi9G1ye6VfhvB01vqdklOclFJK
         OizVx3aDwOIMxaKF76NE5Lhx8Kq13lhF/arhRWbdY/fsQ/PEvBMdLS40LaTbVSvNfBOQ
         pA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XuOQImQQEdg/Lf5yWyiLF6KIpf+FH1UtSKTcamOvRgI=;
        b=V3T7tpP4d5oLaMCVDpenACJ2PzG+uO7pyO9mFtxjIiPzGKSBPO81rCW9QXzAxzd7Zx
         EUVfJdqnhwAUrbCgxp7Oh3D6SAuNmTJRCfy/0uZJ4D21k3ZQT3CQNQCuNLPSVp6udMHB
         4kGMlPhW/4OzfCnfqVC3flmtb0E8s8zrS78YBsEkydKw5bQQsDz+Z+77DF2z3+zJCNsJ
         5FI5sPCLguKppRcX5hbov3c7Wo1MEEKVLRMEDkaXrV3DmIOEWvqZDVGvq30x8HCn2YFW
         e75mQbnqR6KyuS72QwR09CFj84R1oAQj6HM+rMQHGNk7RRByr6j42QVZnNDPigjjMUSI
         EOJg==
X-Gm-Message-State: APjAAAUdqpwOQUWX5WUuDdREMDFW+gSpY3plM61jl4sqo18TAxCMvQs1
        pI9C9GKys4r6RRl4JpJS9Ak=
X-Google-Smtp-Source: APXvYqzUsFO2AoEoTzJTKnFuCcCmj1ybvUg5k/j65y+h+EQ+S93WytBdATQaMLZZpF0B9xnaRmICmg==
X-Received: by 2002:a5d:6b05:: with SMTP id v5mr22301594wrw.314.1553811552551;
        Thu, 28 Mar 2019 15:19:12 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id w11sm875753wre.15.2019.03.28.15.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Mar 2019 15:19:11 -0700 (PDT)
Date:   Thu, 28 Mar 2019 22:19:10 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        kernel-usp@googlegroups.com,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v4 3/7] dir-iterator: add flags parameter to
 dir_iterator_begin
Message-ID: <20190328221910.GL32487@hank.intra.tgummerer.com>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-4-matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190322232237.13293-4-matheus.bernardino@usp.br>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/22, Matheus Tavares wrote:
> Add the possibility of giving flags to dir_iterator_begin to initialize
> a dir-iterator with special options.
> 
> Currently possible flags are DIR_ITERATOR_PEDANTIC, which makes
> dir_iterator_advance abort imediatelly in the case of an error while

s/imediatelly/immediately/

