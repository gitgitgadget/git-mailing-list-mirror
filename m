Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F7732021F
	for <e@80x24.org>; Tue,  2 Aug 2016 20:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbcHBU0G (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 16:26:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63978 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933179AbcHBU0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 16:26:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BC3A335D2;
	Tue,  2 Aug 2016 16:25:59 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aSX0Eykz7C9AFZcTiGWpL+Y6MHs=; b=UOhXUh
	6OAvMwu5ENwoZM+eI+4J17BDy/fmtS+eT7Jfzc46MC601wagrKsDPc6navpl03Z5
	bXhdzslNymuOorY2KCl1nhpr8BIIxfFeEzlSmw9vB7PQSZG2f/k32V1xZ3efTm4R
	yx4MpkdLW5bPE4xD/DkU2SA1Fri2ei7h6sTsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PQaQ+qBJZCmyag/ulZUfUsQ+gwjVITvc
	sES0lP4MXhd4F5EgNVrWfdfu+MeTRhNiGRecrE+k/P4Ght4sPgbz9vhLy4xYi8Pb
	YGBMb015FKvwy8uoIXG1FLYFG9WqAHlVSc7XXUQJReDdJWe24gUTUA48bf9CZP8b
	PeFayiBpbCE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 84F85335D1;
	Tue,  2 Aug 2016 16:25:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B33E335D0;
	Tue,  2 Aug 2016 16:25:58 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: [RFC/PATCH v11 09/13] bisect--helper: `bisect_write` shell function in C
References: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
	<0102015640423cf7-078bef36-54e8-4200-9097-17d95d4f3c40-000000@eu-west-1.amazonses.com>
Date:	Tue, 02 Aug 2016 13:25:57 -0700
In-Reply-To: <0102015640423cf7-078bef36-54e8-4200-9097-17d95d4f3c40-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Sun, 31 Jul 2016 09:21:38 +0000")
Message-ID: <xmqqmvkudiju.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52C680B8-58EF-11E6-9E5D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Reimplement the `bisect_write` shell function in C and add a
> `bisect-write` subcommand to `git bisect--helper` to call it from
> git-bisect.sh

Up to around this step we've seen these patches well enough and I
think with another reroll or two, they are in good enough shape to
be split out and frozen for 'next'.  We may not be there quite yet,
but I think we are getting pretty close.

Thanks.

