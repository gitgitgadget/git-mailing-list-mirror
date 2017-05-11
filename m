Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 740922018D
	for <e@80x24.org>; Thu, 11 May 2017 18:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756111AbdEKSTT (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 14:19:19 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35371 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755591AbdEKSTS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 14:19:18 -0400
Received: by mail-pg0-f44.google.com with SMTP id f131so3733155pgc.2
        for <git@vger.kernel.org>; Thu, 11 May 2017 11:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6qjFiaI4hv4LYpMCu7TY/Bw131zpKkbHluf7dYZkMxY=;
        b=r8cjFPFwgTRlZDfygKDLrFDIoSSOfrDYu9sO3gMpqRtoy0dJj6lYMFzrY/pXRhPsYm
         HggC58A+Rdl6A9GR1Ds/X36DA/khHLV5tqAMqtj50BdiPb9J2dx6Y0EqciuOI7RFbQcr
         MGPQWR6LijYNwpPC7g9N+0Q2wAfuYZdLaYqYOlqDb/9se998Hlo6DpHo0oDp8xIAeNYw
         kBhfbdnPlMDKPHBP2a9Rt3NNb+LuYphS9bjAU7/9h0gv1d+7MIi4VnoDBM13OQnXQskG
         HA5dRTy14OVMkPNjoByXUL/sAWlqrR9gXaDs7zpXpj7jkO0piv0z+jw++G8S5AwnxbRP
         9hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6qjFiaI4hv4LYpMCu7TY/Bw131zpKkbHluf7dYZkMxY=;
        b=tMxdn9hWD7T+hvSRDO/i28LLa7dJHRD6YQ3YCH4YfIAoXHV1bQwXBZrYQ9CCXniZwT
         jjmyqE8y2Txbw6fQxurSnhUNPKLzvmuXduG3sUZZibZXyjYJ105hChPQLsCgN1H/0fS2
         dIx5xx9a3tVtQZ2dkV6EZ3magC9JSRubXN1dD+udNWCi4c+iHkQ/xStvDvRb7dzK+vHj
         b2IHAFdCemcNBg25fhqhp5f4h83menEALv1l5iQnw2Bd5GZxMC1DRnS/4NRlh4HYcrha
         QCa62xaznHH9sBr2omnyb5wZxnXykuzIxSrB65h0KYpfVdUq1kOm+4q/zckc6r75Cpre
         orWA==
X-Gm-Message-State: AODbwcCet/7uoGu4Pcrv9zaHzUaBpKycBE/ABtmA9wygiRoWxzn7oKD0
        D3M+h5LZx1W9CjVxd3LxdXEP/rWoj4C68C4=
X-Received: by 10.84.142.133 with SMTP id 5mr186639plx.52.1494526757568; Thu,
 11 May 2017 11:19:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 11 May 2017 11:19:16 -0700 (PDT)
In-Reply-To: <c73881261cc3021410695126989c6f1596f638b0.1494509599.git.johannes.schindelin@gmx.de>
References: <cover.1494509599.git.johannes.schindelin@gmx.de> <c73881261cc3021410695126989c6f1596f638b0.1494509599.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 11 May 2017 11:19:16 -0700
Message-ID: <CAGZ79kaM30ExQT6m9k5F5FqhKc-RwP4gsH6AaW_YgDL_ixs1Qg@mail.gmail.com>
Subject: Re: [PATCH 11/11] PREVIEW: remove support for .git/remotes/ and .git/branches/
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 6:48 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> At long last, after a cycle or three of warning users who *still* use
> the ancient feature of .git/remotes/ and .git/branches/, it is time to
> retire the code.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

The PREVIEW patches also look good to me, though I just
skimmed them and other may chime in on the timing of them.

Thanks,
Stefan
