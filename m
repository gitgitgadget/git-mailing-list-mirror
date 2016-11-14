Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 331E21F858
	for <e@80x24.org>; Mon, 14 Nov 2016 19:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935028AbcKNTAK (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 14:00:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59431 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932483AbcKNTAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 14:00:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5D6F24EDB6;
        Mon, 14 Nov 2016 14:00:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GpzsRb7UZ1edEtRoIBAOBStXUJM=; b=YlVB2s
        CF3Vk2E61ghiACsUAjNQhfwBy7xT+V2IiRTYo+EVMLXgQVZ5xuq40rOfOVv/BQ9K
        yBlIF+Jta0ai54y1lfe3QrXpJcbAse4K48bIQgSFFXzzbL2VW6roOInONeHoBaYP
        8i1+VFPu98zwFkMtARc+eIEFGGf/mBIsamhzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jzLacz2fOGkG7SbRk9qNkrR1/UrLYWcZ
        p+ZljEfzYVN+9NY3dHjaYuq+1ht4tPlMhsVVcv8II1Rkzc5b/2qxnrDXlaRC+iHW
        y73x/FyFbPwVyREs9XGl9RV2eoQB/2i/cVQkTdAsc2Pcjz5zEiES1mcx1rAxZPDE
        FlADRnIjKxY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 352D24EDB5;
        Mon, 14 Nov 2016 14:00:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 285424EDA8;
        Mon, 14 Nov 2016 14:00:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matt McCutchen <matt@mattmccutchen.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch/push: document that private data can be leaked
References: <xmqqy416uvan.fsf@gitster.mtv.corp.google.com>
        <1479001205.3471.1.camel@mattmccutchen.net>
        <xmqq1syezs3g.fsf@gitster.mtv.corp.google.com>
        <1479148088.2406.27.camel@mattmccutchen.net>
Date:   Mon, 14 Nov 2016 11:00:04 -0800
In-Reply-To: <1479148088.2406.27.camel@mattmccutchen.net> (Matt McCutchen's
        message of "Mon, 14 Nov 2016 13:28:08 -0500")
Message-ID: <xmqqbmxhyjij.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8EFBADFC-AA9C-11E6-AE37-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matt McCutchen <matt@mattmccutchen.net> writes:

>> Yup, and then "do not push to untrustworthy place without checking
>> what you are pushing", too?
>
> If there is no private data in the repository, then there is no need
> for the user to check what they are pushing. As I've indicated before,
> IMO manually checking each push would not be a workable security
> measure in the long term anyway.

Then what is?  Don't answer; this is a rhetorical question.

The answer is "do not push to untrustworthy place", if you are
unable to check what you are pushing.

