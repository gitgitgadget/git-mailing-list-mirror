Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37F24207EB
	for <e@80x24.org>; Wed, 26 Apr 2017 21:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030845AbdDZVfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 17:35:12 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33625 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030840AbdDZVfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 17:35:09 -0400
Received: by mail-pf0-f172.google.com with SMTP id a188so6606480pfa.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 14:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qlX/KdECBCqfaWXCmQM9nL2EM3lmrqOZGwtcqNKRzFE=;
        b=LZSc8TPywrUW6K5zCZ4ZwHModRr93yF+jpn0uRA36pJKg1/aCHuNJDyPasWPVuGUtU
         FdWoKBcGdu+3rf7//URIqUAa9sqWt1mDe/KPt75HgHB3KLuvUf3mPeDRswgZRo9GYckV
         8W/89W97otQD1+TefVLA5bDjDHDyVeCP0jBFQzfmUjpADGj7j4MW/IL9tE+rDfwoRHrQ
         U7gUzMAMN1Ok1srKC4UGMGOQvwKoJBAzC85U1YwM77cSieAXfswC7obzuqSt46qvQpmg
         04fvCBJmrBbJLoPa0JXnNWMv82eSWnZ5ZZVkjhv3+HnCeR59HZ7w4/YVI6Dg9amcutj3
         VRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qlX/KdECBCqfaWXCmQM9nL2EM3lmrqOZGwtcqNKRzFE=;
        b=sEekfZZw3L9Zo+HHz00JRRaZvw0nmWuR6cxko5Cbe7kUpw65cuZSKKH8bevv/F5YEg
         EmQcst2re9ct69qzdGzDbJP3O/TGYMTb9vdmq68H5oFe0KLvmTzv2STPRKYr3OXg2/zd
         L1w85iA3o8XFjvp8f67VSg/25EN2RbD6o1nOZ4ITN2Jqnj+pNDdY3AGnWsToZUsfL8eB
         1w0b2TnTOdwDVmEVgTPlChu7PDy3HPlKyXqh+nHJbnG/szuOO69kH3xaBGZVqVk99efu
         A7Upn8TUP25PdwzdA0hJB6xmU6xANN3uZNSM0dJuZ1n2wQu09O1hgWcFBKy/fFmwRTur
         6XLw==
X-Gm-Message-State: AN3rC/5n292HN6IUtofLfyI9akbg0p80H/RjgDPEjR2uZb3YK4Foq9mw
        sXfhrTQReJo7REnLPrpgCsdNglTYixcSgRw2oQ==
X-Received: by 10.99.126.23 with SMTP id z23mr2059278pgc.63.1493242498867;
 Wed, 26 Apr 2017 14:34:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Wed, 26 Apr 2017 14:34:58 -0700 (PDT)
In-Reply-To: <cover.1493237937.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Apr 2017 14:34:58 -0700
Message-ID: <CAGZ79kbbHshh4=WC2ymG15=W5oq98b3KTV4zxiTx0LgCLeYwfQ@mail.gmail.com>
Subject: Re: [PATCH 00/26] Address a couple of issues identified by Coverity
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 26, 2017 at 1:19 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> I recently registered the git-for-windows fork with Coverity to ensure
> that even the Windows-specific patches get some static analysis love.

YAY! How do you trigger the coverity scan? (via travis or uploading a tarba=
ll
manually every once in a while?) Can you talk about the setup? I'm interest=
ed
in that as I run coverity for Junios pu branch, plus a couple patches on to=
p[1].

[1] https://github.com/stefanbeller/git/commits/coverity

>
> While at it, I squashed a couple of obvious issues in the part that is
> not Windows-specific.

Thanks.

> Note: while this patch series squashes some of those issues, the
> remaining issues are not necessarily all false positives (e.g. Coverity
> getting fooled by our FLEX_ARRAY trick into believing that the last
> member of the struct is indeed a 0 or 1 size array) or intentional (e.g.
> builtins not releasing memory because exit() is called right after
> returning from the function that leaks memory).

For the latter I think we could get away with maintaining patches on
a dedicated coverity branch (which I do currently, just not in an extensive
manner). For the first, I think we can just compile with FLEX_ARRAY
defined as an insanely large number. I'll experiment with that.

> Notable examples of the remaining issues are:
>
> - a couple of callers of shorten_unambiguous_ref() assume that they do
>   not have to release the memory returned from that function, often
>   assigning the pointer to a `const` variable that typically does not
>   hold a pointer that needs to be free()d. My hunch is that we will want
>   to convert that function to have a fixed number of static buffers and
>   use those in a round robin fashion =C3=A0 la sha1_to_hex().
>
> - pack-redundant.c seems to have hard-to-reason-about code paths that
>   may eventually leak memory. Essentially, the custody of the allocated
>   memory is not clear at all.
>
> - fast-import.c calls strbuf_detach() on the command_buf without any
>   obvious rationale. Turns out that *some* code paths assign
>   command_buf.buf to a `recent_command` which releases the buffer later.
>   However, from a cursory look it appears to me as if there are some
>   other code paths that skip that assignment, effectively causing a memor=
y
>   leak once strbuf_detach() is called.
>
> Sadly, I lack the time to pursue those remaining issues further.
>

Thanks,
Stefan
