Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7206D1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbcFQXRF (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 19:17:05 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750774AbcFQXRE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 19:17:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C1F89250D3;
	Fri, 17 Jun 2016 19:17:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=201wiPPYkN4i
	lXTAIRHjfgUGtS4=; b=r25mB8Hyk/f2p3eU5Qd3Ka9skX76mK0BzZlVsN3ZVRCV
	z/sZz4rZGh79UT+MvCoBi7IUVFWBtxl05ve/FzT4B8njgJ1MvZCfHoBncdYD3lJL
	z/hpYsA0Pdd0IrmG0lKthPgWb/Tz9FYhFMTOrkqRH99NIxU3MslydPR/xNPdoZs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=s+Ru5x
	PGwsvwmzM/yG9i6/f9nzn185iJVXldQb4a95zazx2DaZabkWZUILrT2B4+dKiZtt
	M6Ucr4g8XwnuXLOXf7mnyLlSvHEK9oSOgEy4sm9Vweo/3rgLqssq48EXbwsBlt/j
	ryUDqmQUcV/bOeCm8w0b4y/cTXhgRrvZTSw1c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B8817250D2;
	Fri, 17 Jun 2016 19:17:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37077250D0;
	Fri, 17 Jun 2016 19:17:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH v6 00/11] Fix icase grep on non-ascii
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1454724190-14063-1-git-send-email-pclouds@gmail.com>
Date:	Fri, 17 Jun 2016 16:17:00 -0700
In-Reply-To: <1454724190-14063-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 6 Feb
 2016 09:02:59 +0700")
Message-ID: <xmqq4m8rz9qr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 991BAE9E-34E1-11E6-99BE-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v6 fixes comments from Ramsay and Eric. Interdiff below.

Another thing I noticed with this is that the non-ascii test breaks
when run under dash (but passes under bash).  You need to have is_IS
locale on the system to see the breakage, it seems (which is why I
didn't see it so far).

