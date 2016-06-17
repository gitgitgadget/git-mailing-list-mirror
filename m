Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DF520179
	for <e@80x24.org>; Fri, 17 Jun 2016 17:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753515AbcFQRES (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 13:04:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53130 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752796AbcFQRER (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 13:04:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3F5725281;
	Fri, 17 Jun 2016 13:04:15 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/07Hr/ouhnppNWs5UTva9blU4zY=; b=dWtzWi
	MEmSxrOcmIaXfVAcI1SjuwTb8HK1z81jBwYnJWgvew1qQpd6taKSZw6PYno0xQhz
	p84ZDBA+pZyq3CnmkGwv4ePfX5rYEfH/6/9wegFW9wlqa4fgVpYSbb4sYafwSeFt
	dap2Szw1NjY52q/339rA/9aFW39tuD5LWF/Kc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lSdgEKeNUbP7IqSTxA8Rfe00iDo0+9qd
	K/d7n1fSLfwE6He4plVlwQ6+DUZP5ZmcrLAd9Cv3xErLVO04Dsk2oK9qYiFOBqMR
	S2id2nlSzaS2PDLbp+KjjXzGTHuHtHZbU5twkCWGpYHupyfJYyKJdFxnvLxP7Rey
	j3byP0o6yAc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECD4D25280;
	Fri, 17 Jun 2016 13:04:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70DD52527F;
	Fri, 17 Jun 2016 13:04:15 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Martin Vladev <martinvladev@gmail.com>
Cc:	git@vger.kernel.org, szeder@ira.uka.de, spearce@spearce.org,
	felipe.contreras@gmail.com, lee.marlow@gmail.com,
	Martin Vladev <martin.vladev@gmail.com>
Subject: Re: [PATCH] completion: add "diff.compactionHeuristic" to git config
References: <20160617164223.79500-1-martin.vladev@gmail.com>
Date:	Fri, 17 Jun 2016 10:04:13 -0700
In-Reply-To: <20160617164223.79500-1-martin.vladev@gmail.com> (Martin Vladev's
	message of "Fri, 17 Jun 2016 19:42:23 +0300")
Message-ID: <xmqqshwb21de.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8583FC76-34AD-11E6-AE44-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Martin Vladev <martinvladev@gmail.com> writes:

> Signed-off-by: Martin Vladev <martin.vladev@gmail.com>
> ---

The reason why existing documentation marks this feature as
experimental is because we would eventually want to end the
experiment (and use the better heuristics, if the experiment yields
one, unconditionally).

Making it more discoverable by completing like this will make it
harder to end the experiment, so I am moderately negative on this
change.

Thanks.

>  contrib/completion/git-completion.bash | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 3402475..55862d6 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2066,6 +2066,7 @@ _git_config ()
>  		core.whitespace
>  		core.worktree
>  		diff.autorefreshindex
> +		diff.compactionHeuristic
>  		diff.external
>  		diff.ignoreSubmodules
>  		diff.mnemonicprefix
