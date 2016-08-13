Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6106D2018E
	for <e@80x24.org>; Sat, 13 Aug 2016 15:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752672AbcHMPbF (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 11:31:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752648AbcHMPbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 11:31:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FD0A35114;
	Sat, 13 Aug 2016 11:31:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MFIjDz5IwHzN6ozoR13PW5GqHcg=; b=xeVYjv
	OvYJewXKDqOe2o1hz+uxnVcn/1fNZ0W0Ff1/2TxaZBxZXq4haoqqUjvMNVT2Rs37
	OhJ/T2ZSdGSxKraeBEVGdNQQPoUBaTKZ94Fm6L5CCcyfHFuGpn2DHKwMFsH/8dHt
	g/SQvGrPaecDSdbHAapERw4HircrI6PKt0ZdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r9XUYF/PCmZ8ChOCWElbhcmAgEf3ERe/
	Zit984g9vODflz1sXWkjHzsGhuf/oMJtAlfi4T+fb2+cHg1ii463WRs9XT1U4WEl
	MWEkTVmtjjL9a9IrGHJ2fb82lMwPfTWtWCBNctmbtiw04pfuKFuU6gm4YxECPeDD
	Y9VOQ3Obp9g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1712B35113;
	Sat, 13 Aug 2016 11:31:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8E36235111;
	Sat, 13 Aug 2016 11:31:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"Ralf Thielow" <ralf.thielow@gmail.com>, <git@vger.kernel.org>,
	<larsxschneider@gmail.com>, <me@jnm2.com>
Subject: Re: [PATCH] help: make option --help open man pages only for Git commands
References: <CAPc5daXicjUDi6B-MA8Sn=_UZ_jHvc8SE4ZXt2dHbbDQkD7=WA@mail.gmail.com>
	<20160812201011.20233-1-ralf.thielow@gmail.com>
	<xmqqk2flvfhb.fsf@gitster.mtv.corp.google.com>
	<xmqq1t1tvbu8.fsf@gitster.mtv.corp.google.com>
	<F3BA479B58944083A62896E2F0504D48@PhilipOakley>
Date:	Sat, 13 Aug 2016 08:31:00 -0700
In-Reply-To: <F3BA479B58944083A62896E2F0504D48@PhilipOakley> (Philip Oakley's
	message of "Sat, 13 Aug 2016 01:08:22 +0100")
Message-ID: <xmqqwpjku1mz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F171F8E0-616A-11E6-AB8C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

> But does it cope with the Guides? Should it cope if spelt that way?
>
> git help revisions
> git revisions --help

Hmph.  Ralf's patch is not just "I wonder if we could do a bit
better" but is also a regression.  I do not particularly care
if the latter stops working, but the former definitely should,
as "git help -g" encourages readers to type that, but with the
change "git help <concept>" seems to stop working.

