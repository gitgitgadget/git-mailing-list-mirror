Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DEBA2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 17:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752907AbcIORes (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 13:34:48 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64764 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752504AbcIORer (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 13:34:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5CC73D492;
        Thu, 15 Sep 2016 13:34:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ESffPWKMfwaxsyaJecDpfDBYMvs=; b=bhvtcV
        8LG8ApjRJmCpNjg3WLFHnn/G2iklaFAF/NNpu+bVWmoWRh4wFQvbGjucG91cRbJ7
        PyTHv/HyCtaW9jd68mzvanX2alUZ/P6dLxgQEXgzY/0gvRlOpUdJh8zpF3Ace64b
        UCZDa27mWadyM6S0VLqGFeSpXjDkVz1lrpda4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GffZjdDKmpB9PO684ybFgIB1GMPZ5heG
        8E/8vqS4aAioJ6zIsFrEWTc6/G6D8i9mdqqTJ1qw4IDY5XH93sX4fvPM7f/bbXt0
        QQzI6za3J+hJlIYjO29fXX9PiyntVsfwPl44rzdVZcD1YLvnfMminD5uudAZTFKa
        st+/abE/7tw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CF08F3D491;
        Thu, 15 Sep 2016 13:34:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4129D3D490;
        Thu, 15 Sep 2016 13:34:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathon Mah <me@jonathonmah.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: Tracking down a segfault in delta_base_cache
References: <3946EE74-219D-4E9C-9CED-69D53B940955@jonathonmah.com>
        <20160915005640.3ui4qfmiqjz2lsov@sigill.intra.peff.net>
        <6FA0A47C-61CB-4602-8629-46448E582292@jonathonmah.com>
Date:   Thu, 15 Sep 2016 10:34:43 -0700
In-Reply-To: <6FA0A47C-61CB-4602-8629-46448E582292@jonathonmah.com> (Jonathon
        Mah's message of "Thu, 15 Sep 2016 08:42:26 -0700")
Message-ID: <xmqqa8f9oymk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B14E22B0-7B6A-11E6-B324-2D857A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathon Mah <me@jonathonmah.com> writes:

>> On 2016-09-14, at 17:56, Jeff King <peff@peff.net> wrote:
>> 
>> Have you tried with the patch in:
>> 
>>  http://public-inbox.org/git/20160912164616.vg33kldazuthff3d@sigill.intra.peff.net/
> All the examples I've tried work when I use that. Thanks!

Peff, thanks for a quick suggestion and Jonathon, thanks for a quick
confirmation.

