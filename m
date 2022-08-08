Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E357DC00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 13:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbiHHNAw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243015AbiHHNAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 09:00:09 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA99273D
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 05:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659963577;
        bh=E7IA9cUpZ/e4veEE4cPhtiBLIDvInI3toQB2YNKldwY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=KKRSAdU88yy+TdCb4BtFXqlr7IvS6ShMVd6KPkZekoAj6haZYSGC4lCldbkV0Po5/
         VDmsuewjAMGiooRCKzPt9SCmzPklYJsDk+/9i6KcnedVTAmmxowEllh3T1jd9l+I/g
         29xhYo+yfdZK8xqM+62u8kh1QAMVvmY9NBIa+4RY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.21.182.192] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOA3F-1o12em0OGP-00OZRE; Mon, 08
 Aug 2022 14:59:37 +0200
Date:   Mon, 8 Aug 2022 14:59:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pipe_command(): mark stdin descriptor as
 non-blocking
In-Reply-To: <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
Message-ID: <q341oso8-1ps6-65n6-s394-n8q433q79nr2@tzk.qr>
References: <YuikU//9OrdpKQcE@coredump.intra.peff.net> <YulFTSTbVaTwuQtt@coredump.intra.peff.net> <xmqq5yjahb8u.fsf@gitster.g> <YunxHOa2sJeEpJxd@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:amHclShsTSzOKOS5QhzbQMbRliQ5+DQ4avJTqNF7YxaknAa4uED
 UZLHu5dzj0smWia83xDifhFe8mXTP4FlqGEsewi+/uyeZOVPMP61y6JVL8eN0090L6R7DhA
 syctl6SQ1P2WnyTAI4Rb12DgutXYRx8IMvrhb2i5e77KJqHdBYpZmptmy7bZj5tneVErryl
 W9atfJRtUt7YrWHoX84mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:riaC4akl27k=:FHcKclivg6hEu8lHk1eE0d
 RZd1Hos7X5cytsqpZi+fPx7XEjvk9o8Abkud+7BEvkulWi7IzvH7ddVo5ng+MUsRbmI9jZOrn
 qrA6VNEi5WYMuG8CKSAI6XeHyknS1MA8qnWaR3QoA6aUAsDfaBH7dowpA9pSl/NL8eCaHU9bS
 GQluxlbUZVURDkR/8NH20AvrJtGss/phoKKpFHaspKszYuCGbaaTz4qyIkkaZX1+m9HPFJhQR
 0cyWrx6v5+lhZBMPVx0Wn0OAoR8eUNU852Agc0tFGRfweaJnRE2b8ZNmjVjmZQLpIn/RXBR9G
 XqVnjLAgJbzznog1zqEEKw4wMQk2cdZteW+UPUiEiitzSvb/K4Vu+b+BbpUyJaWCeiyMNIfCl
 wSNtcDDRernJmcL3AVn8HGEplqIdSOcoa7xHLcG0x6HzmU6nyUyvgooHS3dh5C+twAHOv2DOv
 h8oirOwcCe9oJB04alw1PfBBF6360txc0B4wQmQRG14izpuBDxJqr2WYoZfdj5XzzQBFMiqz+
 s7SHWDG1oD3YrSsXCQYAjnLMu0nLSQu8sYVL6SiKrXS22BrkQ8LixUluaFkAW5CIvpECGLt48
 pJ3rDgHcqfLkTkOugRyhfQx8Dzef0kB9XIcAiUNl9jExOeAqiEaH/3YsfE+abNOYFIM1CiUe5
 8nkCs0MzJfjKegCcOSF9/LtHNacYrh6eSER2Jx8yQD0tQcVIl/pipOCG/FLhjYAHWAIBMexK1
 7KgvIl3TAcZP2Nk6lx/8E6wVC4NL0EuL3rMqK7EnVvol4Kbc/zHQhuY8tMLsOLpsHXXpXsiWz
 IpHVWfB+IMRqgs+ZPJqxv8/atuDxxC1Sjt4yeONXGH/iXhtuscvJkZEuPkBy3hPq7bx9SR6Cf
 3UECt7anLOepTJRNhtfVxNDQs7ZpDHw9XcHHPvkkz0se3yRn9LjoQRjRT9C6l30smkvavRUZ6
 nzMFfHaWsLK0IHXMFQNOg/NKSmuXHOZLj8OQqbRiOmDNRGh2IoEqRS0xt+rzWA9Ah6pEMikmV
 /bTBLlMRwZBzynGdEHBzQ5WFS3kFBAFREge6VsWIAEgb0F5O0qzblNwq5dNBt9FpmU8xclfmm
 TE9vDx2HmX9FGM6EmlqelLmJvu7JI6sv+Z6tU7JcwKYD2JV/GzVlGoHeQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Tue, 2 Aug 2022, Jeff King wrote:

> diff --git a/run-command.c b/run-command.c
> index 14f17830f5..ed99503b22 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1438,6 +1439,15 @@ int pipe_command(struct child_process *cmd,
>  		return -1;
>
>  	if (in) {
> +		if (enable_nonblock(cmd->in) < 0) {
> +			error_errno("unable to make pipe non-blocking");

It might be a bit heavy-handed to error out in this case, as it usually
does not cause problems. At least that's what the fact suggests to me that
I personally never encountered the dead-lock myself, and neither do I
recall anybody piping more than two megabytes through `git checkout -p`.

Could we turn this into `warning_errno()` and avoid reporting an error
here? We could add "; This might hang the process if large amounts of data
are piped to/from <cmd>" to improve the user experience.

Ciao,
Dscho

> +			close(cmd->in);
> +			if (out)
> +				close(cmd->out);
> +			if (err)
> +				close(cmd->err);
> +			return -1;
> +		}
>  		io[nr].fd =3D cmd->in;
>  		io[nr].type =3D POLLOUT;
>  		io[nr].u.out.buf =3D in;
