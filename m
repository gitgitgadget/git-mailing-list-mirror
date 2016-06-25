Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77C2E1FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 06:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbcFYGR4 (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 02:17:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53840 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751053AbcFYGRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 02:17:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73BAC2064B;
	Sat, 25 Jun 2016 02:17:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=epdee7SsgBkCShNfq47YK5fFYGQ=; b=lCdY2G
	KRW9nhOgh3mHuuJQUwxD9J33QV0X+PVK0HiiwTxWD/GyXEtMlx4kFJ+uvqs0Qhew
	8oKXxFYXtZrmQCrzbZq5J4/XfxQJEb6caQtO6ZgZOtQqVwAnB9ffXXSsaEOqENno
	XhS/vKbkvYs6uyBFDlLVQKj/Rpa7Gpzk+M4Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IAphLuJqdi1i1oHeSWEtbrEHrzG6qinT
	lYB2FoRZW/NkoK1MopC4ZCpQ86PbCJszhtfqLzn3Z8hiI0OUVwdur1WOoCycmxiZ
	JD+zc5M64ZEz7Gb4UWmbhB33ePdp50xZkIUryxDnBdE7b2KTOy67/MnMJVTfQtWk
	cRDmk3j/q1w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6AEC62064A;
	Sat, 25 Jun 2016 02:17:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6FE820649;
	Sat, 25 Jun 2016 02:17:53 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Barret Rennie <barret@brennie.ca>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
References: <20160625051548.95564-1-barret@brennie.ca>
Date:	Fri, 24 Jun 2016 23:17:51 -0700
In-Reply-To: <20160625051548.95564-1-barret@brennie.ca> (Barret Rennie's
	message of "Fri, 24 Jun 2016 23:15:48 -0600")
Message-ID: <xmqq60sxeqr4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8D3304AE-3A9C-11E6-AE55-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Barret Rennie <barret@brennie.ca> writes:

> Add the --name parameter to git worktree add that allows the user to set
> the name of the created worktree directory. A worktree must not already
> exist with the current name or creation will fail.

Hmph.  This strongly smells like "because we can add this feature",
not "because we need to add this feature".

What problem does it solve?  Please do not give me "currently we
cannot give a name and instead live with the automatically given
one, and with this patch we can give arbitrary name" as the answer.
That is what I called "because we can".  Why is it bad that you have
to live with the name automatically given to your new worktree?
