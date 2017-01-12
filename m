Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024D21FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 18:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbdALStq (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 13:49:46 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51488 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750755AbdALStj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 13:49:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F2D3E5D65F;
        Thu, 12 Jan 2017 13:49:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LLLuU8rre+noqMWjqQSe0l1d3GU=; b=BglAv0
        TEM4EEN1kp52HaBZKPH0F12AongR2FPuXeam8uIPSCWIZfE80sxV4ZxTvG/iJFPD
        GlHiXc4HAYB8tw9/vwU1R4NEiQ1vaJawma+JZt1PctmJSJ9NUN+Qfftr2az810FX
        pMV8TeBJJvo4yWqXbfq8hEWe2YyZ+XjW3qEio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x7iXqsJjInHq2iRDBH8Ed6lUCLyYqdH5
        FmTdDHfevKbkXYBnE7OLUqWx1jfnMs3aQyJQr4UeGlVFn0Z8YQmUi1sZt/6+ExB2
        wWuSq4sHU5M1Fu9zI1zz4zE5LvXgOBTEOs476owg5q91QWIZxvXZ3Idu23gEnwHF
        Ck9s89vvFiU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E96F95D65E;
        Thu, 12 Jan 2017 13:49:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AEFE5D65D;
        Thu, 12 Jan 2017 13:49:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 02/38] sequencer: move "else" keyword onto the same line as preceding brace
References: <cover.1481642927.git.johannes.schindelin@gmx.de>
        <cover.1483370556.git.johannes.schindelin@gmx.de>
        <65e0dac0115713b6ae955acdbc5b7655aeb18e7c.1483370556.git.johannes.schindelin@gmx.de>
Date:   Thu, 12 Jan 2017 10:49:36 -0800
In-Reply-To: <65e0dac0115713b6ae955acdbc5b7655aeb18e7c.1483370556.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 2 Jan 2017 16:26:14 +0100
        (CET)")
Message-ID: <xmqqbmvckta7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DDF6E6AE-D8F7-11E6-9803-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is the current coding style of the Git project to write
>
> 	if (...) {
> 		...
> 	} else {
> 		...
> 	}
>
> instead of putting the closing brace and the "else" keyword on separate
> lines.
>
> Pointed out by Junio Hamano.

For a small thing like this, the attribution is mostly irrelevant,
but for the record, the credit should go to checkpatch.pl from the
kernel project ;-).

I'll try to squash the part that was touched by 01/38 into this
patch locally; even though I haven't finished going through the
individual patches, I expect that my conclusion would be what I
said in <xmqqinpnuaxl.fsf@gitster.mtv.corp.google.com>, i.e. the
changes in the series are mostly good and improved relative to the
previous round except for the parts reading and writing of
author-script (from the maintainability's point of view).  

As I do not think we want to see another reroll of three-dozen
patches, I am leaning towards merging v3 (with minimum fixes like
squashing 01/ and 02/ into one) to 'next' and cook it there and
fix remaining issues incrementally while the series is in 'next'.

I may have to change my mind after I read through the remaining
patches (I've done with the first dozen or so at this moment), but I
do not expect that, judging from what I saw in the interdiff.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  sequencer.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 23793db08b..3eededcb98 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1070,8 +1070,7 @@ static int create_seq_dir(void)
>  		error(_("a cherry-pick or revert is already in progress"));
>  		advise(_("try \"git cherry-pick (--continue | --quit | --abort)\""));
>  		return -1;
> -	}
> -	else if (mkdir(git_path_seq_dir(), 0777) < 0)
> +	} else if (mkdir(git_path_seq_dir(), 0777) < 0)
>  		return error_errno(_("could not create sequencer directory '%s'"),
>  				   git_path_seq_dir());
>  	return 0;
