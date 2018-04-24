Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CFD81F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932640AbeDXAPa (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:15:30 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33240 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932615AbeDXAP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 20:15:29 -0400
Received: by mail-ua0-f196.google.com with SMTP id q26so11437102uab.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZRk2japSxa9uFUbs/MjnyjP1xaBwWgj1Dc6XQaYVp28=;
        b=t+buuBEb5AvTKS5V+AeekCeMcUXnljyQ/bZeqy1fbAOPNOBwCA0oOAP9v3Bm5lHAWQ
         dQD82LE/2CRalNDg6Bh2rwOMtX0rtiYsPqXqc1fRG1yN9KwzrNQEWSu+gG4iBmSu8BB+
         06mTlqNuYnZwnurwMAyelVoi+J8w0TrpKHWHYGVJYCO3uCaDCRtknu0WF5irCwWkTTCz
         y+D2DaZgDvI3Rzwc8ecLyejISZpTHHWx/7u1/UjjPg3BE3Y8mtv+onJK7UBPRuJArQWr
         BflUJu8FMwDDbSenL0dN41L/0xxAA51MzpHPOPV4fQP/XDlymGqAOPgusiCXYOH47wRc
         xwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZRk2japSxa9uFUbs/MjnyjP1xaBwWgj1Dc6XQaYVp28=;
        b=pNrkYhgGk9t/O9vaTWrobogODvsYtxIVJx7ExdxVuq9DC9NvnsFjXpjKMY5qpu92Nc
         qijLvSVbHCxQnHzrfCtZVTebuuqRrY/mf1K30hdeRNQEQMZjIe0STfXlxlO62P9nUFTh
         sHELCbofH3nuvNuo4p6tBLguZZxk/nMURY/nMZWX6F2LhJneutknV7LTBw66T3C/cihU
         d5H/Sch4+NB9jcTjTLrvh0odNfIP3kxuJLwTPJ5s4y2Dw126TogeTw4kf6PF2RJOzHz0
         4/TlV838GF+UjjPiFDbHrU9u27DQX8IjeL5fXOeJtM0gO7iG1DRBpK4tOARFpa2x9FBi
         BgDA==
X-Gm-Message-State: ALQs6tBsf3kHTPdw8WfP3wtntC3ndjlo91+DRplfqbEWBca8KT4F77vm
        QkslF+Jd6hRd8foL79ZWDe79GsnCzYKzUMMRbjw=
X-Google-Smtp-Source: AIpwx49NktKqD0pKoB5hpjq7LL5DuNzA73ZqMyecK+2CruV5DbuZTcXzuCZ780pgAuRrghDrWH/JX0AUhv4XyibW74c=
X-Received: by 10.176.83.38 with SMTP id x35mr16519636uax.29.1524528929059;
 Mon, 23 Apr 2018 17:15:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Mon, 23 Apr 2018 17:15:28 -0700 (PDT)
In-Reply-To: <xmqqmuxt8p1i.fsf@gitster-ct.c.googlers.com>
References: <20180419175823.7946-1-newren@gmail.com> <CABPp-BHMt1Hjr8A_wkxvSExV9ALgG5032vV5uEE2-HtpYuA9QQ@mail.gmail.com>
 <xmqqmuxt8p1i.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Apr 2018 17:15:28 -0700
Message-ID: <CABPp-BG632JPG0CMfjgDu6kLx-QK9o0B5D-Xpp-0hDCN2X9X=A@mail.gmail.com>
Subject: Re: [PATCH v10 00/36] Add directory rename detection to git
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 23, 2018 at 4:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> Out of 53288 merge commits with exactly two parents in linux.git:
>>   - 48491 merged identically
>>   - 4737 merged the same other than a few different "Auto-merging
>>     <filename>" output lines (as expected due to patch 35/36)
>>   - 53 merged the same other than different "Checking out files: ..."
>>     output (I just did a plain merge; no flags like --no-progress)
>>   - the remaining 7 commits had non-trivial merge differences, all
>>     attributable to directory rename detection kicking in
>>
>> So, it looks good to me.  If anyone has suggestions for other testing
>> to do, let me know.
>
> There must have been some merges that stopped due to conflicts among
> those 50k, and I am interested to hear how they were different.  Or
> are they included in the above numbers (e.g. among 48491 there were
> ones that stopped with conflicts, but the results these conflictted
> merge left in the working tree and the index were identical)?

They are included in the categories listed above.  What my comparison
did was for each of the 53288 commits:

1) Do the merge, capture stdout and stderr, and the exit status
2) Record output of 'git ls-files -s'
3) Record output of 'git status | grep -v detached'
4) Record contents of every untracked file (could be created e.g. due
to D/F conflicts)
5) Record contents of 'git diff -M --staged'
6) Record contents of 'git diff -M'
(all of this stuff in 1-6 is recorded into a single text file with
some nice headers to split the sections up).

7) Repeat steps 1-6 with the new version of git, but recording into a
different filename
8) Compare the two text files to see what was different between the
two merges, if anything.
(If they are different, save the files somewhere for me to look at later.)


Then after each merge, there's a bunch of cleanup to make sure things
are in a pristine state for the next merge.
