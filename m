Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 128601F453
	for <e@80x24.org>; Tue, 23 Oct 2018 00:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbeJWI6l (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 04:58:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46083 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbeJWI6l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 04:58:41 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so3201380edq.13
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 17:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Wg6RSGarDCO3eGOfjUcs4vryV2Jk9DDc4aPhro1jL9A=;
        b=IMu1MaXXEJpT64r8jEgh8Gqh6i8zuE9GmXvp9ARQ8vLfekC1SIrsAAywnlltygXSmj
         7fyuWXjJ2obYt+bnX8IKSELsww36zgi7bOhmgSaKWYwlrFmmpRhP1cM6ffw0ncnJECiS
         JDh9pdi4MtUdJ5AdD0pdctZzMw/zQ66/0TzGhBUHOdHJoVsPEtoe44z/cJr6qordXStF
         fkxNmo651t/04T9zuSNcSB7Wi/kV64IyNkSS6Q/kWdt/Yny1PBZUM4KN/OqwGFDCTFUq
         oxfXj+RqV2zFV3kXy5PEaxzMjObyhZMIN6TZXa3Op69dv0OMLyOWyYC1tUcHV6QaDil8
         ASZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Wg6RSGarDCO3eGOfjUcs4vryV2Jk9DDc4aPhro1jL9A=;
        b=UitEN0+2M1tROicRnEURzPBnxHTgFhq1R5DgJ+Nm/s1BdyB46bTVmFCaQ9u6hvd/wZ
         Q6pI88/n+gCKfy9WPibzFX+kMafQRPKtnO3SbYLsd5r2+TF/W1Ca58nCdOWsXOOfs5ZN
         qvhOGYP0a1FqqKyAvLzl119R1Km39UY5phkw03c5zQ75kT00fT6G6hmYocIoXwmNF7bM
         yX+9UPFTA1qnxmWwA8sBgjJPtjfrj5cPCPsjMDxRxFHnYfniCZbK4T3or792LlzF1j0s
         LdezRedN+AODsTpOgougBKyzBhsTViNEULRbXi53s9GJ+bLBs1M2nztH2hlYOc2ZRnuy
         Js9Q==
X-Gm-Message-State: ABuFfoiRdM2Hi9oSMPnYlBBbtApi5hLxdWYk34lAMfCLn4ZhvQ4SncQF
        Q7rS+e4CF1YAkcA5ExVxN2GtHJa5+oplok0jCMMgLxLXYfc=
X-Google-Smtp-Source: ACcGV60tDVMGBJ90bVVMioKsZs5Et4IMyzn/edHX7A2QLTKIMnKu8zuJASHb5bujIuNXdnTJbDKyD/35CIPqj9S6qgk=
X-Received: by 2002:a17:906:b819:: with SMTP id dv25-v6mr36293716ejb.70.1540255067720;
 Mon, 22 Oct 2018 17:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1538516853.git.steadmon@google.com> <cover.1539305180.git.steadmon@google.com>
 <70986cec32880db16568d85c351b33e9a8e16f1c.1539305180.git.steadmon@google.com>
 <CAGZ79kbuVRAceWF5cb4JAk=ss_4sEKthwxMG2wM+gLWbUdcTVQ@mail.gmail.com> <20181022225559.GD233961@google.com>
In-Reply-To: <20181022225559.GD233961@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 22 Oct 2018 17:37:36 -0700
Message-ID: <CAGZ79kbB6F9Bqx7d=9zAKSt=3Yxpm+nj=jgUA=A2P6X8v0ywMg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] protocol: advertise multiple supported versions
To:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > similar to argv_array_pushl  or would that be overengineered?

> Am I missing some other way to do this cleanly? I'll admit I'm not very
> familiar with va_lists.

Ah, you're right. By not passing pointers (and I am unfamiliar
with va_lists, too), this was a moot suggestion.
>
> Yeah, my understanding is that we don't want to assume that version
> identifiers will always be simple integers. We could get away with
> sprintf() for now, but I figured I didn't want to cause future pain
> if/when the version identifiers become complex.

Makes sense.

Stefan
