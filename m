Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B697A20248
	for <e@80x24.org>; Mon, 15 Apr 2019 13:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbfDONJ6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 09:09:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:33931 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfDONJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 09:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1555333791;
        bh=jKkaYZFlBJZ6Yv8nj8SLJIjxwX3C6O4CU6aOMIuJSys=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FuadStDANb0RbBAm3mCoMoSfwgY6UAZg4R1PRB6I71tTdiag2g3KjuZVC8+9TRtSZ
         XPt9823tGAs04t6i2Jbq2fjPpCwmjQ1DfvkPDT68RLYsQzwJ4Xd42HDpjunYp5HezI
         z/OthlSFjeEDcaRT/4R0tmHJ8cKFj3LiFfwSWU4Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MHoC5-1hHPTW20Cr-003eoM; Mon, 15
 Apr 2019 15:09:51 +0200
Date:   Mon, 15 Apr 2019 15:09:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 8/8] tests: disallow the use of abbreviated options
 (by default)
In-Reply-To: <xmqqy34cugdj.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904151509020.44@tvgsbejvaqbjf.bet>
References: <pull.167.git.gitgitgadget@gmail.com> <pull.167.v2.git.gitgitgadget@gmail.com> <a27d316855a833aa1726fc20c905dc40e41adf2f.1555061837.git.gitgitgadget@gmail.com> <xmqqv9zhwbxt.fsf@gitster-ct.c.googlers.com>
 <xmqqy34cugdj.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1HMCgZ2i6vgIRQi3cfHni3zeKCAm6bvfL+qdcnJbrUQUPWdz7JU
 qHLllZF4Xi3Q00C3fcBJocbfo+OQhNNTkTDvczya2qkko5yPKlz0a8DAbNNJwQzUvdK7eLL
 tU0/wukU5GplUSzyb9DZ7Z5XM1R+HxjC5RrFjpWHoOHF8YfktC8SsEc0bMVUdI7YSW0FE+l
 v3IrwUADIBFgCIDxihqJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xAqIdn/Blmc=:aKBJsvz4sE8ntsM6rZ5ChQ
 a8pkuh1EUvSH4Dfce1+aFA0r0xQHCKnEwOts6taPSesmg19l6XSEurL6RhegkvuqwFRY52BNK
 A6rJlPQluB1oetK/4rZDs8pk+Rsb+tkNbnhEr/1CWi4ZlXBbxJsevD9GknkY5A5DBsnmylV03
 wvx8hri6YZeHsnuZTklxbBN9+UoDOgVysjijDrAGYFB8BRsxa0JCqqwq3f8gedv8JmN5KkNDv
 t63zHvmXI6Shr9qsbVBpMQ8Dx+9VB5WJcUR5zmam/bwGP4222OTiwmWn0nuBmurPZC4eBHOKR
 A6pnJEtfAJzqcMk0dJ1VBjDNiCmV8CiljPOADkyZqEuM33pLbu/wKxAhBBkxq1atv0dta/F9L
 06GlYf4INzAj12WOYlQESJrZXdSSOsTUDoB5VarQ5a/4FQDOGJIzloIfup4SbFaPM3qdJ8htF
 hGgdPy3ygoW9nQR+TpeP89qiQvb2xs8AOvp9ACPXsEVZpE/2iyhZMVWsXQ8pTRxf9uaxrJr30
 DJD9EtLE8rkrfA13srDrnCL0VlSWuGUpgKHBE0gjWMJxN7ZDR4o7yOND/+QQljcXUv6hdmntW
 hHWXIR7nxJQszyxrUlEPZ+S1aWq7vgAhWKnZdq3t/pkaRj567p+M4mTOdTFmsYP4ebrx3YE8W
 UNpTwhgxQ8cnVnPvL8lwNzeYT5l/g4C8xzK7JnfE6dl2SPV0hBxjCPenLR658uIqcfkdi8y2H
 CbihrhYiOjdiVCLfTIuxioiATxO4L/EWIJpRNoFrckenyjANEfMFDOSiOTyf7tQvmqMfvgaBg
 4aRH8IzpkziKH3JqDQ7o6M4Cj9x/hvpuBK5Q4L0QAG+0zeE8wMOUYpiomzIFOHIn9swfuffka
 YdymHXWPAlZLg5vtpMc7WdD5FkMFaJ1FMlqIb4hqgrQLBs9zhwvkOTOODUhcaA7rgMthwKF/W
 h1lxDS3z4Rw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 15 Apr 2019, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>
> > Do you mean more like
> > ...
> > I think I can agree with either of the two positions...
>
> I am guessing from the earlier iteration that you wanted to say
> "unless it is given explicitly, we turn it on".
>
> As this last-minute style update that was botched, and a typofix in
> the proposed log message in 8/8, are the only differences, let me
> locally fix 8/8 up and replace it.

Sure. I still would like the `isset` thing, as it makes things more
consistent, but I'll not fight for it.

Ciao,
Dscho
