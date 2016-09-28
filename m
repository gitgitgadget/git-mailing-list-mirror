Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D119A20986
	for <e@80x24.org>; Wed, 28 Sep 2016 04:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751126AbcI1Eny (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 00:43:54 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33097 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbcI1Enw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 00:43:52 -0400
Received: by mail-qk0-f177.google.com with SMTP id g67so37090535qkd.0
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 21:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zLiogIrFR5w3UPWywFl9tIjRDEkYnnxdnohDVIbwHk0=;
        b=ANYj6bw23v0WXB1qU102JGn48tW3D4QeaN1SAr3sgX9GaFcxHhaG4WL04rTcUaLYtY
         Cd0Mof3jwxbC9QMOE9Mo733yxOQB120JU/sJaSd2a+dEusBPhBqHNKEC6CwHk5le2T/W
         HCrCABVarVAt2kyhLQSwOiJ1c9t9abyrfC6FB7ef2b+TogAwwLTZyR8w+ZuT5fB2HnK4
         ueRrbAPlyRF/rwjXkfrtmEODJpqS8iJwDfiTv0m+L2ly3x3Akbhd1cY7usnCczhnjmC4
         SI+9QQhqIbou3oe8vgGeFjoGl9HPiCF7J0L1/35wkEPt79G6/k5PTOAG3gRVQbX3AjNj
         DBUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zLiogIrFR5w3UPWywFl9tIjRDEkYnnxdnohDVIbwHk0=;
        b=X01V9ClxSJ9OyGyxxoS5lnkNqqg2JonOW+zR16IOKnx5iSkuYgLVtelL+mMNVtLS5b
         qV1t/kIK9/cnYlZfKdREHAqYkbSOP/KlPNo2fX5R/lu78Zy8MNB/m316l6Hq4xFcffXM
         9oK7fLH9ihHvm8tbaiNsTtKirsFsFgxdVmGx8zuiIp9zpR3Er8ohig2xI1XYlVAAuLDh
         jSdiocjvJ8u5FoU+Xon78OllvZc9cpEjHc272e7YMIscLy20osEnRBcrptfg9ZCs4SOV
         WfhQDMxZ2p9h9IBpvdYg4lhKd0Hy0qTSRQl7NRDpnB0JyoWlVNTFr66hWMNA9ieWb4O2
         SmmQ==
X-Gm-Message-State: AA6/9RklwbxzMIHnISqX69xb9dov5rJh2LB23d0f5jHvOU5EBhM8gT8GCSaP4JOUvRjU6w==
X-Received: by 10.55.15.167 with SMTP id 39mr5199805qkp.234.1475037831443;
        Tue, 27 Sep 2016 21:43:51 -0700 (PDT)
Received: from kwern-HP-Pavilion-dv5-Notebook-PC (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id 8sm2169503qty.36.2016.09.27.21.43.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Sep 2016 21:43:50 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
X-Google-Original-From: Kevin Wern <kwern@kwern-HP-Pavilion-dv5-Notebook-PC>
Date:   Wed, 28 Sep 2016 00:43:49 -0400
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Kevin Wern <kevin.m.wern@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 02/11] Resumable clone: add prime-clone endpoints
Message-ID: <20160928044349.GC3762@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
 <1473984742-12516-3-git-send-email-kevin.m.wern@gmail.com>
 <CACsJy8ARu_PkduP-McnE26OFEgr_YAkLtmfaxwYX7i9m47mJmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8ARu_PkduP-McnE26OFEgr_YAkLtmfaxwYX7i9m47mJmg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 08:15:00PM +0700, Duy Nguyen wrote:
> We also have an exception for select_getanyfile() below. I think it's
> time we add a function callback in struct rpc_service to run each
> service the way they want. Then prime-clone won't need an exception
> (neither does select_anyfile, mostly)
> -- 
> Duy

Great idea! I'll definitely do that if we decide to go with the service I
implemented.
