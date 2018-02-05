Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C72E1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 22:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeBEWSj (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 17:18:39 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:38385 "EHLO
        mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751736AbeBEWSh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 17:18:37 -0500
Received: by mail-vk0-f47.google.com with SMTP id z9so18670174vkd.5
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yt5lWj/4SGw9m2K3Dw/5vo630SzIPLd3Awdzb4naykI=;
        b=ZY302QUfoatAG8386eZ7+1LZCZCWvpY/oFIXZPyv4wSG7wMyxm+/uAq6tiEIegfkHJ
         De7Io9Kl2coaeaoHYmyBeOKA3zth0Ceqvet3Ed+mrsnC0UlIA74HGNYDpP+/xt8HIUC5
         nxxDPztwpB+2RGI4PkjNAO4UheBmj4wGE50IA0orsQSSmKVbsrcwLuDQNx8RLsepGNPZ
         ZrUXVvCjlWiz4ms5ZFicnLTOqWruNtXYgah/HsFFt3ilbOiP44XjEWdTY3WXlDA8c5qG
         igeVgHg+WFkluDFwojaKmp2Q/d2zkhgBhOZxP9DQPhht7hVLP6KpXIowWJM26t8ScTrv
         dKtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yt5lWj/4SGw9m2K3Dw/5vo630SzIPLd3Awdzb4naykI=;
        b=f/q1pWvXJehXiqhWUyjRho8TbcOtUHqsqMzDpLnH3JnUmzU358Rn0JocUijx2s0Sqj
         O7Xq36M6Z3NaEi0/dUmR9FzPHA+TG0mdlDhYy9CEKqwkHzDezMpTNegwY++DTLqEXbc4
         zZN+1Z6JjohT/53I44t0xtsmtwPm6FSw+u6Sxdy+tJM6Tz4kMJH6EIRRLagea+IEAyor
         KTHs4AoH974XQ0zKDzCU7rsIAykYI8LC27gW7NqCAee8qxYMYVLF4zpwvyZfAdSNK09Q
         98shJ3+Nw8m4erF62LWPAa5yOCv1L2a6slBgUMZWCT2Jp2hJd0oJuELm5Jlah0EeudJt
         6p6g==
X-Gm-Message-State: APf1xPA7g+IsWymOyxS9tKK0HFruQhXtDWKiCNQa31AkkTdYwksbDpT8
        Ik8HYq7bEQhUpLOC22+eY5Hwe43+MRtlBAfy/JU=
X-Google-Smtp-Source: AH8x227jHoLa9I81hxpAaHOal4fnzjamHxHNQ7hcCXZ41kIEtAWyEmka3s7S8Kt5bPteLwt6YYbAlGAzP25PkhZ5qdw=
X-Received: by 10.31.63.213 with SMTP id m204mr330832vka.79.1517869116278;
 Mon, 05 Feb 2018 14:18:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Mon, 5 Feb 2018 14:18:35 -0800 (PST)
In-Reply-To: <CAGZ79kYwDnL1AJ79Z02qxse1ZjKd1zqORqKTxpZGHmCqPhTHJw@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-29-newren@gmail.com>
 <CAGZ79kYwDnL1AJ79Z02qxse1ZjKd1zqORqKTxpZGHmCqPhTHJw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 5 Feb 2018 14:18:35 -0800
Message-ID: <CABPp-BHpC9EqSM_qmBxo3J3jbSrHNR-UkDpC0amztwfCYg8Low@mail.gmail.com>
Subject: Re: [PATCH v7 28/31] merge-recursive: fix remaining directory rename
 + dirty overwrite cases
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 1:52 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:

>> +               /*
>> +                * Stupid double negatives in remove_file; it somehow manages
>> +                * to repeatedly mess me up.  So, just for myself:
>> +                *    1) update_wd iff !ren_src_was_dirty.
>> +                *    2) no_wd iff !update_wd
>> +                *    3) so, no_wd == !!ren_src_was_dirty == ren_src_was_dirty
>> +                */
>
> Not sure iff this comment is at the right place and is a good addition to
> the code base.

Fair enough, and I should apologize for letting my frustration come
through there.  However, what if I replaced the first two lines of the
comment with:

"Because the double negatives somehow keep confusing me..."

so that it reads:
        /*
         * Because the double negatives somehow keep confusing me...
         *    1) update_wd iff !ren_src_was_dirty.
         *    2) no_wd iff !update_wd
         *    3) so, no_wd == !!ren_src_was_dirty == ren_src_was_dirty
         */

Even if my wording was suboptimal, the rest of the comment did seem
pretty important because I messed up the line after the comment
multiple times.  (You'd think that the odds of getting it right should
be 50/50 and that a simple inversion would fix it, so one could only
mess the line up once, but I'm apparently special).  And then I came
back to look at it later and was still confused.  For some reason, I
seem to need the longer explanation.

> However it hints at the underlying issue of a bad API that is provided
> by remove_file ?

I'd definitely agree with that.
