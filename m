Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B58C820196
	for <e@80x24.org>; Thu, 14 Jul 2016 19:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbcGNTjh (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 15:39:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61626 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751246AbcGNTjg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 15:39:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A0FF92A3CE;
	Thu, 14 Jul 2016 15:39:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MssfycGvK/mBi79iANW56NGrq0Q=; b=l7nXyV
	33sp00ouBfRoh4HMtT2Ma5gs2aVhLcbafFCtf7w6DnW5uvtaqt1VmokYW78U8v65
	n7FeRLD68sk7BTy4H0gIe6x+8hE79JF2tFus2tBbrB6ZqgtLGHT1YL1pV2TSNmKJ
	f4Iiu+YfHzTdA3fGqpzi64oJ5mThmN0QB1Q3A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QbWldFPB0ZAch2QcR4n128bT64PtFbJA
	/Pu/d38Y/jZlFGRQjViVOyV5weMKeov/O0waayca301eiQjFjJMySRK7UBevDbPA
	NfExy0gNYwdJ402I8IS2WtgrAXyGsE7/JMUzG0YjB5lSklF67ttud3TSsUEgz6RM
	01zmpXDrUVw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 977232A3CD;
	Thu, 14 Jul 2016 15:39:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F3B22A3CC;
	Thu, 14 Jul 2016 15:39:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH v3 00/16] Use merge_recursive() directly in the builtin am
References: <cover.1467717729.git.johannes.schindelin@gmx.de>
	<cover.1467902082.git.johannes.schindelin@gmx.de>
	<xmqqpoqi35u3.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1607141414180.6426@virtualbox>
Date:	Thu, 14 Jul 2016 12:39:32 -0700
In-Reply-To: <alpine.DEB.2.20.1607141414180.6426@virtualbox> (Johannes
	Schindelin's message of "Thu, 14 Jul 2016 16:03:33 +0200 (CEST)")
Message-ID: <xmqq1t2wqaa3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0FCD348-49FA-11E6-B744-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The two topics that are in 'pu' and conflict with this series are
> 'jh/clean-smudge-annex' and 'bc/cocci'.
>
> It also conflicted with 'va/i18n-even-more', but that one was merged to
> 'master'.
>
> Now, I think it would be okay to wait for 'bc/cocci' to go to 'master'
> before integrating the 'am-3-merge-recursive-direct' branch, but I would
> want to avoid waiting for 'jh/clean-smudge-annex'.
>
> Do you concur? If so, I will rebase onto 'master' as soon as 'bc/cocci'
> lands in there.

I do not have a strong preference myself.  As you are not proposing
to eject jh/clean-smudge-annex from my tree, I'd have to resolve the
conflicts when the second topic is merged after one topic, whichever
happens to be more ready.  IOW, such a rebase adds to my workload.

Like it or not, it is normal for different topics to want to touch
the overlapping area or one topic to invalidate an assumption the
other topic is based on, and working well together does not have to
mean leaving the conflict resolution to the sole responsibility of
the integrator.  A clean way forward may be for everybody involved
(and I see you forgot to add Joey to this thread) to agree that this
topic is more ready than jh/clean-smudge-annex and you and Joey to
work together to rebase jh/clean-smudge-annex on top of this topic
(or possibly the other way around), making him wait for you.

