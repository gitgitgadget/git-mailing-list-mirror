Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC350C433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 02:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244839AbiCHCOv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 21:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242445AbiCHCOv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 21:14:51 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B856DEAD
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 18:13:55 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95F42F81AD;
        Mon,  7 Mar 2022 21:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pu/mthbQWmS3nIV7yBGd3W6PoLVuoUA93x+j5n
        gj4r0=; b=bYGv2hb4QAvUGpYKKvn2VJK6KwQo521Dhf4wS+QT7eWAfMjSB46UGi
        A/WGE3eu2lS9Q/uUKrbdWpZNfpmD/FlEn5bkb1BWrzEa/31CTbi2Igtz48YJCSf8
        iNIxCu/zIFcYn+BD8UVpYNihpGwbGMPdr2DaJ2Lqb+O5IgwKcAEro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8DD0DF81AC;
        Mon,  7 Mar 2022 21:13:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EFBBFF81AB;
        Mon,  7 Mar 2022 21:13:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jason Yundt <jason@jasonyundt.email>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 0/2] gitweb: remove invalid http-equiv="content-type"
References: <20220307033723.175553-1-jason@jasonyundt.email>
        <20220308010711.61817-1-jason@jasonyundt.email>
Date:   Mon, 07 Mar 2022 18:13:52 -0800
In-Reply-To: <20220308010711.61817-1-jason@jasonyundt.email> (Jason Yundt's
        message of "Mon, 7 Mar 2022 20:07:09 -0500")
Message-ID: <xmqqbkyhp4wv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 672546CA-9E85-11EC-84D5-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jason Yundt <jason@jasonyundt.email> writes:

> - keeps an extra variable,

I am not sure if this is an improvement.  The original had two
places that used $content_type, but after getting rid of one, there
is only one place that needed the value, which can be used in place;
and it was quite clear that was what was going on in the previous
iteration.

About the <meta> thing, it seems that brian already commented on it.

Thanks.


