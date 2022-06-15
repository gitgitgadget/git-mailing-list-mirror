Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4235DC433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349373AbiFORLY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 13:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354934AbiFORLS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 13:11:18 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F76F4F9D4
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 10:11:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B74DA1B5E3A;
        Wed, 15 Jun 2022 13:11:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pJdurGsl2z2bFrZKTpyRNVxx8rY3EnikxGJG+8
        9mlWI=; b=Kjee6IsULWxin1Jz1oD7aL+cMeGQk3/Zucv1lUv1nEtA3gG741mLCl
        HWeQ59tbqZeHVrLtmYr4KmOR5hcqwMA3fkoJM+pNYzMBag3ss2fyONjUR+cfV8qF
        71onr4nJWk81nRO6Y7Gu3cbM234HAc231VshpRR4mlOepi+9Sef8o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AFD661B5E39;
        Wed, 15 Jun 2022 13:11:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 504B71B5E36;
        Wed, 15 Jun 2022 13:11:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] revision: mark blobs needed for resolve-undo as reachable
References: <xmqqfskdieqz.fsf@gitster.g>
        <7cd41846-e6ef-7a24-0426-6031a529360f@github.com>
        <220614.86czfcytlz.gmgdl@evledraar.gmail.com>
        <31f406b1-b4e8-5da2-40af-5747938de634@github.com>
Date:   Wed, 15 Jun 2022 10:11:13 -0700
In-Reply-To: <31f406b1-b4e8-5da2-40af-5747938de634@github.com> (Derrick
        Stolee's message of "Tue, 14 Jun 2022 10:35:10 -0400")
Message-ID: <xmqqedzp26oe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29636B7C-ECCE-11EC-A9C6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Junio is right that we would need to convert this into a method with a
> function pointer instead of a for_each_* macro. That's quite a big lift
> for some small convenience for the callers.

Heh, I never said we would need to.  I only said we _could_ do such
a change but I do not see the need to.

