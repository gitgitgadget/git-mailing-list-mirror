Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE071FD99
	for <e@80x24.org>; Wed, 17 Aug 2016 17:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753016AbcHQRqE (ORCPT <rfc822;e@80x24.org>);
	Wed, 17 Aug 2016 13:46:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752984AbcHQRqD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Aug 2016 13:46:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E2DC35D64;
	Wed, 17 Aug 2016 13:46:01 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wxwE89ygxBlM1ldjREuWMY3N0A0=; b=nB98y5
	fOXJYtmI92ZYsR3/LvOHJyN3+Z9JVBrlMYuH2U/erEd2i7EXQqwrK42bL0ARTv/z
	e9ltxnxbjXCYM7tUuM5GxdPg1KW1X8OkuugcI+TgfRCGkWEhA6FNKkdCCDjWnjZd
	iBloxN3KSer6OVPm+k2h7mb7q00idCkcYI1UY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aF3YY9nspOP9djEj0MKSXgzt1Ncq0RIF
	aCTbZ7DM7eUZ8EQHGcNl9rZEQcdocxwqctZLBb2hc4ZOZ69YCvZFaeLEpDquMabH
	GJxOmdrcbyQoy+rx/pNSHfE/CMF8m+HRUrQMdvlgaXKMdgusF0jLpN8M6JXr/xzj
	pa2NKdBB4QY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5C2F935D63;
	Wed, 17 Aug 2016 13:46:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8521B35D62;
	Wed, 17 Aug 2016 13:46:00 -0400 (EDT)
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
	<20160817113602.GB6080@sandbox>
Date:	Wed, 17 Aug 2016 10:45:58 -0700
In-Reply-To: <20160817113602.GB6080@sandbox> (Heiko Voigt's message of "Wed,
	17 Aug 2016 13:36:02 +0200")
Message-ID: <xmqqlgzv9tm1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75D26F5E-64A2-11E6-B661-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Thu, Jul 28, 2016 at 02:55:14PM +0200, Heiko Voigt wrote:
>> To reference previous commits people used to put just the abbreviated
>> SHA-1 into commit messages. This is what has evolved as a more
>> stable format for referencing commits. So lets document it for everyone
>> to lookup when needed.
>
> A quick ping about this patch. Maybe you missed to include it Junio? I
> can not find any reference to it in the cooking mails and in your
> repository.

That's because I was undecided.
