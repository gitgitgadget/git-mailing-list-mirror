Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2582C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 18:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiGGSui (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 14:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiGGSuh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 14:50:37 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1254222BFF
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 11:50:36 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 13708145DC0;
        Thu,  7 Jul 2022 14:50:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ubDAMuw+2RHssZ7KaklZHYp/mfnvuvdWBHFWLa
        jkV4k=; b=wl0HCtqxUotbrad4vg3qYZLUDwGTcfK3Q1gIVnyjNCBf5ygpDL8RdI
        MO45Ny9r7cOFjQaI3ro0rmLgs5NzfjC/yA9Bee8568y1LJeuBsWWD+NfGN9NBVqJ
        HIYGABO3OvPB0KqrJpxfuDpd8neUtUWuU7LXmEl71Nldwx8Bq9ZuE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0A577145DBF;
        Thu,  7 Jul 2022 14:50:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6C909145DBE;
        Thu,  7 Jul 2022 14:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 3/3] clone: propagate empty remote HEAD even with other
 branches
References: <YsVAfudoUA5YkQWH@coredump.intra.peff.net>
        <YsVB2eOMp5guQfVr@coredump.intra.peff.net>
        <xmqqr12ygl3p.fsf@gitster.g> <xmqq5yk9hpd9.fsf@gitster.g>
        <Yscaoz8qmPYiiLO5@coredump.intra.peff.net>
Date:   Thu, 07 Jul 2022 11:50:34 -0700
In-Reply-To: <Yscaoz8qmPYiiLO5@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 7 Jul 2022 13:40:51 -0400")
Message-ID: <xmqqk08ozrid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AF94022A-FE25-11EC-B0C3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If so, do you prefer to go straight there in patch 3 (and drop patch 2,
> keeping the unborn setup inline), or do you prefer to see it on top?
> Normally I'd suggest the former, but I worry that doing it all in one
> patch means it's reorganizing the code _and_ changing the behavior all
> at once, which is harder to reason about. And I don't see an easy way to
> reorganize the code without changing the behavior.

Either way is fine, but the "go straight there" approach may work
better, I suspect.

Thanks.


