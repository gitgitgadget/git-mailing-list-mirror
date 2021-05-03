Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801D5C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 01:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5524C61264
	for <git@archiver.kernel.org>; Mon,  3 May 2021 01:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbhECBrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 21:47:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52610 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhECBrl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 21:47:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 47EBC11316E;
        Sun,  2 May 2021 21:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/D7PRoEUQGeNkFtUeS9YetoddA/cm0D30rQms6
        LHH+Q=; b=HopN6shYafzEtxWsQWC7q99bUAbaRrvDK50Qn1P1yhR34GykN9lc4z
        VI2V74ep1r7RYBY1LWNDIWDiJ5X2+Lm2xTdcppxo/vJpOAP7/9jyoN0TXrD3M0px
        97Cz8P4LHxEcQ43pn+wljfzxKrR6EG/HcFY8GaZUnS1o8uzvgF5yA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 409DF11316D;
        Sun,  2 May 2021 21:46:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8B38211316C;
        Sun,  2 May 2021 21:46:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Apr 2021, #06; Thu, 29)
References: <xmqqr1itfo41.fsf@gitster.g>
        <CAOLTT8TWLUCOnL=s-SgCaJYbOw7YCyX5WNssZw5HCspaSAoxmw@mail.gmail.com>
Date:   Mon, 03 May 2021 10:46:44 +0900
In-Reply-To: <CAOLTT8TWLUCOnL=s-SgCaJYbOw7YCyX5WNssZw5HCspaSAoxmw@mail.gmail.com>
        (ZheNing Hu's message of "Sun, 2 May 2021 20:00:02 +0800")
Message-ID: <xmqq1raobncr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B7D3718-ABB1-11EB-873B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

>> * zh/pretty-date-human (2021-04-27) 1 commit
>>  - pretty: provide human date format
>>  (this branch uses ab/pretty-date-format-tests.)
>>
>>  "git log --format=..." placeholders learned %ah/%ch placeholders to
>>  request the --date=human output.
>>
>>  Will merge to 'next'?
>>
>
> Here is a small typo error, I forget a small blank, which was pointed
> out by Josh
> Soref in https://github.com/gitgitgadget/git/pull/939
>
> - '%ch':: committer date, human style(like the `--date=human` option of
> + '%ch':: committer date, human style (like the `--date=human` option of

Please update it with an incremental patch as the topic has been
merged to 'next' a few days ago already.

Also plase trim your quotes to exclude description of topics that
you are not commenting on.

>> * zh/trailer-cmd (2021-04-17) 2 commits
>>  - trailer: add new .cmd config option
>>  - docs: correct description of .command
>>
>>  The way the command line specified by the trailer.<token>.command
>>  configuration variable receives the end-user supplied value was
>>  both error prone and misleading.  An alternative to achieve the
>>  same goal in a safer and more intuitive way has been added, as
>>  the trailer.<token>.cmd configuration variable, to replace it.
>>
>>  Expecting a reroll, after waiting for "commit --trailer" to stabilize.
>>
>
> I have a little doubt here. Do I need to modify the "Commit-Count"
> example in the docs immediately? I thought this should be left to
> the next step?
>
> If necessary, I will make changes immediately.

We've done the "after waiting" part already, so I should have
updated the topic summary for this one.

I just re-read the second patch and the count example that leaves an
empty "commit-count:" does look strange.  We probably want to update
it before the topic hits 'next'.  While at it, you might want to add
the "Helped-by: " example we discussed.

The phrase "global script" looks strange---just call it "script"
would be much easier to understand, as things that are in ~/bin do
not sound "global" to everybody (it is effective across
repositories, so is a bit wider than per-repository, but it is of
course not visible to other users).

Thanks.
