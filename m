Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11B1C433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 09:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhLEJQK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 04:16:10 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54406 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhLEJQJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 04:16:09 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CFC1B174028;
        Sun,  5 Dec 2021 04:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=3uMtR+tcrftI1NhAiTqLlwXNM
        38MXrBrlCUi+PmU5/k=; b=qZAtF7pm0qom72skOFFs8b6aaJGOzxaerzWyzq0LB
        sSf55PuJczcLkmo114Y0ShYBQjRq8zfv1U6O0tr1ogLcziFY7DDu89lZi+9ABdl6
        s2QdqnrxTDWgkv0bcVMHLO7dRlw8gHfHa6HlbQaXh4LmarJBBYzd3oeSSdN90kXh
        rA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BC5D8174027;
        Sun,  5 Dec 2021 04:12:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDEF6174025;
        Sun,  5 Dec 2021 04:12:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git List <git@vger.kernel.org>,
        Baruch Burstein <bmburstein@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Jeff King <peff@peff.net>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Subject: Re: [PATCH 2/2] git-worktree.txt: add missing `-v` to synopsis for
 `worktree list`
References: <20211203034420.47447-1-sunshine@sunshineco.com>
        <20211203034420.47447-3-sunshine@sunshineco.com>
        <211203.86k0gmt5fl.gmgdl@evledraar.gmail.com>
        <CAPig+cR7f1koM7d2GoHMcDhZkQe3=XJD2RVuMajXSpcwZiyGtQ@mail.gmail.com>
Date:   Sun, 05 Dec 2021 01:12:37 -0800
Message-ID: <xmqqa6hfmn3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7E46484A-55AB-11EC-A636-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Dec 3, 2021 at 4:15 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <=
avarab@gmail.com> wrote:
>> On Thu, Dec 02 2021, Eric Sunshine wrote:
>> > -'git worktree list' [--porcelain]
>> > +'git worktree list' [-v | --porcelain]
>>
>> Aside: I've been thinking of hacking something up to just change all
>> these "[verse]" bits in the *.txt source to:
>>
>>     [verse]
>>     $(git worktree -h)
>>
>> And then have the doc build process pick that up, run 'git $name -h', =
do
>> some light search/replacement (e.g. "$cmd" to "'$cmd'") and build the
>> docs like that.
>>
>> Seems far preferrable to dual-maintaining all of these forever.
>>
>> But in the meantime this small fix is obviously correct.
>
> One caution that springs to mind is that there may be external tooling
> which processes these documentation files directly, and such a change
> might break them. (The one which popped to mind immediately was the
> git-scm.{org,com} website, though I don't know what their tooling
> looks like.)

Also it would slow us down by making the .txt variant we see in the
source tree harder to read (or in this case, impossible to see without
building the documentation).
