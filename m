Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28913C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1166D61207
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbhIPWwL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:52:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52768 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241276AbhIPWwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:52:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AF24D9095;
        Thu, 16 Sep 2021 18:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tTAC31qJbFZGSrfwviy3H0/X2Zi7U6gHXG+cgy
        4Rlvg=; b=SD/5Zn2XLNd7zH8jsEDAhnWLFgXt56f4KU2uNp4zWw4N3MAgOgm5WO
        VqlD4tAUHZKyvv/eH++2P3lroF9f8de6XUrq7NV9U6RaJj5rzwWMp4hmgFtBnELS
        4d8u4viIs7hisiY1oLe5Njm3/mEnBVFGFiBE0D7PYd1E+bWY8TKx0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72202D9092;
        Thu, 16 Sep 2021 18:50:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE85CD9091;
        Thu, 16 Sep 2021 18:50:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
        <xmqqy27wrzmj.fsf@gitster.g> <874kaki1nb.fsf@osv.gnss.ru>
Date:   Thu, 16 Sep 2021 15:50:48 -0700
In-Reply-To: <874kaki1nb.fsf@osv.gnss.ru> (Sergey Organov's message of "Fri,
        17 Sep 2021 01:41:44 +0300")
Message-ID: <xmqqzgscqgmv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89309FAC-1740-11EC-A52F-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I'm not sure I follow. What "show -p" has to do with "diff-index --cc"?
>
> My only point here is that usage of *--cc* in *diff-index* is entirely
> undocumneted, and that needs to be somehow resolved.

It was a response to your "historical status quo that is a problem."
I do not think there is any problem with "diff-index --cc" (except
for it wants a better documentation---but that we already agree) but
I wanted to give you some credit for having worked on "--diff-merges",
an effort to generalize things in a related area.
