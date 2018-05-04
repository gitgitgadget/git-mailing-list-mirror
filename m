Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65B98200B9
	for <e@80x24.org>; Fri,  4 May 2018 16:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEDQVH (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 12:21:07 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:43567 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbeEDQVG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 12:21:06 -0400
Received: by mail-vk0-f67.google.com with SMTP id x191-v6so1198334vke.10
        for <git@vger.kernel.org>; Fri, 04 May 2018 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vmx14DPReLgK/GGkk9sTbK2YdaSUweOEHB5mkf9Q89s=;
        b=PKPLPx+0Ekr797k0/RP5Mo5UFLKOYZF4mgPztJY0OMOb0L/O2Tp3CByR+PxRFijGW+
         4QtE0DFGTvGHisWLxr5SfM1TrkE/HQbohEwBuYy1xw2WcTzCEv5tjZ+q0OsH9XEKANzu
         BkfjLSGCP5kRaTRm24hBAqa4cpDphquN4EqgdbbzKi8MS0XJ2jvwLVwl/x9MhrAiRKQ6
         Ay12jWiB19JAFSfYAK51muoUgpxaPQGGQBH0zRLJrW1M5+92TVjhcyDZp5utwPGzmuWx
         mFJdd0i5JA8D1P6zmoeORavjFCVQe7f/1qdWYCaycD+O9oMRLFb0E9sAcUu+acYLbO+/
         skOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vmx14DPReLgK/GGkk9sTbK2YdaSUweOEHB5mkf9Q89s=;
        b=nRxDfL4RCjTXgwlnnNhdLmNCfDPwEAehKBeKowsxAeIoUIuH4RAinAckJ0ZzbsM27A
         FVEYXV7UeA9p9DMlrGo89owWHLFTK49CUEn62JPauf+YAomS3YNJidOT+UYOF9YWzMCu
         cvym7VKik319CDwN7VF7lfuuH7sNE/r2apz2TN/OMCOMLNpgHlRvjHRfJwcESqGK/I2j
         Xka7Fv7GspfdPpk7JL9bNGecFpQ1pLhuhStWjI96kShRSbN2Eef3CpoQoEPrlj7L1yhx
         /VEqoW3KqlG60KMEn64pIFWwIEDpdXPz9th/jmgmao9GGggfCNowDnMZAcq0O/6l/dzp
         c1Lw==
X-Gm-Message-State: ALQs6tB44B+Llv5l/EecbEQIpKJqlecK/IsaRxYZJohnmCkE4reYOEwL
        b9x7sRLzv26z5/Ou8e8EP05IYVTiD/Y767nbEqg=
X-Google-Smtp-Source: AB8JxZqZp/srFMl1Rq00H3jH2je55CUbk4HhfIvuKxe6nrIeZaZlmtgcdTSRUWnmchQG4wve928nwb2R1PtPk7HTN1w=
X-Received: by 2002:a1f:370a:: with SMTP id e10-v6mr24520682vka.106.1525450865786;
 Fri, 04 May 2018 09:21:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 4 May 2018 09:21:05 -0700 (PDT)
In-Reply-To: <cover.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 May 2018 09:21:05 -0700
Message-ID: <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 4, 2018 at 8:34 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The incredibly useful `git-tbdiff` tool to compare patch series (say, to see
> what changed between two iterations sent to the Git mailing list) is slightly
> less useful for this developer due to the fact that it requires the `hungarian`
> and `numpy` Python packages which are for some reason really hard to build in
> MSYS2. So hard that I even had to give up, because it was simply easier to
> reimplement the whole shebang as a builtin command.

tbdiff is awesome; thanks for bringing it in as a builtin to git.

I've run through a few cases, comparing output of tbdiff and
branch-diff.  So far, what I've noted is that they produce largely the
same output except that:

- tbdiff seems to shorten shas to 7 characters, branch-diff is using
10, in git.git at least.  (Probably a good change)
- tbdiff aligned output columns better when there were more than 9
patches (I'll comment more on patch 09/18)
- As noted elsewhere in the review of round 1, tbdiff uses difflib
while branch-diff uses xdiff.  I found some cases where that mattered,
and in all of them, I either felt like the difference was irrelevant
or that difflib was suboptimal, so this is definitely an improvement
for me.
- branch-diff produces it's output faster, and it is automatically
paged.  This is really cool.

Also, I don't have bash-completion for either tbdiff or branch-diff.
:-(  But I saw some discussion on the v1 patches about how this gets
handled...  :-)


Elijah
