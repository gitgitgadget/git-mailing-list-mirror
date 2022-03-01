Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9F7C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 06:35:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbiCAGgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 01:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiCAGgb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 01:36:31 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CAA11C2B
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 22:35:48 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 34EDE1880DF;
        Tue,  1 Mar 2022 01:35:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XRXCThIxz2Jw6bKo0jweB9wMS5/U5Cakm6fVIN
        QAeVY=; b=G2iUONmvEmsma6oFS6M969qJhFHQjjw07IdAr2ezWiu24PmIw6g94/
        uNdzt03T4VYKlL74nKkKLzxMvFwnV+5vF5l/nd1xF/IWwVGHULyBVLT+w4heSmMR
        PvpyuZENUbLG5A+ZYn4ufYIL2Qk2Uy1XG8g0aSovq/oqL52AyhpYg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2CFD71880DE;
        Tue,  1 Mar 2022 01:35:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AAAD31880DB;
        Tue,  1 Mar 2022 01:35:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/9] ci: make Git's GitHub workflow output much more
 helpful
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet>
        <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet>
        <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
        <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com>
        <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet>
        <xmqqv8x2dd7j.fsf@gitster.g> <xmqqzgmd5uzu.fsf@gitster.g>
        <xmqqee3mwf7k.fsf@gitster.g>
Date:   Mon, 28 Feb 2022 22:35:44 -0800
In-Reply-To: <xmqqee3mwf7k.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        28 Feb 2022 18:59:11 -0800")
Message-ID: <xmqq35k2w56n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D32A4DCC-9929-11EC-A8D3-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> FWIW, CI run on "seen" uses this series.
>
> Another "early impression".  I had to open this one today,
>
>     https://github.com/git/git/runs/5367854000?check_suite_focus=true
>
> which was a jarring experience.  It correctly painted the fourth
> circle "Run ci/run-build-and-tests.sh" in red with X in it, and
> after waiting for a while (which I already said that I do not mind
> at all), showed a bunch of line, and then auto-scrolled down to the
> end of that section.
>
> It _looked_ like that it was now ready for me to interact with it,
> so I started to scroll up to the beginning of that section, but I
> had to stare at blank space for several minutes before lines are

Nah, that was several seconds, not minutes.  Even though I am on
Chromebooks, they are not _that_ slow ;-)

> shown to occupy that space.  During the repainting, unlike the
> initial delay-wait that lets me know that it is not ready by showing
> the spinning circle, there was no indication that it wants me to
> wait until it fills the blank space with lines.  Not very pleasant.
>
> I do not think it is so bad to say that it is less pleasant than
> opening the large "print test failures" section and looking for "not
> ok", which was what the original CI UI we had before this series.
> But at least with the old one, once the UI becomes ready for me to
> interact with, I didn't have to wait for (for the lack of better
> phrase) such UI hiccups.  Responses to looking for the next instance
> of "not ok" was predictable.
>
> Thanks.
