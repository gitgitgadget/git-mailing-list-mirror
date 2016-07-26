Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B366203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757012AbcGZUoH (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:44:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59188 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752550AbcGZUoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:44:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C39653035E;
	Tue, 26 Jul 2016 16:44:03 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lLXByRYhhhYClgQvo64fmSDaWW4=; b=SnZFPj
	r8xcyI/g1xY2XeYpjIyVDaaGxEzbGsU1wAu7phJc4Up4MlCteUUhIH3AbZKQ5wGO
	XZFWx4ZNba7DOdzGWMMFleOd58btAIbt/BQAjZ1ezPBOBDltI4GvvCCK+6LNBAR9
	4igkll/adDPzsDxJPyTPnWxUKtSnVE1qWYzzk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FaFuGUsSHpTqKsbFPt0tZvcIpKrI8EVj
	1jtjizMrXBUW3KeLtooDtWlYvAADSc5wT418invx5Cmq7IPXWD9hslbeGE0HEOTU
	s7x+u2TanPzba/yldgWGeDA2NBtkMhHCMQ1+OyJtadn34SlzF6k9vc3u7z98Q5Yn
	gq/UczTEqDQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BB9D33035D;
	Tue, 26 Jul 2016 16:44:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 421B03035C;
	Tue, 26 Jul 2016 16:44:03 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	orgads@gmail.com
Cc:	git@vger.kernel.org
Subject: Re: [PATCH v2] commit: Fix description of no-verify
References: <1469541615-21726-1-git-send-email-orgads@gmail.com>
Date:	Tue, 26 Jul 2016 13:44:01 -0700
In-Reply-To: <1469541615-21726-1-git-send-email-orgads@gmail.com>
	(orgads@gmail.com's message of "Tue, 26 Jul 2016 17:00:15 +0300")
Message-ID: <xmqqoa5kyvse.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B0225AB2-5371-11E6-8E26-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

orgads@gmail.com writes:

> Subject: Re: [PATCH v2] commit: Fix description of no-verify

Following the prevailing style from "git shortlog --no-merges -100"
would make it "commit: fix description of no-verify", but "fix" is
too generic a word and does not convey as much information as it
wastes bits ;-)

    Subject: commit: --no-verify option skips commit-msg hook, too

perhaps?

> From: Orgad Shaneh <orgads@gmail.com>
>
> include also commit-msg hook.

Then this half-sentence can go completely.

Thanks; I'll do the above myself while queuing, so there is no need
to resend.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 163dbca..2725712 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1616,7 +1616,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
>  		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
>  		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
> -		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
> +		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
>  		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
>  		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
>  			    STATUS_FORMAT_SHORT),
