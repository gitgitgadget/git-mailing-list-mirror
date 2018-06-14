Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5E01F403
	for <e@80x24.org>; Thu, 14 Jun 2018 15:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755242AbeFNPo5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 11:44:57 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33353 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754965AbeFNPo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 11:44:56 -0400
Received: by mail-oi0-f41.google.com with SMTP id c6-v6so6086513oiy.0
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 08:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2XiOq/wmkUiCOv/jzSLi/xlyjHVbELMWmh75P3XsArA=;
        b=a5YPYJaoTgERtCy/7/9KylhoitRjtjC9BawmKv090mewUrCN6EfxfP+eITBcebo6qu
         Paj1q30j0lith9rN+q0uXhekP1qAYuF6C8x9/RZkeF0xzW2e5VS2oGC7oWjqrgP503uu
         qWS8wq6VKt/91DM4emIkTawTVYZb9uC8uAytcEiWI8s0L5lrF6WXGSYswopsuDmt5lO8
         rsgkCEc36fGAfixAhyZN6iUrU6I5fhag5w3DXBpTRuDB68tWQefzEMS/wAJS6W6IWeUH
         YjFbcUUgi4U6XZKS+L42bjbuffSySIUPJpxtEZBdOoPTahCTmdr9KdRTPeoaCuhe0ESg
         AJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2XiOq/wmkUiCOv/jzSLi/xlyjHVbELMWmh75P3XsArA=;
        b=MhmJnoOVunXa16+GhhzGnmcVYPf6Eege4A1I+q/IbZRwkGkiiwScg4JmZJJ0RCt9fr
         sywd7YQjX1Txr+r+ts5iUFi2/mM060i+DSQlAxRF437/srhEfOLLQg8n8+RObwUYn2SA
         oA4HVEQ6v6g5W0Jf6KsDetDcvWUPYuK39hnVm8C9lW+oBVc1WX5kspgk6J6cIGZ1x1Pw
         +d4WC8BXKmGmBAdxyCsy1H5HrpZPXQHzD/w/zlkdn3pkfBt3Zg/fA6G6671dSxn5nq3M
         Mud+Gy4cAGIVRzxYNHSr1yToERcQNS2rNISEIhF8ws9Pwl3X1613w7MC7h1CgoTURgMT
         km8w==
X-Gm-Message-State: APt69E1HmH7FSZqvBmGxhQwPZf3Xx19Rh8gu3Crg1zX00x/Na3N3DGo6
        avotpJePjc4KuKP/1ptzDvcRkbvKZFwPPiFxo1E=
X-Google-Smtp-Source: ADUXVKKAALk6Uuuu/8u1ptMzW2x/o648MD2hM2qqWSzwMyOn/ElnpSewkZf3XeFQMa7Zl94RMX+hJX3nFqRUHbIn/8A=
X-Received: by 2002:aca:fcc8:: with SMTP id a191-v6mr1634206oii.34.1528991096081;
 Thu, 14 Jun 2018 08:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <CACsJy8CNrQ-CKoJ+1NCR1rsO+v0ZNZ9CVAFsJpmcRWZY6HUtKw@mail.gmail.com>
 <20180609110414.GA5273@duynguyen.home> <CAGZ79kZk=OGPJdsDEHtgmPUrO7P2rOLSV40aJawdLs5e0=Kduw@mail.gmail.com>
 <20180614151521.GA2436@book.hvoigt.net>
In-Reply-To: <20180614151521.GA2436@book.hvoigt.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 14 Jun 2018 17:44:29 +0200
Message-ID: <CACsJy8Ab3HoVWSWOtCBRYcsnnHnpO-2oEfV60f=H15RuzwpWwQ@mail.gmail.com>
Subject: Re: BUG: submodule code prints '(null)'
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 5:15 PM Heiko Voigt <hvoigt@hvoigt.net> wrote:
> ...
> Would you want to update your patch? Or should I put one on top?

I think it's better that you make a proper patch. You can provide
explanation and all. I am more like a bug reporter :)
-- 
Duy
