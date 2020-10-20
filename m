Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645ABC4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:48:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C5E22247
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 21:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I6ME32VJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbgJTVsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 17:48:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52588 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389709AbgJTVsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 17:48:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 696BCFAF9D;
        Tue, 20 Oct 2020 17:48:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TyRX7gjvH+hYcaRskMZRIrM+rhw=; b=I6ME32
        VJHjIX4G9queayOMr+zJDcpfW+8a2girdzkeBWWD7+zulkljtT5V7NIX3hkd4EeE
        sxqYj4pD9iQCh3jrtJBFvwB73gjC8dF8bBchSsxozHdeIH6yDmYQ5wYCRSeg43Vl
        sUBRCSXXGeMZtwA1cX5fxZFNenDEeMPgwSU5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f5l0ZtTUMveYr11H0x3qmqiT56WkNDld
        T+ZkpjaOubHQY78z58xFJvYCNoRcgaX57OCM2c88KH+zwnQsBncEiU4Q8RsmYw8i
        Rc6+RGBhFbZtd3bufn9rF+PRmiQreqjfrk7f6kTcCwUqzqrzYjhRRujUOkwzvu7a
        pWQECKJRZt4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 62664FAF9C;
        Tue, 20 Oct 2020 17:48:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFA19FAF9B;
        Tue, 20 Oct 2020 17:48:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] apply: when -R, also reverse list of sections
References: <xmqqo8kwaagx.fsf@gitster.c.googlers.com>
        <20201020213651.691101-1-jonathantanmy@google.com>
Date:   Tue, 20 Oct 2020 14:48:10 -0700
In-Reply-To: <20201020213651.691101-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Tue, 20 Oct 2020 14:36:51 -0700")
Message-ID: <xmqqblgwa7s5.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F308B716-131D-11EB-9DA7-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Should I resend a version 2 that includes this test or will you apply
> this to your local copy?

The former, as I do not want the final version to be not shown to
the list---we'll miss a good opportunity for other people to spot
issues we didn't think about.

Thanks.
