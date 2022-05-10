Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9E9C433FE
	for <git@archiver.kernel.org>; Tue, 10 May 2022 16:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347438AbiEJQfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 May 2022 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347431AbiEJQfp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 May 2022 12:35:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BAC82638
        for <git@vger.kernel.org>; Tue, 10 May 2022 09:31:47 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8007114BAF;
        Tue, 10 May 2022 12:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8WraSHeND2O7lc5GjIZ1rq5SbaSEX7QZRGlV4y
        AkE9Q=; b=p7tmVsKl9QNFbExRLjKmmj8xynTuxZuB1RAgL6VutUZoZHmqHq8NzT
        IKjHmL5kWfcwWMhKovi30zPfq3WUpwtKq+Ei1UcSDPi5B+Wt43kvQKk8olO4mmXQ
        HGlWxezEjvY4mw1BRBxd8sNyWdZ3mLPPNJCB6/5Ia4FPQbatO/tDI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CF9CF114BAE;
        Tue, 10 May 2022 12:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CFD9114BAD;
        Tue, 10 May 2022 12:31:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Plato Kiorpelidis <kioplato@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, avarab@gmail.com
Subject: Re: [PATCH v2 00/15][GSoC] iterate dirs before or after their contents
References: <20220509175159.2948802-1-kioplato@gmail.com>
Date:   Tue, 10 May 2022 09:31:44 -0700
In-Reply-To: <20220509175159.2948802-1-kioplato@gmail.com> (Plato
        Kiorpelidis's message of "Mon, 9 May 2022 20:51:44 +0300")
Message-ID: <xmqqilqd8i33.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AE65E2BC-D07E-11EC-ADEA-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Plato Kiorpelidis <kioplato@gmail.com> writes:

> This is the second version of a patch series which implements pre-order and
> post-order iteration over directories. In this version I use the new iteration
> scheme to convert entry.c remove_subtree() function from using opendir/readdir/
> closedir API to dir-iterator API.

This cover letter seems to be written specifically for those who
have read v1.  It is not very advisable way to write your cover
letter, unless you are aiming to shrink your reviewer base in each
iteration.

Do not assume that everybody who didn't give reviews to the previous
round is not interested in the topic.

Instead, at least repeat the justification and the motivation enough
in each iteration to make it easier for those who were not involved
in earlier rounds to join the discussion.

"implements pre-order and post-order" is "what" and not "why".  Even
in this version, "convert remove_subtree()" is only a "what" and not
"why".  The reviewers need to learn why helping these patches is a
worthwhile thing to do before they decide to devote their time, so
helping them would in return help your cause.

You highlighted the difference since the previous round very well
(omitted here).  It would be very appreciated by those who were in
the first round.  Keep up the good work ;-)

> I also didn't CC Michael and Matheus in this version, since they weren't
> interested in v1 where I did CC them.

This is OK as long as the message goes to the list, but again, "no
responses" should not be taken as more than "no information".
Seeing no review comments from somebody on CC: is not a vote of "no"
by the recipient (nor it is not a vote of "yes").

Thanks for working on the topic.

