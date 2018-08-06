Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 658D5208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 07:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbeHFJoP (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 05:44:15 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40242 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeHFJoO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 05:44:14 -0400
Received: by mail-lf1-f48.google.com with SMTP id y200-v6so8307885lfd.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 00:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MP76Wy6BvYVz5uVoMqi2wRS70MZ65uzH22YVipTZobY=;
        b=Rglf4XF1Vk48AzGb1T5uHXoCON+JqZdWxvTa0bGABPfr/bLi39vR/YoLF1rxjxcptX
         7w5UXK8In9i6QzqoPKL9F0icLduf6+kRsyGomv+ACnOJ134LAPihzcAhIhOZoj5pY6T4
         2I3Ufq45BxaT0V3DANfBxv3khGw7cv1itEhZpAJKAQRybkGjjFjOrKM4FRCB5r7F3F+2
         TYZK523lKbwopsuGq6y42WV5y4In8fKxEqOLjAc13z52ne+VbmU3YqVWaYUKxJz16u7O
         AeurekHuyFkBafSTZgsYEoFv7uSyZSVJCjiSA6AtR+N4m1SbiL6vx5MVLQ2dfvt5yAxF
         QAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=MP76Wy6BvYVz5uVoMqi2wRS70MZ65uzH22YVipTZobY=;
        b=Nj77GLr6Krmqf//WihqEciPCbffPQ/rBPbBY8RsceD+Rkn+u0K1EE/pnEZuMAU07Ii
         5RP3IqixgaI9nFUt8pzsLepOlYf7gc7Clgc5PTSPU9cn7Uo/RMo19LXS9QpvxIFmvL1K
         dfukTmNiDhLBC6NUXbfBxIQpstTOP8fC2kgboz96DJ1dOCzijLpNAZrBa4JzfnaCoomL
         LXT0epwr8LpcgCR+mAY9Afc6DADDtmTuB61h0RFR4c0QxDKwKMI5UPOI4VP1f2Hf6UWW
         2kD9Ivs9XFJy36IZfdNa+0LxvZBTr1hEWnNebdOoCWwxk6T6ho7Hc1/4cRcQ2p/S7fY1
         Kouw==
X-Gm-Message-State: AOUpUlHjmzLhIlkth4z1SA9SwLb8oHdldAX5VwFmnRN5pvxkYVCWmSw4
        ZOJaZ8/2d4ehqrmIFXEik1Dhc74oV/B4cpjwPVU=
X-Google-Smtp-Source: AAOMgpf23mB8J7773qqFNxa0kLkxC1jZiv8GO+QEd5AEHKA0Xs4kDK6rrjBpqmRE9mJjM+JhlkWgyWzNK14CKgtb4yw=
X-Received: by 2002:a19:2043:: with SMTP id g64-v6mr10084642lfg.66.1533540987565;
 Mon, 06 Aug 2018 00:36:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:4057:0:0:0:0:0 with HTTP; Mon, 6 Aug 2018 00:36:26 -0700 (PDT)
In-Reply-To: <20180805081116.GG44140@aiede.svl.corp.google.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com> <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
 <20180805061312.GA44140@aiede.svl.corp.google.com> <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
 <20180805081116.GG44140@aiede.svl.corp.google.com>
From:   Alexander Mills <alexander.d.mills@gmail.com>
Date:   Mon, 6 Aug 2018 00:36:26 -0700
Message-ID: <CA+KyZp760a3yTF6ghiNh=c5FoU36MN3cdQU5J8NF2Ss+nwRqyQ@mail.gmail.com>
Subject: Re: concurrent access to multiple local git repos is error prone
To:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johnathan,

Yeah this concurrency problem is real. Not only does it happen with
`git status` the same thing happens with `git rev-parse
--show-toplevel`.
What happens is that I get no stdout when repos are accessed
concurrently (and no stderr). If I limit concurrency to 1, the problem
goes away. When I up the concurrency, the problem is sporadic, which
is the exact signal for a concurrency/race-condition related issue.
The signs are damn clear. I have seen this problem on MacOS I think a
year back on a different project, but I never reported it b/c I hadn't
really verified it.

Like I said I am on Ubuntu. I have 3 git repos that are incorporated
into the tool that's generating the problem. For one repo I got this:

$ git fsck

Checking object directories: 100% (256/256), done.
dangling tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904

For `$ git version --build-options` I have:

git version 2.17.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8


-alex



On Sun, Aug 5, 2018 at 1:11 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Alexander Mills wrote:
>
>> Yeah in this case what appeared to be happening is that if `git status` =
was
>> called concurrently, frequently I wouldnt get any stdout..
>
> Thanks for reporting.  A few questions:
>
> What platform are you on?  What version of Git are you running?  What
> is the output of "git version --build-options"?
>
> What is the exit status from these "git status" invocations that
> didn't write output?  What options are you passing to "git status"?
> Are there any other interesting symptoms?
>
> Is this part of a larger tool or script?  Are there other operations
> going on (e.g. something sending signals to these git processes)?
>
> Does the repository pass "git fsck"?  Any other symptoms or hints that
> could help in tracking this down?
>
> Can you paste a transcript of the commands or script you ran and what
> output it produced?  Is this something I should be able to reproduce?
>
> Thanks and hope that helps,
> Jonathan



--=20
Alexander D. Mills
=C2=A1=C2=A1=C2=A1 New cell phone number: (415)730-1805 !!!
alexander.d.mills@gmail.com

www.linkedin.com/pub/alexander-mills/b/7a5/418/
