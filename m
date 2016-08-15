Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61C0D1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 15:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752957AbcHOPmZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 11:42:25 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57217 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752850AbcHOPmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 11:42:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9F8EC3320A;
	Mon, 15 Aug 2016 11:42:23 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PUmVKySqEA8ScsT5DG6l1Mbd3D0=; b=TO6I/v
	in+IQlHmNGFkqFKfYGtW74vFXLqGTrNhs2F32vOoe7UeZHq0DaW+wa1QPGbo7tqj
	gBQ0jT/yehRszcihbe/dQ1fP8qdicE/JVXH9oN0wunoqfSnBYbcmh2929PwPrPfR
	e3kCDR8YIfYYn43z3oXNLAaR1lyUpRyW4kL8I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EFAhYsFbBI7W+XomXf5B12KHYGS2vANL
	j/ZNkGD8Vyi/j6xZy6GYzrXbgoebGUPtk+olQgPdYiNbkndlesG66OGCm19VeCLN
	vV1mxe7PvK+ojFu1ZkxFPsK+RpfbAEKqJA88/DP3TQOVZSM3tYBmXacY4B+U0Vzn
	Ng07WwzcRMw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97C5A33208;
	Mon, 15 Aug 2016 11:42:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D79733207;
	Mon, 15 Aug 2016 11:42:23 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	"Philip Oakley" <philipoakley@iee.org>
Cc:	"GitList" <git@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] doc: rebase: clarify fixup! fixup! constraint
References: <20160814214630.1312-1-philipoakley@iee.org>
	<20160814214630.1312-4-philipoakley@iee.org>
	<xmqqvaz3j8ln.fsf@gitster.mtv.corp.google.com>
	<73D1326EA2D94A1D8898884BF047C1B5@PhilipOakley>
Date:	Mon, 15 Aug 2016 08:42:21 -0700
In-Reply-To: <73D1326EA2D94A1D8898884BF047C1B5@PhilipOakley> (Philip Oakley's
	message of "Mon, 15 Aug 2016 00:23:18 +0100")
Message-ID: <xmqqshu6hwde.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBDD6826-62FE-11E6-AC46-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

"Philip Oakley" <philipoakley@iee.org> writes:

>> I think this is about
>
> Yes, but the original wording didn't make me think that.

Yeah, it is very plausible that it is not limited to you, and I
agree that it is worthwhile to update the description around here.

>>> Also, does 'earliest commit requiring fixup/squash' fully convey that
>>> its the one to fix.
>>
>> I cannot tell if that a question or a statement?
>
> It's a question. In your prior para you offer "they fix the very first
> commit that invited these fixups" as an alternate.

I think both are equally understandable to me (but I am not the
primary target audience).

> It's when a users mental model is that they got their first fixup
> wrong and it's that fixup they are correcting, and later they add
> different fixups to the orignal that it all gets hairy.
> (diffs must have the right sequence, while snapshots don't care - so
> if we keep the diff sequence, we don't care about the user's mental
> model as the end results are the same).
>
> The writeup needs to cope with the mental model rather than the end result.

Yes, yes.

