Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDA31FA7B
	for <e@80x24.org>; Wed, 14 Jun 2017 00:33:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753624AbdFNAdf (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Jun 2017 20:33:35 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:35790 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753311AbdFNAde (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2017 20:33:34 -0400
Received: by mail-pf0-f178.google.com with SMTP id l89so75283103pfi.2
        for <git@vger.kernel.org>; Tue, 13 Jun 2017 17:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/McJ2SmkJqio376dtzLT3xHJiJXyYUaEryK8nNkMfRY=;
        b=CB1QVFZbiglDz1CumPZto4s+tTNNbDw8Dmxq4ZVvFdYJCub/idiluLoFYdJZWCX9bk
         1h8sfVh+lzVtr9A37tbgf09Jhp9ceXyUi/78BE9hyGL57T3+knQwTOksUjgZYGFp2T5Q
         OoGNQj0/KcKQOW8E5ek2SCel+wzwalXU9e9NWt34m1SQYX/kANWO17SgHkvlXN8zTc0/
         TkooRdR3lm5wpkP9LUXpITPlTpf0mtAirdYUYnhlyBHxR19N/ux57XniaV+vEiQFOEjn
         Kf9Q3V0/n61mt3atiZXZKeSyxSzlMueczOJCOSzihGAR/YdPWwdQFkAuX0g/1TuH6WWU
         r5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/McJ2SmkJqio376dtzLT3xHJiJXyYUaEryK8nNkMfRY=;
        b=CUfNYZxV6jg9hxIWKKGi5lHEqIo+4vI71v8NcRIkVUxgPqJmOQ+rLbm56geiAxz0wh
         XbAiEPjGiukUz+A0SAIYRHS/PF+4ive8yKOGnOqA1VbQiZv5efJa27I0bI2NMughSupq
         o0H8KxSOrwhuHSIb339rAt3OgaagpDZeYNN30AqTlYwQHMs0ELHy3Zp8Nl4eig4BiF30
         ibIabHioxWsXCgc1Wv6dmm1u+Rv4jYeAmv3qeLlKt71Hrhyw+64GbBlZfJfH4kYv3k5M
         Flcj49pcp/qDnJupLXrY0RXpKyBNv7XBC0A/k8+n1sRSBHzjEAhRJOLVUOW4idOEsDBr
         gFtA==
X-Gm-Message-State: AKS2vOxpJJD+SjPAzCR4hLIXFsub1XCeci5P4YiTZ8CjzWb7nUNmNGOQ
        FIp3jepQR7RFsONagJQXmhrUCtkmzgxk
X-Received: by 10.84.217.157 with SMTP id p29mr2143138pli.66.1497400413129;
 Tue, 13 Jun 2017 17:33:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.218.134 with HTTP; Tue, 13 Jun 2017 17:33:32 -0700 (PDT)
In-Reply-To: <20170613164256.1773a62d@twelve2.svl.corp.google.com>
References: <20170613023151.9688-1-sbeller@google.com> <20170613164256.1773a62d@twelve2.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Jun 2017 17:33:32 -0700
Message-ID: <CAGZ79kaCGJicxhwwKC3QCSDWg_8U8X=3mPZT672fUje7f-tKKA@mail.gmail.com>
Subject: Re: [RFC/PATCH] builtin/blame: darken redundant line information
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2017 at 4:42 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Mon, 12 Jun 2017 19:31:51 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> When using git-blame lots of lines contain redundant information, for
>> example in hunks that consist of multiple lines, the metadata (commit name,
>> author, timezone) are repeated. A reader may not be interested in those,
>> so darken them. The darkening is not just based on hunk, but actually
>> takes the previous lines content for that field to compare to.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>>  Example output (blame of blame): http://i.imgur.com/0Y12p2f.png
>
> Looking at this image, how does blame decide what to dim? As it is, I see many
> identical timestamps (and also from the same commit) not being dimmed.
> (For example, see the very last line with "2013-01-05 ..." which is
> identical to the previous line, and I would expect that to be dimmed.)

The date dimming is broken (it is implemented separately as a hack :/)

> Also, my preference is to have all-or-nothing dimming (dim the whole
> line up to and including the time zone if nothing has changed, and dim
> nothing otherwise) but I know that this is a subjective issue.

ok, noted.

That is what I had as a very first design (except for dimming, blanking out
the lines with white spaces) and then went on "dimming even more".

I think this is also very similar to the discussion of boundary colors of
the moved blocks in the neighboring thread, this is finding "blocks"
(actually the finding part is easy as we are given the blocks) and then
applying some "dim middle, highlight boundaries" algorithm, which in
this particular case is a "highlight first line, dim the rest" for each field
separately.

Originally I dreamed more a Zebra-style non-boundary coloring,
the colors being temperature (https://en.wikipedia.org/wiki/Color_temperature)
and the recency dictating the temperature, such that you can easily
see which code is "hot" (i.e. modified recently)

Going by that I we could have different definitions of hotness:
* recency
* number of patches on a given line though that is hard to estimate
  when a line was changed vs newly-introduced
* number of different authors in a given function (= block of text with
  the same context hint in a virtual hunk header)
