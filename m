Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B08C433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63AD560241
	for <git@archiver.kernel.org>; Mon, 10 May 2021 07:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhEJHd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 03:33:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57849 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhEJHdz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 03:33:55 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D3D5CC71B4;
        Mon, 10 May 2021 03:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jUE4zjgv1PgkTxv1kwLUTvCSiFjEytlMO1fdFm
        nArsk=; b=kUmSSTo0XRhusGjcQVikyduAsgyXimU21dXwGEUPWkFTNaqOCyPOrR
        IHgh9JE9d5QX1tr6eJdSU058pvDmJB2Pvc3pekn5wFueJkKKI+e58BEsWdHFUooF
        vTakK05bgBwPNdNL1ORiMpAnBP5N2z/r/hcq/pEkfVYBTbYWzVMdY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB125C71B3;
        Mon, 10 May 2021 03:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54582C71B2;
        Mon, 10 May 2021 03:32:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Firmin Martin <firminmartin24@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 2/8] format-patch: confirmation whenever patches exist
References: <878s4ngta2.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
Date:   Mon, 10 May 2021 16:32:49 +0900
In-Reply-To: <878s4ngta2.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
        (Firmin Martin's message of "Mon, 10 May 2021 05:30:13 +0200")
Message-ID: <xmqq8s4nqc0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC8EC870-B161-11EB-BE73-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Firmin Martin <firminmartin24@gmail.com> writes:

>> True.  But if we require confirmation before overwriting patches,
>> that would be overall worsening the end-user experience, I am
>> afraid.  In a 5-patch series with a cover-letter that was formatted,
>> proofread, corrected with "rebase -i" and then re-formatted, unless
>> you rephrased the titles of the patches, you'd get prompted once for
>> the cover letter (which *IS* valuable) and five-times for patches
>> (which is annoying).
> This is true for this patch, but the semantics changed after the patch
> #3. I really should have squashed them together to not create
> confusion. Sorry about that.

No, please keep them separate.  What we can do to avoid confusion
like I showed is to make a note on the earlier one, saying "with
this the user experience looks like this, which may be suboptimal
for such and such reasons, but in a later step it will be improved
in this and that way".
