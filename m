Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E45520A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 01:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLIBgO (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 20:36:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52716 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLIBgO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 20:36:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3DB3C20D5A;
        Sat,  8 Dec 2018 20:36:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zffISr+LUolRHWe3ZARv27lDHRg=; b=DyhUwL
        8vqJ3ptZSDkPdVgTxzSdP3xvOiHxOOh+nr9pXxpqMPExDwcJ9KplV+QtaiI/9YPo
        GrvhzwVetKEFv0LJKA30TLIUVScWjF2BzrQrJtU42jGLIQzFfbkPFB59DRuY6/5g
        CjdTQZdRc83Dzn/rk3jzLsJ8ecRHgagZzTpIY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ow0dCOG53IewwzileId3d9v8kspJkPLC
        yabYjQoDPq0lE0d4L1QLspvimWAN5Qs/utqi4xIKZNTtHYihtZLg34JMsnkF+/pV
        QRefIFx77acriRxUDFm0JoXmK8DVsfXsbUm45Qm9Wvb08Tj69rfyTHB+d4IdCt+9
        xk9xcM12CYk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 365D220D58;
        Sat,  8 Dec 2018 20:36:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5435320D56;
        Sat,  8 Dec 2018 20:36:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jrn@google.com, matvore@comcast.net,
        dstolee@microsoft.com, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH] terminology tweak: prune -> path limiting
References: <20181206213315.64423-1-matvore@google.com>
Date:   Sun, 09 Dec 2018 10:36:07 +0900
In-Reply-To: <20181206213315.64423-1-matvore@google.com> (Matthew DeVore's
        message of "Thu, 6 Dec 2018 13:33:15 -0800")
Message-ID: <xmqqo99v5vnc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CDCF18BC-FB52-11E8-8B14-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> In the codebase, "prune" is a highly overloaded term, and it caused me a
> lot of trouble to figure out what it meant when it was used in the
> context of path limiting. Stop using the word "prune" when we really
> mean "path limiting."

path limiting is also used for two purposes.  "pruning", which is to
cull the side branches that do not contribute the changes made to
the paths we are interested in, and showing only the changes to the
paths that match pathspec.

AFAIK, "prune" is also used to describe unreachable loose objects,
but that use is fairly isolated and have little risk of being
confusing too much.  Are there other uses to make you consider it
"highly overloaded"?

My gut feeling is that the result is not reducing "overloading" in a
meaningful way, and this change is not worth the churn, but it
depends on the answer to the above question.

Thanks.
