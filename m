Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21D6A1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbcHPUTI (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:19:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62252 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752034AbcHPUTH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:19:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 26228355CE;
	Tue, 16 Aug 2016 16:19:06 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vRaEuy1EbElT
	hKTrCRttgc/N+WQ=; b=Q64HRci1XmIlhq6t+GoPVimCIpPj87FE9amvPyN4Ri1r
	9tXouW+y84K8w4Zolbdw5bllpA/4p5J0x1uysEbu261/kvixh2YtXzWna0DS96Cj
	6c1Ti+/N4vSG5mWVHO+2ppRc5vSt5ECibK2f1iP49sZNgJJN8zfWu9ThnT3inZI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DFZyI1
	XkHkv4PA4qwMOjVuQtLahfDK2y4Kn+G0Ppvz8YWItRhhBG7+3CnOBoaJMvjLxKWs
	JNhRH/u7aVUKcreSS0GUYdEge9Gwd/bcYJ9TkF2mbFsIbJPuEZCFKPusOEsCQRc0
	dLt2p7zPQq5qgZLXo5slUB73gYMW0nNg2MrZU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DF33355CC;
	Tue, 16 Aug 2016 16:19:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E342355CB;
	Tue, 16 Aug 2016 16:19:05 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	David Lang <david@lang.hm>, Nikolaus Rath <Nikolaus@rath.org>,
	git@vger.kernel.org
Subject: Re: Working with zip files
References: <87y43wwujd.fsf@thinkpad.rath.org>
	<alpine.DEB.2.02.1608160926330.11774@nftneq.ynat.uz>
	<xmqqeg5oejmn.fsf@gitster.mtv.corp.google.com>
	<34d64f4f-3cda-385c-cdce-5f1852d545e3@gmail.com>
Date:	Tue, 16 Aug 2016 13:19:03 -0700
In-Reply-To: <34d64f4f-3cda-385c-cdce-5f1852d545e3@gmail.com> ("Jakub
	=?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 16 Aug 2016 21:56:08
 +0200")
Message-ID: <xmqq8tvwcvrc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AE27EFB4-63EE-11E6-9B05-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> There is also `textconv` filter that can be used instead; it might
> be 'unzip -c' (extract files to stdout, with filenames), or 'unzip -p'
> (same, without filenames).

That assumes that the in-repository data is zipped binary blob; the
result won't delta well, will it?


