Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF2FC2D0F4
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AD2075E
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 19:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dSMzYlqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbgDHTJy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:09:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51774 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgDHTJy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 15:09:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 81F04B16CB;
        Wed,  8 Apr 2020 15:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tKWj/LovlPfWO/WiCFMslCNMXUI=; b=dSMzYl
        qm1YU2PL5N8KxjAKuxSbZMuDvmglQ/JnXwQ5d4h7TXDKD5+VYebDhoLRyLcqcEPa
        K0eJ7U3dJZAgQ+T5qQmobwoHRySXF2JaW++I0UE6643TGcondGDOhy5bP3ggCpwe
        rcVEy+OKYiCWrfd6SAU5xM5c2xiwqr45nUVGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vvcJ1PBXoxIeY0GZXdVbu/v2yaKi3Z+T
        Kepba2CjU6ugiW/0dpiNVrrDW8O1x6UsVY8L+wPYUHjRSO/K6jwZ2zvEXbOd1PjW
        w+CHahjY7e9p3gmoEitskFQ/tvE/Tg0KF1My13yNyltAebGR0HyTTp0s0E+Ncc26
        iiBcuCO4exg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7817AB16C8;
        Wed,  8 Apr 2020 15:09:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C33ACB16C7;
        Wed,  8 Apr 2020 15:09:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] subtree: fix build with AsciiDoctor 2
References: <pull.600.git.1586355949189.gitgitgadget@gmail.com>
Date:   Wed, 08 Apr 2020 12:09:45 -0700
In-Reply-To: <pull.600.git.1586355949189.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Wed, 08 Apr 2020 14:25:49
        +0000")
Message-ID: <xmqqk12ppzeu.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 831BD3BA-79CC-11EA-A41B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This is a (late) companion for f6461b82b93 (Documentation: fix build
> with Asciidoctor 2, 2019-09-15).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     Adjust contrib/subtree to AsciiDoctor 2, too
>     
>     This is something I had to do because the Git for Windows release
>     process now offers only AsciiDoctor 2.

Thanks.  The original justifies its change quite well, and its
reasoning applies perfectly well here, too.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-600%2Fdscho%2Fsubtree-and-docbook-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-600/dscho/subtree-and-docbook-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/600
>
>  contrib/subtree/Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 6906aae4414..6fa7496bfdb 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -25,14 +25,16 @@ ASCIIDOC_HTML    = xhtml11
>  ASCIIDOC_DOCBOOK = docbook
>  ASCIIDOC_EXTRA   =
>  XMLTO            = xmlto
> +XMLTO_EXTRA      =
>  
>  ifdef USE_ASCIIDOCTOR
>  ASCIIDOC         = asciidoctor
>  ASCIIDOC_CONF    =
>  ASCIIDOC_HTML    = xhtml5
> -ASCIIDOC_DOCBOOK = docbook45
> +ASCIIDOC_DOCBOOK = docbook
>  ASCIIDOC_EXTRA  += -I../../Documentation -rasciidoctor-extensions
>  ASCIIDOC_EXTRA  += -alitdd='&\#x2d;&\#x2d;'
> +XMLTO_EXTRA     += --skip-validation
>  endif
>  
>  ifndef SHELL_PATH
> @@ -78,7 +80,7 @@ install-html: $(GIT_SUBTREE_HTML)
>  	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
>  
>  $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
> -	$(XMLTO) -m $(MANPAGE_XSL) man $^
> +	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $^
>  
>  $(GIT_SUBTREE_XML): $(GIT_SUBTREE_TXT)
>  	$(ASCIIDOC) -b $(ASCIIDOC_DOCBOOK) -d manpage $(ASCIIDOC_CONF) \
>
> base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
