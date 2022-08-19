Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F1C25B0E
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 04:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344618AbiHSEdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 00:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbiHSEdI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 00:33:08 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03389DD74A
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 21:33:07 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5E6D132114;
        Fri, 19 Aug 2022 00:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jLSB9q0TVnphQ8IdxueUCNidb49XbCk3Rja2cX
        1Rn1o=; b=qnPW/DipywVwx5+aR/mju9ekY6BkcYBl68drHG2LImTlUOntEjt+YW
        UNdxxKGSz1j/bVOIgwNQH+cHGEzGCuii80Rgt/vL2XA+GCoF5EcTuqhaIIHLI3e9
        TvDMZm/35H/91x2bX48nAg6baOF/sw/ZV1f2bntBXoxQvZEOWwxEc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC9E8132112;
        Fri, 19 Aug 2022 00:33:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08DEB132110;
        Fri, 19 Aug 2022 00:33:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Maxwell Bernstein <tekk.nolagi@gmail.com>,
        Max Bernstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Max Bernstein <donotemailthisaddress@bernsteinbear.com>,
        Max Bernstein <max@bernsteinbear.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2] trailer: allow spaces in tokens
References: <pull.1309.git.git.1660806376021.gitgitgadget@gmail.com>
        <pull.1309.v2.git.git.1660809243298.gitgitgadget@gmail.com>
        <xmqqk075qyq0.fsf@gitster.g> <CM9DZ4Z18PY9.1T2O8U54X66FD@cedar>
        <CAP8UFD1304rQh+9jMUkTmTvmNBxm6BNDt3=d07+C8iXSbJb2RA@mail.gmail.com>
        <xmqqa681nsrv.fsf@gitster.g>
Date:   Thu, 18 Aug 2022 21:33:04 -0700
In-Reply-To: <xmqqa681nsrv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        18 Aug 2022 14:31:00 -0700")
Message-ID: <xmqqwnb4n98f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 051C7C5E-1F78-11ED-AAF9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In short, you do not support Max's patch that allows arbitrary
> number of white spaces anywhere but at the beginning of line,
> but see a room for unrelated improvement from the current code,
> namely, to allow exactly one optional space, immediately before
> the separator and nowhere else.

Ah, no, sorry, I misread the situation.  It's not a room for
improvement.  It is very close to what the current code already
does, i.e. to allow optional spaces immediately before the
separator.  The difference is that the current code allows arbitrary
number of optional spaces, not zero or exactly one.

So the only thing we need to do is to update the documentation that
Max misread as allowing spaces at arbitrary place to reflect what
the code has been doing, i.e. an optional run of spaces is allowed
between the "token" and the "separator"?

Anybody wants to do the honors to produce such a patch, then?

Thanks.


    
