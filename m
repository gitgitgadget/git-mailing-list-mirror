Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B4C433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247072067B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 16:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LI8zxsYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgFJQ5Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:57:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60071 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgFJQ5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 12:57:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C67775A591;
        Wed, 10 Jun 2020 12:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J0u/hhybGLis5ndJYGX2KkrKbXE=; b=LI8zxs
        YPwFaLJi2pNEsYKv+EzDzpvqqoidS+QFq7YxnfInXqlLj1rhTGzXk0CrHacD+DOk
        UkM00tg/4sHfxAM7IBRsy3USU5Wy25LdteSuf2yibY7ksMvWNeTWmyraEej41/UH
        3MJKlLJIiXegqXS5dBGR6O/Pu5s2IbNsSMJ5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vP1gBsZabdoxNxn5WUYlOtvjUMaDlmGS
        vItJowMCLOUbdINsC4PCudhzbzPgbuuV/fdzORyz03AzxzhjWRn81fHz9v2JTTy8
        jw0oZmOTOZlAuLIzhDgp+ixHkgI/pKD842TPaMV8+9EpXo/f60GIKRTTi4FRmxt5
        /MryP/cYBJw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBBA05A58F;
        Wed, 10 Jun 2020 12:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3910F5A58E;
        Wed, 10 Jun 2020 12:57:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Luigi Cantoni <luigic@fgcint.com>,
        David Aguilar <davvid@gmail.com>, git@vger.kernel.org
Subject: Re: Auto Rescan - as plain text
References: <37bd22ee8bcb9c91969d68cbc5e6852a8a70ab36.camel@fgcint.com>
        <bf895dc550881b35baea45cd269bf9b0518ade35.camel@fgcint.com>
        <816ce248ab1708d41b5233abdb998ff2d4cb3400.camel@fgcint.com>
        <36bd7dc26883017770c28da94a251be2d5019f75.camel@fgcint.com>
        <xmqq3673hj11.fsf@gitster.c.googlers.com>
        <20200610085902.uv7cxl6s5qnlniwm@yadavpratyush.com>
Date:   Wed, 10 Jun 2020 09:57:20 -0700
In-Reply-To: <20200610085902.uv7cxl6s5qnlniwm@yadavpratyush.com> (Pratyush
        Yadav's message of "Wed, 10 Jun 2020 14:29:02 +0530")
Message-ID: <xmqqv9jyg8pb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7334E0EA-AB3B-11EA-A0D4-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Hi Junio,
>
> On 09/06/20 05:16PM, Junio C Hamano wrote:
>> Luigi Cantoni <luigic@fgcint.com> writes:
>> 
>> > Hi All,
>> > I have been using git for several years now and using git-cola.
>> > I just started up git gui and that is quite self explanatory and all
>> > the functions I use with git-cola appear to be there.
>> 
>> We used to see the maintainer of that project around here quite
>> frequently but haven't seen him for a while [jch: David Cc'ed].
>> 
>> By reading https://git-cola.github.io/about.html it seems that they
>> prefer to see problem reports and feature requests at
>> https://github.com/git-cola/git-cola/issues and not on this list.
>
> The feature request is for git-gui, asking for auto rescan in git-gui 
> like git-cola has.

Sorry for the noise, and thanks for your correction.
