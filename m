Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232CAC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 06:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0863C60F51
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 06:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbhKQHCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 02:02:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62258 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbhKQHCK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 02:02:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 84914167445;
        Wed, 17 Nov 2021 01:59:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=ZTY0ln82CYpWELrrngrf65gOE
        +r8KgfnFL86FMHvSZc=; b=bakIQVzHwaaO/d5vfUf3raGkmGGv9LJICs45rkicD
        UVakmAwEwFpIe/ccolg9VXjQZgPhPFqxcnUeRPnUwfaxGYbmF8tgyz/Bj1kBpTn7
        s4851O6cRDnl7Ezi+e1b/knaElIDQQWbjDT36K4CdYEmQ1L5+ijHdC574LWdAGoi
        F4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7D0B3167444;
        Wed, 17 Nov 2021 01:59:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D97F9167440;
        Wed, 17 Nov 2021 01:59:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     hakre via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, hakre <hanskrentel@yahoo.de>
Subject: Re: [PATCH] ci(check-whitespace): update stale file top comments
References: <pull.1138.git.git.1636822837587.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2111161321380.21127@tvgsbejvaqbjf.bet>
Date:   Tue, 16 Nov 2021 22:59:08 -0800
Message-ID: <xmqq7dd75kub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DD2B85E6-4773-11EC-B617-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Hans,
>
> On Sat, 13 Nov 2021, hakre via GitGitGadget wrote:
>
>> From: hakre <hanskrentel@yahoo.de>
>
> As per https://git-scm.com/docs/SubmittingPatches#sign-off:
>
> 	Please don=E2=80=99t hide your real name.
>
> I strongly suspect your real name to be Hans Krentel, not hakre.

Thanks for pointing it out.  I have a feeling that we see more
submissions with this problem via GGG than other avenues, and I do
not want to be the only one who is enforcing that rule.  Very much
appreciated.

>> Part of these two recent commits
>>
>> 1. a066a90db6 (ci(check-whitespace): restrict to the intended commits,
>>    2021-07-15)
>> 2. cc00362125 (ci(check-whitespace): stop requiring a read/write token=
,
>>    2021-07-15)
>>
>> are well written messages that reflect the changes (compare: [1]).

The above may not be incorrect per-se, but other than the fact that
what this patch fixes came from these two commits, I find it largely
irrelevant.

>> Unfortunately those commits left the description in top file comments
>> unchanged which are still showing the previous picture.

    Earlier a066a90d (ci(check-whitespace): restrict to the intended
    commits, 2021-07-14) changed the check-whitespace task to stop
    using a shallow clone, and cc003621 (ci(check-whitespace): stop
    requiring a read/write token, 2021-07-14) changed the way how
    the errors the task discovered is signaled back to the user.

    They however forgot to update the comment that outlines what is
    done in the task.  Correct them.

would perhaps be sufficient?

>>  name: check-whitespace
>>
>> -# Get the repo with the commits(+1) in the series.
>> +# Get the repo with all commits to steady catch the series.
>
> I am not a native English speaker, but "to steady catch" strikes me as =
not
> quite English. I would suggest something like this instead:
>
> 	Get the repository with all commits to ensure that we can analyze
> 	all of the commits contributed via the Pull Request.

Sounds good (I am not native, either).

>>  # Process `git log --check` output to extract just the check errors.
>> -# Add a comment to the pull request with the check errors.
>> +# Give status 2 on check errors.
>
> Is it really interesting that the exit code 2 is used? Or is it more
> interesting that the job will exit with failure if the check produces
> errors? I think it would sound better as:
>
> 	Exit with failure upon white-space issues.

Sounds fine, too.

Or "exit with status 2 to signal white-space issues" if we really
wanted to say "2" somewhere, but I do not think it is needed,
because I do not offhand see other non-zero exits in the script.

Thanks.

>
> Ciao,
> Johannes
>
>>
>>  on:
>>    pull_request:
>>
>> base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
>> --
>> gitgitgadget
>>
