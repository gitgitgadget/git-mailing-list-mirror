Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271E4207EC
	for <e@80x24.org>; Thu, 29 Sep 2016 21:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934206AbcI2V12 (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 17:27:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61984 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932267AbcI2V10 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 17:27:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 78CD442CF3;
        Thu, 29 Sep 2016 17:27:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gUEEkETx7QxadCwUeFt1ZUQWPV8=; b=lNGFM6
        PsZXALHtbpvef/GLwNIUdh01jxLk5r7woYUpI3kL+pimMoq+N/OhnoCP5hOBrg1X
        z9sZ19jrL5j/bJ/fVm7o/wFbwx33D/iSN6p0CfK/yq9ibBNgV3g2BB5Buccp4qcz
        +i9WRYn53FrpQfJJVSa1aspDVOKCq0XvjmqcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=P5Zg5fYdajzezOeMNh6C4TrDLqpTrYAl
        2BZh+dQfcdmL6aEe+AlAzU9exocN3SAx7d9UdGuEFZnytLPXKXP82SAIp+BuxNso
        /Ak7qQ1fPA104XJVLAAbQU7cRMA7ipsfparjIbwmY6jMQJHsX+qgu6A2iQTzepuK
        jBwzl030+TQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 70D5D42CF2;
        Thu, 29 Sep 2016 17:27:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E1E0742CF1;
        Thu, 29 Sep 2016 17:27:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Stefan Beller <sbeller@google.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        ramsay@ramsayjones.plus.com
Subject: Re: [PATCH v8 00/11] Git filter protocol
References: <20160920190247.82189-1-larsxschneider@gmail.com>
        <xmqq8tubitjs.fsf@gitster.mtv.corp.google.com>
        <C2C9761E-986F-473D-BFB7-CBEF900D9FA3@gmail.com>
        <f7a4f828-bb1d-0ffa-e369-3b4fa476d9e5@web.de>
        <xmqqk2duhcdm.fsf@gitster.mtv.corp.google.com>
        <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com>
Date:   Thu, 29 Sep 2016 14:27:22 -0700
In-Reply-To: <1A8A9127-4DF9-44AD-9497-F8A630AB1193@gmail.com> (Lars
        Schneider's message of "Thu, 29 Sep 2016 19:57:43 +0200")
Message-ID: <xmqq60pee6rp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 83BAE744-868B-11E6-BC39-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> We discussed that issue in v4 and v6:
> http://public-inbox.org/git/20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net/
> http://public-inbox.org/git/xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com/
>
> My impression was that you don't want Git to wait for the filter process.
> If Git waits for the filter process - how long should Git wait?

I am not sure where you got that impression.  I did say that I do
not want Git to _KILL_ my filter process.  That does not mean I want
Git to go away without waiting for me.

If the filter process refuses to die forever when Git told it to
shutdown (by closing the pipe to it, for example), that filter
process is simply buggy.  I think we want users to become aware of
that, instead of Git leaving it behind, which essentially is to
sweep the problem under the rug.

I agree with what Peff said elsewhere in the thread; if a filter
process wants to take time to clean things up while letting Git
proceed, it can do its own process management, but I think it is
sensible for Git to wait the filter process it directly spawned.

