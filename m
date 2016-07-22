Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B01D0203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbcGVTwO (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:52:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752070AbcGVTwO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:52:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0E3C52CBD1;
	Fri, 22 Jul 2016 15:52:13 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M9LPrxpzP2BOmZIEshmLMI3CQSA=; b=An4YB1
	2eCCqPO7JfDi4zPYaQncUjUzbPvm+btbuhWlwi5G/70w2coimPU1PbQE6t7XiuDL
	+WgFkrTtidEzg7JhbltmHPMC7mrAswCqDb3j3luXas43vD/Op93kFoKtnZ1k2puu
	g1h8pWWhE/ktgSXuMfCcG7KButoFSkIVx680Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VgDX+GglXlNuCnUjhn6xFdp8msFzEL5M
	d7uz5ZordzUwFzZ6M77z579KR14oUchYBpohqneYypBUFAGEgn5VBrIka4tu38AM
	WX8PI7o20BzgaiC9IjnOynwci9gCa0DHMuWvymABvpZHcgDuXV74hzweOml4SnJe
	mde/lrayBqE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 05E782CBCF;
	Fri, 22 Jul 2016 15:52:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7A67C2CBCE;
	Fri, 22 Jul 2016 15:52:12 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 2/2] submodule-helper: fix indexing in clone retry error reporting path
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
	<4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org>
	<CAGZ79kbiVwyyTZLxQP+ioLBoC6r8dcJV4SdDUL_bn58bFUbsWg@mail.gmail.com>
Date:	Fri, 22 Jul 2016 12:52:10 -0700
In-Reply-To: <CAGZ79kbiVwyyTZLxQP+ioLBoC6r8dcJV4SdDUL_bn58bFUbsWg@mail.gmail.com>
	(Stefan Beller's message of "Fri, 22 Jul 2016 12:30:17 -0700")
Message-ID: <xmqq60rxa1sl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8516A44-5045-11E6-8681-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The approach to tests is different though. I like yours better than mine,
> as it doesn't add more tests, but strengthens existing tests.

So... are you retracting
http://thread.gmane.org/gmane.comp.version-control.git/299995 and
instead giving an Ack to these two?

