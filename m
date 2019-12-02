Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6A2C432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8066C20717
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 14:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Vxso1/yM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfLBOQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 09:16:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55537 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727362AbfLBOQK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 09:16:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43D289A593;
        Mon,  2 Dec 2019 09:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=SU7wNmhtnT5nvPESFjHes4Gbh6s=; b=Vxso1/
        yMY8qgWto+jFnJ+Y9Z2CCU3N8GZTOrEEcb5ZuEZINcLeqbJ6A0WUF2HT9IaCtmwQ
        cvhAq07WyshzPwXqYWY+M+zqE4ytCUkqPZxnpAR8kewwZfg424o8GhdWnD7lc7tc
        LU15nzETY6lX1V7s2XSdjZ4sc+H6ONeSmYIdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mFgJMseKIMBcV3RnHfQa7ubrLs3xpGkQ
        mj7iM+he5zY5FZPQOMRIJv7tritp4z3RuJ9EtBUVAuwVdoKJQJOf8JH6FOe5dnMt
        saVeaVqC/+6vwikzw6pPBgNgvZG4fFFYXCJ/bSaGYWB9TcClOjdDHtVaFBA986VG
        X2Fd04ghbrk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B60B9A592;
        Mon,  2 Dec 2019 09:16:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EC2C39A58E;
        Mon,  2 Dec 2019 09:16:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/1] pkt-line: fix a typo
In-Reply-To: <df82efe896aea1fd5ff597b3fad772aef0957d2e.1575276191.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Mon, 02 Dec 2019
        08:43:11 +0000")
References: <pull.481.git.1575276191.gitgitgadget@gmail.com>
        <df82efe896aea1fd5ff597b3fad772aef0957d2e.1575276191.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date:   Mon, 02 Dec 2019 06:16:00 -0800
Message-ID: <xmqqr21myfrz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4634F6FC-150E-11EA-8EF0-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> This typo was introduced in 2153d478b74 (pkt-line: introduce
> packet_read_with_status, 2018-03-14).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Good eyes.  Will queue.  Thanks.

>  pkt-line.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pkt-line.h b/pkt-line.h
> index 5c62015db4..fef3a0d792 100644
> --- a/pkt-line.h
> +++ b/pkt-line.h
> @@ -77,7 +77,7 @@ int packet_read(int fd, char **src_buffer, size_t *src_len, char
>  /*
>   * Read a packetized line into a buffer like the 'packet_read()' function but
>   * returns an 'enum packet_read_status' which indicates the status of the read.
> - * The number of bytes read will be assigined to *pktlen if the status of the
> + * The number of bytes read will be assigned to *pktlen if the status of the
>   * read was 'PACKET_READ_NORMAL'.
>   */
>  enum packet_read_status {
