Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CA2F20954
	for <e@80x24.org>; Thu, 23 Nov 2017 02:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbdKWCFF (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 21:05:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65215 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751525AbdKWCFF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 21:05:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 81C7EC0A24;
        Wed, 22 Nov 2017 21:05:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CMJT0QBJEL6aGiqLKOjCbZXHvUc=; b=b/P70m
        lFt7pV471VpQ4ELV1RzL7G2OilthbbbZ5IgnkuldlNc1zL/m6j50mYMvQ/Vn62Ru
        QSPUMjL55GPZR0bXCNL2BByHrs0RxTU/ixyzvLSsK9JkeXuVu0M6NR0Xj91xOdd2
        pjSF1yRVZzrWz/FxXjtjhhPmaQ2OqYteBywAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v9VmCq1pATJbvuHJ7+GcW40SPFt1mPLU
        9LQPdsIy9TOU4jig3sWGC6UeXvwovWP5qt4l46Z5T9hr0V42DWU85Y2NUYO8FAHB
        ONyMgyVGfZl1inpXAMBWeto0nQdQIISRRL8tUBE+rSTQxqCuteqnwO83rnwpODU/
        NeOZqEZHvRY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77E94C0A22;
        Wed, 22 Nov 2017 21:05:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5DF36C0A21;
        Wed, 22 Nov 2017 21:05:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH] xdiff/xpatience: support anchoring line(s)
References: <20171121221717.155301-1-jonathantanmy@google.com>
        <20171122234152.72901-1-jonathantanmy@google.com>
Date:   Thu, 23 Nov 2017 11:05:01 +0900
In-Reply-To: <20171122234152.72901-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 22 Nov 2017 15:41:52 -0800")
Message-ID: <xmqqa7zdsqb6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B7FF9D5E-CFF2-11E7-BC34-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> One thing that might help is to warn if --anchor is used without
> --patience, but I couldn't find a good place to put that warning. Let me
> know if you know of a good place.

How about dropping --anchor option and do it as "--patience=<pattern>"?
