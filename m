Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA5AC433E0
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 10:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D14B207C9
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 10:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgL1Kaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:30:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61036 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgL1Kai (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 05:30:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7B169BACF;
        Mon, 28 Dec 2020 05:29:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=rJ/3LXvW9SfL6p0wFe4FGVXxgXI=; b=reVTpe/3pe18k9SUglZv
        xkG7f7+9EGnzYBntAs8BNiGkK0JF0Lrst/iFh1mBMqw4c2cpllOeCqG6SGilApVL
        9d3OdF7umPwmeGI/9Uv5fXeUAW3BHVZ6VVGmQb8VL+kX6JHT/QCFCwPfU9LbSgc3
        +vMPUpzx58Po6DFptlQshVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=sVQzT7gUluSq8cLxXHyOXSe5053v3y1yBTktGyu0K5QJx7
        wLjy7TXT+FXwJqPKdZXRMuByrZHe+U7fkl80+6HQgCcw/7nqpNuKL0bBZk6GuYp1
        l9rBK69wFrX8t1s4qIPZQ8PaT5AzHCN4vd9rmlSI37Jd4u+KidmrZdWPy+BGQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BBAC89BACE;
        Mon, 28 Dec 2020 05:29:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 392699BACD;
        Mon, 28 Dec 2020 05:29:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Seth House <seth@eseth.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v7 0/2] mergetool: add automerge configuration
References: <20201227205835.502556-1-seth@eseth.com>
        <20201228004152.522421-1-seth@eseth.com>
Date:   Mon, 28 Dec 2020 02:29:53 -0800
Message-ID: <xmqqsg7qjk9q.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FF21EAE-48F7-11EB-A140-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House <seth@eseth.com> writes:

>    * Signed off on Felipe's commit. (Although I have minor qualms with
>      Felipe's various wording and even the name of the flag it is
>      decidedly not worth burdening the list with bike-shedding.)

Even when the original is a horrible patch in your opinion that is
laden with bugs, as long as the original author signed it off
(which means that the original author certifies that it can be
included in and distributed by the project under our licensing
terms, and agrees to the fact that the original author did so will
be recorded in perpetuity), you can relay such a patch as-is, and
you are required (i.e. SubmittingPatches is pretty clear that
without your sign-off we cannot accept) to sign it off to record
the provenance of the code.

The other side of the above coin is that you are not endorsing or
vounching for the patch when you sign it off, so your name is not
smudged by wording and flag name chosen in a way that you may
consider poor.  So "Although..." part is not a good objection
against signing it off.

In other words, sign-off is not about assuring quality.

Also, instead of relaying as-is, you can relay a patch with your
improvements rolled into the same patch (i.e. not as follow-up
fixes).  Some (or major) parts of the original patch may still
remain in the edited result and you'd need to keep original author's
sign-off as-is [*1*].

In this topic's case, 2/2 would be a feature enhancement on top of
1/2, so relaying 1/2 as-is would be OK, but in a case where an
promising patch was sent with sign-off and bugs, then gets abandoned
by the original author, fixing the bug in the patch you relay in
place (i.e. not as follow-up patches) may even be necessary to keep
bisectability.  When you do so, you'd typically do:

	Subject: [PATCH] title of the patch

	... original author's log message, possibly copyedited
	... by you

+	<Comment on what you did on top of the original can come here>

	Signed-off-by: Original Author <ori@ginal.au.thor>
+	[or brief comment here]
+	Signed-off-by: Your Name <you@your.do.main>

 (1) add your sign-off at the end
 (2) explain what you changed relative to the original, either
     inside [] on the line before your sign-off, or at the end
     of the log message proper.

to indicate that it is not relayed as-is; this allows you to take
responsibility of an unintended breakage your "fixes" might have
caused.


[Footnote]

*1* The result may become something that no longer aligns the
original author's opinion, but that is OK.  The sign-off by the
original author just says that the original author has the right to
contribute (the remaining part of) the patch and the original author
agrees that the record of author's involvement in the patch
(including sign-off) will be kept.  

It is not about assuring quality of the final work by the original
author, either.
