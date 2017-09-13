Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17C7420281
	for <e@80x24.org>; Wed, 13 Sep 2017 04:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751010AbdIME3v (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 00:29:51 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:38687 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbdIME3u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 00:29:50 -0400
Received: by mail-io0-f174.google.com with SMTP id n69so56235236ioi.5
        for <git@vger.kernel.org>; Tue, 12 Sep 2017 21:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=+gb9U79bLE65lIBwtgOZw0xmSQSsAQ7B4iW28hI7EbE=;
        b=SLsw8kgnfk9GLPuEHXVnGqNoMpG6eeY7UT5F2HzHWYXJ6C+cDP67YvbPq/teZ5FyaG
         JAq7DKe2pmXAgxImhLRFfAy7unU/WF4eoRydDbzpXgEKLMP9m++h4QgBAnmgs87WBC9T
         0uoc2ilHE5SYT1ubpVjxVAOmlSo5ib+cdcQuknZPGnu2Hh+Cbsq0NbQJXGyhJkBsQzTN
         mrsdKbChwk3gNeBwxpQ1UBwA2K6gpEn+7NxLUdPeKYeznbEBDSevJtqMaJtdLc5ace3Z
         3yNFB09xU7sFUBMvsERsz4WMuRSnqqFAOXMCIfIf0t+aHezDN6d6xDAt8Z8t5OIxwwZ/
         VDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=+gb9U79bLE65lIBwtgOZw0xmSQSsAQ7B4iW28hI7EbE=;
        b=qqKKhjNNqXn3qNnptOdjCtB273GM6M29w9OJoT4nX58qRTk59FN7q/2y3faaTH2Q3t
         jySoXUyPt0d3rkVZmqrBNxApM2DnH7SKIcMdfVOs+rHIUd541cm51F1ZQHUCJVoT/R3j
         Om0oAq81AcNHRpGWdqpXf3WlgUy7JK/5o6sxVIANnt9RshjFrBXK18GefPrjfcg7kXXQ
         kmMTtLPLJfRMc7qF3rbkfd7ZihmjX1yNftFhUaMzZoVkN6xv0l3hz4TQxK2OFPyqpSKv
         pYLV2eCROHVXCWMH7sAKDEqJWCPLJ5h8YzZ2ul62cHh6Y2QgCiKuxvl3lOCJaOaN9e4z
         DZ2Q==
X-Gm-Message-State: AHPjjUg4j+1BntDeEbk3KCkTQ5ItHdq8+iBaOHYfK1QPWXPhIlw12y1X
        P6S1lyTqKXrpz8xRZG/sswkEkiZj/XfIZvPBWDo=
X-Google-Smtp-Source: AOwi7QAxKf5GK3GK/0oVlyzMopLnjItVE9D4CJ7A1wUGpx+Fs1d62BMdXGepa8hy7etJXCf1kCsNkksgi8XXyP9IG30=
X-Received: by 10.107.15.32 with SMTP id x32mr1390597ioi.7.1505276989613; Tue,
 12 Sep 2017 21:29:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.164.103 with HTTP; Tue, 12 Sep 2017 21:29:49 -0700 (PDT)
In-Reply-To: <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net>
References: <CA+55aFxW3qcETiMrNk5SqZU+_jtM2Rxeb3mhF=J=c0ChdGm1tg@mail.gmail.com>
 <20170905215056.4wihyd6hrtvk52yd@sigill.intra.peff.net> <CA+55aFywhyELmbhAorgTjJZeuNxE-+j2qSP=3d3vqQXNM6p54A@mail.gmail.com>
 <20170905220300.isxbt5y5fd2scd6b@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Sep 2017 21:29:49 -0700
X-Google-Sender-Auth: _MbhQRObNfWUtTtiiN3P00cGRPU
Message-ID: <CA+55aFyyHAjEPx6V3X4i7LV-0VGwu2n288ysnpftP1Bx53EX5g@mail.gmail.com>
Subject: Re: BUG: attempt to trim too many characters
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just reminding people that this issue would seem to still exist in
current master..

It's trivial to show:

   [torvalds@i7 git]$ git bisect start
   [torvalds@i7 git]$ git bisect bad master
   [torvalds@i7 git]$ git bisect good master~5
   Bisecting: 23 revisions left to test after this (roughly 5 steps)
   [f35a1d75b5ecefaef7b1a8ec55543c82883df82f] Merge branch
'rs/t3700-clean-leftover' into maint
   [torvalds@i7 git]$ git rev-parse --bisect
   fatal: BUG: attempt to trim too many characters

(Note: I use "git rev-parse --bisect" to show it as an error on the
command line, but normal people would obviously do "gitk --bisect"
that then does that "git rev-parse" internally and shows a UI error
box instead).

              Linus

On Tue, Sep 5, 2017 at 3:03 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 05, 2017 at 02:55:08PM -0700, Linus Torvalds wrote:
>
>> On Tue, Sep 5, 2017 at 2:50 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > What version of git are you running? This should be fixed by 03df567fbf
>> > (for_each_bisect_ref(): don't trim refnames, 2017-06-18) which is in
>> > v2.14.
>>
>> I'm way more recent than 2.14.
>>
>> I'm at commit 238e487ea ("The fifth batch post 2.14")
>
> Ugh. Bitten again by the fact that rev-parse and revision.c implement
> the same things in subtly different ways.
>
> This probably fixes it:
>
> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 2bd28d3c08..9f24004c0a 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -757,8 +757,8 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>                                 continue;
>                         }
>                         if (!strcmp(arg, "--bisect")) {
> -                               for_each_ref_in("refs/bisect/bad", show_reference, NULL);
> -                               for_each_ref_in("refs/bisect/good", anti_reference, NULL);
> +                               for_each_fullref_in("refs/bisect/bad", show_reference, NULL, 0);
> +                               for_each_fullref_in("refs/bisect/good", anti_reference, NULL, 0);
>                                 continue;
>                         }
>                         if (opt_with_value(arg, "--branches", &arg)) {
