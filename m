Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF786207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 19:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934873AbcJFTY4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 15:24:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934857AbcJFTYy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 15:24:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9759043A9C;
        Thu,  6 Oct 2016 15:24:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Bnx98Rst+biDHzqiIj4gvjEZvZQ=; b=tnZ6y2fX4Xwbof7qqwDX
        s2vDXynJefdYcAhog/UQ1fUCRFD38mJPjie6hqJLXW1M3Ex4g9NEjJKJT8v3d16Q
        LJ5g4n2Zo3og2ItEUttWdr8U4D4/fYZNl2FcML8/hhjPV9fTaj1et1VXOssJAlkS
        cblHwpAHFlbF0/V9g+BpnZk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=h4p7Istg9R/srbuL2mz3Ky9m1FSfR8/Apxk8Z7Bko/XbTa
        eAlcOjF0g0FDmrpS0DZm5xrEbSlqA1uu9MDlCPTK+7QRkhYSxtLpZMwG02aaGQ0Y
        TIlITN+3Xpx4n5xP4Xt81ReOP6elA8NPCD8sQ2n6/daLzOvWc7bMWs4uB3PJE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F75A43A9B;
        Thu,  6 Oct 2016 15:24:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0ECB443A9A;
        Thu,  6 Oct 2016 15:24:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 0/2] place cherry pick line below commit title
References: <cover.1475176070.git.jonathantanmy@google.com>
        <xmqqtwcycqul.fsf@gitster.mtv.corp.google.com>
        <11e41a94-df8c-494a-584b-e2bc8da2de3a@google.com>
        <xmqq8tu99o75.fsf@gitster.mtv.corp.google.com>
        <xmqqtwcx8669.fsf@gitster.mtv.corp.google.com>
        <e03fdabd-6690-5244-5f79-1715b0364845@google.com>
        <xmqqbmz16y42.fsf@gitster.mtv.corp.google.com>
        <d3df0636-1975-1d08-2f34-384984c72e5d@google.com>
        <xmqq8tu55bel.fsf@gitster.mtv.corp.google.com>
        <84f28caa-2e4b-1231-1a76-3b7e765c0b61@google.com>
        <xmqqwphouivf.fsf@gitster.mtv.corp.google.com>
        <xmqq37kcufya.fsf@gitster.mtv.corp.google.com>
        <b0e43079-498a-469b-c4b6-f4fc2b8e2aa4@google.com>
Date:   Thu, 06 Oct 2016 12:24:51 -0700
Message-ID: <xmqq7f9ljn5o.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E8862CC-8BFA-11E6-8493-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> How important is this feature? It doesn't seem too difficult to add,
> although it does break compatibility (in particular, "--signoff" must
> now be documented as "after the last trailer" instead of "at the end
> of the commit message").

The sign-off has always been meant to be appended at the end of the
trailer block, so there is no "compatibility" issue.  It's just how
you phrase the explanation of the behaviour, I would think.
