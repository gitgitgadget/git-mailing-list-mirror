Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8142018A
	for <e@80x24.org>; Fri,  1 Jul 2016 16:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbcGAQHc (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 12:07:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64092 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750702AbcGAQHa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 12:07:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2C0C525C60;
	Fri,  1 Jul 2016 12:06:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5V7sneXUnRHfNmybln/LrAV8HGI=; b=YEPkFs
	Slv/iuy79WEDBUOSyqKllZzfTqY1TFkpNkS3MPOsyrnK77xrs0M6BIH7BZezMthb
	ZBTXNsK26iIfR93SyZH4qag76mGgpsjIlT8JzwPH2fa7smN0vqDxQq4o+ZucvGdQ
	aN5NrdhKX33ludWBt+eONwIzgNVSpO643SIl4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J4OvwNagFdFngG3nd5+aER+7fozYXsgP
	q1TKNZ0xVEnN3U/1EMA4uQa+YPfbxhRo8MYTXeeoHpF4+hYQ+RZOgRTzAWG8wzwk
	wM0Cim/NLJ+iy7TY5435nFo++5Szel4pP0LHbdNB1d+mxik31ImyKHmNtheM9aJq
	keRfmZZWguM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 252E625C5F;
	Fri,  1 Jul 2016 12:06:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A135F25C5E;
	Fri,  1 Jul 2016 12:06:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 2/2] t3404: add a test for the --gpg-sign option
References: <cover.1467210629.git.johannes.schindelin@gmx.de>
	<0df34c45db5b1500e55262c8948c9140e7ad6cb8.1467210629.git.johannes.schindelin@gmx.de>
	<xmqq8txn4zm5.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606301019040.12947@virtualbox>
Date:	Fri, 01 Jul 2016 09:06:14 -0700
In-Reply-To: <alpine.DEB.2.20.1606301019040.12947@virtualbox> (Johannes
	Schindelin's message of "Thu, 30 Jun 2016 10:25:30 +0200 (CEST)")
Message-ID: <xmqqpoqxz6kp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDBB5F82-3FA5-11E6-A379-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> that has a substring '-S"' in it to ensure that the codepath to
>> parse --gpg-sign= on the command line of "rebase", and to the
>> message we see here are working correctly, without actually checking
>> if GPG is invoked at all, or if it is invoked the key given by the
>> option is correctly passed to the invocation?
>
> Exactly. I want to test --gpg-sign even when there is no gpg executable
> available.

The other side of that coine is that even when GPG is available, we
do not see if it is invoked correctly at all.  That was what I found
disturbing.
