Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA29B1FDEA
	for <e@80x24.org>; Tue,  9 May 2017 14:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754399AbdEIOYx (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 10:24:53 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35736 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754223AbdEIOYv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 10:24:51 -0400
Received: by mail-pg0-f65.google.com with SMTP id i63so110632pgd.2
        for <git@vger.kernel.org>; Tue, 09 May 2017 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iqT8Trm4huEUeAdAjkr4JOt8vOaqIcMdasDClFxMajE=;
        b=QBZ/vRnZ1hxgiBZoyRVvetL3jQjyI00dJA8zys+PNEK9zHbWmG1wFqj82w8IvwoIgu
         ZA7guNQnJP39K9TGA1i9pyNyikoovHmMM5KAsgRa6CN8Z0/LUJ5s5t26JEqBwzThVjDo
         Jp3n1oo/yH5fjdp/5o8ssbfEYXdHqV2ENbE19BxPrQAcqa3imR8Vfw4jY3dlZKoW33xB
         I8HhjdiRq9n865F0vO7QcHbeu2b/m2Y/8128vUtzhk5nLCG8qx49JJa6iNfd8aHWRxck
         Dd5M9joRenxAl1iqrw55SlyofDxX/FBCzsMuTkiwuCv/XaW6ZI9uK2p0gRbC9fqheC2e
         UqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iqT8Trm4huEUeAdAjkr4JOt8vOaqIcMdasDClFxMajE=;
        b=BP+14OBirxqbRFcHc/xdY5QADFqNZGUAGqgNFn/iccsYScD9gJGenOEEYZuNjh0noV
         f0TrL4c587OsovSac7WVUPy9aQqjDcerxAQQofKwSruF7ZLIdL/5sCenXh4e0kqoQbQJ
         Y8dfE8dljJCEUVGyWDl+AypYW6hWRYpdEclUrlNqgOHuHvN0kqdQ5BXPmcFyWWmh6JAR
         GthrM6d+es7hUs0cctUnger+N4vpYlEVtzCETIc5Tot29nEhWxPAgGaoptZwOye6Qcjv
         Afyq6VOodH3jMwFDnvtXAp7LeYFtgACaVstTD8+111OoNNHAYwWsDgDirHCSgkcpKh1d
         KH+g==
X-Gm-Message-State: AODbwcALS+e5H8AEfDwiLOzhjvq21/FfLycj/35UUJRulLaUuLt5VQP/
        pbdy5Lx3aI2cGw==
X-Received: by 10.99.60.21 with SMTP id j21mr395506pga.99.1494339885570;
        Tue, 09 May 2017 07:24:45 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id z3sm340731pfk.99.2017.05.09.07.24.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 May 2017 07:24:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Ray Chen <oldsharp@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?utf-8?B?VHLhuqduIE5n4buNYyBRdcOi?= =?utf-8?B?bg==?= 
        <vnwildman@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [GIT PULL] l10n updates for 2.13.0 round 2.1
References: <CANYiYbEr1rcV+SjrnSM3Wdv7zz_vR8MgwqH_KSxEYqeMx3VnkA@mail.gmail.com>
Date:   Tue, 09 May 2017 23:24:44 +0900
In-Reply-To: <CANYiYbEr1rcV+SjrnSM3Wdv7zz_vR8MgwqH_KSxEYqeMx3VnkA@mail.gmail.com>
        (Jiang Xin's message of "Tue, 9 May 2017 22:21:19 +0800")
Message-ID: <xmqqziem151v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> Merged another l10n contribution, please pull the new tag
> l10n-2.13.0-rnd2.1 (old tag is deleted):

Yeah, I see our mails crossed.  Will pull.

Thanks!
