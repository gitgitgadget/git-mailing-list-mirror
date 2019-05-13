Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4889B1F461
	for <e@80x24.org>; Mon, 13 May 2019 21:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfEMVOB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 17:14:01 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43508 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfEMVOB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 17:14:01 -0400
Received: by mail-ed1-f68.google.com with SMTP id w33so19547275edb.10
        for <git@vger.kernel.org>; Mon, 13 May 2019 14:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=G7G+6S89S6xT4oVsLJX4lEA9ZGOvq5sWSHsZcMyy4gQ=;
        b=kKRzj07OHZ6VsdK1AeC/z0Ix6FZEwpe9cN1ejs9TO5ssrN4YPjHu4zPDDiuMb6UPBo
         e6fCsq0WOyEHcIZFjbUrwld/HFYFAYYxPxweIvFouBOsfi6XQ1HKHkytF/8Xld8HUslX
         EWw8mIPs5M6g2DXuGk8Le5ccpLMG3TX4KbfqOPtPFcyJGJVCodvkWaiGwozHWmbiO7Uf
         nSKuoRv7bcheUC/r8aMAEHRAM7srPjdickFbBA2uFWCLbK/JLNhqST1x3DlM9o/T1YAu
         WpR48bdNc2+NoBezAFaTy3dxGNQ6z9Z2zm0voX3zbo5EooSAV0HjaNTKRzBBR292I1Fw
         Wr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=G7G+6S89S6xT4oVsLJX4lEA9ZGOvq5sWSHsZcMyy4gQ=;
        b=l+NSQR52WBtiYdqkZsxP7kCYLjptfGXDsmtKPl/wqQGOTKB3GPjCLQfuYJSHRycBQg
         XKc4b/kNPL6Fo1IbvFEJQdx4Ni7PsUCy3StVxilCQCHTDV0SCU6Z7vd4+qI4ij9fjx8O
         Twqp32G6u3yC2DpyDiwG6yZFe/QQC///XxRdmNptui5Pu93bi6fHfsj7rGFDg6EhLSGm
         kbYplH2iQtYkGUGPNoHwpapmbh2RUjMN97Pl0ouMgkK/bU2WWcBCvEsCXD4s+/mcWqRT
         otDtsykj/gfL/vJTHbAZP2wOzb9aD8aGW2VAnhCeJCtVfED5HT+WAbEMhdvGY+NW5CJz
         8iPg==
X-Gm-Message-State: APjAAAWmf8DrxBLEBo17q6sVWKuyr80jpDc9U3//sKf8v//LGGtiLi4w
        xVw0M7lEZKX1tuflc8CmReQ=
X-Google-Smtp-Source: APXvYqxI13+0Xeb1ok88/A5/UAghRaZyJE3TG8UBmEpyJSPRpz7r5VEF6NWrq/SRtmtyRwNl8PD5Ww==
X-Received: by 2002:a50:9490:: with SMTP id s16mr32267079eda.260.1557782039566;
        Mon, 13 May 2019 14:13:59 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id k57sm4020301ede.17.2019.05.13.14.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 May 2019 14:13:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/3] send-email: do defaults -> config -> getopt in that order
References: <20190508105607.178244-1-gitster@pobox.com> <20190509114830.29647-4-avarab@gmail.com> <xmqqmujqbuw4.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <xmqqmujqbuw4.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 13 May 2019 23:13:57 +0200
Message-ID: <87r292vyzu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 13 2019, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>>  # Variables we fill in automatically, or via prompting:
>> -my (@to,$no_to,@initial_to,@cc,$no_cc,@initial_cc,@initial_bcc,$no_bcc,=
@xh,
>> +my (@to,@cc,,@xh,$envelope_sender,
>
> ,,???

Just a typo. I see you fixed this and the other issues noted in your
push-out to "next", thanks! Sorry about not getting to this before that.
