Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6225ECD6116
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377281AbjJIR2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377874AbjJIR2V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:28:21 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581EAD6
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:28:20 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BE101E6B9;
        Mon,  9 Oct 2023 13:28:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=v0tUu5g9HGDPQTUwcxutBMxUXEe2leez1zPcmx
        wh0/M=; b=luDvuhS6SCfQ7HcS1gMwYgZ4BLbXD+GlMTQBfa2d4/caHVX8O4sAri
        PDe1OZ3KEwbjQaYVEzbzFbMoVPgAM+3bxdOL7BzQ1wA8szN1Dk5dpjMiANwktHCD
        kXV+NqxjzIRtrGpmaKzVcTvr/SnolFxay+CD9ZwlVTCTTTR5okcL0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 03B051E6B8;
        Mon,  9 Oct 2023 13:28:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6E3911E6B6;
        Mon,  9 Oct 2023 13:28:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] repack: free existing_cruft array after use
In-Reply-To: <ZSNWZ9+Q2eOpy91A@nand.local> (Taylor Blau's message of "Sun, 8
        Oct 2023 21:24:55 -0400")
References: <cover.1694123506.git.me@ttaylorr.com>
        <cover.1696293862.git.me@ttaylorr.com>
        <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
        <20231007172031.GA1524950@coredump.intra.peff.net>
        <ZSNWZ9+Q2eOpy91A@nand.local>
Date:   Mon, 09 Oct 2023 10:28:13 -0700
Message-ID: <xmqqttqz1z9u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3AB7E508-66C9-11EE-9F22-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Sat, Oct 07, 2023 at 01:20:31PM -0400, Jeff King wrote:
>> On Mon, Oct 02, 2023 at 08:44:32PM -0400, Taylor Blau wrote:
>> ...
>> Coverity (using the just-merged-to-next version of the workflow file!)
>> flagged a leak here. Since the topic (tb/repack-max-cruft-size) is in
>> 'next', I think we'd want this on top:
>
> Woohoo! I'm glad that this is already paying dividends.
> ...
> Thanks, I can't believe I missed this when writing this function. The
> fix looks obviously correct to me, so this has my:
>
>     Acked-by: Taylor Blau <me@ttaylorr.com>
>
> Thanks,

Will queue.  Thanks.


