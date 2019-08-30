Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B47961F461
	for <e@80x24.org>; Fri, 30 Aug 2019 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbfH3T2A (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:28:00 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58701 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3T2A (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:28:00 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id ACA9B6FE5F;
        Fri, 30 Aug 2019 15:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EMgUk1vX5EduQkIvwnqrptYrm2g=; b=s4IVyI
        zAO+DzPDqGgBShanFgWrRzkmKfBlRqYembZn7HldQuVnUEs1wutVdWVrgT2ECB8H
        +5W+Qsqfwl+A6PD1L7E7X/ikysxrfk3uRIC9FU2eD0UK31mcEVSze88O6uMCVTbn
        0Vsls0n9L33YUneUjkKKpDV5Yd5csIsnU8F8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aHUQizEeoMHJ0A/8DhVrmZwJSgB+Z0ke
        YHHf2iAFY4noK0wu/P+5TAye2NLZGTPd+9jVHlP3+umOE1JUp2Tvecx4agm4A8CB
        Wz0pJcIo4q+o4E4pTmyNniqvN3QgX64YcNla9m3OGElhcIH3jnfNhvaEMIMzTv+M
        9OJu/CN49CI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4BEE6FE5E;
        Fri, 30 Aug 2019 15:27:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D43506FE5D;
        Fri, 30 Aug 2019 15:27:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] clarify documentation for remote helpers
References: <20190829210301.18467-1-dturner@twosigma.com>
        <CAN0heSosCnn5msMX18YPwrKJzWkSWptWSFRunQdLE7T7Lc4-OA@mail.gmail.com>
        <88d9063060644dd99122bf0933f23fa9@exmbdft7.ad.twosigma.com>
        <xmqqv9uey2tb.fsf@gitster-ct.c.googlers.com>
        <c6c737c6a37c4cf7aa77e5c5ffd7a86f@exmbdft7.ad.twosigma.com>
Date:   Fri, 30 Aug 2019 12:27:53 -0700
In-Reply-To: <c6c737c6a37c4cf7aa77e5c5ffd7a86f@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Fri, 30 Aug 2019 17:45:43 +0000")
Message-ID: <xmqqimqexxl2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 448A3C8C-CB5C-11E9-AC2E-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> The only other restriction I see is: in order for the connectivity-skipping 
> optimization to be used, the file with s/.keep/.idx/, and the corresponding 
> pack, must exist.  Do you think that's worth mentioning? It seems to be 
> implied by the rest of the text.

Perhaps if you come up with a way to clarify what is merely implied
(e.g.  "this is a mechanism to name a <pack,idx,keep> tuple by
giving only the keep component to do X"), I would imaging that would
be ideal.

Thanks.
