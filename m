Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE0481F462
	for <e@80x24.org>; Fri, 31 May 2019 12:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfEaM6y (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 May 2019 08:58:54 -0400
Received: from mout.gmx.net ([212.227.17.21]:54523 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfEaM6x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 May 2019 08:58:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1559307527;
        bh=N9p+COkJuxZE8esQYI1CtkY4bQJAAMulsXxxr/Limv8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jEleLcLEcJsXjGDNP+PUkD0Ulrwp2htWhF4/8Hgoid9MbHTEDGIIuDwymSY+TSWKw
         JaCBXJsKhh681inSB/1QadXHQkFSmMHgKQSlji6J92gU+aGJu0saWMYpaYI4dEUSol
         F3iCQ5BkvIT4iValHMN0t0vUTiQzNOoyt/hZVe3I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1hHNC24BgG-00JpNj; Fri, 31
 May 2019 14:58:47 +0200
Date:   Fri, 31 May 2019 14:58:30 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Denton Liu <liu.denton@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] config: learn the "onbranch:" includeIf condition
In-Reply-To: <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1905311453420.44@tvgsbejvaqbjf.bet>
References: <xmqqh8a5k9bu.fsf@gitster-ct.c.googlers.com> <7b60e58ba554768fd915e4f5c00a97737707ed42.1559263024.git.liu.denton@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ELa9vMLBGYru6HEwdAQ4ArSKHfmTzEHezbidbZX70D99ykotXne
 vOJJN4Fdv2eOk7cV/cNsbpc4O7WeI8Tl+/aRxwd/s6dLNLlM0A+NLbvxxAZCPSsMJmfY+Zq
 o7VAHGRBHrRSe1fWjaxN7MUJmLs/0ivnBiwvLZ4brlTyEcpXdZUaSwlervYm5DjaAlebUQI
 lv0KOYDYfZpenF99W92hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qNxh1GdSPik=:1gYMd7XjHZ+5Gi1KQ9AKS3
 DiplVHRdjXK900godDWpJXveWQdwEj9ejOL37y/iWgnw38HmHwhfqVEwlpMsBPGqGIK8Aqq0W
 RMuHGw//BPLHrk9XxLPSRBNQeGO5cJb5oAmatMxOVPbv+A5FGYQ5tOGsEjMkncVzzreBqsIkR
 Zqjh5K5L0srjo5TEYvMjlURnKNCvB6zKIU9FDgyPNLp93oqpY4Pejw4n29m9JVziT1JiMcEWZ
 dZi/6HtoVCwCoI67Ozr4EhR32XrowZUTSCAu5geVTPi8n9u2jBQdT8M1WkBjolA9rKXNuS+6q
 6xRC09o5De7VYSldQQ5KRbCudfvpQF6RjzHZLnI+9LSzf9Exl4v8KfMy8P3p1/tGkWK6l/T7A
 Ey5oA1N5ACyDmiTl7ExK60PCkQW/giOracUdzcVTu5FZGz3jeZoMbFop3d1fJHm/cxM48uEc7
 nhmzRGZ1GYJCHBWqUHpwxnOH/pMnK+OmTscmrLx6aWjQPXRUl2OOM83SNmkVdKy4gTXbGT2+4
 NwrvGG6wqLIgJPGTPrcj6AYhU+5cHx0Go7nhrMI2dtZuxaDTSEpQZvInQWZH9nzRfo3zc3N+8
 FDXkngDbT9FjQ/7ce5XEWTx0N6mtdrxeOyONuMTtOfbPaMWUjnPITgA1vcam1Pcl3Jd77rlM6
 DXoljC4HW5xfXurbXgaem5UMTy0SUmlhzfxdaOQExv9Y20eC/9s1IwWPHpQ8V/ajqUiQU8pUj
 avJ60coUzxmc0LmAYO/2+MajH9ymjyE0KpRxnOjwd8uNIZGRY260zL658lQmX3tZWqOmODxnZ
 E4Lip82Vp2TYznJgJ9EktlDGN/fXVvYxE8gPH8sUwuwH2rIEdriIZw9jzmpIl9oVx7/Dg/zUp
 4P/v3F3SUEMrRjSjc0wxCxZNM33FWPFNIBO3RcLM4CXhCiYzsufHl0ws93K0Qmqa9IQixkBbT
 4QssZSLSm3zU49hzMjDqvFmKeDrHBq/IPDdGLyjOei+DWhJR+THOk
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 30 May 2019, Denton Liu wrote:

> Currently, if a user wishes to have individual settings per branch, they
> are required to manually keep track of the settings in their head and
> manually set the options on the command-line or change the config at
> each branch.
>
> Teach config the "onbranch:" includeIf condition so that it can
> conditionally include configuration files if the branch is checked out
> in the current worktree.

What a coincidence. I actually wished for something like this, to have
branch-specific aliases.

However, I would need this to handle patterns (via `wildmatch()`?) rather
than branch names.

> I decided to go ahead and implement the includeIf onbranch semantics for
> fun. For completeness, I'm sending it to the list but I'm not really
> sure if this should get merged, since I don't really have a use-case for
> this, especially if we go the branch-specific format-patch config route.
>
> Another thing to note is that this change doesn't completely cover all
> the use-cases that the branch-specific format-patch does. In particular,
> if I run
>
> 	$ git checkout foo
> 	$ git format-patch master..bar
>
> with the `format.bar.*`, we'd get bar-specific configs, whereas with
> `includeIf "onbranch:bar"`, we'd fail to include bar-specific configs
> and, more dangerously, we'd be including foo's configs.

I actually think that this is fine. "on branch" means that you are on the
specified branch, not that you merely mention the branch name on the
command-line (in which case there would be the ambiguity "did the user
mean `master` or `bar`?").

Ciao,
Dscho
