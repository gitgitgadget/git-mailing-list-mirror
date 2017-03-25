Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849021FC19
	for <e@80x24.org>; Sat, 25 Mar 2017 01:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756642AbdCYBfs (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 21:35:48 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33685 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756699AbdCYBfq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 21:35:46 -0400
Received: by mail-pg0-f67.google.com with SMTP id 79so1061117pgf.0
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 18:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IXi2rNQhSMU733MS0Cq1ZRZvyCin36H8vznrBKQVgi0=;
        b=s0+WBXJyuzFj5H4yI313GOutfaQ86f7xEwUrs4j4f5biWBQvvbzcaEwd1yeIw3dtRS
         3Hah/FVF/DMJ2vzZcyrU8bmL5Mu2TsybEFpYezvfK760WaOLBlqlYuliDB9or2gJh1s0
         Z1ZuZbXFNPasp7CobYuPKfhkyniviuDsH0yEqqo1QH36v1o9h7dbHZcBa28aDe6skB6H
         APNEAG9KgCtrKaqG6rSq2eJa3ut6uoTUqNxzcUdK32GIOqhFzd94JaPUdg6jsCXRUfB+
         jtJ+UsR4vb7g6gUVlAGW7KdJhooMu6WmbXjg4G/4HZvHMSIteqho/6cbVuCJcXLH8Eh7
         myuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IXi2rNQhSMU733MS0Cq1ZRZvyCin36H8vznrBKQVgi0=;
        b=YS0G4ta9mgjOjeu88GMvmjtX1rGX8ed4k6S7/nIc8FfRjfJUzjQ9ZIs6bGt3mNv/t+
         HDWgToxPNQ76l7z40CcURK1urNCFmnQpfylpf40v14czBDwK3LImWLQzqc7T7yesftbz
         Q4d1J8Eih3MBHPpioRvWF3aLxzRFA9hmm43XyWOz0tDItWP0/1HzjeoUr6dUBEiKg3Nx
         7zj6A2Jd099L9csyhcXXSIWaNdfw6zTn9hIHlrabQEWcEdU6FBM5II/L1Dr46XBIarVs
         7zt8CO0ck6RwG5gOG+/Hdg+XJtfc5bhvTj+kHnHqHmviNvn7sum5KYpYWTukd/E4SltN
         i2JQ==
X-Gm-Message-State: AFeK/H0XaNkNXgHa0fOB0dA1EH4PY6+nNHxG5sB4tOx1xL7euEfZbQB/hOy6nXq+a6boNA==
X-Received: by 10.98.71.24 with SMTP id u24mr12763450pfa.180.1490405744322;
        Fri, 24 Mar 2017 18:35:44 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:8597:ae41:db75:6a97])
        by smtp.gmail.com with ESMTPSA id t133sm6853495pgc.24.2017.03.24.18.35.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 24 Mar 2017 18:35:43 -0700 (PDT)
Date:   Fri, 24 Mar 2017 18:35:41 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: [PATCH v7 0/7] short status: improve reporting for submodule
 changes
Message-ID: <20170325013541.GN31294@aiede.mtv.corp.google.com>
References: <20170324182902.19280-1-sbeller@google.com>
 <20170325003610.15282-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170325003610.15282-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller wrote:

> v7:
> * taken all of Jonathan minor nits, so patch 1..6 should be good to go
> * patch 7 lacks tests and documentation (according to Jonathan...)
>   but as it is the last patch, just fixing a minor detail we can leave it off.
>
> Junio, please take patch 1-6 as usual, I will be out until next Wednesday.
[...]
> Stefan Beller (8):
>   submodule.c: port is_submodule_modified to use porcelain 2
>   submodule.c: use argv_array in is_submodule_modified
>   submodule.c: convert is_submodule_modified to use
>     strbuf_getwholeline_fd
>   submodule.c: port is_submodule_modified to use porcelain 2
>   submodule.c: factor out early loop termination in
>     is_submodule_modified
>   submodule.c: stricter checking for submodules in is_submodule_modified
>   short status: improve reporting for submodule changes
>   submodule.c: correctly handle nested submodules in
>     is_submodule_modified
>
>  Documentation/git-status.txt |  9 +++++++
>  submodule.c                  | 56 ++++++++++++++++++++-----------------------
>  t/t3600-rm.sh                | 18 ++++++++++----
>  t/t7506-status-submodule.sh  | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  wt-status.c                  | 13 ++++++++--
>  5 files changed, 116 insertions(+), 37 deletions(-)

Patches 1-6 are

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

The effect of patch 7 on --porcelain=2 output is subtle enough that I
don't feel I understand it.  I think it heads in a good direction but
indeed, some tests could help to illustrate the desired behavior.

Thanks for your patient work.
Jonathan
