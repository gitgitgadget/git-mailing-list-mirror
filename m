Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB271F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 07:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfJ3HBT (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 03:01:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42059 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfJ3HBS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Oct 2019 03:01:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id b16so1179414otk.9
        for <git@vger.kernel.org>; Wed, 30 Oct 2019 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Vimzu74YLg7q2B6X2HLoDb3ha6wiSR5iD+DtI8i6oU=;
        b=apwnJTXtIxb3QB+BJB1+KWn3ZvVloRm4MZLdLkZuFBpZkN0jaYn7gDxL2m9eGUziyY
         T/vYeR7QTjSCYi+m+TzSMjpeRjvcrhyFGqr0m3W41zHj5uZwhJg0kPp+KvqA95m0twav
         rfrCc83l5Ki/KLjKz+oO34ETOrZ/UnfG477FFyCyS17MadUceGYPMJZcMkQc5GHWGtnw
         xt+Og9BTZL7NIAfpEmJOVu/HAPtRw2jWIiDgH2y8jR2d4BVMHPT9ox4RzRoK/ePipjX0
         qClz2WvZvKBD6ChewWaws3kCpU2wiIYUqtlfnmsKV+DjXa5GF1Sjffmk7FJkIGDjmUWU
         H2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Vimzu74YLg7q2B6X2HLoDb3ha6wiSR5iD+DtI8i6oU=;
        b=cwh8BezpsZi93Dj8rn1+iKVQc9xaOe5fBFAoAw34RBQ/pLnlS/wqg0uCGr1uzUDJII
         ukle1gj5QipaHttUQlUJo03zt4b3g5tOJfabr/D0l+dtyFejq1m5uBI3vSED0UBbfXRu
         yTMcXqxnsGMG8Z3X0OntwEzDIMq9LQArpjYah2YfpvCGv4ggIIjwL8UPZ5crjtYN+SuI
         oQ60/npnlqHLuRrNVibtSOdIFM1IBuzXKNNoIXpu9Jvp/8MphZjGtDu8CtWaXI29U2A5
         YoqnE6HNsvnbITfM4XGzmVLLKuJqNriDk26dvSu/6KysBYsf4exxQCCT3/UvTHFafYi4
         BmDQ==
X-Gm-Message-State: APjAAAWDSLJUl5gcQkwtPaMeBom5Jo22ENc6+pWBZ33rTkeS8gGFVsuK
        1MoGlcKLCRcRTunHwo+BCC+HM+9oG8Zs+aB1XEk=
X-Google-Smtp-Source: APXvYqyUaVBJviJ0CTgIjWLAjIMjRZHC1sTtl59aYrJseUVSJwKxh0spaNDSc28PfA6hxgzz8okO8v1We/qproo3UNQ=
X-Received: by 2002:a05:6830:1e4a:: with SMTP id e10mr8331641otj.345.1572418877615;
 Wed, 30 Oct 2019 00:01:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet> <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910250020220.46@tvgsbejvaqbjf.bet> <CABPp-BHBUKq73Ru3D9HKp6ABo8eQNmkSkz6MjA+4J2a6xxtWjA@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910251527440.46@tvgsbejvaqbjf.bet> <xmqqpnig8i0h.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqpnig8i0h.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Oct 2019 00:01:06 -0700
Message-ID: <CABPp-BHPRrbCs2qM8-zBaiL5pO3+9k5cbjtk3YVhy9_k1d7t+w@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into the
 root directory
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 28, 2019 at 6:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> Still, I rely pretty heavily on t6036, t6042, t6043, and t6046 for
> >> sanity in the face of refactoring and rewriting -- and as mentioned
> >> before they have caught refactoring bugs in those areas that appear at
> >> first blush as "overzealous", ...
> >
> > One idea would be to try to guard those extra careful tests behind the
> > `EXPENSIVE` prereq.
>
> Yeah, I like that---I think it is perfectly in line with the spirit
> of EXPENSIVE, too.

Or perhaps EXPENSIVE_ON_WINDOWS, since it's actually pretty cheap on
linux and not that bad on Mac  However, if we're going down that
route, perhaps t9001-send-email.sh could be wrapped in an EXPENSIVE
prerequisite?  That single test file takes an inordinate percentage of
overall runtime.  One one box with a few extra cpus, that test both
starts first and finishes last...and it's not far from that on even
normal boxes.
