Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABC8D1F855
	for <e@80x24.org>; Mon,  1 Aug 2016 22:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbcHAWFT (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 18:05:19 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60417 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751467AbcHAWFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 18:05:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A740332F74;
	Mon,  1 Aug 2016 18:05:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gzNT5BDW2dGtN+yfJb0WmBfyd80=; b=vclhCU
	o1KlvqtUgC8a5Baickv6caN4nxDQwfHSpe6LL2WnoxIXRi5yyiTdtdvocyFGl1ik
	11cxey5jSjYVf+VTuWMYwmW9Raa4gusHcyxBGnp78dZYIh/GztAKLrrZEA79fAxL
	boIUT4/d6pL+ZvwiEp/w6BSLaUdfh1nwFkOSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7dEF3Ig/7MNONojCbZe8PqNiAaYgGGP
	bWIYczhAwlLDdU5fbMElMnkfVdEmJv1ux0j6pe3ZSuvD31blHnPyDZL7C4mm6R5O
	VrrWw5frMaD8rA/9/vXdjaKprTNx+UUvCjuY0b892EDiFqjMgZ5hsZK7oy3VvEl0
	i/nHXfALDlA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D49E32F73;
	Mon,  1 Aug 2016 18:05:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AE7132F72;
	Mon,  1 Aug 2016 18:05:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v9 35/41] apply: make it possible to silently apply
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
	<20160730172509.22939-36-chriscool@tuxfamily.org>
Date:	Mon, 01 Aug 2016 15:05:12 -0700
In-Reply-To: <20160730172509.22939-36-chriscool@tuxfamily.org> (Christian
	Couder's message of "Sat, 30 Jul 2016 19:25:03 +0200")
Message-ID: <xmqqeg68gn6v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 067E9F9E-5834-11E6-98D8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> +enum apply_verbosity {
> +	verbosity_silent = -1,
> +	verbosity_normal = 0,
> +	verbosity_verbose = 1,

Drop the trailing comma from the last element in enum definition
(comma after the last element in an array is OK).
