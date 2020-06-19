Return-Path: <SRS0=lJm1=AA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E72C433DF
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD1921556
	for <git@archiver.kernel.org>; Fri, 19 Jun 2020 19:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PlZi2Y/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388915AbgFSTbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:31:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55707 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387907AbgFSTbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jun 2020 15:31:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CC42562FCC;
        Fri, 19 Jun 2020 15:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=svFi08w2yKHSmq3WPsHchjorYiY=; b=PlZi2Y
        /IRuikBdJVMrf9nRxfrZ1kE9eMRO20hgBx7zH+EUukIcAdvKL9O27s63lYhiSd/j
        bb0oxfTNHu8NfV8IoT5x7lufgxdwbT97QtoliW2Hcbyflf+9RIheDF3ZkKUkcump
        1RKbAEs53nJxiCu8Y2HgQnlkRW8Na+MYrSXbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jS/XISM+Czcujl0V4IsvctajvLI3EHVL
        +xOQgtvdlW5f/WUGhaeZc8vFsphJWYGQTLFY/lc2D3JjmigxNJ7+XbPdtKYqj2Od
        dAjxcxKI7KTiZnO2tRuGuGMxoESts83Z0KAWZaXyeXPSsmTTt8CAb3HQ3MUVT/++
        Z2Uak/mdoG4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C377562FCB;
        Fri, 19 Jun 2020 15:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 43BA762FCA;
        Fri, 19 Jun 2020 15:31:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [Patch v1 3/3] strbuf.h: remove declaration of deprecated strbuf_write_fd method.
References: <20200619150445.4380-1-randall.s.becker@rogers.com>
        <20200619150445.4380-4-randall.s.becker@rogers.com>
Date:   Fri, 19 Jun 2020 12:31:36 -0700
In-Reply-To: <20200619150445.4380-4-randall.s.becker@rogers.com> (randall
        s. becker's message of "Fri, 19 Jun 2020 11:04:45 -0400")
Message-ID: <xmqqa70yhmxz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7DF4EFBE-B263-11EA-8110-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

randall.s.becker@rogers.com writes:

> From: "Randall S. Becker" <rsbecker@nexbridge.com>
>
> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  strbuf.h | 1 -
>  1 file changed, 1 deletion(-)

I think this should be part of 2/3 (otherwise we'd have a decl that
nobody references that declares a function that nobody implements).

> diff --git a/strbuf.h b/strbuf.h
> index 7062eb6410..223ee2094a 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -473,7 +473,6 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint);
>   * NUL bytes.
>   */
>  ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
> -ssize_t strbuf_write_fd(struct strbuf *sb, int fd);
>  
>  /**
>   * Read a line from a FILE *, overwriting the existing contents of
