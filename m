Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569FAC4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C23F238E3
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 20:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgLGU4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 15:56:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63771 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgLGU4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 15:56:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D2F22FF068;
        Mon,  7 Dec 2020 15:55:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=WyQOfBlkQc6Z6NVDJndw0WVN21w=; b=id/HV1YuzKAIzDIz/QlO
        7Mo0lK6RdvwikgoyTt5QrYR5n0x2WHSlO346Zo6WVWFRUJEZkzok3qh7pTB7kN72
        fePHnSthFMzOVf57ldYXWS4m0NOAXiXbd+VYVLpqjwqfmvOXbLFymtE8QxQ/ZDHN
        UBLPfk5dBCqmL1XarVbL/yU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=QBn/YWXFjazZm/cpRwvOY3eTNovxhrYKctMRHBeRKdkQHn
        Mwmzr0/9V7MGXgY/AVX56kamvSrfGHXoNJzVC4Z7BnnUuU85OGS6TOXpgdoxQTfW
        C53F16QKl0YHMSMkkNMnt3+HxSJjA40XYetBD18lWQJSgSZHhx8YhW/5XWIRw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CB8A6FF066;
        Mon,  7 Dec 2020 15:55:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 07CE0FF065;
        Mon,  7 Dec 2020 15:55:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v3 00/16] pull: default warning improvements
References: <20201205195313.1557473-1-felipe.contreras@gmail.com>
Date:   Mon, 07 Dec 2020 12:55:52 -0800
Message-ID: <xmqqwnxt8hev.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 98A7F422-38CE-11EB-B79D-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> It is not a complete solution, but should improve the current situation.
>
> Since v2:
>
> 1. The warning is updated to say "a merge, a rebase, or a fast-forward"
> 2. A suggestion 'If unsure, run "git pull --merge".' is removed
> 3. A new REBASE_DEFAULT is introduced
> 4. Tests are revamped using helpers
> 5. The logic of --merge and --ff-only is updated so one can override the other
> 6. A bunch of commit messages are updated
> 7. A memory inconsistency is fixed

On what base has this series been built?  Applying to 'master' seems
to stop at the "refactor fast-forward check" step.
