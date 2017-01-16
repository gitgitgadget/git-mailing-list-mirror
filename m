Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7AA20756
	for <e@80x24.org>; Mon, 16 Jan 2017 07:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751064AbdAPHs7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jan 2017 02:48:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54323 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750845AbdAPHs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2017 02:48:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CE7A7570ED;
        Mon, 16 Jan 2017 02:48:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ObSoAV8KC1ulRs6UW2jAVT64zCI=; b=pumwuL
        gD9X5QiY6BKspxUbGotuou3CRi5IpflmfSLpTlhHSEilTCPZ7SdKeACht1Osi2M4
        uUx1a4PJXYdDDHtjUfdq/ISuZy2NP6mqtaS4fdKpjqHbzNqfj9ey0xsRO7yQUmeB
        TFNBmfiCJawZgh9IHD4h5BbC7E/QtVe/3NixE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XPjkJFRrN+CuuxrtIBGCMS7rhVD0dNDu
        uQmFWjJLPgQno4wNiL6awXE/QxuwIm8mhBs8QjTsIPQ2PidgZSMoF7NwPJFe86e0
        R0YhWSkVpVRr/kAU6Suns4rPD0fEO4wirSm6rx9aOA0388MhJLrYgB0pGlomqeL/
        aRiUOawnRBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C41E5570EB;
        Mon, 16 Jan 2017 02:48:57 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2EB22570E9;
        Mon, 16 Jan 2017 02:48:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jan 2017, #02; Sun, 15)
References: <xmqqh94zbwlu.fsf@gitster.mtv.corp.google.com>
        <257b4175-9879-7814-5d8d-02050792574d@kdbg.org>
Date:   Sun, 15 Jan 2017 23:48:55 -0800
In-Reply-To: <257b4175-9879-7814-5d8d-02050792574d@kdbg.org> (Johannes Sixt's
        message of "Mon, 16 Jan 2017 07:56:43 +0100")
Message-ID: <xmqqtw8za1i0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C3AD91C-DBC0-11E6-B6D7-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 16.01.2017 um 02:51 schrieb Junio C Hamano:
>> * jk/vreport-sanitize (2017-01-11) 2 commits
>>  - vreport: sanitize ASCII control chars
>>  - Revert "vreportf: avoid intermediate buffer"
>>
>>  An error message with an ASCII control character like '\r' in it
>>  can alter the message to hide its early part, which is problematic
>>  when a remote side gives such an error message that the local side
>>  will relay with a "remote: " prefix.
>>
>>  Will merge to 'next'.
>
> Please be not too hasty with advancing this topic to master. I could
> imagine that there is some unwanted fallout on systems where the
> end-of-line marker CRLF is common. Though, I haven't tested the topic
> myself, yet, nor do I expect regressions in *my* typical workflow.

Thanks; will wait for a further discussion on the topic's thread
then.

