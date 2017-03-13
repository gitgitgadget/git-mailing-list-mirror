Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3060320373
	for <e@80x24.org>; Mon, 13 Mar 2017 22:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753206AbdCMWtd (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 18:49:33 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35257 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752834AbdCMWtd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 18:49:33 -0400
Received: by mail-pg0-f52.google.com with SMTP id b129so71946505pgc.2
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 15:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jezf41OV1hhH6ZcU/B2T3cWEOYw2RJzWlXUC0PcfGuY=;
        b=M9uDLWmWMH4+herU49jcWxTN3bGqH9+nb1Wy5QKrMN481sfHVVvUztLFYUydzNRQFB
         9knGyjAzbcEmjOLqHSU7h7hlVadlr1zLBvQQ8xusGWGfN0KYLE0CP4uKvk7ncB2Elz4h
         +B+6ybxNVBXRMQ6XjEm2kELruvEnUKWiGQl4FTfsZnMJF4W0bCZVEm83e+goYIJN6zYA
         jahRY8ReITE9MPO7N97B/odwmVaipctI7WZvP+0v46Z/gO2oppLTtEuHFomVHy3SryHm
         94aS5KPH42AMb0LnfVnA1P4NJVyox6ylaWzC1Y6N1uhREmx/oDnNAIJ5Xnxz3i9A/w+W
         FYMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jezf41OV1hhH6ZcU/B2T3cWEOYw2RJzWlXUC0PcfGuY=;
        b=BXZv8Jijb0EL5TPPPfTHHcklyzmqh806JXkcua0ubg/4T0dsHXb36CGz8lYyTq1/8i
         RbSME2n9jklRxwMqRmXVPzqyI++ZEPz3hzjQT2weynhZYekkVXTKNBYmNdTNQ62LxHW/
         Wc+m6Cq3+j8oMgt273PzTRNRzisEzlSfWk1l3oTYe0IpdFyZV0CXx/4ThmksI8a+lODa
         qe7WW8UDGVNIGKXCOenJTUY/4qPShidj1vDtsg0hEJvYj0tg9lDjPHYwuYDXS9uGDGl5
         MTgeMTWE+pLi7I+S9G8t7SHAutfyco6vh9YoBbUiSIqLPJoJWv3ioN59XZb5UAZRZO6P
         xQGA==
X-Gm-Message-State: AMke39mO63zu0XAdP+ZZIAN6o2kWIx1F64PlKzL0ii37ETHA05XAchasrFiW7RgZm+16OZH8hM2mI/xN4XszJq4Q
X-Received: by 10.84.172.193 with SMTP id n59mr50367638plb.63.1489445371608;
 Mon, 13 Mar 2017 15:49:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Mon, 13 Mar 2017 15:49:31 -0700 (PDT)
In-Reply-To: <20170313214341.172676-6-bmwill@google.com>
References: <20170309012345.180702-1-bmwill@google.com> <20170313214341.172676-1-bmwill@google.com>
 <20170313214341.172676-6-bmwill@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Mar 2017 15:49:31 -0700
Message-ID: <CAGZ79kaqNUV_Wa_9-PSTf=NU7EcKASHqk6NcmGZSX5r610Zdew@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] submodule: decouple url and submodule existence
To:     Brandon Williams <bmwill@google.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+ cc Jens, FYI.

Once upon a time I brought up different addressing/activating mechanism for
submodules and I remember Jens having some uneasy thoughts about
that back in the day. This series addresses the user confusion and documentation
better than what I had back then.

On Mon, Mar 13, 2017 at 2:43 PM, Brandon Williams <bmwill@google.com> wrote:
> Currently the submodule.<name>.url config option is used to determine
> if a given submodule exists and is interesting to the user.  This
> however doesn't work very well because the URL is a config option for
> the scope of a repository, whereas the existence of a submodule is an
> option scoped to the working tree.
>
> In a future with worktree support for submodules, there will be multiple
> working trees, each of which may only need a subset of the submodules
> checked out.  The URL (which is where the submodule repository can be
> obtained) should not differ between different working trees.
>
> It may also be convenient for users to more easily specify groups of
> submodules they are interested in as apposed to running "git submodule
> init <path>" on each submodule they want checked out in their working
> tree.
>
> To this end two config options are introduced, submodule.active and
> submodule.<name>.active.  The submodule.active config holds a pathspec
> that specifies which submodules should exist in the working tree.  The
> submodule.<name>.active config is a boolean flag used to indicate if
> that particular submodule should exist in the working tree.
>
> Given these multiple ways to check for a submodule's existence the more
> fine-grained submodule.<name>.active option has the highest order of
> precedence followed by the pathspec check against submodule.active. To
> ensure backwards compatibility, if neither of these options are set git
> falls back to checking the submodule.<name>.url option to determine a
> submodule's existence.
>




>
> +submodule.<name>.active::
> +       Boolean value indicating if the submodule is of interest to git
> +       commands.  This config option takes precedence over the
> +       submodule.active config option.

... which itself takes precedence over the (deprecated) .URL
We conveniently do not talk about the URL here anymore.
But! We need to change submodule.<name>.URL now?
