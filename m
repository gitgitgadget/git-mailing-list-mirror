Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192A1C3DA7A
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 06:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjAFGb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 01:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjAFGb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 01:31:56 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D3126
        for <git@vger.kernel.org>; Thu,  5 Jan 2023 22:31:54 -0800 (PST)
Date:   Fri, 06 Jan 2023 06:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nullpo.dev;
        s=protonmail3; t=1672986711; x=1673245911;
        bh=PmnNVEP5E8BuSrTC2w/hmDaO4wai0vNZ60ALEIu5lec=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=agUlD4/dDx5sL3AoPwKSfq3ixVFtRfiTHhh2AMBtLRCj96elDCARAT2f2qPzWZwh/
         NvNBi3d82JQvrmgDlLt2PBxGjPP7s7tBffMzCK8in8403leRsH6ZpLmqvgEj9hvd9w
         WKkk5BDl9Kv35SMNkHE/wpDn6/TQsZSQPTFu5Fr1G+OPRAig3yCoJnw53bgG456Aal
         rwXfdP+/ef9KA4NAKIgqJzxTyETBCjx6iFZ3fHDSmzfiJdzx4Z4VWhNa1V056w3EqW
         HzO+1q2vt+vWUNmjER9EZLPw+kXbg/qc2VcutZSvMVE2bXoTEhfpOrJwkF3hAxPY70
         ILWNjbbwlpXSQ==
To:     Junio C Hamano <gitster@pobox.com>
From:   Jacob Abel <jacobabel@nullpo.dev>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, rsbecker@nexbridge.com
Subject: Re: [PATCH v6 2/4] worktree add: refactor opt exclusion tests
Message-ID: <20230106063130.v4npgjzp6dwq2p3r@phi>
In-Reply-To: <xmqqa636mskf.fsf@gitster.g>
References: <20221104010242.11555-1-jacobabel@nullpo.dev> <20221104213401.17393-1-jacobabel@nullpo.dev> <20221110233137.10414-1-jacobabel@nullpo.dev> <20221212014003.20290-1-jacobabel@nullpo.dev> <20221220023637.29042-1-jacobabel@nullpo.dev> <20221228061539.13740-1-jacobabel@nullpo.dev> <20221228061539.13740-3-jacobabel@nullpo.dev> <xmqq5ydvpu1o.fsf@gitster.g> <20221229065142.fmfviwisjmxsey7b@phi> <xmqqa636mskf.fsf@gitster.g>
Feedback-ID: 21506737:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/12/29 03:49PM, Jacob Abel wrote:
>
> [...]
>
> So from my understanding of the situation, the only two options that pass=
 all
> the existing tests are either:
>
> A: Use the diff in [1] without the two quote example tests included.
>
> B: Revert the changes to how this was done in v5 [3].
>
> Both of these options work with me however option A will allow test autho=
rs to
> easily escape quotes if new tests needed to be added at some point in the=
 future.
>
> 1. https://lore.kernel.org/git/20221229063823.ij3jjuaar2fsayju@phi/
> 2. https://lore.kernel.org/git/xmqqsfhawwqf.fsf@gitster.g/
> 3. https://lore.kernel.org/git/20221220023637.29042-3-jacobabel@nullpo.de=
v/
> 4. https://lore.kernel.org/git/221228.868risuf5x.gmgdl@evledraar.gmail.co=
m/

Sorry to poke this but I wanted to confirm which path I should proceed with=
.
Both options are functionally complete and it'd just be a matter of choosin=
g
which version to push out for the revision.

