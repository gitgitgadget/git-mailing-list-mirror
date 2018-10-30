Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E488C1F453
	for <e@80x24.org>; Tue, 30 Oct 2018 05:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbeJ3O3p (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Oct 2018 10:29:45 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:43548 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeJ3O3p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Oct 2018 10:29:45 -0400
Received: by mail-wr1-f49.google.com with SMTP id t10-v6so11091341wrn.10
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 22:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iIbelSrjlCKNnq8V/LtY2YwSgEIfqcVtO9+L0CpmjhY=;
        b=jIlGE1DKJxY0o046KIo/Ubp2ePdWO8ErpU433tr91IF1hn/DYekC/VCAst8L3zRbqc
         UVQ6P04AYdoh3w97B/h4Mb2ncl7LLHwSt7CDSbJd9eOLKZ2yDrvn85NFFUIGRDJsZVNv
         9CzaqGfXoRzXxSdISFG4/d/by2ckIpEHiArDnK+wqsTiOq+qj8tVKXQHnkJHWSAv4pUI
         7DMlRmzNKGKJSYpq/AMAWG8+iJq3RU0bibJgWiOnBYXgDn19L4kn77Atofc7VRestL6E
         nFPAl1/sP2tXQCym3NNdj3Iz4wwlkt5D5uOAUYObGcGg5MZ9F+yKdcUMhdYhEGAsFiqq
         +IxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iIbelSrjlCKNnq8V/LtY2YwSgEIfqcVtO9+L0CpmjhY=;
        b=WTPy5rKt16wIGEtX3xZ3rdLsY2rq1SW2odyETmXmKJfUIVV2fUJaRNpUaPW/aRkvys
         ae+wZakyTuBlWtFPoW5G67O3bhr8qjREe6jP7S2qoRbgnfJE6TrMEa+vtLiFXa41lH6n
         U5eYZHUCFxjWAxtejrMUm6uhe+SoSCJykDeWU19bfvnd8i1VoVaPTiNnPKakr6iX5u25
         LGOix8cyz2D5hjLSv3E4nZDB52uCjoZBRIk+nw03rvd25GoXT/TbDl4AxYf7LhAx3GhF
         unNTYzIyxG1TNm5yIGy1fImAg6pOjz96NIMUVRQiDiEP2VobgsoYvpC8v37fHSMmVtPx
         75qw==
X-Gm-Message-State: AGRZ1gIavRo7NRYCmM63nI/2oUts9kj8SPq/0nsbeFhWuTnR2daHc3C5
        /YC8ieiZzvRKEa9jL7OehWs=
X-Google-Smtp-Source: AJdET5d2M/Ke5jaDJA5SyS9V05KcleogSQLLR/uqRH2VLBXuO1WNCVSaAdrSvZWr69tpM/I/A3nWyQ==
X-Received: by 2002:adf:b245:: with SMTP id y5-v6mr16065849wra.90.1540877862489;
        Mon, 29 Oct 2018 22:37:42 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 7-v6sm3880719wrl.27.2018.10.29.22.37.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 22:37:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: js/mingw-http-ssl, was Re: What's cooking in git.git (Oct 2018, #05; Fri, 26)
References: <xmqqo9bhcf89.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810261407030.4546@tvgsbejvaqbjf.bet>
        <xmqqftwsdevm.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810291418300.4546@tvgsbejvaqbjf.bet>
        <xmqqftwo2nig.fsf@gitster-ct.c.googlers.com>
        <CAPig+cTJR4Qhqf_VVCihNW91tGt8Mbi2Oy99jzg8NmAksKoXVA@mail.gmail.com>
Date:   Tue, 30 Oct 2018 14:37:39 +0900
In-Reply-To: <CAPig+cTJR4Qhqf_VVCihNW91tGt8Mbi2Oy99jzg8NmAksKoXVA@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 29 Oct 2018 22:22:12 -0400")
Message-ID: <xmqqtvl40zbw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Oct 29, 2018 at 10:10 PM Junio C Hamano <gitster@pobox.com> wrote:
>> How's this?
>>
>>     On platforms with recent cURL library, http.sslBackend configuration
>>     variable can be used to choose different SSL backend at runtime.
>
> s/choose/& a/
>
>>     The Windows port uses this mechanism to switch between OpenSSL and
>>     Secure Channel while talking over the HTTPS protocol.

Thanks.

By the way, I am beginning to like this phrasing quite a lot.  It
encourages those with other ports like Linux and Mac to see if they
want a similar runtime switching by singling out Windows port, which
was what I wanted to achive with the original one, but I think the
updated text does so more effectively.
