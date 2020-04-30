Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB37C47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C9420774
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 20:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BAtEcm1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgD3UpN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 16:45:13 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57657 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgD3UpN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Apr 2020 16:45:13 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A152BAFB7;
        Thu, 30 Apr 2020 16:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7hVCduryXEwNAYFlfKtqXlGCm9I=; b=BAtEcm
        1b18MRpW8fdju7uDd9tuXMAj+Y+7xORGK6Zy9mjqSJPSoU9Hsb3DZcD15qlWsgcg
        +XYugs5snuMkqxN9Qp4ek51mtk4Z49FaRhqpew8ec2S+YTfO5EWZoRe9rFvuo/UW
        82AzstgFiPo8f5YWu378UmPr9WEeJtEPaILGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fIkIhGV2u4Ae6j4UkRYU+MaAAMhCC5QV
        u6iqL7beingGCFHpW4KTKbrVxpjfB1F2vR64ob+heBjXxiJ2RZjVDXGduysxQkV7
        xgN0mEq5USlYBwtLc0AdvAF7pT+bbbVnt0WUIbMfyX1N6O+8A1hc64stp73bVtlV
        UkmavEkDA0U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52010BAFB6;
        Thu, 30 Apr 2020 16:45:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8D34FBAFB5;
        Thu, 30 Apr 2020 16:45:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Robert Simpson <no-reply@MailScreen.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] switch: fix errors and comments related to -c and -C
References: <0f7f9eefc056dd4d9b11dab737e00235b3243a2f.1588150804.git.liu.denton@gmail.com>
        <75c9cf6ce95e753f50ce9b8b86b2c3ded5d8d38d.1588247662.git.liu.denton@gmail.com>
        <20200430162151.GB30682@syl.local>
Date:   Thu, 30 Apr 2020 13:45:06 -0700
In-Reply-To: <20200430162151.GB30682@syl.local> (Taylor Blau's message of
        "Thu, 30 Apr 2020 10:21:51 -0600")
Message-ID: <xmqqimhgr9d9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AA4AA64-8B23-11EA-8E83-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> Nicely done. This revision looks great to me, thanks.
>
>   Reviewed-by: Taylor Blau <me@ttaylorr.com>

I'd squeeze this into a single line, though.

> -			die(_("missing branch name; try -b"));
> +			die(_("missing branch name; try -%c"),
> +					cb_option);

Will queue with a local fix-up for the above.

Thanks.
