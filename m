Return-Path: <SRS0=wY2r=4U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185FEC3F2D1
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8CB214DB
	for <git@archiver.kernel.org>; Tue,  3 Mar 2020 21:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LwCCDVF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgCCV50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Mar 2020 16:57:26 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64295 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgCCV50 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Mar 2020 16:57:26 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DBB034327C;
        Tue,  3 Mar 2020 16:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GSwasoxx1jZh+PkUY7tJ3xYJD4k=; b=LwCCDV
        F0L6M+4zE+DTaYYC4DdfBcXkYiuwSQufVS3eMf0rIdwmlrVVLM2y4b2y2kmHjw9A
        /xeYwFGKmu/+2lYgXclwv6Tu7zvuJQABhCSv4Dl30hEJ5Q6MchV7li2Oq14k/DmX
        vc4aC7iFiz7TfBA7RgATJCTnJMalfEkluN/IU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NLz+e0/x02dDDK/4x1/6HWR1jIoGBJU+
        Oj2usY4yu8WyrkWLZvXA4XJuJUMazgT1XMWX2CDHlRrZ4rOejAgT1x+X2a3b7S1E
        tGaxDi7NFAz8hPwUMD2HGi7Vp2Ja46/D2Fsev84hB3ImPlSOe4e+DqkUGJNn5knz
        n0FPVesgNPI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D308F4327B;
        Tue,  3 Mar 2020 16:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 43AA64327A;
        Tue,  3 Mar 2020 16:57:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Damien Robert <damien.olivier.robert@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v2 3/5] doc: explain how to deactivate recurse.submodule completely
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com>
        <20200303170740.1879432-1-damien.olivier.robert+git@gmail.com>
        <20200303170740.1879432-4-damien.olivier.robert+git@gmail.com>
Date:   Tue, 03 Mar 2020 13:57:22 -0800
In-Reply-To: <20200303170740.1879432-4-damien.olivier.robert+git@gmail.com>
        (Damien Robert's message of "Tue, 3 Mar 2020 18:07:38 +0100")
Message-ID: <xmqqsgip6r0d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6F60192-5D99-11EA-8900-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Damien Robert <damien.olivier.robert@gmail.com> writes:

> Signed-off-by: Damien Robert <damien.olivier.robert+git@gmail.com>
> ---
>  Documentation/config/submodule.txt | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/config/submodule.txt b/Documentation/config/submodule.txt
> index 5962f41ead..74e691a487 100644
> --- a/Documentation/config/submodule.txt
> +++ b/Documentation/config/submodule.txt
> @@ -63,6 +63,13 @@ submodule.recurse::
>  	(`checkout`, `fetch`, `grep`, `pull`, `push`, `read-tree`, `reset`,
>  	`restore` and `switch`) except `clone` and `ls-files`.
>  	Defaults to false.
> +	When set to true, it can be deactivated by calling
> +	`--no-recurse-submodules`. Note that some Git commands without this

You do not "call" an option [*1*].  Perhaps "... can be overriden by
passing the `--no-recurse-submodules` option from the command line."

> +	option may call some of the above commands affected by
> +	`submodule.recurse`; for instance `git remote update` will call
> +	`git fetch` but does not have a `--no-recurse-submodules` option.
> +	since `submodule.recurse`. In this case a solution is to temporary
> +	change the configuration value by using `git -c submodule.recurse=0`.

A good piece of advice.



[Footnote]

*1* ... unless you are in a different business, that is ;-).
