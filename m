Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A6401F600
	for <e@80x24.org>; Thu, 20 Jul 2017 20:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935711AbdGTUky (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jul 2017 16:40:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53629 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935339AbdGTUky (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jul 2017 16:40:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9CC88D415;
        Thu, 20 Jul 2017 16:40:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O8Nih34Uflh5DwlhTpuEDtbG5kU=; b=KblNor
        Z7xEaNetZpESt1oqmM7JH5s+gKSYdL9p7qEd0/myepq3aSYfQLhRYvh0lO19p7nY
        TL1EUJR5D2ChLpbEDVeZhigZXIHeVVwrUU8Uf2l1icixFw4ztx/SNoQEOHE1dovr
        4EM5Jcf+Ru3gQ1YBqGKsffpx/PyZVjoB0g71U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iwkuE5EQQadx9nj98O4MBpyhvx3WbJQf
        q565Hpy2BJ00ZSG3WkMIqF/HTE77AbdBRXRzQgUZ3+tK/7LSekEHxliSsb4oLm7c
        q6Th1AQmR3zOJHoNALLNCYu7Sfn7CYWBWLYQVlGyQOP5i1EWhLlJbDi8z9StGl7w
        +g3xO09E0Io=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C92BC8D413;
        Thu, 20 Jul 2017 16:40:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2D68E8D412;
        Thu, 20 Jul 2017 16:40:46 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Volodymyr Sendetskyi <volodymyrse@devcom.com>, git@vger.kernel.org
Subject: Re: Binary files
References: <CAFc9kS8L-JJoJqKi7bB90qwKVW8gB=EFk9D8c=4YShqnamwa2w@mail.gmail.com>
        <CAFc9kS_xYVyPsW7qogDxLugxBb1p2vEFAoP=W9Rdnfqs6XtWKQ@mail.gmail.com>
        <d4b1b92d-6ab1-7e6f-4afd-6194a5ba8e40@gmail.com>
Date:   Thu, 20 Jul 2017 13:40:45 -0700
In-Reply-To: <d4b1b92d-6ab1-7e6f-4afd-6194a5ba8e40@gmail.com> (Igor
        Djordjevic's message of "Thu, 20 Jul 2017 20:49:35 +0200")
Message-ID: <xmqqo9sekfjm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B4F5CE4A-6D8B-11E7-ABE1-EFB41968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> On 20/07/2017 09:41, Volodymyr Sendetskyi wrote:
>> It is known, that git handles badly storing binary files in its
>> repositories at all.
>> This is especially about large files: even without any changes to
>> these files, their copies are snapshotted on each commit. So even
>> repositories with a small amount of code can grove very fast in size
>> if they contain some great binary files. Alongside this, the SVN is
>> much better about that, because it make changes to the server version
>> of file only if some changes were done.
>
> You already got some proposals on what you could try for making large 
> binary files handling easier, but I just wanted to comment on this 
> part of your message, as it doesn`t seem to be correct.

All correct.  Thanks.
