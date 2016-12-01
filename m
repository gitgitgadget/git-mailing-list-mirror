Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC061FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756691AbcLAU6Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:58:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56794 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753335AbcLAU6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:58:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 022D254AC5;
        Thu,  1 Dec 2016 15:58:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tfIxr/PTVJDHI33Hn6JgOnrgP+w=; b=oawK6D
        ZUlaBl/PX7c8CPxs4l8NlrOa+dG4566YifI1yjXIZqEe9WdTqOhuYo8vVkHxVa+C
        yTkbC7kQ1IpyQL8+uAu62QXRZGwj/3YH5dKZcQFwhOHdk6xabxr0tkUhzcFMqB78
        U6eEqb73OkbklfF4j4hXJWKAxAa+wsOaOV4eU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=POnjfKETTrOFrKthR9a0nvuYTkLA/mSP
        a2t1a9Up2HD5w51+WIJcineAYDeVPvnaM/c7YWv+rPGuOj/Qk7SgIs9+bcH1h1lO
        dJrjL3oO8s+jF93xq5Ywl1y9mgUcN1IDSUpdE6xlgfkOusH89D7Vmpl7V4GRmd+A
        KzjTOzCumCU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EDB8554AC3;
        Thu,  1 Dec 2016 15:58:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 679A254AC1;
        Thu,  1 Dec 2016 15:58:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diff-pairs tool
References: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
        <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
        <20161201205504.flgaf7dwv3b3dkkd@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 12:58:21 -0800
In-Reply-To: <20161201205504.flgaf7dwv3b3dkkd@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Dec 2016 15:55:04 -0500")
Message-ID: <xmqq7f7j8iz6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E51B8A1C-B808-11E6-A471-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 01, 2016 at 12:52:05PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > This takes the output of `diff-tree -z --raw` and feeds it
>> > back to the later stages of the diff machinery to produce
>> > diffs in other formats.
>> 
>> A full circle.  This reminds me of the experiment done more than 10
>> years ago at the beginning of the "diffcore transformations" design.
>
> Heh, I didn't even think to dig for prior art on the list.

It took me a while to dig it up because the topic is so old, but

https://public-inbox.org/git/Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org/

is the thread I had in mind.  The idea of rename detection followed
soon afterwards.
