Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E329B1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 16:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388496AbeGZSOR (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 14:14:17 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:45528 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388525AbeGZSOR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 14:14:17 -0400
Received: by mail-wr1-f45.google.com with SMTP id t13-v6so2390899wrv.12
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 09:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=d5aCrUR9qhNp5nxFl5qJxEu0EcXpGFMcAFa0J/viGdM=;
        b=WHhZJCQ1IR80UaQjfvs4Vs98JmbFdd5uRNgYPgLFEqj4FjzEp5EOlgVSsCQgvHOmw8
         YvCsl6lfTnVk9Ks61gdqV+XslDv537T2HPDhyxiLiKAVPkY6RFpgAqgw3CN2s/YriYGT
         MNcbQScAKTY5d2AEMOk/uxQTGGcXmg0JpqDrprpuEKaqKX0LUKBmq9yAxXx0Egx19h7g
         4i0X55QzB3JfJLuUf/jSXdtky/tNRCsvbd+S+fTwLs/VCYnCTTvSBGK8Gc37TSrWELzP
         LphW8PiqRV+4TfEaHQXGCTtDpyOtEzbBSjdYQqqBcnj9Yvr+5A7VgmQAsyVLb5wLygSQ
         pjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=d5aCrUR9qhNp5nxFl5qJxEu0EcXpGFMcAFa0J/viGdM=;
        b=eitT4OgvHZBoRblKRB9kW4ngK9+FqxFFfdkdu2nExhuqG8LzCDVXhLqPnnmJD98WV8
         8lMRYWBNwck5VI2As2Yfrb0k+Uby7va4eDieYodjXl8leF4oDYG6ZG2WBPsEliv3EHC8
         Vpc8359aqRcPFPkeSn7v0ONW2vK2qvVUGnhQPqGn50d+2AcCxtV4FSOM55OwayjO5u1r
         RQmPRr8CegorlB4W4ajJqZevsCZiBGMH2I79B5F9X+8UWY9xPdbPJvob0siMm45RiQDv
         LuLQiaw23AX7BDh9yCAX5iR+8xibcRkyaVTqApyd7WNt6zt1rS3kTJppX1RPOznT85SH
         H1tQ==
X-Gm-Message-State: AOUpUlEj3m2Usn9YBp8rAEBb/knA4cddF1sxj/LPN5b6CW0Xz19OpRf7
        sq1keMpdRhY1Gw3l06L8jag6ZH0+
X-Google-Smtp-Source: AAOMgpfVHIkIz1HHntmI2FyombElYY6c0B0DWB6eYZycCBuAYxPlzy/l+/SzkQaBpR3mGqGcKewhaw==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr2218954wrg.230.1532624195554;
        Thu, 26 Jul 2018 09:56:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r18-v6sm1301830wmh.28.2018.07.26.09.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 09:56:34 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kbO1KOfDgjT5duEd49MZ=EaYLtTDeg2efVO5kkO9QFx7g@mail.gmail.com>
        <xmqq4lgmubi8.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 26 Jul 2018 09:56:34 -0700
In-Reply-To: <xmqq4lgmubi8.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 25 Jul 2018 16:43:59 -0700")
Message-ID: <xmqqtvomq6kd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>>> * js/range-diff (2018-07-25) 21 commits
>
>> I think the current coloring is good enough to ship, but it still has
>> errors around corners, for example introduction of new files,
>> having lines in the inner diff as:
>>
>>      diff --git a/Makefile b/Makefile
>>      --- a/Makefile
>>      +++ b/Makefile
>>
>> will be colored white/red/green (in that order), but in the outer diff
>> these are all "context", but as these specific context lines happen
>> to start with +/- we color them.
>> If we want to be perfect, we rather need to parse&understand
>> the inner diff on a more detailed level, but I would argue to leave
>> that to a later stage for another volunteer to step in and cleanup.
>
> I think the primary part of coloring i.e. "white is common, green is
> added, red is removed" together with "bold is new, dimmed is old" is
> quite usable and not broken.  

I just compared the output from the original tbdiff and the dual
color mode of range-diff; especially with that "new round is bold,
old round is dimmed", I find that the coloring makes it easier to
spot what kind of each line is than what tbdiff did.

Dscho, good job on that.


