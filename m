Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5B16203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 16:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752867AbcGYQ65 (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 12:58:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751011AbcGYQ64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 12:58:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 39D872ECBF;
	Mon, 25 Jul 2016 12:58:55 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Qq/ldVvWcaaNXz2m4doQJLgl4u0=; b=lXN9jm
	RuMmxbonu+TetKixVn7OW08/ILU48FKVx6D+X5R2dWmWxJTTt71Obz4EqS3DLpII
	b6+WOJugcW2UttN1hNZ2t9Otyhrif86yOe/TejpDt5d03PpQLurqabN7bCrqCT+q
	/rIVOnq68p6y1rN4UNMouU5MZd4N89r/yPxig=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vhxP10hT0hKcA1sTcgGrkLKi2R5LI40k
	CLdJ+W8p6CSdlyyNu4YbWPA6LLrF3gU5sEqH5Sku9lRWC7UM1tKiFDJg60g5eaIw
	N8x1MkpP0o4nVOh5nK65ZHr7jFfT/GXNKNOo4eNdCZbJqWi23Uc9s26jb3Wg1mnE
	f5JjTv1s554=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 323732ECBE;
	Mon, 25 Jul 2016 12:58:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACA5D2ECBD;
	Mon, 25 Jul 2016 12:58:54 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Sidhant Sharma <tigerkid001@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] git subcommand to check if branch is up-to-date with upstream
References: <57960CFF.5060104@gmail.com>
Date:	Mon, 25 Jul 2016 09:58:52 -0700
In-Reply-To: <57960CFF.5060104@gmail.com> (Sidhant Sharma's message of "Mon,
	25 Jul 2016 18:28:39 +0530")
Message-ID: <xmqqd1m17iyb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 11FD0B40-5289-11E6-B090-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Sidhant Sharma <tigerkid001@gmail.com> writes:

> I was wondering if it would be a good idea to have a command to check if a
> push or pull is required. Perhaps it can also suggest if changes are
> fast-forward or the branches (local and remote) have diverged.

Doesn't "branch -v" give that information these days?  You'd need to
"fetch" first to get the up-to-date worldview before running it, of
course.
