Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C53C5519F
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 02:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A37DC246CA
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 02:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="dHq0KfLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgKSCQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 21:16:44 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59795 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgKSCQo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 21:16:44 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38025110051;
        Wed, 18 Nov 2020 21:16:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PQ+Y2Ftd5X0M/jaqTUPrs1oT2Ic=; b=dHq0Kf
        LVh3RcbIS0vQNtpCfUyTsXps1lOPyaHt8aPEbKGqhtQDat9/LmYEL3cEPvKf9yfj
        CFP58Rts2jSoVgO0Msm3GfcsWCWiLLydjwVsNmhRxTbKFlstnNzV4zrKGQ2ntfLx
        Aojd6vK1vK849eaXN30xpY26VC6AvBC52XwnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Q7Eg24A6puNXtHq6bV6cMMyUb0lRIcsQ
        o76lcqOb1A/iEsxn/q/5Fd0P31s+acTfDDNC6wPMpZy1d1wgz0DYwHsNoKiJFg1M
        xwHIQdsMRI27BsTwMoBiALVtjh2a74NE6opDYEELApehOCdKG9DZx/KktwwjuUK8
        c0iSxLIa0UE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FEAD110050;
        Wed, 18 Nov 2020 21:16:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73F4611004E;
        Wed, 18 Nov 2020 21:16:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: ds/maintenance-part-3 (was Re: What's cooking in git.git (Nov
 2020, #02; Mon, 9))
References: <xmqq7dqu9jwh.fsf@gitster.c.googlers.com>
        <d0123439-236c-1a62-294b-a3373465eadb@gmail.com>
        <20201116235642.GA15562@google.com>
        <xmqqh7po7r3w.fsf@gitster.c.googlers.com>
        <20201117010709.GB15562@google.com>
        <29212864-ab96-5757-cbfb-f5621a43f8d8@gmail.com>
        <xmqqlfez6alb.fsf@gitster.c.googlers.com>
        <f8b1a1cc-dcda-0e53-4c46-bb5bfff3fdd4@gmail.com>
Date:   Wed, 18 Nov 2020 18:16:39 -0800
In-Reply-To: <f8b1a1cc-dcda-0e53-4c46-bb5bfff3fdd4@gmail.com> (Derrick
        Stolee's message of "Tue, 17 Nov 2020 16:12:08 -0500")
Message-ID: <xmqqd00ayttk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 432D2E10-2A0D-11EB-8A37-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I will get started on this fix as a series on top of part-3.

Thanks.  Not just part-4 but Dscho's test update also depends on
this, so let's see it corrected soonish.
