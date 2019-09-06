Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF331F461
	for <e@80x24.org>; Fri,  6 Sep 2019 20:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389915AbfIFUeJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 16:34:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56067 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbfIFUeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 16:34:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0764E3402C;
        Fri,  6 Sep 2019 16:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DehGKwq+m7MFB49tKePOqPomU+A=; b=bWnKth
        QfUElLWjJcMDdizU1m5A0oU3o8YPuj5FlzwpvaamNwrxIdsDOAtBrJ73zMlVjC76
        XHIC3VyYria0lQGklsFz0+sd91eNdN8/jYy2wbpTaMLQpIWaskHxUX1FgXhGf1AD
        6P6hoCJFk+nsFzvitZlGYCOD26sT6o0LaIVWk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YZT2p1H6QMOWOz2pbB7O1QsS0XTQSZ16
        MDzJ7tQ7PDOIZF0pGH6otAARhvnFYrX53/zwhcmu4td+p7nzheh1bMctmLtznBFx
        6pBomGVJHRKqzxBDgvzFhbSXYtXHeOYfLPBFHtTJpbTDfMSoZYnCsVrfagsDoxsc
        37m2fmIuAvA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F37033402B;
        Fri,  6 Sep 2019 16:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B4483402A;
        Fri,  6 Sep 2019 16:34:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, pclouds@gmail.com,
        peff@peff.net, jon@jonsimons.org, matvore@comcast.net
Subject: Re: [PATCH 0/5] Refactor excludes library
References: <pull.329.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Sep 2019 13:34:04 -0700
In-Reply-To: <pull.329.git.gitgitgadget@gmail.com> (Derrick Stolee via
        GitGitGadget's message of "Tue, 03 Sep 2019 11:04:54 -0700 (PDT)")
Message-ID: <xmqqtv9pmaf7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABFFBCC8-D0E5-11E9-97F2-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I had started working on v2.23.0, but found adjacent-diff conflicts with
> md/list-objects-filter-combo [2] and js/partial-clone-sparse-blob [3]. Those
> branches are independent, but the conflicts with
> md/list-objects-filter-combo were more severe (and that branch seems closer
> to merging) so this is based on md/list-object-filter-combo. Hopefully the
> conflicts with js/partial-clone-sparse-blob are clear enough to resolve
> easily.

Thanks.

I did screw the resolution up in previous integration, but I think
what we have today is in a good shape.
