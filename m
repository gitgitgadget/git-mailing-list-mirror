Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 012DB20D0C
	for <e@80x24.org>; Tue,  6 Jun 2017 01:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751213AbdFFBKi (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 21:10:38 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34632 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751192AbdFFBKh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 21:10:37 -0400
Received: by mail-pg0-f66.google.com with SMTP id v14so7759532pgn.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 18:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=y4wsXFwJgD7BzLHF0DG03iE+8pTWJan1XGu54Kk2K+w=;
        b=sgIkx3VcqzeFGhOBKd+Dg4vw4geQ8RzcVySruCVc5tfkbVD4Aecoht4Ucb4ujfpHSX
         tEF8wZBEYa4MQsNmZSOo5bgSFpsx6AwiFy2PklyoYXiusn9CL152mYnGnD3iLuX/cz1J
         hp4s2/ovHGT67fAkS2V9JUbc53UIaOEvB6pzMb9xPBZP1TA5r2RiSEIfUgQmyXRceBau
         GRJTF8d4nog+2sOhEuwl47R+/+HK6vlqWDO4y2cpbWBsUKiYuA69vLNQzHx1D/bxnO2c
         YJpXRQj5/WRf9PMIR3XPY+PV399Pd1M1uXhMFjQqekSnbTUSVttrBnZruRq9DgtKRbul
         jQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=y4wsXFwJgD7BzLHF0DG03iE+8pTWJan1XGu54Kk2K+w=;
        b=al7xKXOT3tsNyuWH43N6Lz9wtyF10difp09gbJYJwJcRYrRcrWpncJpB960AxjbvWY
         0bN00kClA6K1QB7J2qLpIP75gpOe6++aJ+LsuOdauruZ1Tdc/o5iJvKPCcTkbeLhyyl5
         ZvoVVSRHvkbCZjKlpfyGe4KOwuN4yL7Pgx2IJNodib1MAkjtkwpQz+OdbkwKVQoXWa0F
         /DVu8+gtffxZyJAWEkab+Twc36ESMfA/tvQ1mmHsHl1RIuX6XYhYSwTwlugSfo2h2F6j
         mOrIEXOzdIJ+BtT83aWCeh/USMKZd2aBh7nKKravtvQKYrJjnUYmmxpRvA2GixQIgrBM
         JF3g==
X-Gm-Message-State: AODbwcCNglWR5eT0FeH/Xi7ZtteZi7qJQ7TOxjKKKQ4bU1cRfK0jF0Cv
        UGsAcWr6uAf53Q==
X-Received: by 10.98.83.132 with SMTP id h126mr23384493pfb.214.1496711436739;
        Mon, 05 Jun 2017 18:10:36 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:5d03:f5d1:882a:10e])
        by smtp.gmail.com with ESMTPSA id p76sm59594061pfa.53.2017.06.05.18.10.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 18:10:35 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jun 2017, #03; Mon, 5)
References: <xmqq1sqzkrui.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
Date:   Tue, 06 Jun 2017 10:10:35 +0900
In-Reply-To: <CAGZ79kY2Z-fJYxczbzheu1hChLkKkdjEcDMwsP-hkN0TjUBotQ@mail.gmail.com>
        (Stefan Beller's message of "Mon, 5 Jun 2017 11:23:12 -0700")
Message-ID: <xmqq8tl5apkk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  "git diff" has been taught to optionally paint new lines that are
>>  the same as deleted lines elsewhere differently from genuinely new
>>  lines.
>>
>>  Are we happy with these changes?
>
> I advertised this series e.g. for reviewing Brandons
> repo object refactoring series and used it myself to inspect
> some patches there[1]. I am certainly happy (but biased) with
> what we have available there.
>
> Jacob intended to use this series
> for review as well, but has given no opinion yet.
>
> You seemed to have used it for js/blame-lib?
>
> --
> Those patches had a wide reviewer audience cc'd,
> so I would think people are aware of this series.

I tried to, yes.  I haven't had a chance to see how well the current
iteration fares "does the externally-visible goal make sense?" test.

I do not think I saw a negative "an approach to show this kind of
output would not be useful" reaction, so I assume at least people
would want an alternative output format that would help reviewing a
change that moves blocks of lines around.

In any case, that is not a review.  A patch series wanting to do a
good thing, and people agreeing that the externally visible effect
it produces matches that good thing, is one thing.  A review that
makes sure the code achieves the externally visible effect well
(e.g. without overly inefficient algorithm, without buffer overflows
or underflows, off-by-ones, etc.) is another thing, and I haven't
seen anybody going with fine toothed comb to do that kind of review,
hence my "are we happy?" inquiry.

