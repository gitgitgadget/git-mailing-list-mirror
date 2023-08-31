Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8712C88CB2
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 22:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347664AbjHaWMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 18:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaWMf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 18:12:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49E6E5F
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 15:12:32 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C26C1AADC1;
        Thu, 31 Aug 2023 18:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=vJbBAPA7MGMMDTCOld9BOcbpSXgTYsKPHXIJH9
        irPzM=; b=okvGBz2xhaph+Rhv2qbAUaL7wtYouP1hfr+DyopIRA2CE7FYhCVtNe
        aUCmRBpz/Xj7etTdtf+E5tcUZz42yFYodUzoCrOxk8Ksvb5pOBBvcCUBt/2neuXG
        nfWNotk0FRsWQQAX9UbpStgIhka+Ay6y/hzcu3Qttz9lrIOtnkbZs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 236991AADBF;
        Thu, 31 Aug 2023 18:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 921C41AADBE;
        Thu, 31 Aug 2023 18:12:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 04/10] checkout-index: delay automatic setting of
 to_tempfile
In-Reply-To: <20230831212051.GD949469@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 31 Aug 2023 17:20:51 -0400")
References: <20230831211637.GA949188@coredump.intra.peff.net>
        <20230831212051.GD949469@coredump.intra.peff.net>
Date:   Thu, 31 Aug 2023 15:12:30 -0700
Message-ID: <xmqqr0nisvxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7ADD121C-484B-11EE-AECA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Using --stage=all requires writing to tempfiles, since we cannot put
> multiple stages into a single file. So --stage=all implies --temp.

This one is new, and it does read really well.  Thanks.
