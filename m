Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7398A1F453
	for <e@80x24.org>; Thu, 18 Oct 2018 02:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeJRKCQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 06:02:16 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43310 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbeJRKCP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 06:02:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id n1-v6so31773717wrt.10
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uSA/RzbGE01QcNz2Jvk+VnbJNJOAV4gooh4VLJncbJM=;
        b=WTfSyzbyR2stFyb5yvoe4GZ3VYRObNj8wVAqOk/mI07pTupYIXeY454HGaUcyOrKlH
         Msla4KQT1kpZxuuQoZhRRzGQbLMvTr9KJbjZgYi0DK0q4H4BhgkqmGh2o4KW3BnL/FGN
         HGkLllVeorDAZJjRg5uuKwhTwXNCVmYqlPl6i0UWyjPuuUj+RXUMfQLh+OLZkgU4weSk
         UBj88Vk7MWyz2vdhtOcGhLa4ftOyF2tMH6lcdaswN9sLlFOQbuDGrnYTziwAsCSOmDCc
         4wJtQ9T1ry7RQmGG6y2c/N75ZbJ3Y8OulsE76f0LnrcBzylLRsZDdrG/2jSypuxU+ZSw
         2k4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=uSA/RzbGE01QcNz2Jvk+VnbJNJOAV4gooh4VLJncbJM=;
        b=XSZHOX7ePuaM2c9lBCJ99qNGIDSxWwewh0Epmw8U/MlwEV21PQZ2ZvDUK4wEQlWnoo
         D5H8Uh4lxnjVQve5vEY9/yO2K8QCW/eDbMLGPAt5SpMtfAcBg7vkCzYmrYyvClKw7Y6V
         xG045VRx0K+HhWtIXhTzjDV62Qk6nQwnXTNR+B93T6p7F0pNDFd8U1qA2hUCXqCfpGa7
         0X8RshmKvFZFX857EElNhayQ0ISgJtc/UYj/q+q9CqYZNyyTrSMFaVmX2oAhGpfJYNv3
         PrG9fqqPTLU9BVMj0IW2WJ0nUrbFa7VfQQz7m0tO8mkKFxh1tEFGTl0KiW02O93MCcTh
         el/A==
X-Gm-Message-State: ABuFfojx29CeA45arS/zwQo4ks4fTohX6SZBDWrpVqQuGHHEqGpOGNUF
        Ktuj27v0ExZLxsV0mA2drSDn3+mWYZE=
X-Google-Smtp-Source: ACcGV63VpFAVauGuUr8dX0/yoTkkBksgIrReKMMwI7+goov+dmPYF7vTML6a3Zf4a4J+so8wZWua+w==
X-Received: by 2002:adf:db8e:: with SMTP id u14-v6mr27205623wri.217.1539828220747;
        Wed, 17 Oct 2018 19:03:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s7-v6sm1300146wmd.0.2018.10.17.19.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 19:03:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team Services
References: <pull.31.git.gitgitgadget@gmail.com>
        <8736t7dzan.fsf@evledraar.gmail.com>
        <CACsJy8DeA0Zko4+ZM5F2L6YO5rpvL9LX3H9NB_bVCyO2mJFUzg@mail.gmail.com>
        <CAP8UFD3cpXpyx-AtTybPirzduFR7TfhFf2woa-_CU46DN3RaXw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1810152032140.4546@tvgsbejvaqbjf.bet>
        <xmqqd0sa1omm.fsf@gitster-ct.c.googlers.com>
        <CACBZZX59vT1CTiUPfPZDJUSRH=NSzmWiabux=KRdTUFa1R=5bw@mail.gmail.com>
Date:   Thu, 18 Oct 2018 11:03:38 +0900
In-Reply-To: <CACBZZX59vT1CTiUPfPZDJUSRH=NSzmWiabux=KRdTUFa1R=5bw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 16 Oct
 2018 11:14:06
        +0200")
Message-ID: <xmqqo9bsvwn9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> sites could do the same polling and mirroring.  I am just too lazy
>> to open a new account at yet another hosting site to add that for
>> loop, but I may choose to when I am absolutely bored and nothing
>> else to do ;-).
>
> Do you mind if I squat gitlab.com/git/git in the meantime (i.e. create
> an org etc.) and have it mirror github.com/git/git?, I'll hand the

Obviously somebody who is not even interested in obtaining an
account would appreciate, not just "would not mind", if a trusted
member in the community did that for the community ;-)

Thanks.
