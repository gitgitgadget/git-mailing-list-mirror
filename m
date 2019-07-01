Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB9551F461
	for <e@80x24.org>; Mon,  1 Jul 2019 22:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfGAWYk (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 18:24:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50820 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfGAWYk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 18:24:40 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 321356E0F3;
        Mon,  1 Jul 2019 18:24:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QQBcYnHn9fLeW7+guLidj3SYTzc=; b=I7xqmX
        FuhGhyF4Uj1iFnAiVhOzrnCU4J5AjwoftKfUspvt5Uairs2GU0jmYm/aiqU321de
        bjsb700Djyd27wSSHBvqMx49tsuMmjgN2xMYTH0I5ooz+gFVFMkujKAzDS4pZyL0
        2OKSubvmdgnVAlR9ES2IQ/e+h0CBqAS1afkT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WAtpRjRJsZdNkS0l49oc6veO6+1vCq8e
        Cn3deUxx0IoPrZvSWqm7v7tDlP8cDHJY0WVZD/0+ioH1cz3y2YxHU6/qu5fmSlBh
        h8f9cNI8BaDoegJ/Gjaj0LlB+QSHa/09mI/mUg8pWbFh5Hf7wxhC2u22qxe9F170
        J0cf3cIpSRg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A8796E0F2;
        Mon,  1 Jul 2019 18:24:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B4C76E0EF;
        Mon,  1 Jul 2019 18:24:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] test-lib: introduce test_commit_bulk
References: <20190628093751.GA3569@sigill.intra.peff.net>
        <20190629045322.GA8155@sigill.intra.peff.net>
Date:   Mon, 01 Jul 2019 15:24:35 -0700
In-Reply-To: <20190629045322.GA8155@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 29 Jun 2019 00:53:22 -0400")
Message-ID: <xmqq7e915r6k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02BE0496-9C4F-11E9-802B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Here's a re-roll of just the first patch of this series, since that was
> the one that got all the comments (and the others are textually
> independent).

OK, will replace and then queue an adjustment for 6200 which used to
use \$n but now must use %s instead.  Let's see if people spot things
worth pointing out in the remainder of the series (or this one, of
course, but I found this step quite sensible).

Thanks.
