Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A10C20285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753701AbdHXTeD (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:34:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53226 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753681AbdHXTeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:34:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B9C64A9EC5;
        Thu, 24 Aug 2017 15:33:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OVJIG7DoqvJ2G8uufXRsnkn5JaU=; b=OYrw02
        jWbmmxk37JU7IETSIDZ26EHzQ1Gd3d+CYdU2OnHdWdIHbVyrsCElMPh9jgjt4k81
        DEket4Ey7RdJR/Hl/BLzfpkgSYheq9vMi/4r+pcshQgqzk3/UzgvyfQKsrBZwaaY
        0umP3HaNoL0tAQz3JUMQcTx70QRC1Q0vbR67g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pxr7UPr9BbHmMR1PNZX3Hf/P58lWf/lz
        bbh9BdCIeLbiEY3qVcNs5ifXH4jLjfpmMJf4ubPQWaxFi/77RZwg8F9SUSNUwkWh
        EV090NcBfvGCQh+CSObkEyhZFXFHK8jFD8PxG0A7zmQpSL0N0og3geg5TSCRYAEE
        A3tWiPga28s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2CC6A9EC3;
        Thu, 24 Aug 2017 15:33:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2457BA9EC2;
        Thu, 24 Aug 2017 15:33:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2017, #05; Tue, 22)
References: <xmqq4lsz2x6r.fsf@gitster.mtv.corp.google.com>
        <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com>
Date:   Thu, 24 Aug 2017 12:33:58 -0700
In-Reply-To: <7D99B245-4D22-4C9C-9C43-C8B8656F8E6D@gmail.com> (Lars
        Schneider's message of "Wed, 23 Aug 2017 23:38:06 +0200")
Message-ID: <xmqq1so0wyjd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D0A0C06-8903-11E7-90A6-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> On 22 Aug 2017, at 21:56, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>> the integration branches, but I am still holding onto them.
>> 
>> The second batch of topics are in.  This cycle is going a bit slower
>> than the previous one (as of mid-week #3 of this cycle, we have
>> about 200 patches on 'master' since v2.14, compared to about 300
>> patches in the cycle towards v2.14 at a similar point in the cycle),
>> but hopefully we can catch up eventually.  
>> 
>> I am planning to be offline most of the next week, by the way.
>> 
>> You can find the changes described here in the integration branches
>> of the repositories listed at
>> 
>>    http://git-blame.blogspot.com/p/git-public-repositories.html
>> 
>> --------------------------------------------------
>> [Graduated to "master"]
>> 
>
> Hi Junio,
>
> just in case this got lost: I posted a patch with an improvement to 
> 2841e8f ("convert: add "status=delayed" to filter process protocol", 
> 2017-06-30) which was merged to master in the beginning of 2.15.
>
> https://public-inbox.org/git/20170820154720.32259-1-larsxschneider@gmail.com/

Thanks for pinging, but next time ping the thread itself if it is
about something that is not in What's cooking report you are
responding to.

