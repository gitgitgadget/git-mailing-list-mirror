Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C57AC203E1
	for <e@80x24.org>; Wed, 27 Jul 2016 17:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbcG0Rcx (ORCPT <rfc822;e@80x24.org>);
	Wed, 27 Jul 2016 13:32:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61966 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753815AbcG0Rcw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2016 13:32:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 141B42EF58;
	Wed, 27 Jul 2016 13:32:51 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dz4rPS5AukqZHTBHwuZZ0ePMdew=; b=iQCl0X
	Z/wfAn3YrVLZlBgIB6YiZMYXnk9lNB16VCdIL298YurcdypyglSrrR+qjfu01991
	ECncjcWwxinT7EYBtvI1vr2KTxHJya1q04ewN9QDPWcqmFZgOndOge0p6gZKWNnP
	QE+ikiNelNofRls+8maO2+3SXScfQm6wMSP/Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zhfp/TM0PnMXIbolsHiiJuGJdXlVdl0O
	sQFs9+ODoNj9SoKJ0+Z5ohK/mQyjGHGMQF2GTRWrdu1xV/r1droE6XtIoMZgzupr
	b5cTHSz+iF7BEqdSkvME4FONnpwz4Tn8vQHpuHFXtVcT532EkNWoazLVSgbHL5WG
	dcKP0Yp/t28=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BA3D2EF57;
	Wed, 27 Jul 2016 13:32:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8092E2EF52;
	Wed, 27 Jul 2016 13:32:50 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Chris Packham <judge.packham@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [PATCHv1] completion: add option '--recurse-submodules' to 'git clone'
References: <20160727083406.10241-1-judge.packham@gmail.com>
	<xmqqshuvvvxb.fsf@gitster.mtv.corp.google.com>
Date:	Wed, 27 Jul 2016 10:32:48 -0700
In-Reply-To: <xmqqshuvvvxb.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 27 Jul 2016 10:21:36 -0700")
Message-ID: <xmqqoa5jvven.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 24420D8A-5420-11E6-A70A-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> I noticed --recurse-submodules was missing from the bash completion. This adds
>> it. I went for '--recurse-submodules' instead of '--recursive' as I seem to
>> recall the former being agreed upon as the better (or least ambiguous) of the
>> two terms.
>
> Yup, that position is consistent with what 3446a54c (clone: fixup
> recurse_submodules option, 2011-02-11) gave us.

Silly me. The blame actually goes down to ccdd3da6 (clone: Add the
--recurse-submodules option as alias for --recursive, 2010-11-04),
but the conclusion is the same.

> Perhaps we should think about deprecating "--recursive"?  I dunno.

Anyway, I'll apply the "addition to the completion" patch.

Thanks.
