Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0094320954
	for <e@80x24.org>; Mon,  4 Dec 2017 19:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbdLDTda (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 14:33:30 -0500
Received: from mail-qt0-f179.google.com ([209.85.216.179]:39124 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdLDTd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 14:33:29 -0500
Received: by mail-qt0-f179.google.com with SMTP id k19so23706601qtj.6
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=c8orId5vyLIG8PR3PEXgTZvlN3pYYEL/W71BMDw7YUg=;
        b=VRqE1V9kid6yR00/8JfOofBKAgRjz1+gcwcGahDR3TW79tstmttfEmskYNk5HFmSjj
         G87w2RmJ6+lZYZhGAG3h4yI5QYJXrJYf12oIdGyIlQViNvCIB3PawFUjIJ2J+Fr601Ae
         Sj2zj6l7jqHE5KLvfZ/4sQJpsOK9E/FGGVWBPCK7xE7s6QY+hv0PKv+BOg0HrMpWrldo
         ouLj3qex3VxtP2Am/eSVd3KlKhVq/AwXKqhhVaoF88156Eq9l37XQjxwm8acsfSUlLk6
         JGyZtKVoghGM7OLPG9phd5XN+89gohHPg3u12TopvpA1sWO7Wj89WTl+o4TCf35pjlXr
         fBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=c8orId5vyLIG8PR3PEXgTZvlN3pYYEL/W71BMDw7YUg=;
        b=uD4UlHAZN7Jy2fpO6h9bK/f+BdrwwaWScHqL+JhhluuVFmwSMJmxI58RRiU+SNLJJ3
         CfJhkmLrLJ9YIzu5s6KiHx3eQkNjyY5VBLsQmFMyGEW6JC97eg51oM/7JuqtxjIE/dsq
         Cy84icVzig4X00rSAOmmmOVkoLXyEpimeeESfDFUxNC1eZrTiguniPLlTrGl8B/pCyhF
         eQAtkmb4f5Jl0bYpC/Gx+xcISNHc3S+O1hnbRKlBcv1NXRDt5PqfQcpqiAYfAYUlJHQL
         t90xPx2Mpt+lXT+SAbyRXDxRvZlkYmP6Cc1BsfidB2u09025Pm4rQHsB40T/Ocd9JLJ3
         dpBg==
X-Gm-Message-State: AKGB3mKu+VJH4q9aGwpm15q1Dwtetn6YBH0aeW7yJma2Bcj2rjnHPKh5
        BYybmCZGZ1qxYy3eyhNah4R86B61VV2C40NJ7E13Qmbl1L8=
X-Google-Smtp-Source: AGs4zMZ9nH+IeMBBx/WM+zKIfQBUbytDu9LaAqnWdLapUWerZJbL42uvHoKoe/XxWppxmSK+3N1YwVxJGBS2vZj5bDU=
X-Received: by 10.55.143.134 with SMTP id r128mr19977488qkd.320.1512416008903;
 Mon, 04 Dec 2017 11:33:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 4 Dec 2017 11:33:28 -0800 (PST)
In-Reply-To: <CA+P7+xonU838dOAzsUY4KmweYyM-NLFQeKVYD9jYM7i5EuWXcw@mail.gmail.com>
References: <CABPp-BHDrw_dAESic3xK7kC3jMgKeNQuPQF69OpbVYhRkbhJsw@mail.gmail.com>
 <CAGZ79kbRY1gY8L361o568391Efoa1epZ1dFQZcTqJiOE7EAJfw@mail.gmail.com>
 <CA+P7+xorpJGrn=5zTrAPVDwHLkU5vCphOrebkH_d+MxV1k1oRg@mail.gmail.com>
 <CABPp-BFdJr8AL3hJSSLiqwPJMt6LZcLOEcTtxz1vohEuw==wKg@mail.gmail.com> <CA+P7+xonU838dOAzsUY4KmweYyM-NLFQeKVYD9jYM7i5EuWXcw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 4 Dec 2017 11:33:28 -0800
Message-ID: <CAGZ79kYbhTyHRMRvZaq3SC7MpxdruXsr+4nKGo-4RojjymwYVA@mail.gmail.com>
Subject: Re: submodules and merging (Was: Re: [PATCH 02/30] merge-recursive:
 Fix logic ordering issue)
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 25, 2017 at 9:59 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Sat, Nov 25, 2017 at 2:37 PM, Elijah Newren <newren@gmail.com> wrote:
>> On Wed, Nov 15, 2017 at 9:13 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> On Tue, Nov 14, 2017 at 10:13 AM, Stefan Beller <sbeller@google.com> wrote:
>>
>>>> But this line of though might be distracting from your original point,
>>>> which was that we have so much to keep in mind when doing tree
>>>> operations (flags, D/F conflicts, now submodules too). I wonder how
>>>> a sensible refactoring would look like to detangle all these aspects,
>>>> but still keeping Git fast and not overengineered.
>>>
>>> I think given how complex a lot of these code paths are, that an
>>> attempt to refactor it a bit to detangle some of the mess would be
>>> well worth the time. I'd suspect it might make handling the more
>>> complex task of actually resolving conflicts to be easier, so the
>>> effort to clean up the code here should be worth it.
>>
>> I think changing from a 4-way merge to a 3-way merge would make things
>> much better, as Junio outlined here:
>>
>> https://public-inbox.org/git/xmqqd147kpdm.fsf@gitster.mtv.corp.google.com/
>>
>> I don't know of any way to detangle the other aspects, yet.

Jonathan Nieder and me tried some pair programming some time ago[1]
plumbing the repository object through most of the low level internals, which
would help in detangling submodule merges as then these merges could
be done in-core, just as Junio laid out.

[1] https://github.com/stefanbeller/git/tree/object-store-jrn-rebased

> I agree, that is absolutely a (big) step in the right direction.


I agree as well; A better (abstracted) merge backend would be huge for
the future of Git.

Thanks,
Stefan
