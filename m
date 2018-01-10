Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF831FAE2
	for <e@80x24.org>; Wed, 10 Jan 2018 19:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeAJTn6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 14:43:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52897 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751350AbeAJTn5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 14:43:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BCB6CB63B5;
        Wed, 10 Jan 2018 14:43:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gYPliHMcZhXX6pewBDfMtU0091M=; b=q5LVUu
        t68if6fd1nxktgNqwjdxGOn5EGZOIZukVfR5PD157duERl9mKtoWwattQCJRCMjz
        S22S54xzbOATP8U+2AKwOny6s3RDellsNjHmsUDW6ypo6ygLsm4J8ZJJ0Ic+Mx2j
        FTaNYAWiQP+aEI2hONQtbymnBgVPOzq/oHkEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xAcGUP4YYI50ziXx/LXBWU9Kdo20iWnj
        WbgM8//y/OcJdkrT+yhk/syfsR5oh0wyDTGCm8HgcSWn0K420pQD7gGGggckslof
        vJKvVhOgf6tBiG8ku1NiiZzJxZxpGn8urxrvqvGQgEC3gnXnJa7oTmolNRUNxsGH
        3c5ES6kXrQI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B52C7B63B4;
        Wed, 10 Jan 2018 14:43:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 383E7B63B3;
        Wed, 10 Jan 2018 14:43:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3900: add some more quotes
References: <20180110095832.22077-1-dev+git@drbeat.li>
        <6b32292b-0f71-7cf8-2069-41766d440b58@kdbg.org>
Date:   Wed, 10 Jan 2018 11:43:52 -0800
In-Reply-To: <6b32292b-0f71-7cf8-2069-41766d440b58@kdbg.org> (Johannes Sixt's
        message of "Wed, 10 Jan 2018 20:02:09 +0100")
Message-ID: <xmqqwp0p1ouf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 97278E76-F63E-11E7-BA69-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

>>     test_expect_success 'UTF-8 invalid characters refused' '
>> -	test_when_finished "rm -f \"$HOME/stderr $HOME/invalid\"" &&
>> +	test_when_finished "rm -f \"$HOME/stderr\" \"$HOME/invalid\"" &&
>
> Should that not better be
>
> 	test_when_finished "rm -f \"\$HOME/stderr\" \"\$HOME/invalid\""
>
> i.e., delay the expansion of $HOME to protect against double-quotes in
> the path?

Yes ;-)
