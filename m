Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C73C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 21:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75EA360EE9
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhHJViy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 17:38:54 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55655 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhHJVix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 17:38:53 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4FFF15203E;
        Tue, 10 Aug 2021 17:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8dkq1wC35gYZPfEPKF/23IO/DYTIOT3dU30Fwd
        d8ib0=; b=xvmUtDr1YcbS60bib9hzR5hPefFpHLGQ7kh8QzLV5ZhPib3oHMI3Ee
        605j/D4a8wpBu5h6uZ0FEJdAGaiTabalbut3MIDGdAW5ZkJjdTjO/rEdNxIe2dhl
        jVQRxShew97vbe8JixZNUJ1f87KT0Ppmm8PUrrg5V01KNxlJ0QTnw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDAA215203D;
        Tue, 10 Aug 2021 17:38:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2FD8D15203C;
        Tue, 10 Aug 2021 17:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/7] grep: typesafe versions of grep_source_init
References: <cover.1628618950.git.jonathantanmy@google.com>
        <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
Date:   Tue, 10 Aug 2021 14:38:26 -0700
In-Reply-To: <e5e6a0dc1ef59b2ab419816e463814d93115e7f6.1628618950.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 10 Aug 2021 11:28:41 -0700")
Message-ID: <xmqqlf59c759.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CACA92A-FA23-11EB-82E0-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> grep_source_init() can create "struct grep_source" objects and,
> depending on the value of the type passed, some void-pointer parameters have
> different meanings. Because one of these types (GREP_SOURCE_OID) will
> require an additional parameter in a subsequent patch, take the
> opportunity to increase clarity and type safety by replacing this
> function with individual functions for each type.

Nice clean-up.
