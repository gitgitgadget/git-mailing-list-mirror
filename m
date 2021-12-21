Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070D8C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 01:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbhLUBHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 20:07:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53593 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhLUBHO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 20:07:14 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C0F8B17BB4E;
        Mon, 20 Dec 2021 20:07:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RPUSc3oiguSioeLY/sm5B28z4gwx9dCyhbuaxh
        pPL/Y=; b=HUSjRGZ95j94MjElXTOzQDJxlnpTR7K0FMcntp51vESYuvUU09Uvka
        covkOi/tGc8DzmS4hPYoh9jsyDfEk3Zpgl3gcWEme7RfSOFHPCf1smDwzrolvBJO
        CoZb4gqYyv1Bck7hRld6ig3b4itDfRjsgXNLNgNHZN/WBOq+auMCY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BA38017BB4D;
        Mon, 20 Dec 2021 20:07:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAE3A17BB4C;
        Mon, 20 Dec 2021 20:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v6 0/5] implement branch --recurse-submodules
References: <20211216233324.65126-1-chooglen@google.com>
        <20211220233459.45739-1-chooglen@google.com>
Date:   Mon, 20 Dec 2021 17:07:08 -0800
In-Reply-To: <20211220233459.45739-1-chooglen@google.com> (Glen Choo's message
        of "Mon, 20 Dec 2021 15:34:54 -0800")
Message-ID: <xmqqv8zisr43.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52A3DA76-61FA-11EC-9604-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> v6 fixes v5's bad rebase; it was based off a merge commit in 'seen'
> instead of js/branch-track-inherit. Since v5 is mostly a no-op, I will
> also include a range-diff against v4, which is the last version that
> anyone except Junio would care about.
>
> This version is based off Josh's js/branch-track-inherit v7. Because that
> is not yet in 'seen',...

Thanks.  js/branch/track-inherit has been using v7 since Fri Dec 17
15:47:47 2021 -0800, but unfortunately that was after the week's
integration work and the 'seen' shown to the public probably did not
have it.

FYI at least since [*1*] was used to create 751363af (branch: add
flags and config to inherit tracking, 2021-10-16), the topic
js/branch-track-inherit has always been queued on top of f443b226
(Thirteenth batch, 2021-10-14).  I try to keep the same base to keep
things stable, unless there is a strong enough reason why we should
depend on newer base commit.

I've wiggled the patches to queue your v6 but haven't pushed the
result out yet.

Thanks.


[Reference]

*1* <b9356d9837479914bcf9a265f52afe170be7e2e2.1634445482.git.steadmon@google.com>
