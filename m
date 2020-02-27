Return-Path: <SRS0=G+lC=4P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FD5C11D3D
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285512469F
	for <git@archiver.kernel.org>; Thu, 27 Feb 2020 17:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVl2u77E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgB0RiV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:38:21 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61881 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgB0RiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Feb 2020 12:38:21 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20775C01B7;
        Thu, 27 Feb 2020 12:38:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Nt6Qlwda8YE/AYywM2mxMTBrGM=; b=wVl2u7
        7EcAsVmsrUIIEA03XonuFw06a/rbPII77LuLhwQKoIqgjKQomdx/jUyq+jkx9qy2
        xB6vyKsVmrc/ZUviPQWvb3lCs52W4/0K7HHTDXpzrlm5QGIfXl7cwS7fc/8aDxP8
        42KY8hrgC6v+vo2i4FmsiO/KUHwlpxOFnatKM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BrHe/ky/4enoxu9g7NeDe2vG2TNZF8yo
        YBamY4lF1QMF9kFzRsopmCycYY7Fy6DeFrtYSF1NyL+M1G7CM2bYgLCxjb2RwMuD
        LspW7uPsK4sMJSgwEZrEK/P0g1aPpiH9DyDoj+oFpw1EQioShiBH6Yr7sItcS7Ap
        p6SXCBrECjY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19192C01B6;
        Thu, 27 Feb 2020 12:38:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 362F6C01B5;
        Thu, 27 Feb 2020 12:38:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH v6 2/4] advice: change "setupStreamFailure" to "setUpstreamFailure"
References: <pull.548.v5.git.1582628141.gitgitgadget@gmail.com>
        <pull.548.v6.git.1582778112.gitgitgadget@gmail.com>
        <828b4aee19d09218beca6ad1d93006012be99a0a.1582778112.git.gitgitgadget@gmail.com>
Date:   Thu, 27 Feb 2020 09:38:13 -0800
In-Reply-To: <828b4aee19d09218beca6ad1d93006012be99a0a.1582778112.git.gitgitgadget@gmail.com>
        (Heba Waly via GitGitGadget's message of "Thu, 27 Feb 2020 04:35:09
        +0000")
Message-ID: <xmqqo8tkexru.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EF88761C-5987-11EA-A71C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Heba Waly via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Heba Waly <heba.waly@gmail.com>
>
> fb6fbffbda (advice: keep config name in camelCase in advice_config[],
> 2018-05-26) changed the config names to camelCase, but one of the names
> wasn't changed correctly. Fix it.
>
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
> ---
>  advice.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/advice.c b/advice.c
> index fd836332dad..258cc9ba7af 100644
> --- a/advice.c
> +++ b/advice.c
> @@ -80,7 +80,7 @@ static struct {
>  	{ "sequencerInUse", &advice_sequencer_in_use },
>  	{ "implicitIdentity", &advice_implicit_identity },
>  	{ "detachedHead", &advice_detached_head },
> -	{ "setupStreamFailure", &advice_set_upstream_failure },
> +	{ "setUpstreamFailure", &advice_set_upstream_failure },

The mistake is sort-of understandable, when "setup" is taken as
a verb.  Well spotted ;-)

>  	{ "objectNameWarning", &advice_object_name_warning },
>  	{ "amWorkDir", &advice_amworkdir },
>  	{ "rmHints", &advice_rm_hints },
