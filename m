Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B7A1FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 05:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbcHaFKy (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 01:10:54 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38698 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbcHaFKx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 01:10:53 -0400
Received: by mail-it0-f44.google.com with SMTP id g62so76776479ith.1
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 22:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zwJSVoph/hxFjm+sCFYiRRBeNFyou30953eJ7bwsWHM=;
        b=XaLSUfaB0Oura/c04EMMNhQhvaMd35Jj8ptBEMDX3v+f1m7UivFZMEYsSrlKoYPJSR
         rJFuN5rtKb951i+APOSZpEzLIA+KfDpludcXQMDOtVZBjFUb4FprhjnmY3gJejQ6roMO
         t0StsRmz/tGO1dpiz30b+dXR68d8Hp7dMvorKkvANRTbPH6q/baxrQvcwDKs7RAc/E/3
         0l1zho4YpE7CVa6R1pA/+RH/MU/cnXZIWR+1Na+4h8WA/9Q2db9Hglm7lkdjQveg/doL
         XtHVcnFtFLHFt+7yYCc8WAV6q4b4+Jzwu8klPqC/pZKzQ6SuW2VRscaF/0JmJXPKBiPG
         Tbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zwJSVoph/hxFjm+sCFYiRRBeNFyou30953eJ7bwsWHM=;
        b=kOeuvMQo+VLvqEVtG6CNNMieEb3EaNEMWQBI0aSx5lXP+oZPbHFQDfYCZXwfrEmYdN
         6MSskiOVqixF65VeNA+0rFQU6kSJg1N1msCjgYLUp+ucBE6bA+AHMOUwXklPnp+VZ30L
         o8ZsTqZBhC3Ep6QqZG5eS/YoHj+50AfgxHENIA3pSO8QdHN8VNtFqnL66qHTjAyNJEuN
         Abx9UufkNc+K7snNdLdgkMRepnZdlwT0aFFpXI+h+osiA0mMH5eJON4SXRNOB5y7itU0
         T4NztTE3KNIEC2wO5BPoYAo3p1qpD7SFhO3wjDSPMrwOIfzKxXgOa5GNmqCb9Qleuztg
         So4A==
X-Gm-Message-State: AE9vXwMLyx2TLHy521ghTiE+cJ43HODuEGinlSB2l/ys5i+Ynmc6sqogJlaYTa7D8HgjTjgAJ3x/Fk0fUVKCUZH2
X-Received: by 10.107.186.86 with SMTP id k83mr3516753iof.83.1472620252215;
 Tue, 30 Aug 2016 22:10:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 30 Aug 2016 22:10:51 -0700 (PDT)
In-Reply-To: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
References: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 30 Aug 2016 22:10:51 -0700
Message-ID: <CAGZ79kYVgCy95Pf14my_pq1qW=MB-3gF=FPf+S-VqO8k-8yf5A@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2016, #08; Wed, 24)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> * sb/submodule-clone-rr (2016-08-17) 8 commits
>  - clone: recursive and reference option triggers submodule alternates
>  - clone: implement optional references
>  - clone: clarify option_reference as required
>  - clone: factor out checking for an alternate path
>  - submodule--helper update-clone: allow multiple references
>  - submodule--helper module-clone: allow multiple references
>  - t7408: merge short tests, factor out testing method
>  - t7408: modernize style
>
>  I spotted a last-minute bug in v5, which is not a very good sign
>  (it shows that nobody is reviewing).  Any more comments?
>
>

Jacob Keller reviewed that series as announced in

https://public-inbox.org/git/CA+P7+xpE=GoFWfdzmT+k=Zku8+YjEH-aOMsFUtJJJwFHa1hKDQ@mail.gmail.com/#t

and concluded it is fine as in

https://public-inbox.org/git/CA+P7+xrokr0ZGidQFuvpN+-J_WDjkaUropcnPGVjZHafc12AnQ@mail.gmail.com/

Thanks,
Stefan
