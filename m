Return-Path: <SRS0=d2Ax=EG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0462DC388F7
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAED208A9
	for <git@archiver.kernel.org>; Sat, 31 Oct 2020 17:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vmkr9xgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgJaR3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 31 Oct 2020 13:29:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55689 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgJaR3b (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Oct 2020 13:29:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 98D05ED08A;
        Sat, 31 Oct 2020 13:29:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SmUd5gW7Hle4Qeqaa/OpWjZx0X8=; b=vmkr9x
        grHYyv3cD6Yt0GKrIpRcNeBhusv/ayEIvCtikn5jmBEjrVi1s6xITNoLjVpiji0d
        +xTv3r8Ki3U7fbmsXoj7QnvULiARrxfNqYP3T5a6Q7Rl9iZEh6lbv7C8JBEXE4HN
        egymFujLtmjvlCd+GSILl8bEY4nIDQgUMh7dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UrSp3YWnVyParSXlHgZ4ryxewYz0Cv6P
        5+dVhVFo5CBEpf/4ISXyCaKwAWTsz9EWDTxQfEaYKMILwB2tvxgsJ/qzllzTgn/y
        pcSvqK5YnVMxC8BMmocy39yyvnUFyWKPpAk373oi7y9gS22/DcjpQ8N/MeDKiRx3
        HP+VRgYIJZA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 91234ED089;
        Sat, 31 Oct 2020 13:29:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DCF74ED084;
        Sat, 31 Oct 2020 13:29:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Thomas Rast <tr@thomasrast.ch>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 1/6] doc: log, gitk: move '-L' description to
 'line-range-options.txt'
References: <pull.774.git.1603889270.gitgitgadget@gmail.com>
        <96f6f95abcbd79d432073cb294ba12b71300580f.1603889270.git.gitgitgadget@gmail.com>
        <xmqqft5w7poo.fsf@gitster.c.googlers.com>
        <C8539F4F-D51D-463B-825F-385AD743723E@gmail.com>
Date:   Sat, 31 Oct 2020 10:29:25 -0700
In-Reply-To: <C8539F4F-D51D-463B-825F-385AD743723E@gmail.com> (Philippe
        Blain's message of "Sat, 31 Oct 2020 13:18:01 -0400")
Message-ID: <xmqqmu02483u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A0A9DB6A-1B9E-11EB-8360-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> Makes sense.  As to the conditional, I actually think the version
>> with SP after -L do not have to be listed and instead to show just
>> the "stuck" form as the standardised way.  If the option takes an
>> optional value, you must have to use the "stuck" form anyway, and
>> showing that you _could_ have SP there unnecessarily throws extra
>> bytes at the reader with no real gain.
>
> I'm not sure I understand here... The <range> argument is not optional
> here (`git log -L` by itself is meaningless)... I know gitcli(7) recommends the
> stuck form, ...

I do not think showing alternative ways distracts without adding
much value.  We should remember that most users are learning Git to
only to do things they want to do and not necessarily learning Git
to master all the slightly different ways to do the same thing.
"You can write option and its argument separately most of the time
but you must write option and its argument in the stuck form some
other times---you must think if the argument is optional or not,
whenyou want to write your argument separately" crams more things to
learn than the simple "Write option and its arguments in the stuck
form and it always works".
