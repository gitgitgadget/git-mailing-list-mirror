Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C5611FD99
	for <e@80x24.org>; Sun, 14 Aug 2016 22:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbcHNWLw (ORCPT <rfc822;e@80x24.org>);
	Sun, 14 Aug 2016 18:11:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751788AbcHNWLw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2016 18:11:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D663584F;
	Sun, 14 Aug 2016 18:11:50 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E0ebxJzMD23qeYBzjWoLhmQ/y9Q=; b=O6Nmf5
	6YA7Pz+Q++PtqItP5okPTkReVBAU6+WuDZa9bnkhA36N8WFqwtwVfGie+LTiWxjU
	o6aE3X5+dwaLPsc1whj6Q3rd069xkwn/Gw7Ir1aYAiLvfAHvVTkee3ESybkJsTKF
	J62YVnK9c4jkWIJVVfB1PBNBGLsV53I2+5s5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nawmo/Q0hhJgIjm4oL+LzHVn5zcbD0Kb
	5dGnIs7/fBy4SPKVOE5RV+GtBHjL8RDQzxYxJCL3g09pNyy7x5cYh1Eabg1YkgeJ
	ZkMzv2Zs+I2aUYEVEEAePfighKHzTtAJlJrdtvJf13O9bRLJhOYMUgzCs34EE5Lt
	Si16pn/Z26E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 679193584D;
	Sun, 14 Aug 2016 18:11:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EB5903584A;
	Sun, 14 Aug 2016 18:11:49 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] doc: rebase: fixup! can take an object name
References: <20160814214630.1312-1-philipoakley@iee.org>
	<20160814214630.1312-3-philipoakley@iee.org>
Date:	Sun, 14 Aug 2016 15:11:48 -0700
In-Reply-To: <20160814214630.1312-3-philipoakley@iee.org> (Philip Oakley's
	message of "Sun, 14 Aug 2016 22:46:29 +0100")
Message-ID: <xmqqziofj90b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 192CF9DC-626C-11E6-B776-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> Since 68d5d03 (rebase: teach --autosquash to match on sha1 in addition
> to message, 2010-11-04) the commit subject can refer directly to the
> destination object hash as a single word.)...

That's not an object hash but an object name (see glossary); you got
it right in the actual patch text, though ;-).

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 0387b40..66b789a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -421,7 +421,8 @@ without an explicit `--interactive`.
>  --no-autosquash::
>  	When the commit log message begins with "squash! ..." (or
>  	"fixup! ..."), and there is a commit whose title begins with
> -	the same ..., automatically modify the todo list of rebase -i
> +	the same "..." message, or a commit object name (standalone),
> +	automatically modify the todo list of rebase -i

What's "(standalone)"?  I can understand the updated text and agree
that it is better than the original without that part, though.

>  	so that the commit marked for squashing comes right after the
>  	commit to be modified, and change the action of the moved
>  	commit from `pick` to `squash` (or `fixup`).  Ignores subsequent
