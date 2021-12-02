Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA614C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 17:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359846AbhLBROT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 12:14:19 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52285 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359845AbhLBROS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 12:14:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D0DBE8E94;
        Thu,  2 Dec 2021 12:10:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+TFV2k9GB/bXWxZafjo3z92KUfK8T0QkqnwGLi
        USwtA=; b=gS3MuNBtHloNrMQCoTTIl3qh6cBzlJHyS24MRQhK9iOp63OIZzazc8
        YvgEH19WjhfZvMRZB22xVU5YedwFqOM45VYgjwRGRtHMUKrXFmU/1gCxJBYdnZ/m
        95ZRGUllLMTXiUlYyWR4k7a8hQwwGQZg/RBHExv0NYhGICxls1QC4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72E75E8E93;
        Thu,  2 Dec 2021 12:10:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C1AEAE8E91;
        Thu,  2 Dec 2021 12:10:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 7/7] ssh signing: verify ssh-keygen in test prereq
References: <20211117093529.13953-1-fs@gigacodes.de>
        <20211130141112.78193-1-fs@gigacodes.de>
        <20211130141112.78193-8-fs@gigacodes.de> <xmqqczmfyi44.fsf@gitster.g>
        <20211202093126.nuuvxjnhbkdu5pwn@fs>
Date:   Thu, 02 Dec 2021 09:10:52 -0800
In-Reply-To: <20211202093126.nuuvxjnhbkdu5pwn@fs> (Fabian Stelzer's message of
        "Thu, 2 Dec 2021 10:31:26 +0100")
Message-ID: <xmqqwnknue3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CE995424-5392-11EC-8F45-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fabian Stelzer <fs@gigacodes.de> writes:

> Yes, that looks good. In this case the conflict is rather trivial, but
> how could i prevent this / make it easier for you to merge these?
> Especially since in this case the conflict only arose after a reroll
> when both topics were already in seen. For a new topic i can of course
> make them as "on top of XXX". Should I in the future rebase the
> "support non ssh-* keytypes" topic on top of this series and mark it
> as such? Or whats a good way to deal with things like this? (besides
> avoiding merge conflicts altogether :D)

For this particular one, my rerere database already knows how the
conflict and its resolution should look like, so there is nothing
that is urgently needed.

If the other topic were to be rerolled, since either has hit 'next',
basing it on top of the other, essentially making the result into a
single series, may be the easiest (and that is basically avoiding
conflicts altogether ;-).

Thanks.
