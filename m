Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72B5B1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 21:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeGIVCP (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 17:02:15 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55746 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754544AbeGIVCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 17:02:14 -0400
Received: by mail-wm0-f66.google.com with SMTP id v128-v6so4895405wme.5
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lp1aHPAo1fMckXRxaIy+AwBMzMp9Crj4aUKYJ4dzVGM=;
        b=id/rdI6zBwkD3puygqL5s1E0AZ/xIBnpizCb4sXlQQzpCF1wvCZoU9npWg+CEKX2QI
         iivZtHbJJHuF0hOxf+guAh2zg/e1ifSecjFAsTl2bB/W43b4j80PFTsvirUY2hBZWcNr
         bgQ+tYnInEzywSfhNgcUEjfgmpOdgFapn7C8Gl3gYjg5FTMIWRl0AXxRx5vK2FALnz54
         vtk7xI27sODyZxh5KCKbirte3H8O7YUymdwdp8/hFs9322NStxFlLbRl9SJYixeLJlKv
         CdDnptX6Z4UCkef5Cjq2YNhIl9vrIu9oBo8PQWFsKfCKOHMefkuvFxjYIP0ZnHyNW/+S
         Ya5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lp1aHPAo1fMckXRxaIy+AwBMzMp9Crj4aUKYJ4dzVGM=;
        b=dtU0hRz50ruXqA3ejtBnxKahGypvtGBk/i0hcft99MXGs/e4OhWN2TI/XCDtUZKgty
         2xHH3uA4mRiGj9U8a+MYmLz4amH1nGTCQ6ciEnwifN89iP3LCmtcWOLQ8t3q7ZYFICZp
         iGRE+AdchDMsAghFa4AxnAtYuQh6xdkbPHhyXQL/br6Mcz8StjOgJoZ2pEWywi7Kf0xn
         nTeexwz/tbmepLwGXnjsW4WUGrSHnqoJZKar3GqoS8ZfYkZ9EtXnzWTJEHzgCAzN4pcT
         ZXDDEN04Y24sAYuP1RSsRvbT8tRoV5f/esi12/puHP4JoWsNalqAvZIu08MfJv3VeJdo
         cZEA==
X-Gm-Message-State: APt69E2O2VW66Z3Sn+PqUS7mOmMDsMdiLm9bzLaiNkuLM//n/mRaGnQI
        j42p1W56Hmt9xVxyJcNnlR0=
X-Google-Smtp-Source: AAOMgpezG/DABde62dGHJ98mH9ip1UPBrTggyMy1H43JRX+qa8ED/1w1l2HTYdH6+vI0g7ZwigOIFg==
X-Received: by 2002:a1c:ce0a:: with SMTP id e10-v6mr12129185wmg.135.1531170132905;
        Mon, 09 Jul 2018 14:02:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 131-v6sm29789791wmm.31.2018.07.09.14.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 14:02:11 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 16/20] range-diff --dual-color: work around bogus white-space warning
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
        <dfa7b1e71f7a39dfa608e1e205579d3b95d8a34f.1530617166.git.gitgitgadget@gmail.com>
        <CAGZ79kYQTTjipfBn3oAbpjZGnszWNiTKN3Ai4Pp-QA+i_xigbg@mail.gmail.com>
Date:   Mon, 09 Jul 2018 14:02:11 -0700
In-Reply-To: <CAGZ79kYQTTjipfBn3oAbpjZGnszWNiTKN3Ai4Pp-QA+i_xigbg@mail.gmail.com>
        (Stefan Beller's message of "Mon, 9 Jul 2018 12:34:14 -0700")
Message-ID: <xmqq601ocecs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jul 3, 2018 at 4:26 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> When displaying a diff of diffs, it is possible that there is an outer
>> `+` before a context line. That happens when the context changed between
>> old and new commit. When that context line starts with a tab (after the
>> space that marks it as context line), our diff machinery spits out a
>> white-space error (space before tab), but in this case, that is
>> incorrect.
>>
>> Work around this by detecting that situation and simply *not* printing
>> the space in that case.
>
> ok. If that is the workaround that you deem to be the right thing for now.
> (I do not have an opinion if that is the right approach, or if we'd want
> to s/<TAB>/<SPACE>/ for example.)
>
>> This is slightly improper a fix because it is conceivable that an
>> output_prefix might be configured with *just* the right length to let
>> that tab jump to a different tab stop depending whether we emit that
>> space or not.
>>
>> However, the proper fix would be relatively ugly and intrusive because
>> it would have to *weaken* the WS_SPACE_BEFORE_TAB option in ws.c.

I agree that weaking the error checking is a wrong solution.  Is the
root cause of this whole problem because for a diff of diff e.g.

	  context that did not change between iterations
	- context in old interation
	-+whatever new contents added by old iteration
	+ context in new interation updated by earlier step
	++whatever new contents added by new iteration

there needs to be a way to tell the ws.c whitespace breakage
checking logic that the very first column is not interesting at all,
and the "+" before "whatever" and " " before "context" should be
considered to actually sit at the first (or zero-th) column of the
diff output to be checked, but there is no interface to tell the
machinery that wish, because there is no such need when inspecting a
diff of contents?  If the word "context" above were indented with HT,
I can understand that the one common between iterations would
trigger SP+HT violation that way.  Is that what is happening here?

Adding a way to tell that the apparent first column is to be ignored
to ws.c machinery (or arranging the caller to skip the first column)
may be more intrusive than it is worth, only to support this tool.
Ignoring the problem altogether and live with an incorrectly colored
SP-before-HT might be a less noisy but still acceptable solution
from that point of view, though.

I also wonder if we should be feeding the context lines to ws.c
machinery in the first place though.  In the above hypothetical
diff-of-diff output, I _think_ the only two lines we want to check
for ws.c breakage are the ones that begin with "whatever".  We may
find that both iterations are trying to introduce a ws breakage, or
we may find that old one had violation which the new one corrected.
A whitespace breakage on "context" lines, whether they are the ones
being removed by the patch or the ones staying the same across the
patch, is not worth painting---the normal diff-of-contents do not
by default show them as violation, no?
