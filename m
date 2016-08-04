Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75F6320193
	for <e@80x24.org>; Thu,  4 Aug 2016 18:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934046AbcHDSsU (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 14:48:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934029AbcHDSsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 14:48:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CA2D732971;
	Thu,  4 Aug 2016 14:48:16 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5QcDHumwijoYUbuXlIkkhrsw8ME=; b=EqeoiJ
	oXsjcCf9UgqN6uTPDcMY4lujZmNv47i8hjqOFFihLtBwXckUagWN4aDI3gMRaAfh
	us3viblI8R4Kum+sshG738InaqvP4189EtnMHSxuA0oR03JojRFGXW6hoIHfA0wq
	TL9PhUkO8dqJvG8QvGWBb4HGPmB3l6GwQs2dU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QluJmp3g80whBpfme6SaHs3i0SK59xA6
	lSHQlKrNTDICGC0afanSSdh1foKPYKoOb6kO9/1b8X5P6svGyYPwR7Du0wA4kBqA
	Y7Q07zaiMpRnrbSyJI1avhlfqXnw/UvDgYkr/EMrXHT29O0f9qqqnDMisbEsNDXu
	KSTNlqkgxLU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C23AE3296F;
	Thu,  4 Aug 2016 14:48:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4FC7A3296E;
	Thu,  4 Aug 2016 14:48:16 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Michael Haggerty <mhagger@alum.mit.edu>
Cc:	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Jeff King <peff@peff.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 7/8] is_blank_line: take a single xrecord_t as argument
References: <cover.1470259583.git.mhagger@alum.mit.edu>
	<4a83126ab9e7bff9061204296798bf281242358e.1470259583.git.mhagger@alum.mit.edu>
Date:	Thu, 04 Aug 2016 11:48:14 -0700
In-Reply-To: <4a83126ab9e7bff9061204296798bf281242358e.1470259583.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Thu, 4 Aug 2016 00:00:35 +0200")
Message-ID: <xmqqk2fw2wwh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0126A5EA-5A74-11E6-B781-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> There is no reason for it to take an array and index as argument, as it
> only accesses a single element of the array.

Yup, I think I am partly guilty.  The result looks much nicer.
