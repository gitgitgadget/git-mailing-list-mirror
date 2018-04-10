Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F5CD1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 22:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756323AbeDJWuN (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 18:50:13 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33771 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756314AbeDJWuK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 18:50:10 -0400
Received: by mail-wr0-f193.google.com with SMTP id z73so14330006wrb.0
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Fnz9mnNZetKXhug0L6uBogndidMjF4TXzje03eIG8Ww=;
        b=X0xW/8jy/VXBJ2pYUYeuDjr5fuDsRj5FyaukEQ2h448A6QcfGIMAiu24fFwjHHWEix
         QuVNTnc/H1rQDDdwU0QhMeh+O4RrMF+15OM1CwI3+1zKSLMcX6j040iMIOu9P1WalEeK
         rawFJAuc05XtdH8QC3bolsXTff6OLOXU9/9iSuAwLDGCqZXIasMnHgkEv3bfhevxgM6D
         gkaznUB7mYPfYO/VI8bC/rblYNP1FRZ/e7H9/lvLbPDadNnvsEDmIL70zxqTTUttYhWz
         UcH2CzmvxDskVwT/DJCWXl3PgtfyDYzi5tP74LcNVfc7kKgSdBLo5KtGxHNILdcnYaDe
         vgjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Fnz9mnNZetKXhug0L6uBogndidMjF4TXzje03eIG8Ww=;
        b=GT20a9TSwSQ4cCgfKtbFjdfa1yoLKRfBF+gZTXoYbTTR3oTdz0otxS4fViT4pNfs0o
         2FTbEup526hLm67BBNmpLvRcBovGxn8UL0WsWEsaHgUOQJOkcEO/A0yCcnoWpJHTz4PT
         T0OCoP6/Ix29oSsARskH+EkKfJAfxgYLLiykCoVqXmc9NirFFdG47+sb7b+ZsoRa3DRD
         OWn+IyTVHOChgIJQIKtPv5EziCkEoPM4vD3RzhUpkM8wP+DDuADWmj/R+LroisJjlJbc
         eFDMwkRdN9ProijsWMG988euPcRKkNARGIY2WWcQKNfiAr+mdnXzm0OvnZP8lvj27oii
         ZYRg==
X-Gm-Message-State: ALQs6tAo/crvmKZIMvzMdnjhNdkZZUSKx31kLLDZaN/aAxRsQkXj7NNF
        jUfQwsQ9DRTuK/Pv5xV8pyg=
X-Google-Smtp-Source: AIpwx4+giECbm0sdpp2Uzw79PjkzbFzVDQsncsO5Pt9LG6UBmUmDm4ZQeFheA89wpMsH2WL8IyJ8ow==
X-Received: by 10.223.168.4 with SMTP id l4mr1492004wrc.170.1523400609351;
        Tue, 10 Apr 2018 15:50:09 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g185sm47553wmf.40.2018.04.10.15.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Apr 2018 15:50:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Chris Maes <chris.maes@macq.eu>
Cc:     philipp@gortan.org, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        git@vger.kernel.org, philipoakley@iee.org
Subject: Re: git-gui ignores core.hooksPath
References: <74c84bda-4f3d-b2d3-91cf-e80e84fe46b1@gortan.org>
        <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu>
Date:   Wed, 11 Apr 2018 07:50:08 +0900
In-Reply-To: <3a3eb88e-0d7b-e689-c4e4-207569ebd667@macq.eu> (Chris Maes's
        message of "Tue, 10 Apr 2018 17:00:20 +0200")
Message-ID: <xmqqd0z61xsv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Chris Maes <chris.maes@macq.eu> writes:

> Is there any hope from here that anyone will pick up this / these
> changes? Will anyone else be assigned the main responsible for this
> git-gui repository?
>
> Just hoping to revive the discussion here, since the
> https://github.com/patthoyts/git-gui/ repository seems quite dead.

It indeed does.

I've played a patch-monkey in the past for git-gui and have a few
topics queued still in my tree, but that serves merely as a bookmark
that is slightly better than a pointer to the mailing list archive.

We need a volunteer to take over this part of the subsystem;
somebody who actually uses it, passionate about improving it, and
can speak tcl/tk somewhat fluently (I qualify none of these three
criteria myself).

Any takers?
