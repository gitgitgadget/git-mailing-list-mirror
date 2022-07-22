Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25689C433EF
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 21:05:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbiGVVFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiGVVFf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 17:05:35 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6734E501B9
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 14:05:33 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 773AB1B61B5;
        Fri, 22 Jul 2022 17:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RHwi7O97ENIwsHpVP+A9hpF+x/1Y+MpJYd0ljc
        Roa1Y=; b=XvFAIvSK58N/+iE4NBZaxrmd87Gd1CIymUo21ZTot9mhjqOKmsk74A
        Xc1loKvF6/MVYf5HWmUhCcMIXRCb7sMc7fHncx4iUT/XmnGd+OZICzhMitUbWK5N
        uHkbah4+PFcbQ2bQZ3Ehh+qwZCROpsmzyXo6of6fDON/NKArQt9f4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F1CE1B61B4;
        Fri, 22 Jul 2022 17:05:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B487B1B61B1;
        Fri, 22 Jul 2022 17:05:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "tenglong.tl" <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@jeffhostetler.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 1/2] api-trace2.txt: print config key-value pair
References: <cover.1658472474.git.dyroneteng@gmail.com>
        <32f8b9ae6bb6aff0ce55ee494c4c0d40c672752b.1658472474.git.dyroneteng@gmail.com>
Date:   Fri, 22 Jul 2022 14:05:27 -0700
In-Reply-To: <32f8b9ae6bb6aff0ce55ee494c4c0d40c672752b.1658472474.git.dyroneteng@gmail.com>
        (tenglong tl's message of "Fri, 22 Jul 2022 16:19:31 +0800")
Message-ID: <xmqqy1wkc0yw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03C0E45C-0A02-11ED-BD5D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"tenglong.tl" <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> It's supported to print "interesting" config key-value paire
> to tr2 log by setting "GIT_TRACE2_CONFIG_PARAMS" environment
> variable and the "trace2.configparam" config, let's add the
> related docs in Documentaion/technical/api-trace2.txt.
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/technical/api-trace2.txt | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 77a150b30e..ddc0bfb9c9 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -717,6 +717,7 @@ The "exec_id" field is a command-unique id and is only useful if the
>  {
>  	"event":"def_param",
>  	...
> +	"scope":"global",
>  	"param":"core.abbrev",
>  	"value":"7"
>  }

Isn't this a bit premature to do in [PATCH 1/2]?
