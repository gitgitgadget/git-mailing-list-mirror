Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF9451F744
	for <e@80x24.org>; Mon, 11 Jul 2016 18:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbcGKSom (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 14:44:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752334AbcGKSom (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 14:44:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C920A2C021;
	Mon, 11 Jul 2016 14:44:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0qR5aDI79uWFU51bPlZqTQ7Oa9w=; b=mizkXZ
	fSJ5dMZpXhEUGFvLBcGDZtxuLovCiHYtksa5sLHQxocFh5ttOEzyP83Q1q2kGCGq
	i+c6ecpLCjVureWLy8wx/gR1CDQdkS/fItyoPrO0Cjew1GvXZbGBlM/t9bhmuOZY
	lZXkniqc+VgmkjFwD1KNxzEPW7qghCqlQoEyM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jn7bVO/Dcs32Sss3uX4yVKJ+GJ1Gxv5b
	urrlHSYddH1iY+PU3CPkFesYPoEV44GR8oJWfjn2x2Qob39WReChiw4wF2f5ogGR
	vnGbGJrdxpBKLD2Dd2tHqhWMyA9QLXSTmyd08tKNtpqJ+yQq3tbsWzflgWnahJfi
	WI2T46tQfbE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C16DB2C020;
	Mon, 11 Jul 2016 14:44:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 44C2C2C01F;
	Mon, 11 Jul 2016 14:44:40 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"brian m. carlson" <sandals@crustytoothpaste.net>
Cc:	Eric Wong <e@80x24.org>, Ronald Wampler <rdwampler@gmail.com>,
	git@vger.kernel.org, mackyle@gmail.com, reubenhwk@gmail.com,
	sunshine@sunshineco.com
Subject: Re: [PATCH] config.mak.uname: define NEEDS_LIBRT under Linux, for now
References: <20160707204554.14961-1-rdwampler@gmail.com>
	<xmqqwpkxnoae.fsf@gitster.mtv.corp.google.com>
	<20160710221644.GA4927@whir>
	<20160711103653.GA29598@vauxhall.crustytoothpaste.net>
Date:	Mon, 11 Jul 2016 11:44:38 -0700
In-Reply-To: <20160711103653.GA29598@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Mon, 11 Jul 2016 10:36:53 +0000")
Message-ID: <xmqqmvlo9fqh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 868081C4-4797-11E6-8163-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Sun, Jul 10, 2016 at 10:16:44PM +0000, Eric Wong wrote:
>> My Debian wheezy LTS system is still on glibc 2.13; and LTS
>> distros may use older glibc, still, so lets not unnecessarily
>> break things out-of-the-box.
>> 
>> We seem to assume Linux is using glibc in our Makefiles anyways,
>> so I don't think this will introduce new breakage for users of
>> alternative libc implementations.
>
> This is a good idea.  If it's broken with Debian wheezy, it will also be
> broken for RHEL/CentOS 6.  People who really want the slimmest linkage
> can use the -Wl,--as-needed flag.

Thanks all, will apply.

