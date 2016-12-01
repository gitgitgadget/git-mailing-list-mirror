Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8ADD61FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757068AbcLAU46 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 15:56:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60028 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753421AbcLAU45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 15:56:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C49E2540DF;
        Thu,  1 Dec 2016 15:52:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1dl/x8BhDcHhcqVeAFKCkioIPgM=; b=hnXe3W
        BOs8Qa4xVD3DrWfSjdKY4kw4MhUwpTdM+Y2ShvyQE5fk86zWnMNPCtbZxBrIRCNO
        gXxJ9Ifq8HIpa0Ks4pD5i0IvzX/cq9563zsQxef4Gq4Q62FeGJ9Gx1X0IybEjUx+
        ckMTc/Aod2wIyQBJSEX5R9jlSQGdS1j4mmmKk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K/ghMb1G9p2NqtbjsW/AhYKhvfiUMQc+
        6+ThhUSIgtgHArXGxJsH/LaGT6i53GfBnaMvJd3kHgdE4AafgdDNw0m1owDsF1Fq
        fPECRZzwwIftqeQVfZqgUh3zMxFkUQpo9goFap/9I+tjsrL6/ghUgSIDd/fAiDoe
        J/+DXw6mTk0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD521540DE;
        Thu,  1 Dec 2016 15:52:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 356E6540DD;
        Thu,  1 Dec 2016 15:52:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diff-pairs tool
References: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
Date:   Thu, 01 Dec 2016 12:52:05 -0800
In-Reply-To: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 1 Dec 2016 15:40:43 -0500")
Message-ID: <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0577D0DC-B808-11E6-AB2C-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This takes the output of `diff-tree -z --raw` and feeds it
> back to the later stages of the diff machinery to produce
> diffs in other formats.

A full circle.  This reminds me of the experiment done more than 10
years ago at the beginning of the "diffcore transformations" design.

