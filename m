Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21DF620756
	for <e@80x24.org>; Fri, 13 Jan 2017 18:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751077AbdAMStX (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 13:49:23 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52429 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750968AbdAMStW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 13:49:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 114C05D1CD;
        Fri, 13 Jan 2017 13:48:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6XL8W6Ybu9OHdmfE8/dISYlCsII=; b=EU6q6D
        7Q77dsFXKirXdB9R7h0bUD0sM4SVQyKTL+HjnEl2aXTqnI+uSxdVKIpgLG+d+LcM
        0qV1UfgQVOAsdICi+lhTQvnhhzuodSFILelbhaYUoYUpaR8eI9zeQQbvUVQV02cV
        uoGjUxMTzvETQlliZX6ZfdVbWLxDhpABA6U+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lagoTg9IJlD71wzLkRz+sVpdT2lBv27h
        ap1Zx2MjYsbKNMIVlocOdTUeICvsSk3fZO8NZeRGkZKNI9Bj70TL5gpxNykf2Gyy
        8nO4Zh3qxdxLUEPJXtNx2umI3Af0fAJil2FeDEk9xIeewchTO4QK2oDRgsYzstdG
        0yFQk4txxeI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 07E645D1CC;
        Fri, 13 Jan 2017 13:48:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 630D65D1CA;
        Fri, 13 Jan 2017 13:48:35 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/5] extend git-describe pattern matching
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
Date:   Fri, 13 Jan 2017 10:48:33 -0800
In-Reply-To: <20170112001721.2534-1-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 11 Jan 2017 16:17:16 -0800")
Message-ID: <xmqqpojqhk3i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E372796C-D9C0-11E6-AF60-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Teach git describe and git name-rev the ability to match multiple
> patterns inclusively. Additionally, teach these commands to also accept
> negative patterns to discard any refs which match.

You made quick responses to reviews with "will change", so I am not
queuing this round to my tree; please don't mistake that as my
indifference or opposition to the topic.  This sounds like a good
thing.

As to the semantics of mixing positives and negatives, I would
recommend this to follow how positive and negative pathspecs mix.
IIRC we chose to use the most simple and easy to explain option,
i.e. a thing must match at least one of the positives and must not
match any of the negatives to be considered a match.


