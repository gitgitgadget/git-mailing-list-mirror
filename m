Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DAD20986
	for <e@80x24.org>; Tue,  4 Oct 2016 21:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbcJDVtc (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 17:49:32 -0400
Received: from mail-yw0-f169.google.com ([209.85.161.169]:36141 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbcJDVtb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 17:49:31 -0400
Received: by mail-yw0-f169.google.com with SMTP id u124so51662923ywg.3
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GGova7OJ9c5f3C7libtaIfbEpircjRUROwrlwGf7g2k=;
        b=M4pyL/COqjOrPmWhyag350IIyGepO+4blwhzkD1Ie+/SkKyP7iel4cy6wZ4ojzCMfc
         UjOkQIQaGxr6pQbz7fgrHDsI0Ljxffg+9+RG1et44G5bBVH7scy77EsTbqkCFdK0dKaq
         oGk5h0LG+wzh7JKnY5ktxX2exd8eNMgUevxZSPwSVNjIxc9Tir1awOpIp7v7OKYYmSy8
         0jjrtacxgymnCLgKv9O7s4eHqRmS0aJLUh5gljA/eE0Y9B+4Qx17YK7VEse5CkZa91f2
         Q+E1kAShh+G3YKsqUvChxi5RioThFfX7vU9Xz+wgrgBy/0E6/HGT85t56MkDoJa32Z48
         wsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GGova7OJ9c5f3C7libtaIfbEpircjRUROwrlwGf7g2k=;
        b=nDFlQYxqOR93Vhmv7xBPEHtnkMWobUVidMtC+SkMCT/m/4NT2nL2EFk+9j64dg3sef
         t9HV6BbwB3rWEvbd0DlvzyjzVyngTa/esZCVHrLoy2VIOK1tEW9pzwB4BRMIBt4ln89I
         P4ApTX9ZUxJcrdmhY4nyUZZ1ZZ5hWEnbUqaWyibE/NVdqGihtkHXHvvojdJUpoETL6qa
         kPyZGhANEKS2VvudVYSmZBDAl/N700sBnQW3D+qXye1i/E7OfoGr3r4P83eeEzmosUGq
         2LHL1qmQYOMibM3BBU5VaWw/N4uc6zKCpq9pZtxqyfDU9bUr5K08HwEiGYU801UrqWuD
         Mhug==
X-Gm-Message-State: AA6/9Rm5GqUH13koPj4XXjJMX0bJrH/tyP1WRACXbMh8OM1wmKz9mvBUax6q4xjft/wd+xUl3U8EiIYdt/mHzw==
X-Received: by 10.37.172.136 with SMTP id x8mr4638333ybi.119.1475617770768;
 Tue, 04 Oct 2016 14:49:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 4 Oct 2016 14:49:10 -0700 (PDT)
In-Reply-To: <xmqqbmyzss6z.fsf@gitster.mtv.corp.google.com>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203555.6xadycotmmkuf34h@sigill.intra.peff.net> <CA+P7+xpOxoRBDZGF_CU1Q-SYiQZtMx2vuwQKS0og864awZod5g@mail.gmail.com>
 <xmqqbmyzss6z.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 4 Oct 2016 14:49:10 -0700
Message-ID: <CA+P7+xrBX684an5EzUUk+_Dtu6Ep_F+nB1JyWDWsZjUANWcFoA@mail.gmail.com>
Subject: Re: [PATCH 13/18] fill_sha1_file: write "boring" characters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> On Mon, Oct 3, 2016 at 1:35 PM, Jeff King <peff@peff.net> wrote:
>>> This function forms a sha1 as "xx/yyyy...", but skips over
>>> the slot for the slash rather than writing it, leaving it to
>>> the caller to do so. It also does not bother to put in a
>>> trailing NUL, even though every caller would want it (we're
>>> forming a path which by definition is not a directory, so
>>> the only thing to do with it is feed it to a system call).
>>>
>>> Let's make the lives of our callers easier by just writing
>>> out the internal "/" and the NUL.
>>> ...
>>
>> I think this makes a lot more sense than making the callers have to do this.
>
> The cost of fill function having to do the same thing repeatedly is
> negligible, so I am OK with the result, but for fairness, this was
> not "make the callers do this extra thing", but was "the caller can
> prepare these unchanging parts just once, and the fill function that
> is repeatedly run does not have to."
>

Sure, but it's a pretty minor optimization and I think the result is
easier to understand.

Thanks,
Jake
