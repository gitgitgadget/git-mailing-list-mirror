Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6AEC51FF40
	for <e@80x24.org>; Wed, 29 Jun 2016 16:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbcF2Q5i (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 12:57:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56803 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751674AbcF2Q5h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 12:57:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E30DE27A47;
	Wed, 29 Jun 2016 12:57:33 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r4NlSA6VHYYvSQGDJLN1TyiW6cg=; b=AefIMK
	WqXuW4xqWIxvNdcIRYpt982sduYBpjqIKgdInU2ExzETJRh6W/IUC+unc5dqtd/u
	3pAUHiP7JTzzXjYkG1jw8D3lhz+nnr/BNZOUQTcL0L/ZigtZbaoq6XETKf3FTx/E
	8rhGKKEViNy+3E5gZS1V7UJJzPyPFCWpTIHOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UmPTZsWrW3oNEz4OWdaZVwZ9RDEkQAkg
	kCs1+4IyL2KD1lGzLfa6caN1xY5r0QbASAQ54POokpqZhdpANHMtf+lhVzQS+C2r
	oL3DET+jrLPLqQGWsREJ/AH1z7tDZZrNsNXu53/2AAfL2dIWGOr0NP1doWMzabeg
	H0IAVo/SS/E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DBF8127A46;
	Wed, 29 Jun 2016 12:57:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6181827A45;
	Wed, 29 Jun 2016 12:57:33 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: preview: What's cooking in git.git (Jun 2016, #10; Tue, 28)
References: <xmqq4m8c7uo6.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1606291345440.12947@virtualbox>
Date:	Wed, 29 Jun 2016 09:57:31 -0700
In-Reply-To: <alpine.DEB.2.20.1606291345440.12947@virtualbox> (Johannes
	Schindelin's message of "Wed, 29 Jun 2016 13:47:31 +0200 (CEST)")
Message-ID: <xmqq4m8c53wk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92C90388-3E1A-11E6-BB5E-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 28 Jun 2016, Junio C Hamano wrote:
>
>> * jk/ansi-color (2016-06-23) 7 commits
>>   (merged to 'next' on 2016-06-28 at 354989c)
>>  + color: support strike-through attribute
>>  + color: support "italic" attribute
>>  + color: allow "no-" for negating attributes
>>  + color: refactor parse_attr
>>  + add skip_prefix_mem helper
>>  + doc: refactor description of color format
>>  + color: fix max-size comment
>> 
>>  The output coloring scheme learned two new attributes, italic and
>>  strike, in addition to existing bold, reverse, etc.
>> 
>>  Will merge to 'master'.
>
> Please note that those "colors" do not work on Windows, at least as far as
> I know, I only skimmed the code in set_attr():
>
> 	https://github.com/git/git/blob/v2.9.0/compat/winansi.c#L175-L314
>
> ... and it looks as if italic is plainly unsupported, and strike-through
> is not handled.

This hopefully is a low-hanging-fruit for aspiring new developers in
the Windows land, perhaps?

We do not use italic/strike as a built-in default style for
anything, so we do not have to wait for Windows support of these two
attributes to appear to include this topic in the next release.

After all, users on "screen", or anything that translates these ANSI
colors via termcap/terminfo, do not get them, either.  A user may
try using these once, notices that her terminal lacks support, and
would move on.

Thanks.
