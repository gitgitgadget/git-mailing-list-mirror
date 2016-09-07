Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998931F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752266AbcIGXCX (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:02:23 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64135 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751400AbcIGXCU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:02:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 975EA3AD99;
        Wed,  7 Sep 2016 19:02:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3zYCbb89fRt0x/fE6Mno5RHp2Ko=; b=hGf4SD
        7N0UazAehYyQewbBZDsaPHMrcDEr+wE7KWA1AOZiA2lEsfMtBEHWi9OyeC3gBCrK
        rgX2HARbKulX9GWrskc/rBqCw2+j0KqGyupjlUbr8Nu2xCPnQBKhW12Ha37h6JlV
        aoX2/6fEsnvN4iNvd/yxSvm3PPkx+IhYKjEAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hmqp9WPXdVMG28dnpywTSK9Zj0r08rHe
        P16kyV3OSYISMFgmjRqchP9mFwaF4cSgI+HkMqR7W5VBka1R/ZeAHrrtznG0G7Q9
        BTrx9n+avUtNS5yGyTz0HGhkJIDIzffXvh2Fx9zqRnCw4driR+Hy8H46sAeVMdpX
        POfkCzqULrk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FEB13AD98;
        Wed,  7 Sep 2016 19:02:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 14C5C3AD97;
        Wed,  7 Sep 2016 19:02:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        spearce@spearce.org, sbeller@google.com, peff@peff.net
Subject: Re: [PATCH v2 2/2] connect: advertized capability is not a ref
References: <cover.1472853827.git.jonathantanmy@google.com>
        <cover.1472836026.git.jonathantanmy@google.com>
        <cover.1472853827.git.jonathantanmy@google.com>
        <174c8ca6638f1cd3145a628925e65655b56af366.1472853827.git.jonathantanmy@google.com>
        <xmqqoa3zocud.fsf@gitster.mtv.corp.google.com>
        <20160907203836.GB25016@google.com>
Date:   Wed, 07 Sep 2016 16:02:16 -0700
In-Reply-To: <20160907203836.GB25016@google.com> (Jonathan Nieder's message of
        "Wed, 7 Sep 2016 13:38:36 -0700")
Message-ID: <xmqq1t0vl3ev.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20A1212A-754F-11E6-94F7-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Given that there aren't any servers that are going to produce this
> kind of bad input anyway, I prefer a die().

That would certainly put bigger pressure on the folks who write
buggy stuff in the future.  If we know that nobody produces such
output, I'd prefer to forbid it, of course.  It's just that is not
what this 2/2 implements ;-).

