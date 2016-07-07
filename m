Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE2E520705
	for <e@80x24.org>; Thu,  7 Jul 2016 21:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbcGGVOy (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 17:14:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752299AbcGGVOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 17:14:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 295512BA2B;
	Thu,  7 Jul 2016 17:14:52 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rW723BPVqsoc1iX4T9axDmkf294=; b=CHGeLo
	lqGhXc5SXOete4U8NG4No6HcpCigRWe6DwxtLqgWpxvTtVHiiusA6B3Ks0OWwuev
	/1vj+QD3TA3BAzEVX1dJHyvBXuYeX5wUFZPNj5JS3Rabyq/QWxQE9TSBcxEAtDea
	ukxtWUJ8DzD1SUl2nwct9hc8tdgaSiUj9sD64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kZEO1RASuDLxXbYni3qYD5aOF910vIoa
	Mic4mZC+sbtoIVhm8qg0Q/7PlusKzyyJpXJyMc5Cfglssop0LOLfRsQzCpfMlMi4
	3rh8BdhBekz1gpKCIJ9Zj/FGdzfCKfXR5QU5PaNjFnbG1Cw8JJFQy8BdkdBQ+h8F
	6BDQKeDMzR0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2097E2BA2A;
	Thu,  7 Jul 2016 17:14:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CF9E2BA28;
	Thu,  7 Jul 2016 17:14:51 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Ronald Wampler <rdwampler@gmail.com>
Cc:	git@vger.kernel.org, mackyle@gmail.com, reubenhwk@gmail.com,
	sunshine@sunshineco.com
Subject: Re: [PATCH] Makefile: add NEEDS_LIBRT to optionally link with librt
References: <20160707204554.14961-1-rdwampler@gmail.com>
Date:	Thu, 07 Jul 2016 14:14:49 -0700
In-Reply-To: <20160707204554.14961-1-rdwampler@gmail.com> (Ronald Wampler's
	message of "Thu, 7 Jul 2016 16:45:54 -0400")
Message-ID: <xmqqwpkxnoae.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D8002A3A-4487-11E6-B7E1-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Ronald Wampler <rdwampler@gmail.com> writes:

> I am not sure if this the correction solution. Another option I
> considered was to wrap the EXTLIBS += -lrt is an ifndef NO_RT and only
> defining NO_RT for Mac OS X in config.mak.uname.

That alternative would make the resulting code noisier/uglier with
nested ifdef, I would imagine, but it would be of less impact to the
existing users.  But my gut feeling is that the patch you sent is
probably a better solution for the longer term.

Thanks.

