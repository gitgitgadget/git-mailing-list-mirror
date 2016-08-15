Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4A71F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 22:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbcHOWiL (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 18:38:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752258AbcHOWiK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 18:38:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 87479350BB;
	Mon, 15 Aug 2016 18:38:09 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bbkQeUqzaArSVSpQ9p4FztGK0X0=; b=tHuH0A
	fHd+eWDg8pLzlexs3Bin4sipIYTJ+2WSz4aMPeb1+aJgk96Y1UkY2YlqZ1265b9H
	59MWxXljRbuUukwuN107E7yxq40uYBC/FF1RUR4h+4l7Xda4e64FClNlRoxcMuRn
	OjrL9FdmjcpLs9iHIIEGp6BtyRLvooxG1Ldcc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k3C2NQ3S9LAik0fkfIlESB2r0Yl2GvP/
	8QJhRI1d/+9knkoyZraDNHuzyqdQ75KJpOkXUbiIrdnHF+/ubSWeqQ/wYKC/4nVK
	3ylR56bqMDfJJyW1/mAbktiThxTtsNFNby/NrDO8ORvsNxTCrFE5RBFYb7KGGplQ
	BsVyBCDAyog=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FDB7350B9;
	Mon, 15 Aug 2016 18:38:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 05531350B8;
	Mon, 15 Aug 2016 18:38:09 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	jrnieder@gmail.com, remi.galan-alfonso@ensimag.grenoble-inp.fr
Subject: Re: [PATCH 2/2] checkout: do not mention detach advice for explicit --detach option
References: <20160815184021.12396-1-sbeller@google.com>
	<20160815184021.12396-2-sbeller@google.com>
	<20160815184730.eevqogqrxp2zp43q@sigill.intra.peff.net>
	<xmqqh9alg2uh.fsf@gitster.mtv.corp.google.com>
	<xmqqd1l9g2lv.fsf@gitster.mtv.corp.google.com>
	<20160815211354.vsyg3lpira6pttom@sigill.intra.peff.net>
Date:	Mon, 15 Aug 2016 15:38:07 -0700
In-Reply-To: <20160815211354.vsyg3lpira6pttom@sigill.intra.peff.net> (Jeff
	King's message of "Mon, 15 Aug 2016 17:13:54 -0400")
Message-ID: <xmqqvaz1ejzk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0D1564A-6338-11E6-A8EF-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  			   REF_NODEREF, UPDATE_REFS_DIE_ON_ERR);
>>  		if (!opts->quiet) {
>>  			if (old->path &&
>> -			    (advice_detached_head == 1 ||
>> -			     (advice_detached_head == -1 && !opts->force_detach)))
>> +			    advice_detached_head == 1 && !opts->force_detach)
>
> Maybe s/== 1//?

Surely, and thanks.
