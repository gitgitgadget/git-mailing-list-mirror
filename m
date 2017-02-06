Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B88DF1FC46
	for <e@80x24.org>; Mon,  6 Feb 2017 10:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbdBFKNZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Feb 2017 05:13:25 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36739 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbdBFKNY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2017 05:13:24 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so51385779itd.1
        for <git@vger.kernel.org>; Mon, 06 Feb 2017 02:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lvJKx8vFzpxCjdxJeU2XA88fzMiRpj5Pv/WIE3XGwMs=;
        b=jSb9NR5KRY0Kn06BztVIYSsQxccT48Tj/pfQnZGDSw8ZpQuhBvTVKWuMjss7lZJJeu
         FryOg1lCgqIfzhAPY8YkNo2qGxsQsctxl6pRJSKBxJZL693f01NzeL5uLqWqAMqYjpRS
         OdgE9TOlIjEnWPjV77AasMfiMEqn5j39+fMW83afm+xtrQUwOM4ub/SHqTixKqHLbm0A
         iW3YO9ea+hMq5zxVkHnCtx0ttH5wpaysQ/7pBbMjv/24Na3yXQfjc7mHn2DPOG6/DgnN
         xKDYF1vwR10PQIiPhqRbUA69zMCoQ2iqmSHxa4JFmCMaxeWYQwV1pZoT0J7aM3rI27bn
         EazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lvJKx8vFzpxCjdxJeU2XA88fzMiRpj5Pv/WIE3XGwMs=;
        b=d4N6N40SyMhcDjfM2rFJLamKOwX0WoJhsVeHUFxdXHyJZUaWTIYoR+YBsEu9BgsLyJ
         IbJ3vHaQeWKjv951yLgLHsg2mYd3weoFkhtpcNCM8QmiGCcP1g9h1sPseMy9VgwKoW6C
         SnSVJw2NZYxcymDS5BQB9TXb8nmXj4oSkZW5d5Ae9nGTqANxkDMPvCC1gT6hZ02JFz3D
         JF2nZHWaB/XwZhMxeYFULvlrz/GaYxAUD1pYrEL6CyQOkxSSf/HiZNjf4n6Z+h/qimSf
         G6U+Ji4POPpBcGgbeBf+9l0mYute4HR3FtaaAJJNW2cIKqB8a642v0iBRCqfO7CInnT5
         LN/w==
X-Gm-Message-State: AIkVDXKnMeGIvkErOEyo2AfxvhEFO3AKuryUngNJVeCy5ofXJrXfrI/Eg/RsWPTxn1yj2WIAtdFbExNPADwvJQ7n
X-Received: by 10.36.65.161 with SMTP id b33mr6596692itd.114.1486376003553;
 Mon, 06 Feb 2017 02:13:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Mon, 6 Feb 2017 02:13:23 -0800 (PST)
In-Reply-To: <CA+P7+xp0QJZkiYzgBhPvYPsG7iqRDhRQUjcdgf_GHU-93bSO-g@mail.gmail.com>
References: <1485809065-11978-1-git-send-email-email@benjaminfuchs.de>
 <1485809065-11978-2-git-send-email-email@benjaminfuchs.de>
 <xmqqr33krtww.fsf@gitster.mtv.corp.google.com> <c872072a-4754-051d-81e7-1e2166560733@benjaminfuchs.de>
 <xmqqk29bsz2o.fsf@gitster.mtv.corp.google.com> <CAGZ79kY_1ELUZ2wZwNbQ+HrDnRBM3ngt9HKHKPmvaJEcoAFTtg@mail.gmail.com>
 <CA+P7+xp0QJZkiYzgBhPvYPsG7iqRDhRQUjcdgf_GHU-93bSO-g@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 6 Feb 2017 02:13:23 -0800
Message-ID: <CAGZ79kZyofKoAzFH7zU7DDndRPbiS1L+7d7Y6HqRZ+_4JoJ_zw@mail.gmail.com>
Subject: Re: [PATCH 1/4] git-prompt.sh: add submodule indicator
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Benjamin Fuchs <email@benjaminfuchs.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        ville.skytta@iki.fi
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 5, 2017 at 9:55 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sun, Feb 5, 2017 at 8:23 PM, Stefan Beller <sbeller@google.com> wrote:
>>
>> (unrelated side note:)
>> At GitMerge facebook presented their improvements on mercurial
>> and one of the things was "hg absorb". It would take the dirty hunks/lines
>> of the working tree and amend them into the "stack of commits", i.e. into
>> your local unpublished history. So instead of making fixup commits
>> and doing the whole interactive rebase thing, it would do it automatically
>> for you. I think that is a neat time saver.
>>
>> Thanks,
>> Stefan
>
> How exactly was it different from doing "git  commit --fixup xyz" and
> "git rebase -i --autosquash"? Like, what was the advantage to the user
> facing workflow? Just curious to see if we could learn something from
> it.

My impression is that all local changes were split up and the "xyz"
was determined based off a heuristic, e.g. blame(?) and then the
rebase is run automatically after that, i.e. having just one command for
a complete workflow here, moving up a whole level in abstraction.
