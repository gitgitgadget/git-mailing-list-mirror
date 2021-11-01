Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC52DC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B77F661058
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 20:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhKAU0S (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 16:26:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64491 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhKAU0R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 16:26:17 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D927BE2EC6;
        Mon,  1 Nov 2021 16:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=elSa4Jwub8Ns
        CokHThla3qzDMwcj0vaFBBi2mpTTW8s=; b=vTti4T8id6lfSvGNa4ZL8wtXYRZV
        4py15biyL3W3+L6vLwGEo4Adh5OjJ5BQKoa0ms6uwKS16sOESXRmVKnPpoKQNyRj
        wnz+gIFAOMRh7yNoy645qFQrjwwiINrbXWuiMd3Zhd6RemY50lrGUYO7rJ9OpkHe
        MJU+6JV97xEdbjU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CED4DE2EC5;
        Mon,  1 Nov 2021 16:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 35A18E2EC2;
        Mon,  1 Nov 2021 16:23:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Maksym Sobolyev <sobomax@sippysoft.com>
Subject: Re: ms/customizable-ident-expansion
References: <xmqqr1c3e57a.fsf@gitster.g>
        <211101.86fssf3bn3.gmgdl@evledraar.gmail.com>
Date:   Mon, 01 Nov 2021 13:23:42 -0700
In-Reply-To: <211101.86fssf3bn3.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 01 Nov 2021 20:39:51 +0100")
Message-ID: <xmqqr1bzbp69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9BB53C98-3B51-11EC-A8BB-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But as for the feature it's clearly useful to some, and helps SCM
> inter-op, so even if I'm also rather "meh" on it I think it would be
> good to merge it down, it's clearly very useful to its (small) target
> audience, and doesn't seem to be harming anything else.

I do not care too much how small the audiences are.

The part I do not agree with the most with this is that this allows
the placeholder specified per path (because it is built with the
attributes, not the configuration, mechanism).  "Use this token
instead of 'Id'" command line option with a configuration variable
would not have had such an issue.
