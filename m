Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A13DA1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 15:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbcG1PiY (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 11:38:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757245AbcG1PiW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 11:38:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8FCA82EDCD;
	Thu, 28 Jul 2016 11:38:21 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TcMQBAdxC/FryIj+dP1CbfpicIU=; b=mkmJm4
	M9G+tQ8P+SUfI2dID3hJ+zin9Rns2ozeN1cPN21ee9oY5oNT5x1yHp+zTv0s5m8T
	AMsg31zxJE/L8trknxuCwT2JRKmwpNCP1lvNVVfBTQ+e74VvMJNMuAk+7kIMLqum
	eUFxSjGjzZ3EIo7zoq3TUHoKuUsmTUE6O5b38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NsG15Gw9MXTBEJOYgxGFLYKi3xch+tED
	YxJ/quZXnzXZOpHO+OxMgghVlrfPnsLYjgQHXLrIGisGP52hgAJRmt9d3XKVFE8G
	KvXVwJLCjGmNdB6dRW6NDSfgE4kZk3YLNcmmS6hOIAVYvyxJ9YF+ISLa+NF0Jt6J
	qj9+vDcMWfE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8752C2EDCC;
	Thu, 28 Jul 2016 11:38:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0D9452EDCB;
	Thu, 28 Jul 2016 11:38:21 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Heiko Voigt <hvoigt@hvoigt.net>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH] document how to reference previous commits
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
	<57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox>
	<xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
	<20160726094913.GA3347@book.hvoigt.net>
	<CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
	<20160728111636.GA7760@sandbox> <20160728125514.GA2813@sandbox>
Date:	Thu, 28 Jul 2016 08:38:18 -0700
In-Reply-To: <20160728125514.GA2813@sandbox> (Heiko Voigt's message of "Thu,
	28 Jul 2016 14:55:14 +0200")
Message-ID: <xmqq60rpu61h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 502F59FC-54D9-11E6-BF97-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> @@ -121,6 +121,11 @@ its behaviour.  Try to make sure your explanation can be understood
>  without external resources. Instead of giving a URL to a mailing list
>  archive, summarize the relevant points of the discussion.
>  
> +If you want to reference a previous commit in the history of a stable
> +branch use the format "abbreviated sha1 (subject, date)". So for example
> +like this: "Commit f86a374 (pack-bitmap.c: fix a memleak, 2015-03-30)
> +noticed [...]".
> +

I earlier said that our goal should not be to spell out all the
conventions, which would lead to unreadably long document, but this
does not look too bad.  Small additions however tend to accumulate
over time, though ;-)

I wondered if we need to also say "why", but we probably shouldn't.

Thanks.
