Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 676BD20193
	for <e@80x24.org>; Thu, 11 Aug 2016 17:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbcHKR54 (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 13:57:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751059AbcHKR5y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 13:57:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE812330FF;
	Thu, 11 Aug 2016 13:57:02 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ze3UVz/8S4DKkxDdMP0S8MlpoPk=; b=ZkLJHy
	qyFcmpjTdoXoUTxZMaW9ATXKYdIj7XExPn9gZkq+mYW1HztCFIK7AlK9PMUjNaA0
	ndmCgnxYDC506GiBrAG4MHJl3AXb1prZzVfpqwczE4qbx1y3m0iSYD79VLLFlvyr
	bFA1RTg/PJUzB8C92bHWK3DuOK1ut950uerSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rrp6br/ibssZ3prw8aNvBqaa7ajk/Ozf
	fkuDcZF+RtoTojWJGpBsIBV6osuNkO+6+yd/X3jexF7jaMdr597n7vHs81giuirO
	nyKvdmOCKSTxD5WtkFs7ut0km5YjD+/WSzTl+RnC7ItEGqqyO/9WrNJmemZL4KKr
	F4IBzK1pxvc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E065C330FE;
	Thu, 11 Aug 2016 13:57:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B556330FD;
	Thu, 11 Aug 2016 13:57:02 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jacob Keller <jacob.keller@gmail.com>
Cc:	Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
Subject: Re: Can cc's be included in patches sent by send-email
References: <D8F2D8316A4C4E198C6847C1165A8811@PhilipOakley>
	<CA+P7+xpyCQLsEHE-Hqqob5mQisW=aw1gC+5f6Qq3q01etjX2Ng@mail.gmail.com>
	<CA+P7+xrBegRdS-HXi2SfO0Uu6N=gUVVp_F29GCb1rQn9cnxnHQ@mail.gmail.com>
Date:	Thu, 11 Aug 2016 10:57:00 -0700
In-Reply-To: <CA+P7+xrBegRdS-HXi2SfO0Uu6N=gUVVp_F29GCb1rQn9cnxnHQ@mail.gmail.com>
	(Jacob Keller's message of "Thu, 11 Aug 2016 00:59:08 -0700")
Message-ID: <xmqq4m6r2npv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01C8E93A-5FED-11E6-B2A1-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, Aug 11, 2016 at 12:58 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Aug 11, 2016 at 12:32 AM, Philip Oakley <philipoakley@iee.org> wrote:
>>> While 'git send-email' can have multiple --cc="addressee" options on the
>>> command line, is it possible for the "cc:addressee<a@b.c>" to actually be
>>> included in the patches that are to be sent, so that different patches can
>>> have different addressee?
>>>
>>> The fortmat-patch can include appropriate from lines, so it feels as if the
>>> sender should be able to add cc: lines at the same place. Maybe its just
>>> part of th docs I've missed.
>>>
>>
>> Yes, just put them in the body as tags below the signed-off-by. It
>> should be on by default unless you change supresscc or signedoffbycc
>> configuration.
>>
>> Thanks,
>> Jake
>>
>
> See --suppress-cc or --signed-off-by-cc help in git help send-email.

Also, those who do not want to see Cc: in headers (like me) can
instead edit the header part of the format-patch output to add Cc:
lines and they should be picked up.
