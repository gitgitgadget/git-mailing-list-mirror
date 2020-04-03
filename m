Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2425FC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 17:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8BF2077D
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 17:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EZyMA31J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgDCR6t (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:58:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64936 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgDCR6t (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 13:58:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11F235A1E8;
        Fri,  3 Apr 2020 13:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mjL08NFqku25aYMr332VS7yS04w=; b=EZyMA3
        1J52Zxl/a2gG56muwewGHveRZ6H7YjtTSYdv3NUmYWVob6RV7jZvBg2rdjrVSUDo
        YbqgAxo/XJaOMX7n2Mm6vk/jBK2TBeins9M+wdz0FHhucZoeN2CD03+0FEp/HWTN
        FPkNF/nnQ8XHwaxPY1y04avFSHWSMstIWF3vA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aFBYm+OA0bQK6vf9kMCBaGvo/Hz5/VJg
        Mw6TrJCmf4Co0AKXN75psONQqPd8OcH3tqjGwZFI6QB+0SARjWABVWJb7qWSXLrJ
        quKGHYM2ze0uAg9fSTrtna6+Dy28iBZjPxAwxVo+1BaLb9ub0SCQtbu28JsnkGV6
        CkshrJQSmYU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A41B5A1E7;
        Fri,  3 Apr 2020 13:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89DEB5A1E6;
        Fri,  3 Apr 2020 13:58:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/1] submodule--helper.c: Rename 'cb_foreach' to 'foreach_cb'
References: <20200402225807.8603-1-shouryashukla.oo@gmail.com>
        <xmqqo8s91ktt.fsf@gitster.c.googlers.com>
        <CAP6+3T2Kj2tfeaR+xm_B=_oJO8eWLyOjeXLm+8WSRSFSjkpUSQ@mail.gmail.com>
Date:   Fri, 03 Apr 2020 10:58:45 -0700
In-Reply-To: <CAP6+3T2Kj2tfeaR+xm_B=_oJO8eWLyOjeXLm+8WSRSFSjkpUSQ@mail.gmail.com>
        (Shourya Shukla's message of "Fri, 3 Apr 2020 11:31:34 +0530")
Message-ID: <xmqq1rp41mei.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3BF353E-75D4-11EA-BF0E-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shourya Shukla <shouryashukla.oo@gmail.com> writes:

> I apologize. I did not notice that my patch was merged.

No need to be sorry ;-)  Thanks for contributing, and keep the good
patches coming!
