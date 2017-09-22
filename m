Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42ED7202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 01:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdIVB5j (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Sep 2017 21:57:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51680 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751602AbdIVB5i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2017 21:57:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C5A56A62E0;
        Thu, 21 Sep 2017 21:57:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9cum/4Cji1p5YxqZgAj3Of6Hmt4=; b=SgwJt3
        /i1Yoe212kkMcq3Zphr1Y4tqcGWKGZaOFIn9DMaWEuF10uaWB9OYFL5b//fh8U4E
        bj5eUKHf9sQGBOi2MyLqkLYTH5rJ9Op9rbqLqnjFkpNu9MXuKtcExCv6wGFtXrj8
        owDzVSRyh1wm17yvJE7ci47bCW5ovIvkk4uWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A9MkpIB/bDNPabd+WS5fixgcC8DuXHQL
        kVkc+0EvR3b0XNxroYVr0ihs7RRElNdJfrRgtZSmVbXtzoYX6+ZJVLDuCVzS47eJ
        oie8s38QhY396xd0gYMEUteuBSriq7SaRGkwUYnPavO7HdtrJudTqpfKE6nCaRwo
        53dX9Lr2s0U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD956A62DF;
        Thu, 21 Sep 2017 21:57:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2033AA62DE;
        Thu, 21 Sep 2017 21:57:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        szeder.dev@gmail.com
Subject: Re: [PATCH v1] travis-ci: fix "skip_branch_tip_with_tag()" string comparison
References: <20170921204830.66831-1-larsxschneider@gmail.com>
        <20170921212848.GJ27425@aiede.mtv.corp.google.com>
        <4FC081C4-355E-4E62-8CD8-89C299485182@gmail.com>
Date:   Fri, 22 Sep 2017 10:57:35 +0900
In-Reply-To: <4FC081C4-355E-4E62-8CD8-89C299485182@gmail.com> (Lars
        Schneider's message of "Fri, 22 Sep 2017 00:26:44 +0200")
Message-ID: <xmqqvakblckw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6864DFFA-9F39-11E7-B179-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> Oh, you're right!
>
>
>> Could you squash in the following?
>
> @Junio: Can you squash it when you apply the patch?

I do not mind and I already did.

The patches in the series this patch is fixing up were solely about
splitting these scripts out of the YAML file as-is, and I think it
was correct to carry these style differences over without adjusting
them.

But resulting scripts in ci/ are riddled with styleguide deviations,
which may want to be cleaned up later.  There also are some
bash-isms marked with "#!env bash" in them, but I think they are OK
because we know we are running them only at a very specific place
and the need to make them portable is very small.

Thanks.
