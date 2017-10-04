Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C768A20281
	for <e@80x24.org>; Wed,  4 Oct 2017 08:46:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbdJDIqZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 04:46:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61771 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751736AbdJDIqX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 04:46:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7EDFA3225;
        Wed,  4 Oct 2017 04:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RkEkFMWRh7QBIaH685FC4z+ts60=; b=rfe5Sa
        A/3VTVgiB8DYtt5d1h0Ysbi/dPF1EafEFHgZZceKq/sLq7Bdilo+MwWvU+A8JMJd
        8niTKXJyfR3iumLCWrmYh2H5tiol7EMr3x7O6CDOya7Mg8taGqM/CEQk2NTE4wf+
        zvPmy2cokegqJdwY691BYyUYL99uJcuqrDwDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ya0QsVW0yCjdaqF9FC7G0BdyuP8wg3uV
        +h3rmaAoe+0vbpl9U25L2PwE+fHuhgd3Mz0lGR8UpDWMY3hRM3WXNiRsGS+h7VCB
        nr6aVpUc1xby4A9grsnb4nvLG/IE7wR/Wo1m+1/VTzJIYF1Op3s4DWBE9xQjRCtz
        5cm7vaOki+A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFF09A3224;
        Wed,  4 Oct 2017 04:46:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5B74FA3223;
        Wed,  4 Oct 2017 04:46:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2017, #01; Wed, 4)
References: <xmqqy3orbcrr.fsf@gitster.mtv.corp.google.com>
        <20171004083111.5y7su63scydg2yzk@sigill.intra.peff.net>
Date:   Wed, 04 Oct 2017 17:46:21 +0900
In-Reply-To: <20171004083111.5y7su63scydg2yzk@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 4 Oct 2017 04:31:11 -0400")
Message-ID: <xmqqr2ujb8rm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F888E42-A8E0-11E7-8D62-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  - pretty.c: delimit "%(trailers)" arguments with ","
>> 
>>  "git for-each-ref --format=..." learned a new format element,
>>  %(trailers), to show only the commit log trailer part of the log
>>  message.
>> 
>>  Will merge to 'next'.
>
> I think we want the first patch of this series to graduate before v2.15,
> even if the rest doesn't make it. It tweaks a new syntax introduced
> earlier in this cycle by jk/trailers-parse. If we ship without the
> tweak, then we'll have to support the colon-delimiter to remain
> backwards-compatible.

Yeah, thanks for reminding me.  I actually was hoping that this will
prove to be stable enough by the time -rc1 gets tagged, but yes, the
bottom one looks innocuous/safe enough and should be fast-tracked to
'master' soonish.

Thanks.
