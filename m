Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01F051F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 22:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbcHOWas (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 18:30:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57050 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751176AbcHOWar (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 18:30:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 33974367BF;
	Mon, 15 Aug 2016 18:30:46 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p5Y16iT0qLRQrf/oOsb5VQOkPq0=; b=K44r98
	8lDnrux7vNukbpaqKhZq7xgcvWMQ3y2BeyP4DE9upQieBDLVgqHOEpuHe63MjSQI
	K77cOHbMgY8eRlLY8DSMpjv2R41rq5moFtmi5cnURN+C9anyHoCWrMCEGXRKcLpR
	oE2KBzy93mpD/n3ByDaHZEQIUCeEXcIPSck/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rLb/DMFN5V3ORtquhkHZL6TNgK5xRgr7
	+0ssktHIsNUn3VZY7bEY0j3oIL2/mzaMXFOiHW0RuPDd/5YCTCg86zdKfKC+DSXA
	Vy89KpC1s8EtrwIENGDuZDCInZgBvTzlrdhWrHH7UHuwe2IImRPetHDDm0+uZb/0
	S3dqGbCMo30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2B94C367BE;
	Mon, 15 Aug 2016 18:30:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C61EA367BD;
	Mon, 15 Aug 2016 18:30:45 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
Subject: Re: [PATCHv5 0/8] git clone: Marry --recursive and --reference
References: <20160815215327.15682-1-sbeller@google.com>
Date:	Mon, 15 Aug 2016 15:30:43 -0700
In-Reply-To: <20160815215327.15682-1-sbeller@google.com> (Stefan Beller's
	message of "Mon, 15 Aug 2016 14:53:19 -0700")
Message-ID: <xmqqziodekbw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E89B2C7C-6337-11E6-89D8-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As the comments only address programming work as opposed to design, the 
> interdiff is rather small:

Thanks.  Will queue.  I think we do not need that extra err strbuf
in add_one_reference(), but we can go either way and it is not worth
rerolling.

