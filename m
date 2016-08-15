Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BF221F6C1
	for <e@80x24.org>; Mon, 15 Aug 2016 17:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753104AbcHORqc (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 13:46:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55780 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753098AbcHORqb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 13:46:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5715D346F1;
	Mon, 15 Aug 2016 13:46:30 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kbgNdckfvP7qgT1FoKZxKRkulx8=; b=M4Rg7i
	ReHS6tStjwOqWwXJzNtZiVkXxZA1eddLmfqoglMghMGEe11VSgretRk0Q/HV+pjX
	rXDUz7+OOOIU1hGFuRMQlI5dl/gapCmKskZKINrDRAHtM8ZIVG1v6RxCaibj2nKe
	zFSAwaraOgl9htaB0SP7X0cGpI8oc56XifffU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jz3gcxtLKPMXSfgtp4n/TXlFky1rPCxW
	O1hc+agd0Zv1f76O/WxlpfbYJ2tLiYaIILV2RN1TtSrOI88evQYKsnEb2MWCSzxT
	A2qj4+JEH4G+EyR7pbRrSCpGpM56FnoRFpZFuV4JeJxyg/Yf1ia7loaVoigyAXvw
	4T3t/p7iAMQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4F8D7346F0;
	Mon, 15 Aug 2016 13:46:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CFC60346EF;
	Mon, 15 Aug 2016 13:46:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Eli Barzilay <eli@barzilay.org>
Cc:	git@vger.kernel.org
Subject: Re: Minor bug: git config ignores empty sections
References: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
Date:	Mon, 15 Aug 2016 10:46:27 -0700
In-Reply-To: <CALO-gutdz5VMgoRmbqEa9UiaTC+L2Sy2n-3AF+zfPr-X8+1U4A@mail.gmail.com>
	(Eli Barzilay's message of "Sun, 14 Aug 2016 21:29:27 -0400")
Message-ID: <xmqqvaz2gc24.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3276A862-6310-11E6-97B0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Eli Barzilay <eli@barzilay.org> writes:

> Looks like there's a problem with setting a config with an empty
> section, making it create a new section.  The result is:

Thanks; this unfortunately is a well-known issue, that once was even
(supposed to be) a part of GSoC project but hasn't been solved.

The latest mention of the same issue I think is

https://public-inbox.org/git/xmqqeg95aor6.fsf@gitster.mtv.corp.google.com/

which redirects to

    If you are interested, start here:

    http://thread.gmane.org/gmane.comp.version-control.git/219505/focus=219524

but gmane web interface is not working and an equivalent is here:

https://public-inbox.org/git/20130329195155.GA19994@sigill.intra.peff.net/

