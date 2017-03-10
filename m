Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 976C01FBEC
	for <e@80x24.org>; Fri, 10 Mar 2017 16:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932610AbdCJQkH (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 11:40:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52792 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751316AbdCJQkF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 11:40:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 92DAB617C7;
        Fri, 10 Mar 2017 11:40:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+qH3aK+k/siQ6yE6mAGrGqrcJcE=; b=l5OVzm
        G7MjhYRlXspl2jJ3o2JHYomUolbWOfa230VWKmz+kGISaapaQ0G/xDhnA1RdqOt3
        61CEH6ZAf/LtORNfCmLZMTpjvQ5qRkrYR/JNCc7CRKo5ZcpnOGeFBwmnOz7tvol9
        p4rhp2xqCrYpiwXKdincsEp1uhgNDxQKSEavg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x+FPiUEntLjR3p4L5+3ES2OzFs6odqYz
        P1aEY3XROqo2foh1A+el3Gxg0DpMTV0b7uFPRQXTwCqvZaa7TK8O6AIuiEqExpxV
        ksH70TxtwGyjzdmDousHm6civKjPAIchiW9nc9BFNw5AgXgWwQ9vUIUw05UUe61z
        PHC+AOcYbDQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88AE1617C5;
        Fri, 10 Mar 2017 11:40:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E5E4617C1;
        Fri, 10 Mar 2017 11:40:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 0/9] Fix the early config
References: <cover.1488506615.git.johannes.schindelin@gmx.de>
        <cover.1488562287.git.johannes.schindelin@gmx.de>
        <20170304073952.drfgy7jacnlm6tum@sigill.intra.peff.net>
        <alpine.DEB.2.20.1703071314180.3767@virtualbox>
        <20170308073035.pt5ysp6bzpozoqps@sigill.intra.peff.net>
        <xmqqy3wf3dbo.fsf@gitster.mtv.corp.google.com>
        <20170308174237.cm6e5uvve6hu7lpf@sigill.intra.peff.net>
        <xmqqinnj1jb6.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1703091243260.3767@virtualbox>
        <20170309121620.rld6scydqru72nbk@sigill.intra.peff.net>
Date:   Fri, 10 Mar 2017 08:39:59 -0800
In-Reply-To: <20170309121620.rld6scydqru72nbk@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 9 Mar 2017 07:16:20 -0500")
Message-ID: <xmqqmvctytk0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 354C4B26-05B0-11E7-B6D9-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > > Yes, exactly.  It would have been less confusing if I picked something
>> > > that passed nongit_ok. Like hash-object:
>> 
>> ... or like testing the early config directly?
>
> I was trying to demonstrate that the problem existed already without
> your patch series.

Yup, they are not new breakages introduced by Dscho's change.

>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> Subject: [PATCH] t1309: document cases where we would want early config not to
>>  die()
>> 
>> Jeff King came up with a couple examples that demonstrate how the new
>> read_early_config() that looks harder for the current .git/ directory
>> could die() in an undesirable way.
>> 
>> Let's add those cases to the test script, to document what we would like
>> to happen when early config encounters problems.
>
> Yep, these all look fine.

OK.  Thanks, both.
