Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E99EC43219
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 00:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiJKAJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Oct 2022 20:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJKAJZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2022 20:09:25 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 379B47C1C4
        for <git@vger.kernel.org>; Mon, 10 Oct 2022 17:09:25 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C495A1C09AD;
        Mon, 10 Oct 2022 20:09:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/6F6UhGYR2+ouzCgWTna73sWCGJ8yzUoA+0SP
        H8vRs=; b=fvvifvS9DjHYXVvz/cxrBXtG/WV3SpLI+PLtrvABm1ed+L7WRVVF8d
        OoIxyz7TYFIjALfWkA/qhnauRftdM69NsYlvotAH946iz1aPwDikOD7s94ptwIhl
        JuTGl7ZaWQEsy2ucRr4Bcyb/htvzS+1gGWByy41NcomUicndLzjsY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCE4C1C09AC;
        Mon, 10 Oct 2022 20:09:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF7CE1C09AB;
        Mon, 10 Oct 2022 20:09:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ci: add address and undefined sanitizer tasks
References: <xmqq8rlo62ih.fsf@gitster.g> <xmqqtu4bz2fw.fsf@gitster.g>
        <Y0SyH34tdXQK2qhA@coredump.intra.peff.net>
Date:   Mon, 10 Oct 2022 17:09:20 -0700
In-Reply-To: <Y0SyH34tdXQK2qhA@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 10 Oct 2022 20:00:31 -0400")
Message-ID: <xmqqy1tnxlu7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F50BF0CE-48F8-11ED-B238-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The signal of "passed with asan, but not ubsan" (or vice versa)
> is not that useful in practice.

Ah, that may be true.  I'll try that in the next version.
