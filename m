Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED441F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 16:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757016AbcHXQ02 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 12:26:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56260 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756350AbcHXQ01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 12:26:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F5B738AE9;
        Wed, 24 Aug 2016 12:18:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TocbPH4RuxIooCU+PWM4eLeP6co=; b=A9Gi9v
        hmZ8PTxLVODXgcPvOfG7ORmHAGEQhwBxLk9B5JdBM9PLGPjz006WbNTIxNzL1VHE
        3BU+EjEoDD4mWpNtn6dstCaHaKkGF+FIPU/89F6g9PO2OzDOWOizH1LLLeRZV3GG
        dOFztAHwuY98jMrDJZne7koogjAREg2+HNIRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cSXW6D8SQXutvh3MT+qvxMzfcI7kdcZH
        Pgv6Z1h014/TVR2j6UAeE9ocuOvs99BA4B9ECB4vJD+K/1K1Zp6udqRLFcFxVW2F
        XLDhdeDO55PUGZF4k/85uu8nA3kEI6bQFXROin53e/rqwztlmOCrxGIYvUjDt7Et
        3ymNxTuQDHg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7736838AE8;
        Wed, 24 Aug 2016 12:18:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE91538AE7;
        Wed, 24 Aug 2016 12:18:57 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@drmicha.warpmail.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Documentation/git-patch-id: give working code example
References: <5d33c4682e6251fc724b35c6f1c2f2a477a41b0a.1472043384.git.git@drmicha.warpmail.net>
Date:   Wed, 24 Aug 2016 09:18:56 -0700
In-Reply-To: <5d33c4682e6251fc724b35c6f1c2f2a477a41b0a.1472043384.git.git@drmicha.warpmail.net>
        (Michael J. Gruber's message of "Wed, 24 Aug 2016 14:56:52 +0200")
Message-ID: <xmqqfupurvgv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 75D27D68-6A16-11E6-94B4-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@drmicha.warpmail.net> writes:

> As it stands, the documentation gives the impression that
>
> git diff-tree <treeish> | git patch-id
>
> would be a working invocation of git patch-id, leaving the novice user
> in the dark.
>
> Make it explicit that 'git diff-tree -p' would be the command to use.

I take the lack of <treeish> as a strong hint that it is not meant
to be the full command line but merely there to make the command the
description talks about stand out from others (i.e. "This
description does not apply to 'diff-files' or 'diff-cache' output").

So I would think it is fine as-is.

Having said that, if we were to change something, I would rather
replace the mention of "diff-tree" with something like "git show" or
"git log -p", neither of which were even present in their current
form back when this piece of text was written.

>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  Documentation/git-patch-id.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
> index cf71fba..67f8e28 100644
> --- a/Documentation/git-patch-id.txt
> +++ b/Documentation/git-patch-id.txt
> @@ -21,7 +21,7 @@ have the same "patch ID" are almost guaranteed to be the same thing.
>  
>  IOW, you can use this thing to look for likely duplicate commits.
>  
> -When dealing with 'git diff-tree' output, it takes advantage of
> +When dealing with 'git diff-tree -p' output, it takes advantage of
>  the fact that the patch is prefixed with the object name of the
>  commit, and outputs two 40-byte hexadecimal strings.  The first
>  string is the patch ID, and the second string is the commit ID.
