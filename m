Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53C141F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 02:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfJUCVG (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 Oct 2019 22:21:06 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57726 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfJUCVG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Oct 2019 22:21:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4D59A9B522;
        Sun, 20 Oct 2019 22:21:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Q9LBIQnKiYZ8
        fkfhF1CmWKPES0Y=; b=b2Ybc9HCfmJcRhT9xs8Foca26RVV/oqM0rqgD8yj+Kg+
        ihFZ8+GQURPE61p9K/O1B/myIGmI6bWFS9YMKhaQPRKXvBBkwoV2N7Jevye/WxMi
        ceng5vkZ05i+Nssh91TasZdluQNEJcVlmRjp4LPGbqvyTyX8uOHCXAE/ZvUz/RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Y3isKj
        8RCtF0tNydXi8POpGz7LSlrpNeZvkM3FR0CpfAs4TfbfjipiJ8g23OxGHCwruDQx
        FtJ+VA6o01cByL24VPi/AGf8nVh8bs3pIqvSssmAvClmKmvSaZprO1uG2PgYWD7Z
        6gn2OcmoXoxydrFb2gSeD75nTCBJxJmyveYmY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 45AF29B521;
        Sun, 20 Oct 2019 22:21:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7460B9B51F;
        Sun, 20 Oct 2019 22:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 1/1] ci(osx): use new location of the `perforce` cask
References: <pull.400.git.1571160721.gitgitgadget@gmail.com>
        <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
        <372ab24acffbc956407cd93ed34135f83156e10d.1571316454.git.gitgitgadget@gmail.com>
        <20191018105143.GY29845@szeder.dev>
Date:   Mon, 21 Oct 2019 11:21:00 +0900
In-Reply-To: <20191018105143.GY29845@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Fri, 18 Oct 2019 12:51:43 +0200")
Message-ID: <xmqqeez6n8j7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D93A418-F3A9-11E9-885B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Thu, Oct 17, 2019 at 12:47:33PM +0000, Johannes Schindelin via GitGi=
tGadget wrote:
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>=20
>> The CI builds are failing for Mac OS X due to a change in the
>
> s/CI/Azure Pipelines/
>
> Our Travis CI builds are fine.
>
>> location of the perforce cask. The command outputs the following
>> error:
>>=20
>>     + brew install caskroom/cask/perforce
>>     Error: caskroom/cask was moved. Tap homebrew/cask-cask instead.
>>=20
>> So let's try to call `brew cask install perforce` first (which is what
>> that error message suggests, in a most round-about way).
>>=20
>> The "caskroom" way was added in 672f51cb (travis-ci:
>> fix Perforce install on macOS, 2017-01-22) and the justification
>> is that the call "brew cask install perforce" can fail due to a checks=
um
>> mismatch: the recipe simply downloads the official Perforce distro, an=
d
>> whenever that is updated, the recipe needs to be updated, too.
>
> This paragraph is wrong, it mixes up things too much.
>
> Prior to 672f51cb we used to install the 'perforce' _package_ with
> 'brew install perforce' (note: no 'cask' in there).  The justification
> for 672f51cb was that the command 'brew install perforce' simply
> stopped working, after Homebrew folks decided that it's better to move
> the 'perforce' package to a "cask".  It was _their_ justification for
> this move that 'brew install perforce' "can fail due to a checksum
> mismatch ...", and casks can be installed without checksum
> verification.  And indeed, both 'brew cask install perforce' and 'brew
> install caskroom/cask/perforce' printed something along the lines of:
>
>   =3D=3D> No checksum defined for Cask perforce, skipping verification
>
> It's unclear to me why 672f51cb used 'brew install
> caskroom/cask/perforce' instead of 'brew cask install perforce'.  It
> appears (by running both commands on old Travis CI macOS images) that
> both commands worked all the same already back then.
>
> Anyway, as the error message at the top of the log message shows,
> 'brew install caskroom/cask/perforce' has stopped working recently,
> but 'brew cask install perforce' still does, so let's use that.
>
> Note that on Travis CI we explicitly specify which macOS image to use,
> and nowadays we don't run 'brew update' during the build process [1],
> so both commands work in our builds there.
> ...
> Now, let's take a step back.
>=20
> All 'brew cask install perforce' really does is ...
> ... in fact, that's what we have been doing in some of our Linux jobs
> since the very beginning, so basically only the download URL has to be
> adjusted.

This is already in 'next' X-<; reverting a merge is cheap but I
prefer to do so when we already have a replacement.

Thanks for taking a closer look.
