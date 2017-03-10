Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E06321FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 19:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755377AbdCJTnd (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 14:43:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56177 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755490AbdCJTn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 14:43:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 11CF16905D;
        Fri, 10 Mar 2017 14:42:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EJJTJ5WPrGEVJ127XVrnmHxGUFM=; b=jIIDUl
        t6ifZipmbF+zt7NDysLb2cxSg6ZWewNDHYsgjSUkk/7ykH6AHzCf4782uXrcUV+v
        aTwH0vfw/jTLrQqFun5SY3ck5G87CUxoTBNhByqDMOBjCQQZTG9e0hB/uWQH0K7c
        rHTXR1B4OQXqv2C7o4JXOPm3/5HOt36rT/hBA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xg7VzGn2bHLau3g6VIesmC+kk0ZxSK5S
        kk1i1gISgt/rFIlsp7q1Y9msbx5/0/CtdpYgcuD3rriqmt2a4l4lKpAkSyXLAJhM
        suZfoQTHshPoJ1RNvas62LpsW/p/gvXHXjdBZY3Xpkl/ohdPnUqgEZIMgvXsHr2l
        uWTYw1IxBSM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B1636905C;
        Fri, 10 Mar 2017 14:42:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7CF816905B;
        Fri, 10 Mar 2017 14:42:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Valery Tolstov <me@vtolstov.org>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH v3 2/2] submodule--helper.c: remove duplicate code
References: <20170309003858.GB153031@google.com>
        <20170309012734.21541-1-me@vtolstov.org>
        <20170309012734.21541-3-me@vtolstov.org>
        <20170309181837.GF153031@google.com>
Date:   Fri, 10 Mar 2017 11:42:50 -0800
In-Reply-To: <20170309181837.GF153031@google.com> (Brandon Williams's message
        of "Thu, 9 Mar 2017 10:18:37 -0800")
Message-ID: <xmqqvargyl39.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF5D9644-05C9-11E7-B79B-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 03/09, Valery Tolstov wrote:
>> Remove code fragment from module_clone that duplicates functionality
>> of connect_work_tree_and_git_dir in dir.c
>> 
>> Signed-off-by: Valery Tolstov <me@vtolstov.org>
>
> Looks good.

I'll queue with your Reviewed-by: added.

If sb/checkout-recurse-submodules is going to be rerolled, I'd
appreciate if it includes this patch inserted at an appropriate
place in the series, instead of me having to remember re-applying
this patch every time it happens.

Thanks.
