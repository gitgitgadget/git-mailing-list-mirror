Return-Path: <SRS0=eul5=7K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F1BC433DF
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627A92074B
	for <git@archiver.kernel.org>; Thu, 28 May 2020 23:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pvEbflPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437614AbgE1XjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 19:39:08 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58900 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436651AbgE1XjG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 19:39:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3398FD5956;
        Thu, 28 May 2020 19:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HNeD7RMlwR6Lc6s3k6/GOdo0M6k=; b=pvEbfl
        PjEyrxB29yF8KybTMLayjy8ZsoTEdb0P6RTC0alj5fZZ7zqg/4I1wuqN0qET+90f
        Swx94lrfbB/H+paIhYicufC3S3N98S9XS84oCLT0otA05FNSKNKwWwv7C8NycZ8f
        gjBsoExiFIozgtxRcIC0sLXYCT65cf8nL2a+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YhcLE6TEKXDStrhZS6tncbEyvUlrDli5
        9XoaErXB8w5pkUz7JTUX791pqMiT1eVbPbPztK9k5TY20SAvq5MuUdndg5FuHOCs
        zm16IrS+BdcMhCc3Fx54QijmMZy43nOBtuEOtdMLgg56TDb9mHlWwJCKQ2UmPY25
        z1T6cRiztm8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B9E3D5955;
        Thu, 28 May 2020 19:33:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 74C91D5954;
        Thu, 28 May 2020 19:33:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
References: <20200528231608.59507-1-emilyshaffer@google.com>
Date:   Thu, 28 May 2020 16:33:16 -0700
In-Reply-To: <20200528231608.59507-1-emilyshaffer@google.com> (Emily Shaffer's
        message of "Thu, 28 May 2020 16:16:08 -0700")
Message-ID: <xmqqftbj1vpf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C4235D2-A13B-11EA-987D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

>    <p>
>      Bugs in git can be reported directly to the mailing list (see above for
> -    details). Note that you do not need to subscribe to the list to send
> -    to it. You can help us out by attempting to reproduce the bug in the latest
> -    released version of git, or if you're willing to build git from source, the
> -    <a href="https://github.com/git/git/tree/next"><code>next</code> branch</a>.
> +    details). Note that you do not need to subscribe to the list to send to it.
> +    If you are using git 2.27.0 or later, you can run <code>git bugreport</code>,
> +    which generates a template to guide you through writing a useful bug report
> +    and gathers some diagnostic information about your environment. You can
> +    help us out by attempting to reproduce the bug in the latest released
> +    version of git, or if you're willing to build git from source, the
> +    <a href="https:/break/github.com/git/git/tree/next"><code>next</code> branch</a>.

It took me a bit more then necessary to spot this due to rewrapping
of the string, but I do not think you meant "https:/break/" there.

Care to share how it happened (what tool has the tendency to
introduce this particular breakage)?

Thanks.
