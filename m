Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D1641F42B
	for <e@80x24.org>; Wed,  8 Nov 2017 05:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752988AbdKHFZO (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Nov 2017 00:25:14 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54606 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752980AbdKHFZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Nov 2017 00:25:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AB109BA8A1;
        Wed,  8 Nov 2017 00:25:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NhlnbpTuok4HUFW3b6G5RDOuA7I=; b=mfhtYQ
        X6uOm1vwnna9dT7ojEMqGvPHJEmBQIsGdUDAvmHbp3ArTIYu63JpJByXW0yNksik
        TL/tHK3uF86VAGnqzZZUQyGNQGZhLXSonQM5ZzR2vjAL8tKVfHc19dbjlYEw0yjB
        er3IsDWeLBp1XQlwfj7BicNJysATPJwDnMupc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RptTL8HKAoGqvvJlLw04RVTRWsx1wAeq
        X+sPbfpjM2biYXAnrGQgQNpTLaP8M/tPkKaaLp4epgaYkOOtI2ebiz3fa2cqHJvX
        QOWoOxRZAnYsnYAJ5686yrhWE+4EwNv/+n4zAQQaKWV7dOlnSjDFUyRtbdcMID8f
        b977+KIJ0h0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A3A25BA8A0;
        Wed,  8 Nov 2017 00:25:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2A1E7BA89F;
        Wed,  8 Nov 2017 00:25:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 0/6] Partial clone part 1: object filtering
References: <20171107193546.10017-1-git@jeffhostetler.com>
Date:   Wed, 08 Nov 2017 14:25:10 +0900
In-Reply-To: <20171107193546.10017-1-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Tue, 7 Nov 2017 19:35:40 +0000")
Message-ID: <xmqqmv3xl4uh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31973F50-C445-11E7-A3F7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Here is V3 of the list-object filtering.  This addresses the
> comments on the mailing list for the V2 series as well as the
> various TODO items I left in the code.  I also documented some
> of the bit flags and fields that I added.
>
> In the blob size filter, I removed the ".git*" pattern matching
> for special files.  I don't think we need it any more and it
> simplifies the code.  This patch series does not support
> traverse_bitmap_commit_list() and the --use-bitmap-index feature
> in rev-list, but by removing the ".git*" pattern matching now
> we should be able allow filtering and bitmaps to be used
> together in a future effort.  (That is beyond the scope of
> the current partial-clone effort.)
>
> With this patch series, I think part 1 is complete unless there
> are further comments or questions.

Thanks.  

I tried to rebase the other two on top and queued them in 'pu'.
