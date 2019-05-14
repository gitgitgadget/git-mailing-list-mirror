Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0C621F461
	for <e@80x24.org>; Tue, 14 May 2019 12:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfENM5Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 08:57:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:48961 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfENM5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 08:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557838637;
        bh=1/yKzp1VvLNy01hRFutPbfg4tPFnZg7VfPkQ9Adpwug=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Lh+hVTJdHvjbiFZv+HNjzOb8HoUTJAfH5H1bYay0C7Y1TsoNRbwlXXCTccnd4pylr
         0qA7zkFYlcnYrQ3K5t/asP8LUw+0bbh0Ogx8MSZZAyFg9jJaNbsx/Xmf5YIkY2kqg+
         d/0sXtxNVJJaIRY6fqmumbC9VNZG826zbio1dDb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCwbX-1hZ1Ac2zLf-009l8D; Tue, 14
 May 2019 14:57:17 +0200
Date:   Tue, 14 May 2019 14:57:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
In-Reply-To: <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet>
References: <pull.192.git.gitgitgadget@gmail.com> <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com> <xmqqo9469buw.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7qmhlVpWWUtfDuUynMhXy8tos6B/RMC8+3mRtZtBIf30QKNIcPr
 5j+CZAc66FLQ++bnaQUYpXeUMjdmY0NVfxGrDweArS5bHsUX/g5ozE9D7lwcYPjg+aUNXwi
 JvW8hOWMPrdgSUzgqoUDiaeg/k5tMQgxv5K+JW3Ml5LdACOIaMO6KTXuT30sJq+okcyoI4T
 HrM0sAVvsfzjuNsuG4YgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/+DxVix2bAI=:eLc+pxzVlvwBVcdJlJ1d5m
 FXKnP+JfB8yf7rarOy6twsUIHgIpvStiVrxquJmgYWvBAe6xtdnqwCBPgWx+GVljgrkNrAdtJ
 9/wBKd+oovdpWSsNgUba5sEFLm/CGI44D4bgLwNvWRa8+lr7uijfE0xWi30EjInPhakZvxQXk
 iShqGhuzokU2Gheee4SoxEpoEXHavg/ExMyl6xUdr3V7vIgl+LlV/+EailxlArZqdR6s3S+HM
 vd+HWA9zhCZ4EF9Sirek/CqAsT7bDQlZAQj8rMRlZNyjpkXGmvmm1DSN2S5/4l3M0d5HFzkEK
 GdsW/GvrhBlG3hA1wdkfCyJUJ11EQzQODQ5xcWU1depPs62ugJZRPYZwUOm5oYNoR9vQW+8j1
 HpWY2SdTKCnfuBG+D/XJUUg0AjGc/cg0SYkbAdoU35sr4SfMaexYab0SUldupKGwef0BPjZLi
 WHZV03exBLqkxxHWjIJX3PUy5CLwYd2qhXZUbbMZ/+Jmsf+2up+Rz6lncJXDrqUE/H5rUk+rE
 zaxvXitXV1K2Sgu3mr4TVNyn2tFnnZs55I0PjZeLTR66RksWRYuWcj2ZtAHOHFli2a7axhbG3
 Xm2Gf4hq8QrbEI2aIEIs9dLN7+kJUE2db8DSb9lbKiesIILPKHdkA/SIS4J9w72DrEuNlOdQ3
 epuIbwNFwQTbNchoSHRWkkxCL4/onVHSiMpucmInqa0cgdXNnRtW3Vfe0nsNStVqxXN81vyWc
 mMXT3uHSNAh3JUyh8rz/n+Jaa2DLn1NZ+GPjhRuLZ5kYl1cl0NNpurtv6s5NYDGqYuSdn8655
 RPAaN/Bb2itIHC10LPVitKXOI2JxePBQRT6MWQG1lh4LlBs0+U+M7b6sjuS2VBDPu0PWahDzZ
 sjrPJKDqFDqkKw8DlHZfTkz/mlVPGtWXBDsPjP7wt+Z30Pbh18PwkcCr4aK1J6o18WbjYY3mB
 UtztzaSzoRA==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 14 May 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When this function was changed in a97d00799a19 (remote-curl: use
> > post_rpc() for protocol v2 also, 2019-02-21) from file-local to global=
,
> > the declaration was incorrectly missing the `const` qualifier.
>
> I do not quite get it.  Back when the function was file-scope
> static, it did not even have a separate declaration, and the
> definition the said commit added looks correct to me.

Right, I should have said "the new declaration" instead of "the
declaration".

> Having "const int size" parameter in the definition of a function
> does help the compilers and the developers by making sure any
> earlier reference to the parameter in the function would not modify
> it and cause later reference to obtain a different value.
>
> But the parameter treated as a constant without getting modified
> during the invocation of the function is an implementation detail of
> the function; there is no point exposing that implementation detail
> to its callers.  It does not even help the compilers handling the
> caller's compilation unit---the parameter is passed by value, so the
> caller knows that the callee would not modify it without "const"
> there.
>
> Does the language even allow flagging "const int in the definition,
> int in the declaration" as a warning-worthy discrepancy?

Apparently it does, as MS Visual C does issue a warning (and with `/Wall`,
it fails).

In any case, I don't think that it makes sense to have a function
declaration whose signature differs from the definition's.

Ciao,
Dscho

> > -void set_packet_header(char *buf, int size);
> > +void set_packet_header(char *buf, const int size);
>
