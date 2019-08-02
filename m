Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB711F732
	for <e@80x24.org>; Fri,  2 Aug 2019 16:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfHBQhY (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:37:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61439 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729353AbfHBQhX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:37:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EBA7D7EDAD;
        Fri,  2 Aug 2019 12:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=QW7RsjU6OWhT
        1Y/n4wGP69r9Sy4=; b=rbIuF2S6IMv63JEe8NuAJ+s/H04AfyKLdnnS9uZnaX1o
        zKODyrX8vN7l2ZSopJ059CdZjSQhP7QeES/kzABlaBGjRBQ/gv6LOjUSJljoWyr1
        r93chhiwEXLoOFwMnOcO7njkMCKFVKqXjKFFAOAkiJdIpKtTEcIH+QLbqgm55UY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=mT4dF9
        uOk19siQ7KDs9fHIYlfMXNXQBsB5afhbSm4Tv0tkYD3MC+GhYIm6lDSmfCb6K3EY
        l9xonqR5gcggpC9MJfmJUQBygDObGueuG3LuGT1O1JLE3WnQYOQDNUedrqHOV4OG
        c4cwnCEjdT2+5oj9BhIE1zHAc8ULKczuyjIUs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E33617EDAC;
        Fri,  2 Aug 2019 12:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E5B427EDAA;
        Fri,  2 Aug 2019 12:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Brandon Williams <bwilliams.eng@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: warn against appending non-httpd-specific tests at the end
References: <20190730214000.GT20404@szeder.dev>
        <20190801155309.15276-1-szeder.dev@gmail.com>
        <20190801155309.15276-4-szeder.dev@gmail.com>
        <20190801174126.GU20404@szeder.dev>
        <xmqqzhksn3zx.fsf@gitster-ct.c.googlers.com>
        <20190802100956.GV20404@szeder.dev>
Date:   Fri, 02 Aug 2019 09:37:16 -0700
In-Reply-To: <20190802100956.GV20404@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 2 Aug 2019 12:09:56 +0200")
Message-ID: <xmqqo917le0z.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CB49ACFA-B543-11E9-A127-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

>> >   t: warn against adding non-httpd-specific tests after sourcing 'li=
b-httpd'
>>=20
>> That reads well.
>
> Ok.  Should I resend, or will you amend? (I see that 'pu' contains the
> old subject line).

I do not think the original was too bad, either, but I'll amend;
thanks for being extra careful.
