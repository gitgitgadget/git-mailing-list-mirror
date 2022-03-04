Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BCDC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 02:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbiCDCH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 21:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiCDCH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 21:07:26 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE4A17CC45
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 18:06:39 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20D4B18DCCF;
        Thu,  3 Mar 2022 21:06:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E1juJ1hI7QQWlN1x8ktL2sFV32brJljOy4Aze5
        vR3nE=; b=JWVbuEkcqv6/fqqx2hcQ7eGNXovEslMPsSbOffYtGRAAp/c6lZywLC
        Jx+SeLdcL6cgerkr6AjJUPzPDFVMahQho41iN5wt8wDVQcAIxn8G2PXT1/DJTAgB
        znIfvrZVp4oQDgB+Cc4QD+16cA/3x4YUaMEf9BnoqJgjvlP1ShJp0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19A0018DCCC;
        Thu,  3 Mar 2022 21:06:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 910FD18DC93;
        Thu,  3 Mar 2022 21:06:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v4 01/10] t5526: introduce test helper to assert on fetches
References: <20220224100842.95827-1-chooglen@google.com>
        <20220304005757.70107-1-chooglen@google.com>
        <20220304005757.70107-2-chooglen@google.com>
Date:   Thu, 03 Mar 2022 18:06:35 -0800
In-Reply-To: <20220304005757.70107-2-chooglen@google.com> (Glen Choo's message
        of "Thu, 3 Mar 2022 16:57:48 -0800")
Message-ID: <xmqqee3i5v4k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8CA4A58-9B5F-11EC-8022-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +# Verifies that the expected repositories were fetched. This is done by
> +# concatenating the files expect.err.[super|sub|deep] in the correct
> +# order and comparing it to the actual stderr.
> +#
> +# If a repo should not be fetched in the test, its corresponding
> +# expect.err file should be rm-ed.
> +verify_fetch_result() {

I think you updated 02/10 "check_sub () {" but this is leftover.  If
there aren't too many, I can fix them up locally.  We'll see.
