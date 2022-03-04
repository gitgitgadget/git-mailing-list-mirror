Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88326C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 02:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiCDCWz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:22:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbiCDCWx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 21:22:53 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C0B17CC78
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 18:22:07 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 127A3109354;
        Thu,  3 Mar 2022 21:22:07 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F7f6h58yn91ZSG0JzxNLvC0+cOAjMx6yx20dqM
        yt11Q=; b=JzGxOKG+Bdlh3Ft9GnItq7p2erKm7knLAyyoVXQCBxfNAiB5s1N8NY
        GGd19JDRW9MQozeHy5zC/IeEyQcr3Zg3pCGsQ4aZZZEVTmRPK067EcMYN/eCRsFR
        8oUQeLV4enVS75kR/USEjVdkXm0Fhbz7k3Ppbxd/NERvVsgQvDK1Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 08C77109353;
        Thu,  3 Mar 2022 21:22:07 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5D9E7109352;
        Thu,  3 Mar 2022 21:22:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 00/10] fetch --recurse-submodules: fetch unpopulated
 submodules
References: <20220224100842.95827-1-chooglen@google.com>
        <20220304005757.70107-1-chooglen@google.com>
Date:   Thu, 03 Mar 2022 18:22:05 -0800
In-Reply-To: <20220304005757.70107-1-chooglen@google.com> (Glen Choo's message
        of "Thu, 3 Mar 2022 16:57:47 -0800")
Message-ID: <xmqqwnha4fua.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2FD3586-9B61-11EC-8D06-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> == Since v3
> - Numerous style fixes + improved comments.
> - Fix sed portability issues.

Good.

> - Fix failing test due to default branch name assumptions.

OK.  Sprinkling "-b main" all over to "git init" makes a bit noisy
patch, but the conversion looks good.
