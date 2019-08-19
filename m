Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F211F461
	for <e@80x24.org>; Mon, 19 Aug 2019 17:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbfHSRRi (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 13:17:38 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57574 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbfHSRRi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 13:17:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE9716F8F7;
        Mon, 19 Aug 2019 13:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Tnfr5YvWZIcHtx4Uh4BpwY6GHlI=; b=IoYRL7
        RElenP9NVGSMPaILTG6ABTLNdascrqBExp2SEyy2GyOqdEiAsOpRlHGLudMt5Bmi
        V1xQNSDkW99kJ0Ax98YclokXxEDNzuMys1C+N8G+k9DV84kXLcJLp6XyH8mDwgRb
        f0mnzUqTh9ZpUiyf7zz6RFubKp4HHl0TcAAL4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ORSFC23287aZqRtUTuv/Y/j1dlHbb0+S
        92oIAXukfnZzm0gqPN5AyYkUEWx5Bb6r0Rd00lChZk3xgLOWJYVOcZL4hasw4GK6
        5LJ6nfsAHcSQT0sQ/JzgyYREE8IAvlP3AbOqxy4juLgs9ZyNicCS+jlBsHngAfxM
        GaqaY+FAzVc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A820E6F8F6;
        Mon, 19 Aug 2019 13:17:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CF7F56F8F0;
        Mon, 19 Aug 2019 13:17:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 21/24] merge-recursive: split internal fields into a separate struct
References: <20190815214053.16594-1-newren@gmail.com>
        <20190817184144.32179-1-newren@gmail.com>
        <20190817184144.32179-22-newren@gmail.com>
Date:   Mon, 19 Aug 2019 10:17:32 -0700
In-Reply-To: <20190817184144.32179-22-newren@gmail.com> (Elijah Newren's
        message of "Sat, 17 Aug 2019 11:41:41 -0700")
Message-ID: <xmqqy2zpxefn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C4E7430-C2A5-11E9-A364-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> merge_options has several internal fields that should not be set or read
> by external callers.  This just complicates the API.  Move them into an
> opaque merge_options_internal struct that is defined only in
> merge-recursive.c and keep these out of merge-recursive.h.

Makes quite a lot of sense.  Thanks.
