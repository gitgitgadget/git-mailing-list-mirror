Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52A0202A0
	for <e@80x24.org>; Fri, 17 Nov 2017 01:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbdKQBJb (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Nov 2017 20:09:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64265 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751741AbdKQBJ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Nov 2017 20:09:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F1B3DB8D5F;
        Thu, 16 Nov 2017 20:09:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hbsoqm4DWRKzSfaUDmRa7GLEBGI=; b=UzFpVr
        S7dsa9PIllbvzDxRyLbYR0l4TStuML8P3d02+3BR13ZuIrQS+TaH0p6voUGxxRFy
        bQdAnRFf0M3ooonMGtbccUdMCVPLa97rGvzBty02IG48kdHchHJqbFDmKUFQjXqv
        EvjHzoB82UvIjeTqyomaxajh8Jmy/u5NtO3dc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P66fkrcBkQTeb86oUjkJT2e6HcNZunYW
        qVkzMMNn596NEIV1r+cfk6iXnnQOogo5fG1dFUpFkkHEX2vUTOzX66vlisGhw9D6
        Fpkrh3UZ0GnBPlOSC5vrCcrKhy+jbIUOhfV0zLAW85WD+h77Yxo0jLH35QHErfp/
        j2TR0NIeWa0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9846B8D5E;
        Thu, 16 Nov 2017 20:09:28 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 64B0BB8D5C;
        Thu, 16 Nov 2017 20:09:28 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] launch_editor(): indicate that Git waits for user input
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
        <xmqqr2syvjxb.fsf@gitster.mtv.corp.google.com>
        <DAEC36C7-AE09-4C9B-ACC4-07F2C5F2B97F@gmail.com>
        <xmqqh8tuuv6l.fsf@gitster.mtv.corp.google.com>
        <DAA0F91D-5180-4C3B-B0E8-7C917915AC6F@gmail.com>
Date:   Fri, 17 Nov 2017 10:09:27 +0900
In-Reply-To: <DAA0F91D-5180-4C3B-B0E8-7C917915AC6F@gmail.com> (Lars
        Schneider's message of "Thu, 16 Nov 2017 16:24:55 +0100")
Message-ID: <xmqq8tf5vhh4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F5B6EF3A-CB33-11E7-9D66-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

>> On 16 Nov 2017, at 15:58, Junio C Hamano <gitster@pobox.com> wrote:
>> 
>> Lars Schneider <larsxschneider@gmail.com> writes:
>> 
>>>> On 16 Nov 2017, at 07:04, Junio C Hamano <gitster@pobox.com> wrote:
>>> 
>>> Wow. Thanks for the quick patch :-)
>> 
>> Heh, this is not exactly my itch, so if you are inclined to, can you
>> take it over from here on?
>
> Absolutely! What is the proper way to proceed here? Should I send a v2
> with the changes I suggested? How do I attribute you correctly? I
> assume I need to remove your 'Signed-off-by:'?

If you are making major changes over the original patch, you'd
probably want to take the authorship and mention me on Helped-by:
and/or add "This is based on a previous work by...", if you want to
credit me.

If you are not taking the authorship over, then doing something like

    https://public-inbox.org/git/xmqqshdex0ff.fsf@gitster.mtv.corp.google.com/

would be sufficient, I would think.

Thanks.
