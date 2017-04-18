Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6302D1FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 01:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756896AbdDRBsb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Apr 2017 21:48:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64492 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755866AbdDRBsa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2017 21:48:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FF7D73683;
        Mon, 17 Apr 2017 21:48:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xO2dh+oPVU+QSxNEUkKT7xWOjfA=; b=aXCDFz
        SHR2XC77skaMlrE8jvOBN5agtcwZ6+0gJjX3ig5Kz69VCeJ77hCjSq/Za41NSgek
        kQxnBow7xPIejF4PP4X+JMFVm0RMgco/Tx2cOWgEMTLPtzcTigS9uSJVHAIzLcDy
        x+VmqWkvzw3ABiq8lnHZr/lccNVDK+oh481oA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PUKgxI+4qZkWsR2Sr/FZDz1EwvnLzBwi
        WQptI6lrumwSBcu7PYzXcf2eacXZ2RZapKXq+9b6OCmlqc0Wijh7GAcgltHroYWH
        NZIJJTN2mWwgasvH9Azz7F3nWXvvQb637tnraMHH+xffrAlsINRjPoHeBxfA0scH
        J/t8UlwcYjA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0405873682;
        Mon, 17 Apr 2017 21:48:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B5D573681;
        Mon, 17 Apr 2017 21:48:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com
Subject: Re: [PATCH v2] fetch-pack: show clearer error message upon ERR
References: <20170410210511.8505-1-jonathantanmy@google.com>
        <20170412180602.12713-1-jonathantanmy@google.com>
        <21160598-dbb4-2f14-8e22-f6299a1d9004@google.com>
Date:   Mon, 17 Apr 2017 18:48:27 -0700
In-Reply-To: <21160598-dbb4-2f14-8e22-f6299a1d9004@google.com> (Jonathan Tan's
        message of "Mon, 17 Apr 2017 10:49:35 -0700")
Message-ID: <xmqqshl6h4es.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E7DDB52-23D9-11E7-B9DF-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio, I noticed that this did not make it into your "What's cooking"
> e-mail [1] - is there anything more that you would like to see in this
> patch?

No.  

Actually "no" is not a honest answer; "I do not know yet" is.

It's just that I haven't fully caught up with the list traffic from
the past two weeks.  I've finished a single pass and picked up most
things that got discussed by multiple people.  But I haven't read
small patches that did not result in large-ish discussions---some of
these may have been quiet topics because they were obviously good,
and others may be quiet because they were totally unintesting.
