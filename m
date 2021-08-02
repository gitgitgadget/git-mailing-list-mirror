Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC656C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD9C860EEA
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 21:17:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhHBVRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 17:17:42 -0400
Received: from mout.gmx.net ([212.227.17.20]:33467 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231609AbhHBVRm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 17:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1627939036;
        bh=hAqKjH+Zpxd7AveVP4DJinwiyK9m3MYWp0vb/NMQODQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cfjF4i7g8tEX7FtebikgEQrjz5+8m7AM5NOlQSXeCHQER427rSByb2wcIdP2IC/y5
         NGsApglPN01QVw0AcQvubCVSJfbQA8m16vbLloYc4/a3O6rTKC6BqsYAdk483gFLjH
         QhzkKTPiZ9YxYPF7YSaClnh5qN/d1XolHFaVdv+E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.101.220] ([89.1.212.168]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBm1U-1mILLz3xt6-00C8Xk; Mon, 02
 Aug 2021 23:17:16 +0200
Date:   Mon, 2 Aug 2021 23:17:13 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain <levraiphilippeblain@gmail.com>
cc:     Ben Boeckel <mathstuf@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 0/1] Improve automatic setup of tracking for new
 branches
In-Reply-To: <7b50ebc6-7b28-412d-b124-9bd54750c922@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108022316370.55@tvgsbejvaqbjf.bet>
References: <20210728135041.501850-1-mathstuf@gmail.com> <20210729020125.746206-1-mathstuf@gmail.com> <9b8b3a12-6801-1c5d-9cfb-c87b51cd9548@gmail.com> <YQQFWtKo8b1WJIGe@erythro.dev.benboeckel.internal> <7b50ebc6-7b28-412d-b124-9bd54750c922@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/IpHmkqVAnqJiKhtQXkbP+PX3LxAYwkhAri29JwAIwGSZvaYGhS
 ZtqkoKVJUMI2UxjO7cza78yBR0Mtwlv0TVr0ukJ/zLe4xYKIuuOX26RsA7YOGiEi0GStVj+
 LGfo4r1WD0ZEhfCpNtz8cz7PPcJNUmQU1r2e5uCPdhdqgjapAU7OnkKT0oH7t8eBRXaxyOc
 ce0AN7yvLk0qtN8DOlUMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:maQVmGi38aU=:sdJO6J+1IQ0BC0iOyAMtc/
 2rOlsC4nhdAkDtXpdH+VTkKqAUUgEPEWAJxS2YtKxqetcdtz0eFMsiCjb+y84b4EAFp44b81m
 RAq4AE4cCNccQHdJnOD+GiHXBHiWK9JAcojhxsgUiRAHTeu+rcZ/YEsPEzWe2CjhkK3/O+h1T
 +w3zCQLNNDY2BUNPZxG5M783pRXF19J7FmejV4lcjkRhTJMC0jvnsXJ0rQN0IhXCyMHj5/w2I
 HC6nN/bp+d+BOfcnMeBl+UAksG2Pgs17VXlFzzI1f46JoFAolUrD0+Z94wgvb2Le9RP+FZn9M
 k2WMfIxgOmAH5sRJhgWChAxUQN1NBfziLaKTivI/MOUAJZtxECej0fJTbpKzT8XponjA0n4AU
 6oAOaCTZFIdaJjEKLJj8tXkzhPM7kAKLlMki9FTcEG6mVJTEnHri/SolY0E5bNsKUIQHOWz+E
 xWunJ5OeesRnOgqAHZUELXKGs+bwmQ32ZQQ1jHlPX4eU2BgD30VvrYBxaf12QFPw5Oaimdr/0
 MUXiw9ODVEMynHTjbTjpkpmqOKef8U2lN5FRjGCWcMeiR9ACZBTgoHc7NuCLtiL9WPU1BBJ5/
 05OeUu7rM7R4xK+0cS+B+/qeOqV3rsc8qflKzndF72i7wL0XVUQvAznklW3UHjN98a5Z3SUo2
 YWqFEFYnXtW+VmUEA8h5bmlQkrA4dGX6Bw2zN+1sfGxARTAKA7t9KkXsmED6x1WOp2an7zWRJ
 O0PikofxAbwhSGI+UunutNqJSaBDNZ0Fipv4QA2xvdek9YqsNmlPhU2nmI6PoyCIxrBx5S9E1
 XEdkvit1Kw+VQjdhDy5sW8itTKCNKh7IzsyMGv+odhEaE5zmNtl9cyoEzZcVQhg46LT7HmRiT
 P8twyjXNEVWZsmMFTWybbN6yymTgoKQqCxhmxy56JgZu8utgUtNoI3n/eLc46upvv76h0P/v/
 m+skCOKZbBgXGnQACKj/5hWXJ9NxYfH+iq0HnyvPvR4wGATRh6nMx99F7AV7bHpSafWL4D2v7
 rIKbEsiZFXTWgYGmqdXwvOJy8H6c5HjUaUFGX8Ht2xGmu3lIKy7pTi1gmLoxTN7R4eK3yIKKj
 X4o9uNcgRgHeUiGqz72tbEEPi/EK1JycSggAt2qenVQ9EIkPCmjjNlAwQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Fri, 30 Jul 2021, Philippe Blain wrote:

> Recently I've even been using only the terminal with Gitgitgadget:
> I use 'git branch --edit-description'
> to write my cover letter, and then use the 'gh' GitHub CLI to open my PR=
:
>
> $ git config --get-regexp alias.desc*
> alias.desc-title !git config branch.$(git branch --show-current).descrip=
tion |
> head -1
> alias.desc-body !git config branch.$(git branch --show-current).descript=
ion |
> tail -n+3
> $ gh pr create --title "$(git desc-title)" --body "$(git desc-body)" --h=
ead
> phil-blain:$(git branch --show-current)

I bet you could streamline this even further by defining a `gh` alias:
https://cli.github.com/manual/gh_alias_set

Ciao,
Dscho
