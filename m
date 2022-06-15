Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5333C43334
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 18:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiFOSgG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 14:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbiFOSgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 14:36:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB52FFD3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 11:36:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B4921B6637;
        Wed, 15 Jun 2022 14:36:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fC9tUvOL+oPSAY5Cv1dg2Q7bTbkJmUBaGHrZDq
        bf5Gg=; b=ZDedE/RUdwzKIELfIfCXxV7WIjP/4Trkb3Fb/eUiDKy/A5XlBc3+bV
        UVnvYGc+nKFnjJeF9TBu3RbZ2JJ9jy29nmxnVwN7rVdhekBD1oAy1C+NSJDT9heW
        bpy1sJe5nKtDrMHX6x/CejvuZ8qs1AsolFS17sepJsfuVmyqaJeVc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8431D1B6636;
        Wed, 15 Jun 2022 14:36:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 131571B6634;
        Wed, 15 Jun 2022 14:35:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] For v2.37.0: rename fetch.credentialsInUrl to
 transfer.credentialsInUrl
References: <cover-0.2-00000000000-20220615T103852Z-avarab@gmail.com>
        <e53a247d-1d12-e34c-6cc8-3813a2fa34dc@github.com>
Date:   Wed, 15 Jun 2022 11:35:55 -0700
In-Reply-To: <e53a247d-1d12-e34c-6cc8-3813a2fa34dc@github.com> (Derrick
        Stolee's message of "Wed, 15 Jun 2022 09:12:25 -0400")
Message-ID: <xmqqy1xxzsdw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FF8A0552-ECD9-11EC-B507-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> This rename makes sense and is good to handle before the release.
> Thank you for updating the release notes.
>
> The expanded details in the docs are good.

Generally, transfer.$name hierarchy is there to give defaults to
fetch.$name and push.$name so that the knob can be set separately
for different directions of the transfer, but for this particular
one, I do not see a reason why we want to redact fetch requests
without redacting push requests.

One thing that worries me is that this will probably burn our early
adopters, those who are willing to help our development by running
versions based on 'next' and already have fetch.* configuration.
But the breakage this change brings on them hopefully will not be
large enough to discourage them from being guinea pigs ;-)

Thanks, all.
