Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0838CDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjJLQTR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Oct 2023 12:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235756AbjJLQTP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 12:19:15 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A4ED8
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 09:19:14 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 97AF819CE1E;
        Thu, 12 Oct 2023 12:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=Gu45J1QJ6+0qtvuP0Ay2om3nQ8VXPcdhK4uogL
        P7CRA=; b=gZOSSpBd/wtV8mg3wrNgDokChGcymI95ogDDIjDtFAKBRvDvbAp5M6
        FjF5KO5+vpOyA4PNI9QZ/ogcIsbcDMP45A/zr+AfdIu9f7KUckq581sJO2qTU2TJ
        kOvnfklVwrggi2isvKYaYoBlspDlSItWIo84YAdmZOu10DsPyHwQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F43F19CE1D;
        Thu, 12 Oct 2023 12:19:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 06B7519CE1B;
        Thu, 12 Oct 2023 12:19:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     Jeff King <peff@peff.net>,
        Christoph Anton Mitterer <calestyo@scientia.org>,
        git@vger.kernel.org
Subject: Re: why does git set X in LESS env var?
In-Reply-To: <3946c06e90604a92ad0dddf787729668@manjaro.org> (Dragan Simic's
        message of "Thu, 12 Oct 2023 07:30:47 +0200")
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
        <xmqqa5sokdd3.fsf@gitster.g>
        <20231012000416.GA520855@coredump.intra.peff.net>
        <xmqqh6mwipqi.fsf@gitster.g>
        <3946c06e90604a92ad0dddf787729668@manjaro.org>
Date:   Thu, 12 Oct 2023 09:19:11 -0700
Message-ID: <xmqqr0lzhkzk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14E1B7A6-691B-11EE-BF6A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> Please note that dropping "-X" and leaving "-F" would actually
> introduce the inconsistency that I already mentioned.  To reiterate,
> short outputs would then remain displayed on screen, while long
> outputs would disappear after exiting less(1).

Good point.
