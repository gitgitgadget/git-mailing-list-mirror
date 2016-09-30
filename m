Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41343207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 00:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934998AbcI3A5w (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Sep 2016 20:57:52 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34680 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935192AbcI3A5v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Sep 2016 20:57:51 -0400
Received: by mail-oi0-f66.google.com with SMTP id r132so2626083oig.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 17:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Zjkv8YBcIjw8fho1aSi2xVxcJdIFK+uzOfZJO+wXvLs=;
        b=d0+mTvumgNHr+J/pkHxowt6L9vWGwDV2ZhJrbVVp2gDV/KpgsRtcSeq5C9udmzMGXU
         8AdBzd8aIFn5xOCZpRAMSUIXJAp08ZbrkuijPZemES09NT4JqG2yEDLhOz8YbK8drKu8
         LTeUWGMTOswCYaAKblaFk/qMDoiYkLfJt3Dz/+mhelc3NCAVl85Ar1N2FqoqMnqcKorV
         B1uNJ9YK4wy33duPUNuEGrSsFNOg8GtC8+aB+XTPmWzxWqF5vUiF6vqullpcjXYDoBRQ
         gP5ZaYGjtio1adBdFVQUug0HMAz0KelRWKBCLGcfttaPOI+FoCP3yHOQJYVMBfF4vd45
         P9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Zjkv8YBcIjw8fho1aSi2xVxcJdIFK+uzOfZJO+wXvLs=;
        b=Jeru1/Lkfw07+3jUSKTmwD+0aQAROXGx6QldrCRsQHzH1LeXUF+jwqMgKgAk1CDLXK
         L6FDHBcY8/Gns+sAsVMd8ArhqGYXnXn28ZRHD0ro5IaXtCp4k80rk+ADcdg1zAy1lNMg
         xuAsljMV9HXw59jBlwniuVCxOOWR6droOESZF3IbY8a6r+Fd+iLg7t+CvUuoM9fb2DIU
         Zk0pv6HqkbRF6CY0ybLU2ms/AYbTF87ALByPGr71gW5nVBMJ2yh92Adzi6DDxYsAFd9k
         XzXMlRaVnKQ6xYnRClHbmns7mGQ1dWk2lDQGcC2HrYsBoFYTnAkjVqGpbqDfE8ioBDXF
         CHyQ==
X-Gm-Message-State: AA6/9Rmhi4nrlhgdridAPaJuZg8V7xnubjl6EOrl70po/NZFInCkWEZcONXP12x53m1uER27AT0V/7keLDEt1g==
X-Received: by 10.202.69.67 with SMTP id s64mr4198227oia.1.1475197070272; Thu,
 29 Sep 2016 17:57:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.241.106 with HTTP; Thu, 29 Sep 2016 17:57:49 -0700 (PDT)
In-Reply-To: <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <20160928233047.14313-1-gitster@pobox.com> <20160928233047.14313-5-gitster@pobox.com>
 <ae9dbf3b-4190-8145-a59f-0d578067032a@kdbg.org> <xmqqmviqfuoh.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyYWWpz+9+KKf=9y3vBrEDyy-5h6J3boiitGE7Zb=uL-Q@mail.gmail.com>
 <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net> <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com> <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com> <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Sep 2016 17:57:49 -0700
X-Google-Sender-Auth: uLZvhZrCG8eCYj5e06OktCqgplw
Message-ID: <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12 hexdigits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 5:28 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> To be fair, my original patch had a different worry that I didn't
> bother with: what if one of the _other_ callers of "get_short_sha1()"
> passed in -1 to it.  I only handled the -1 case in th eone path care
> about in that first RFC for testing. So I'm *not* suggesting you
> should apply my first version,, It has issues too.

Actually, all the other cases seem to be "parse a SHA1 with a known
length", so they really don't have a negative length.  So this seems
ok, and is easier to verify than the "what all contexts might use
DEFAULT_ABBREV" thing. There's only a few callers, and it's a static
function so it's easy to check it locally in sha1_name.c.

               Linus
