Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795BEC433F5
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 21:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243338AbhLJVvO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 16:51:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56766 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237557AbhLJVvN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 16:51:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D469F152DA5;
        Fri, 10 Dec 2021 16:47:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NYqz0YoZbAj1xssnzshEeUXGOw3h8g+OoihLQI
        cDbik=; b=bNISZmC59rJxkbiOiCIAjA0oEuxTmSU2myGxuWTT6mHymTggGss5we
        y/QGM+ZEpjwF52pT6oNZA3WGNqc9i5yGjOAfZOYG5IUgKd5HP/VhBJGS7DReMS9V
        6Aqa+GTq40qy4AMS7bHSXFmp2nVqC4o5h44WYP0f+y+7D7tkKo5oE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CBFDF152DA4;
        Fri, 10 Dec 2021 16:47:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 59AB8152DA2;
        Fri, 10 Dec 2021 16:47:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Seth House <seth@eseth.com>, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org
Subject: Re: [PATCH v4 2/3] vimdiff: add tool documentation
References: <20211204090351.42369-1-greenfoo@u92.eu>
        <20211204090351.42369-3-greenfoo@u92.eu>
        <CAJDDKr77YQKJj15V52Rs=LPRMZVSkbpV8MWFDWNuYf4jqqCajg@mail.gmail.com>
Date:   Fri, 10 Dec 2021 13:47:29 -0800
In-Reply-To: <CAJDDKr77YQKJj15V52Rs=LPRMZVSkbpV8MWFDWNuYf4jqqCajg@mail.gmail.com>
        (David Aguilar's message of "Thu, 9 Dec 2021 18:58:58 -0800")
Message-ID: <xmqqilvwm8su.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C6D3D374-5A02-11EC-A3D8-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

>> +merge_cmd_help() {
>> +       echo "Run 'man git-mergetool--vimdiff' for details"
>> +       return 0
>> +}
>> +
>> +
>>  translate_merge_tool_path() {
>>         case "$1" in
>>         nvimdiff*)
>> --
>
>
> My understanding is that we prefer "git help" instead of "man" when
> providing hints.
>
> That means we should suggest something like this instead:
>
>         echo "Run 'git help mergetool--vimdiff' for details"

Thanks for pointing it out.  Yes, not all platforms we support our
documentation pages have the "man" command as the primary means to
get to them.
