Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D663D2021F
	for <e@80x24.org>; Tue,  2 Aug 2016 22:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533AbcHBWaT (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 18:30:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754146AbcHBWaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 18:30:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D6D9E32299;
	Tue,  2 Aug 2016 18:17:54 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M/rh4RiiG97z63lDN9TaSgjpEqs=; b=dHsiqL
	zjkbW60JhoULkJOHpyRBPSPDKg01AWzsvWGejTw9RrAA7hQUdb1K407RakaszBfH
	z1lKLi7B8E1x5JJ7E/EKgqZkqNez0aiBCHz3Th+/ofpDBvPUyidko/+cZiX+BF4E
	8dYQbDKVhaniNVc5kwZCb/MsWFk9cSiWX5jYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cuT+PNnTLOU19YRrAHPEA15JEdBGSvAI
	de0jisXGpbwU544Tn6iw8Qvb0ep9WfRx96/iPv6PDqh1fMY1QiafZUk4IOljiiH8
	dvkjqHIXWU0x74foXLZyP41Dyn9C/e2Ys1TcaeVSAgrVsfckLBnh5mzE3q0a270p
	OS5jdcZepWM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CDCCD32297;
	Tue,  2 Aug 2016 18:17:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 595B532296;
	Tue,  2 Aug 2016 18:17:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 09/13] bisect--helper: `bisect_write` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423cf7-078bef36-54e8-4200-9097-17d95d4f3c40-000000@eu-west-1.amazonses.com>
	<xmqqmvkudiju.fsf@gitster.mtv.corp.google.com>
Date:	Tue, 02 Aug 2016 15:17:52 -0700
In-Reply-To: <xmqqmvkudiju.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Aug 2016 13:25:57 -0700")
Message-ID: <xmqqpopqbysv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F56BC4B8-58FE-11E6-8CFB-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> Reimplement the `bisect_write` shell function in C and add a
>> `bisect-write` subcommand to `git bisect--helper` to call it from
>> git-bisect.sh
>
> Up to around this step we've seen these patches well enough and I
> think with another reroll or two, they are in good enough shape to
> be split out and frozen for 'next'.  We may not be there quite yet,
> but I think we are getting pretty close.
>
> Thanks.

By the way, this series applied as a whole seems to break t6030.
