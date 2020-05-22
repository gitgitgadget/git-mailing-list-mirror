Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C5C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F6D2065F
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="SnIGeUtW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgEVNQR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 09:16:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:33265 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgEVNQP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 09:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590153364;
        bh=53Jes70VBXevwed0VFFT9hWFlNkBX4n89ThNDQBbwAI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SnIGeUtWcmAv/RXpIxczei9wWrcqJLJIPaiQKYl1Ej66mW+EPQXAZjse+35C3s/o6
         ZSDIsdjOHQ0bIB9egSCDyba6UuU1OV2tjKh/O44GVI4uTJnvbc5I/FoIFmbTqdTlLd
         8lSWDjjWTAblKbMT3kLLMcUx1CoO4rfm/x7Cg7TE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([213.196.213.226]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBlxM-1jm4EK09ro-00CAjs; Fri, 22
 May 2020 15:16:04 +0200
Date:   Fri, 22 May 2020 15:16:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/12] bisect--helper: use '-res' in 'cmd_bisect__helper'
 return
In-Reply-To: <20200423070704.39872-3-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005221515430.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-3-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gceY3QJJ04kJnPRGPS8TE5G9/6DixM3UhFuMs9iYHBXmtl7VnGE
 lWCqHRFwsZbqJXSiPgN6RfBDENIvgFGHF1mlkNOAiiVYAmuSnj7E8J4qjJ4BA0uwKyIqp1H
 F5E8qCNqsH5WrkINSvIeI/LG9j+y7ZOQ+8CBIz3xQXnKAcQgxO1gj008xxQXjwORzOozM+d
 xGNMDVsOO15qxehdjRQGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oTy3OrES8PM=:RlyavRcBYkVnUiJlv8544B
 sPDdgTF6JKaEI6myPZWWazPbCy/kA50cptsi13i/pL4KTGHzU8zrgHIxLDFjUnaut/yEE9fVA
 L9OYnXvgg2wUR+Gxk2uadgYjLirK0IlPun4Jj+v3UE6OkEa4Ch9BYB+UKUszQugU7MtcTvLpn
 mnR/wZvYWp4k0/8ym/A/m8FcD1i4GSEqvi1K6cWqCkjry8T7LnZDBvTcc1lyaAxZ5wzrPcHkF
 QOJ+l78Vf6WMm0BqVmugDbK2yZ9ZKVSDvrWjOyk6wYigJzIR8R6Mz+gdK8g3FoZggj1KbHHEM
 qU8avMLn3VhezntvvnN5qKo0XqyELI69MgXKuZ85JG59qXyiJUyd3WwD65BFXVYMhIyI31GJp
 qHR2nXQNgZHS1PbZYtYP72cREGzDG6vbM241G8t6LXcLa30HQYkSxe5EKUuWDc1mUO3rmWrYS
 4d2e+xbw2DViG7xtrJJwLV316acebOOWbeslWLlkctvCrFhEpu8xzbDJ6dA+7qfWB1Edy3lfC
 tG437XeqJ908lvgoK0c/eEsgyzkOZCTGaH7+XGc/s4QeuqCdT7xCB+JPpEVHjAxkFdPG+Rg9U
 KQeDq2QD9zXppa7llM4d10A7fhTuIaVvae0PwUyel/Trcb1g3uf1ZCAhhIWwUDawCeeHg6zvm
 dtRffepfD7MSci4tg0gXQJykLszL76bzywI1xTw+UqDfkF4U7DQFcpJjX46y0/6Lk4lbYjSVF
 SdhJhFFqGIgmlIeVo7W56g1io67ZAbuiekW4Bu2RdWzM+gybtJtrog3zNy6Y7UTvLdwYJLtNj
 J5btkjXfC3wQi4eQCa6WklEQ2kkZqg3z5ZeUvr1kfQZEhBevaW9EnQyVeal4+I7r/+jmwaQxM
 fsZTCVeXGbAOtDlxz5ddLRf9M/LXHked0D08CEox0xYNakNO1ArsNoV4oJLw5siPJ5s+oQ82o
 ez1nTZbnbQ+IUEDSi//BYgaTI4UoUneh0CoQ3Jhx6mX/WrOCrCITU26BC79cfty1NspCswdrD
 qz1W7f+ebo3QzgjoAqsKL89Lkg+LmJuQELiDpkQxWP1OcDTud1/70hwVifp+1CJ2A3ByCPhOL
 tWTxDvHRzDV9/0X9LAOUXnCW16dcgIoWMHRAVksJRVAHL0Ukh087l4L5wgOyKTqWVBS8e3DzK
 WfHUdAi9//THnAW+2/8omAWjTI6lusEuxoihnNd5mtsGqm7BnC+TWo+QJAjAV0hrB1fcxn0Wv
 d/0vCkrtb10wWzhf+
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

> Following 'enum bisect_error' vocabulary, return variable 'res' is
> always non-positive.
> Let's use '-res' instead of 'abs(res)' to make the code clearer.

I agree with this reasoning, and with the patch.

Thank you,
Dscho

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/bisect--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index a81a2c76ff..0fbd924aac 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -722,5 +722,5 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  	if (res =3D=3D BISECT_INTERNAL_SUCCESS_MERGE_BASE)
>  		res =3D BISECT_OK;
>
> -	return abs(res);
> +	return -res;
>  }
> --
> 2.25.0
>
>
