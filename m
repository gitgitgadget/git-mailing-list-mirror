Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EE5C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 14:03:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3711E64F53
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 14:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhBDODg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 09:03:36 -0500
Received: from mout.gmx.net ([212.227.17.22]:36055 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236571AbhBDOBx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 09:01:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612447209;
        bh=dtNlXQZnhb7mnLY5TTsGS7N+58XrFO2+IkaZq27cpPc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DR7yveZRj5SCB9ZB/928cMTAyq71uf24k2O2wgug61jvag6kDUY8RP8978/1XEdfc
         y03RWSGrdZm9LL9ibTSr2/0BTomcbFH9YwVMUSc6OnPB3JnG2rcwwlS12XVr43C+l1
         82jvZ7OznHdVflxrMLVyA6ctSyQPOC2lmsq7kJAI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5VD8-1lzqQF0O6c-016uq7; Thu, 04
 Feb 2021 15:00:09 +0100
Date:   Thu, 4 Feb 2021 15:00:13 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Li Linchao via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Li Linchao <lilinchao@oschina.cn>,
        lilinchao <lilinchao@oschina.cn>
Subject: Re: [PATCH] builtin/clone.c: add --no-shallow option
In-Reply-To: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2102041458410.54@tvgsbejvaqbjf.bet>
References: <pull.865.git.1612409491842.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:LMD72WhqHlXg7wFzyKmLUMa+qHiZr1eRZAVjssywGvqhUiNSoRy
 oTSVTX9YE6x59k8SVeRVviA2BnUor0Xk/zNvnkebDCbUMNLnGXdubVlTUcACDC8zZ/uzIE8
 vpts2/ElopaGvPgnRz3/E/WoDbT9PZQN6wl+ilLvegdSRkQlQ9t97vEuu//p3N1uRyGBkcj
 +27i8Ar6p0XZINfC8hTdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0TNKo9kmB4=:JdqR4GsLS50L7JMtUANyEX
 LxdqmNp43pbA1DdbxS4gIo0PnIN2saPWKt/O2EyihP46nx1dc4qNv2JSXS2ZPAdqoSd39zoES
 +/fCxi8CpQ7cKmyqDShf2pczF54c++lzd2GifMd+jB8mnYvorEv2bmAiJzJ5TKlkhSaO7NnIW
 95Skv5f4EdkwV7rSl1UKKz406mfpYxp/Tjti6aT5oq+PNgNolF70+2s5+WhPerWmjDOqFETDU
 jk37LWaAVd+awgrnfTVgDZ6lKI2gopzOOHDzq5eDLh7jUUjgEAi7WkWt7kDLzP5tuGfxQmMEf
 F4LpOlFvzLzeBX63KRrP8BQPCJrR+sTr/uzMLVgBsjayEDVi7Or6k7yCOMo/pquFTEcsqhTWx
 cHE1KF+5dqf8C1/3KQfTlpRXFn/0jESPLzHTuxuD2vFoHNTqsY7iBbahUhiGELieqvs7v9+Zs
 ys9XNEsKrYym/1s7sDPTN3b8OXFnDJhApvfWsRpOVpxz8dT34LqIMjRVjYdSUXZuBsti2xRvE
 y7Wi/gOoLsIheWuq1d9IfLvlBmXFGsAzyPs4ug4XvkiXR0ACeH80IheWteYTQHLe5/rWiBwvK
 o3EbKZ5tXX3vQeGkD27TXiIrzjvCpZO/4fu8rNp/8n66qf8VgWbjGl6rBJuzZr7lmS7sg6S3E
 hP3CqV2RGpb/KMdwLkL0eRkJSyFTCZJL41tk3aKAdTJBqWko9TMdwYBqgz8vsj1WKDQnyezGP
 f4/+u18yqX+GRlqpgBFFMw4QmxrlzYN5D54kZrJuk2hpbVC5GDiAGrQM+mx9W2tNRdWQiFYhv
 txwI0teDQJ88Le2LvNn7YbTpRT/TUM8nDlawPZlktCy3ZwRSSosV5lqrlYQzkHmb7LUfZN194
 amn9pJkMiIa1WGmMCOWYAut+iWACrJs7NJK/ys/Xs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

in addition to what Junio said:

On Thu, 4 Feb 2021, Li Linchao via GitGitGadget wrote:

> diff --git a/builtin/clone.c b/builtin/clone.c
> index e335734b4cfd..b07d867e6641
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -858,6 +860,9 @@ static int git_clone_config(const char *k, const char *v, void *cb)
>  		free(remote_name);
>  		remote_name = xstrdup(v);
>  	}
> +	if (!strcmp(k, "clone.rejectshallow")) {
> +		option_no_shallow = 1;

This needs to use `git_config_bool(k, v)` to allow for
`clone.rejectShallow = false`.

Ciao,
Dscho
