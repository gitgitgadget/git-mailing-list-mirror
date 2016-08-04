Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4855120193
	for <e@80x24.org>; Thu,  4 Aug 2016 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965738AbcHDUmR (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 16:42:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965213AbcHDUmQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 16:42:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E4D630B35;
	Thu,  4 Aug 2016 16:42:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=65wMKmdeiueVRN28JoiiNdOJvSw=; b=pt/DAn
	qhTJIMd2f1Lwyfiot2M5HLCQ+TvCqK9CqTAuyzY0/U6jXlukeCsXZF46dyuADKYj
	nugTZAiTxpjilWoSuE3peiyyaEXj30SCSKWJpir/0B9J34WDZp6kfbBMbr57yTH8
	FVlsjgrUQCbJTp1RtZsFDFzs3zpe8JRWXE9H8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rn8QwWCMZlMlP7bctF9etS8WRaFgE/V+
	Q1Y6TZ7Wp3ZfvsbA+0qkcKS/ZK7A2McsHCqKC4zm1sAtcf94CNuwr6wKMOS4E/Si
	aMA/Ewb6jwZU+mvEnYuQIWxgQbt0xGZy1d64wUa5H5Omvvqp5vudyGX+iOtgayYC
	eYgalccEnmo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1731930B33;
	Thu,  4 Aug 2016 16:42:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9776730B32;
	Thu,  4 Aug 2016 16:42:14 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jeff King <peff@peff.net>
Cc:	larsxschneider@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH 4/7] trace: cosmetic fixes for error messages
References: <20160803225600.fgm23bdacunmrw44@sigill.intra.peff.net>
	<20160803230022.drw4kcwgheeqn3xr@sigill.intra.peff.net>
Date:	Thu, 04 Aug 2016 13:42:12 -0700
In-Reply-To: <20160803230022.drw4kcwgheeqn3xr@sigill.intra.peff.net> (Jeff
	King's message of "Wed, 3 Aug 2016 19:00:23 -0400")
Message-ID: <xmqqfuqk1d23.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED17422A-5A83-11E6-BB7A-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it would be nicer to still to print:
>
>  warning: first line
>  warning: second line
>
> etc. We do that for "advice:", but not the rest of the vreportf
> functions. It might be nice to do that, but we'd have to go back to
> printing into a buffer (since we can't break up the incoming format
> string that we feed to fprintf).

Yes, yes.
