Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20FEC388F9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 749C220729
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 22:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Hm76m+GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732489AbgKWWeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 17:34:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50535 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbgKWWeK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 17:34:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BECE93E59;
        Mon, 23 Nov 2020 17:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W6uWY64WtCn1bWTotlBJBCZz5kw=; b=Hm76m+
        GW9Z/9RAcKRB4RpdjYr2ROpLye+2w2vnFcgtzP4N/0TBJiZ9MLQvHOuGVrESSjTX
        RCM0BD50qrZP7uclirSrEB2g8s+RjUTX0joqJbxsZrvOl0d3yu1aWWwjvl99Uh0w
        WW/6wfoIPaQNBgf9QsfwX3BvNVhRg7EK+Jqm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=x29h0sfm2EcNd5O7QFOIDt2O2uEJyRTF
        bye2FK7RDTfwxMON4cTh3waVAqZwR70WD0zpbmsghZ+f2zr8n7cpagJnX2FM8MRq
        BtknlzORv8/eBRcqLbftHiDudaYf0Ua+a0J16nrJI92N9jdDDGKNfoqJC2TRvJrG
        beTB6ajiRkE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 229F793E58;
        Mon, 23 Nov 2020 17:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8954393E57;
        Mon, 23 Nov 2020 17:34:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] glossary: improve "branch" definition
References: <87blfnhm8w.fsf@osv.gnss.ru>
Date:   Mon, 23 Nov 2020 14:34:06 -0800
In-Reply-To: <87blfnhm8w.fsf@osv.gnss.ru> (Sergey Organov's message of "Mon,
        23 Nov 2020 23:05:51 +0300")
Message-ID: <xmqq7dqbn1nl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FFB0CA20-2DDB-11EB-8869-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> The old phrasing is at least questionable, if not wrong, as there are
> a lot of branches out there that didn't see active development for
> years, yet they are still branches, ready to become active again any
> time.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/glossary-content.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
> index 090c888335d3..8bf198e72771 100644
> --- a/Documentation/glossary-content.txt
> +++ b/Documentation/glossary-content.txt
> @@ -18,7 +18,7 @@
>  	Untyped <<def_object,object>>, e.g. the contents of a file.
>  
>  [[def_branch]]branch::
> -	A "branch" is an active line of development.  The most recent
> +	A "branch" is a separate line of development.  The most recent

A dormant branch cannot be an "active" line of development, so in
that sense, the original is wrong.  The description is better
without the adjective "active".

But do we need to say "a separate line of development", instead of
just "a line of development"?  What is "a line of development" that
is not separate?  What extra pieces of information are we trying to
convey by having the word "separate" there?

>  	<<def_commit,commit>> on a branch is referred to as the tip of
>  	that branch.  The tip of the branch is referenced by a branch
>  	<<def_head,head>>, which moves forward as additional development
