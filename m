Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2FC11F404
	for <e@80x24.org>; Thu, 19 Apr 2018 18:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752984AbeDSSfW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 14:35:22 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:43153 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeDSSfV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 14:35:21 -0400
Received: by mail-vk0-f66.google.com with SMTP id v134so3771398vkd.10
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 11:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IoKB98Nt6SbzhfXznBGvDDdWFdtdkmzxX1fKBQqH/7Q=;
        b=E2+McFL+oDLKT29MeJwCqjSCFywQVLQojUC6tfNQUjjlLpa8Tkd7yDExNot36g+85D
         qSAFShKFLI7mYx89hF4ic9n2IMwXW/9pk/t5Hj6dS7vOL/UcGceAGHflQWUQ6LtZsn7h
         6Uob+uwob7w5MlK6MKvsVJRmE48xUZjEu04lXObkCUoDZoC7oHJ8lJLPH0GNJgxdy6Og
         +2pPoBStzyUh7KjSOEV0KgX6J5cgTPoWkf8d5cFWg2AIzrSySw7tjuQmEif8Gtgd6cIV
         pd6glADJZ8J/l+GffTGP6MF46TfoY195fVyoLdF3LWOzTObYL/NRNwClz6Ld9uCwn8s5
         m6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IoKB98Nt6SbzhfXznBGvDDdWFdtdkmzxX1fKBQqH/7Q=;
        b=EhYZZY7G3SsXAZXz4nysxzxL+NrUw/4t8gtmil56oydGVxqfK73uf9RnFwWRswI3Le
         TW1QG8iZHK6NSKhFmaOKnzyNmEKPfhTETqeK/X8UIVszLNdNOLb5981jZczk00wL2zA1
         vc+dzNRMaxYd1TjNdeeC6DCCaNa9N7stDXtd1NVSckeshQLuVtzL12n5ohfpBdIi9ZLV
         wZXRegDz6s6TNGBfgHaQHbGMKK3uRYFLMOjhyPK7/1pXRsdYUclsDzXw4EdrQ+XEe9g1
         lDQVxBQJ+LC6T+r97C8oDs/c76O+z5H/aTYzhlFqEIKhUyzDzxofrnzGs+XfCIbWVS9o
         VH8g==
X-Gm-Message-State: ALQs6tAL/86b/O2Ahwj8HgcUM9ir9uDyaC/frp3p5CEj2o6Acr1+nppS
        /f83naOiLnz8jaa8lGBKXul0cukfjmFymG1f0Cweqg==
X-Google-Smtp-Source: AIpwx4/OThRbFhOa57uGoEMSrsHBZ+a7/CoU/ulWVusmfU2o7pDKCy3U4Ie+ggk2HT61jdzvVWFKxdNv9DpklZrAanM=
X-Received: by 10.31.55.10 with SMTP id e10mr5135366vka.106.1524162920255;
 Thu, 19 Apr 2018 11:35:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 19 Apr 2018 11:35:19 -0700 (PDT)
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 19 Apr 2018 11:35:19 -0700
Message-ID: <CABPp-BEhfMPNEtAvdc3MsX5mWsq=YT_=rVeOzCfidJde7Mhh-Q@mail.gmail.com>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 10:57 AM, Elijah Newren <newren@gmail.com> wrote:
> This series is a reboot of the directory rename detection series that was
> merged to master and then reverted due to the final patch having a buggy
> can-skip-update check, as noted at
>   https://public-inbox.org/git/xmqqmuya43cs.fsf@gitster-ct.c.googlers.com/
> This series based on top of master.

...and merges cleanly to next but apparently has some minor conflicts
with both ds/lazy-load-trees and ps/test-chmtime-get from pu.

What's the preferred way to resolve this?  Rebase and resubmit my
series on pu, or something else?
