Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59ABA1F859
	for <e@80x24.org>; Fri, 12 Aug 2016 19:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752160AbcHLTZY (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 15:25:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56748 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751722AbcHLTZX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 15:25:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1978534604;
	Fri, 12 Aug 2016 15:25:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eg8U7gZuj2ARAePlOkO1MV+8vAw=; b=DZ1Htz
	7vTBszCYqixrzsiLjOZHtInhuC2oZSaHOQDx6rkh6/fMIPn1b5UZdzxvGk7FFcIS
	ZKPMynTHjC0XA6UCHr9a4Jn4NNKVJ5YKzqdsJ1dFZ77aWotkR9VxrCjBOdSjHrfC
	dDlPAqsXROIYtsohiWbxco/PT/eHv3zQzVU+0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KkVSwpuzHL5tlxeNitVusch957U1BhNi
	8Eds0jt3LNa/H6fgNUqHiztZczWmVVTSt9a8CANgjcgUwgFswlpeSPfDmfOR4eKr
	u8cy4IJ/cAkRQYJ6BUaoIgpKdeA5SaRUfzwVylHrhj8zaLsO+Lzlx4fWuG+mxb4x
	hVvZO2sjrug=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F2BB34603;
	Fri, 12 Aug 2016 15:25:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7F43F34602;
	Fri, 12 Aug 2016 15:25:22 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v12 13/13] bisect--helper: `bisect_start` shell function partially in C
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
	<010201567675ae72-0e0eeb11-e488-4562-8837-2443cbfe0792-000000@eu-west-1.amazonses.com>
Date:	Fri, 12 Aug 2016 12:25:20 -0700
In-Reply-To: <010201567675ae72-0e0eeb11-e488-4562-8837-2443cbfe0792-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Wed, 10 Aug 2016 21:57:19 +0000")
Message-ID: <xmqqh9apx00v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 835EAF4A-60C2-11E6-97EF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> + ...
> +	/*
> +	 * Write new start state
> +	 */
> +	if (write_file(git_path_bisect_start(), "%s\n", start_head.buf)) {

I think this function has changed its signature recently.  I am
planning to tag 2.10-rc0 this weekend, and it may be a good time to
rebase the series on to an updated codebase.

Thanks.
