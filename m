Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FD3C433DF
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61AC8206F4
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 23:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="S28HWXt+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgFJXQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 19:16:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60758 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgFJXQu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 19:16:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58939DDBF4;
        Wed, 10 Jun 2020 19:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NzbcbbjLF4SviSv2+uSZ6ion0Bs=; b=S28HWX
        t+TCkckwnep0oyDFHhHItsl0/oGvRq06kp5icDil9fUs+D08idNRJqin03Hy9RSu
        HyhqG2v1+FtXM/cK5r0GsOtfCJuQCr9zKKG+DtQwWTvn1/xLMW5PngvBcGT72n/6
        SRwjJrZqG3XNazgyCTPJDiLk/eMvJec4o0jFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sy9x50TNYRZRuivSNUvCei6uwc2lJNcf
        n0BT2ab0KFIGe1ZC+YUlXbSaiaEIO2FkucE8/RG1NWuAqY4NthX+wM6ieyNuv52V
        I65X+pFXwNji3IwKwJ7L9tsWcpwHya/ztfFOXxhAgWoI0rulXI7JBJg2t5M341O9
        ysHQ4dxPPaM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FE38DDBF3;
        Wed, 10 Jun 2020 19:16:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73091DDBF2;
        Wed, 10 Jun 2020 19:16:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/9] CDN offloading update
References: <cover.1590789428.git.jonathantanmy@google.com>
        <cover.1591821067.git.jonathantanmy@google.com>
Date:   Wed, 10 Jun 2020 16:16:42 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 10 Jun 2020 13:57:14 -0700")
Message-ID: <xmqqftb2eckl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 73277466-AB70-11EA-BBF0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks, Junio, for taking a look at this.
>
> This version is based on cc/upload-pack-data-2. I thought of retaining
> the base from the original version, but trying out the rebase showed
> that there were some code movements that would clutter the range-diff
> anyway, so I went ahead with the rebase.

I think rebasing is not just justifiable, but is the right thing to
do in this case, as the topics fairly heavily steps each other's toe.

Thanks.
