Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA5AB1F732
	for <e@80x24.org>; Thu,  1 Aug 2019 18:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbfHASSq (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 14:18:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51423 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbfHASSq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 14:18:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 63C44150D86;
        Thu,  1 Aug 2019 14:18:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Iabss+YGN8ow
        eYDFf/KsQXP0UIg=; b=g+dCPk/PJaj2T8qpsG2cKCqBs+JkVVTVIaddoIGr+chP
        6J04Kx+9Ysj5ZqE8zavMxI/7A39fUQ6K98bLLY+ryS37gkpe1LEP8qDq7Yf2cJiz
        3LEy3UMzNKaoIKJRNpvHhp20rPwdB9lR76m8HpZcV0PeN7c8T1Nx9oIk0Pdalmg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dbQWGb
        s0lGyi6FqJ++20UwpdNxWM5a9zoYvsGOYF4vm519PrFkT4Rr5ozsoa0mIKWUKddX
        xV4plEO29av4dbKxSWZ6Yowu93XBBBBuSg16IXMe1rXfgf3UKEAWb3t8zM47zcNe
        4QC8iFxiNDPn0sEozOUPStxMhKyBfB7AGXNzA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5BA1A150D85;
        Thu,  1 Aug 2019 14:18:44 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C5D59150D83;
        Thu,  1 Aug 2019 14:18:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: warn against appending non-httpd-specific tests at the end
References: <20190730214000.GT20404@szeder.dev>
        <20190801155309.15276-1-szeder.dev@gmail.com>
        <20190801155309.15276-4-szeder.dev@gmail.com>
        <20190801174126.GU20404@szeder.dev>
Date:   Thu, 01 Aug 2019 11:18:42 -0700
In-Reply-To: <20190801174126.GU20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Thu, 1 Aug 2019 19:41:26 +0200")
Message-ID: <xmqqzhksn3zx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CBBD5F6C-B488-11E9-9DDD-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Thu, Aug 01, 2019 at 05:53:09PM +0200, SZEDER G=C3=A1bor wrote:
>> Subject: Re: [PATCH 3/3] tests: warn against appending non-httpd-speci=
fic
>>  tests at the end
>
> This subject line kind of sucks, doesn't it?!
>
> Alas I had a bit of a hard time coming up with something better.  So
> far the best (well, least bad) I could think of is:
>
>   t: warn against adding non-httpd-specific tests after sourcing 'lib-h=
ttpd'

That reads well.

Thanks.  It must have been tedious to make sure moving tests around
won't break them due to some (hidden) inter-dependency among them.
Very much appreciated.


