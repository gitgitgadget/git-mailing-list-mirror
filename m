Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C5C433F5
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 18:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238748AbhLOSH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 13:07:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64252 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbhLOSH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 13:07:26 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BEC9316E804;
        Wed, 15 Dec 2021 13:07:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=E1rOBSG/wNda
        ygbGcu8R0eBqMmVSmxyWUQyWNkes54s=; b=Jq+yagIfoNWJ/4FoaOAAGZmYaRvQ
        CO4PaL/qtSJbPj9LavDdnb4tKmAipEslY9LlpgkDM0iU4wvTLoBYOf/IluP3jINZ
        F02gmD7sJPjBeCTjOu4g0YpHPdiqE5GO5pgCh/oOPySk4H25Qm+c7FbgjBmky4cy
        bk7x0kYOsUfzknM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B745716E803;
        Wed, 15 Dec 2021 13:07:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1ED0516E802;
        Wed, 15 Dec 2021 13:07:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jo=C3=A3o?= Victor Bonfim 
        <JoaoVictorBonfim@protonmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Fw: Curiosity
References: <Wlh_w2gSCDQ2ieJnIY7TStWrzxbwP98SNRIFMTYpva7SRFipqk63HEYFVF7wFn1oSHOkQNsjWGOa5L49vyRlvSLbuZqpmvOaDOHmFkdt2zw=@protonmail.com>
        <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
Date:   Wed, 15 Dec 2021 10:07:20 -0800
In-Reply-To: <wVwq9WVLpVt7MNLmIYOWCFKVSf8l532MD_vu4yTA8hl1fCARnW8nOUJjxYmKSzFw1SnPp5iYRD-aW4gAT2HnyQbC5aLBOvyT6npn88lxwNQ=@protonmail.com>
        (=?utf-8?Q?=22Jo=C3=A3o?= Victor Bonfim"'s message of "Wed, 15 Dec 2021
 03:52:38 +0000")
Message-ID: <xmqq8rwl91yf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D991F2D4-5DD1-11EC-8BA0-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jo=C3=A3o Victor Bonfim  <JoaoVictorBonfim@protonmail.com> writes:

> I sent this message to Junio Hamano kinda of forever ago, since
> then I haven't been able to address it or do anything about it
> really...

My spam filter has learned that anything that goes to gitster@
address without cc'ed to the git@vger list are to be caught, so it
is very plausible that I didn't see it.  Sending any inquiry here on
the list is the right thing to do, especially because it is likely
that I may not be the area expert for whatever you want to learn
about Git, while there are others who are more familiar with various
parts of the system and other ways the system is used.

You will also increase your chances to be read if you made your
message look more like the ones typically posted here (see the
archive), by wrapping overly long lines, etc.

> Since Git is almost used for everything at this point, is there
> any intent on providing better support for non textual file types?
> Why do I say this? Take this game mod which I follow as example ->
> https://github.com/SolariusScorch/XComFiles <- whenever I clone it
> Git takes a significant forever amount of time to download 452 MB
> of files whose some part, from my perspective, isn't being delta
> compressed like the text files are (since, whenever reading a log
> of what changes were made, git creates and undoes modes for all
> binary files, some of which only changed by a pixel from one
> colour to another).

Our delta compression does not care whether the contents are text or
binary, so if it is not compressed well, so it can be a sign that
the contents are not compressible to begin with, at least with the
xdelta binary-diff-patch engine we use.  Improvement designs,
algorithms and patches are always welcome ;-)


