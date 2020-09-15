Return-Path: <SRS0=NngS=CY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C1C43461
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229AD20872
	for <git@archiver.kernel.org>; Tue, 15 Sep 2020 22:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MuaHZpVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgIOWyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Sep 2020 18:54:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55416 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbgIOWyo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Sep 2020 18:54:44 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C68C4DF7FB;
        Tue, 15 Sep 2020 18:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GYfBwPlF8DFaZ0GBoU1/ZXxndxs=; b=MuaHZp
        VSIExjVWFy9wwmPGnYEKIS8RthbcWQfBkAX+oW0Bnuw3BU2amS9RrAfmEee0KwPY
        FX8qBjgIs2rKfLgQ+xjuxJaXsfAQMFGTB/dlWNqrKwf4JwshdCYpmFrpvfVjWaAm
        0qax59DeCEjyyO5N9hUmg8agvHtnsAOaR6nWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JEwfp4Knhgo43E3Sq8fiafe+W6Jgsh67
        NGUz27/P7OMR6UhcWzQxCsCQ1LZxTlL3I++dtszdE4i+U1YIiBeJ0gAxpJz4WPcR
        Ntgg/5dZhKSmvO2aiGZ4ZFhMHQjXn7ngNkK5k94+O8jjgpnd3z486z0sVMA8LcUz
        +I1hX5OJ4Xo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEFBCDF7F9;
        Tue, 15 Sep 2020 18:54:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14ED9DF7F8;
        Tue, 15 Sep 2020 18:54:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Sep 2020, #03; Wed, 9)
References: <xmqq4ko6twc9.fsf@gitster.c.googlers.com>
        <CAPig+cQnnukVoJTgsu1sGFWkAYv7V38-0s-CgYuMyizYHhSFQQ@mail.gmail.com>
        <xmqqimcms06h.fsf@gitster.c.googlers.com>
        <CAPig+cQenifmJ5TW1Sh0zimmbAGDXvfkJRTVDg0nyRJ1vfU+wQ@mail.gmail.com>
Date:   Tue, 15 Sep 2020 15:54:38 -0700
In-Reply-To: <CAPig+cQenifmJ5TW1Sh0zimmbAGDXvfkJRTVDg0nyRJ1vfU+wQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 15 Sep 2020 18:48:32 -0400")
Message-ID: <xmqqmu1qy7kh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FD3F014-F7A6-11EA-A3D9-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Sep 10, 2020 at 12:52 AM Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>> >     "git worktree add" learns "-d" as short for "--detach".
>>
>> Thanks.
>
> Since this thread is active again, I guess I'll nudge this a bit. The
> es/wt-add-detach topic still seems to need the above tweak to prevent
> it from being inaccurate[1]. (At least I don't see the updated merge
> message in 'seen' yet.) Thanks.

Thanks.  https://github.com/git/git/commit/698501fba3

