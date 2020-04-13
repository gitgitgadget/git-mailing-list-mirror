Return-Path: <SRS0=K77S=55=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E77C2BB86
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0EED20739
	for <git@archiver.kernel.org>; Mon, 13 Apr 2020 22:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tlOZPkB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389493AbgDMWOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Apr 2020 18:14:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64738 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727871AbgDMWOW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Apr 2020 18:14:22 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E20F152C98;
        Mon, 13 Apr 2020 18:14:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FAtqeYrY8VG6vGR9GmnalWMALzc=; b=tlOZPk
        B4zofY1doYqHhtHLoijLYfX2hs/k9UpXNAdpbtDRZ3lROB5DQWjunzs1GiH3HkMw
        jjXCQ130UwV2VBGjtpraDW5NgnAZ2WwbkNTrINN7uWB1AKFsukljEu/rRldHR009
        e5WAs2udrtFp0kjuHfpM+FQtdGeTB5Hm3VMQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v0dZIKeEEVJW6cPTHBPjR0+M2OWgfSuG
        TSoK6AflRsT4ZtLLpKE5IQjk/7PbueowghQNrMitxxIix0M8/fxHBDQ7OGpKVqfI
        xuajGNeuBP+GDSebp4qnN47j7rHRDUkCvTC2ei53btyLj5n2wR4uDTd667E+tW4V
        uDzizx+Khjg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DAAE152C97;
        Mon, 13 Apr 2020 18:14:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 660D552C94;
        Mon, 13 Apr 2020 18:14:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 6/6] config: reject parsing of files over INT_MAX
References: <20200410194211.GA1363484@coredump.intra.peff.net>
        <20200410195007.GF1363756@coredump.intra.peff.net>
        <xmqqzhbjgfps.fsf@gitster.c.googlers.com>
        <20200410221549.GA2078378@coredump.intra.peff.net>
        <20200413004724.GB55122@syl.local>
Date:   Mon, 13 Apr 2020 15:14:19 -0700
In-Reply-To: <20200413004724.GB55122@syl.local> (Taylor Blau's message of
        "Sun, 12 Apr 2020 18:47:24 -0600")
Message-ID: <xmqqpncbav9g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1F90E89C-7DD4-11EA-BF33-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> ;). Making it lower than INT_MAX moves us into the territory of deciding
> what is an "appropriately" sized config file, which I'd rather not do.
> At least we can blame INT_MAX if someone has a too-large config file.

;-)  Sensible.

