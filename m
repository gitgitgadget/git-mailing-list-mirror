Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BAC01F744
	for <e@80x24.org>; Mon, 11 Jul 2016 18:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbcGKSmr (ORCPT <rfc822;e@80x24.org>);
	Mon, 11 Jul 2016 14:42:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752575AbcGKSmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2016 14:42:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 504DD2BDC4;
	Mon, 11 Jul 2016 14:42:45 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6f4mU3hvtUrT/rjM+wURuV81tIQ=; b=alJ5SZ
	qF2NJ0+gLGPAdkaMntQFUBof/pzlZrWZ6jsU0E3ueGpx+x/YOJcj773yQf+2NY9f
	cmIaT/Xb446Ttq9geTs3UOH0svBjhuyQSW/iQPO7y4wUaoc/z6rKuTSBFcE9jKBi
	uQj7zHR8i7lroQTlrypgw22M7xL6Rz2LBKZUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hpJE2f/xGTPL/cEBBFL6MLQ00KPWbObv
	Va6c6zsKoGf9B6xFEqhLbyJaOKeKS0Tj7cnvWmh/44sTmwGJBV/+uoCKiSdnkymT
	ymB3+q97KYAYDvYVTf5J9xadJsWqStnC2hwgfmIL1iQY+k2Kj9TBN/ulKpeLXuxT
	otzEDiKfmPw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 449BE2BDC2;
	Mon, 11 Jul 2016 14:42:45 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AFAF42BDC1;
	Mon, 11 Jul 2016 14:42:44 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Jeff King <peff@peff.net>,
	Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 3/4] push: accept push options
References: <20160707011218.3690-1-sbeller@google.com>
	<20160707011218.3690-4-sbeller@google.com>
	<xmqq60shp3w9.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbkbb=qYUYmKnuKwJCBtidymXua3eAZGANpXDHT56pqGQ@mail.gmail.com>
Date:	Mon, 11 Jul 2016 11:42:42 -0700
In-Reply-To: <CAGZ79kbkbb=qYUYmKnuKwJCBtidymXua3eAZGANpXDHT56pqGQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 8 Jul 2016 15:59:53 -0700")
Message-ID: <xmqqr3b09ftp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 419558F0-4797-11E6-8B4B-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This is not what I had in mind, but rather the pain of dealing with multi line
> environment variables.

Hmph, is that painful?

    $ cmd "$VAR"

inside double quotes would do multi-line just fine, I think.

But I think it is OK (and probably preferrable) to limit the options
to be a collection of one-liners.
