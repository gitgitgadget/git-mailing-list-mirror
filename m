Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084A3C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61B260F94
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 21:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhHDV5H (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 17:57:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62599 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHDV5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 17:57:05 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BADC01384CF;
        Wed,  4 Aug 2021 17:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rwfh2mXolkzojZsOX2SLBeiKHTNQYsHGEmr7C8
        XM4ds=; b=tX67JjNZdJCTeMz+JoiXzXAQFyFrEWJv3Z4AQwDJB8BqmW3ut9KU4d
        aKto4g5g04iFQpTHR+rbHtGEsc/Pk8CLTJRCpJBP4IWv3pHQRTgGcR6gQgVCcq+s
        /1u1RfaFiMw19he7evQnPLJhIl5hknsWqH+ufWWgFKm5E2QfFmUHc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B48981384CE;
        Wed,  4 Aug 2021 17:56:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 092D41384CC;
        Wed,  4 Aug 2021 17:56:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] connect, protocol: log negotiated protocol version
References: <f79ab95af6da3da710da2112cfcae4a042b7f7fb.1628020616.git.steadmon@google.com>
        <YQmxSxTswHE/gTet@nand.local> <YQsIscghtbpKI/OI@google.com>
Date:   Wed, 04 Aug 2021 14:56:47 -0700
In-Reply-To: <YQsIscghtbpKI/OI@google.com> (Josh Steadmon's message of "Wed, 4
        Aug 2021 14:37:53 -0700")
Message-ID: <xmqqh7g4naao.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DE5917AA-F56E-11EB-A5C0-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2021.08.03 17:12, Taylor Blau wrote:
>> On Tue, Aug 03, 2021 at 01:13:02PM -0700, Josh Steadmon wrote:
> V2 will include a format_protocol_version().
> ...
> Thanks for catching this dumb mistake. Fixed in V2, and added tests to
> make sure the trace message shows up on both client- & server-side.

Thanks, both.  I was about to merge the original one to 'next' as a
"good enough" version, but you caught me just in time ;-)

