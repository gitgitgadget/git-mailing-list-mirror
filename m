Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 234681F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 22:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbeJIFqy (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 01:46:54 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46334 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeJIFqy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 01:46:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id g32-v6so18935234edg.13
        for <git@vger.kernel.org>; Mon, 08 Oct 2018 15:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8BSai4Tko0UTY+qwqzL2ydvW4WDncQNOiPitnjnPLgw=;
        b=FiP0CGFU9CXKSrKAkh9W4NK1qRmeN2IrAvmAXk72k7U8SQ71dT3y0gWeujJbemNm6a
         2OKTtI528+LwelpmdT39z64cBqaTVVgdHYyvBzxIgz2lCAG8r7FN4wnWydtg6JD52HIt
         H70cKadjFrX3cnbA2ljyeAOLD5hjg+tYSCWpiE982v5pmL5saHVH6hSPsxLvnD6qTf5A
         COh7QTilk3PCZiL7mA//o3aKCTlqUr+oKPnquk4Fi0fpcevE7aQyY52yX582nDVZWRl2
         dI4ZG9m8XCKBX/oIExVK+Yya0tfA1EbKSK6Fo6fOsaa5mguFoS68AZwXv+mGwEDQTsmB
         O8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8BSai4Tko0UTY+qwqzL2ydvW4WDncQNOiPitnjnPLgw=;
        b=UaWZFaGu61gmMNI+hdlNTioXR3YesGN8Vm5dK0HLqEUJrOdWqbkGPD6eZpFl/KE9B5
         pgqKrOu9JbH4obUULbKpjppxb+fIzsvCjFN9FYO5J6TbAtvz9hCR+xGUxonywltzn/i2
         8RH0Tfty+8DflrFF0fdaQc1dA4Kk9KoKu8LAzSyIwf4sPZg2s+4wQFHWVy/r0aZ38uug
         vPdGjfVPXv8/ldrpXohuY01TAXiDP3/GUHTqq1daDsC2VxaavGgkENopbHFNwV9EcM9Q
         S0RKRjtmTmdm+rpLpGVFVqTbuXK34/FxKDa4Oq7zPjt4LzY2EpfEnEYdQOVIpcKhEL+v
         4IEg==
X-Gm-Message-State: ABuFfoiPMFWwM5TuQEacUP351PCNZe9QHYnl6Os3fMzUf9G5Bg7vFWwV
        NB4QtMk5pRuWd3XUaGCBe4c3FgFCDOaj1sZz1yg/5x6Xzjs=
X-Google-Smtp-Source: ACcGV61Acy/ssx7KeOlEZ01t72gafrtWKnZH1FGnjjKbOrwSJ7haUe+ID5EgrYKLAXGk9rn++nnpUU4R4N57V5FoSGs=
X-Received: by 2002:a17:906:9a1:: with SMTP id q1-v6mr4110134eje.126.1539037976394;
 Mon, 08 Oct 2018 15:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net> <20181008215701.779099-4-sandals@crustytoothpaste.net>
In-Reply-To: <20181008215701.779099-4-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 Oct 2018 15:32:45 -0700
Message-ID: <CAGZ79kYeLiiU5tdO1n=cG3fPDWmezhd=oS=UiS=iZkxz+HfeFg@mail.gmail.com>
Subject: Re: [PATCH 03/14] builtin/mktree: remove hard-coded constant
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> Instead of using a hard-coded constant for the size of a hex object ID,
> switch to use the computed pointer from parse_oid_hex that points after
> the parsed object ID.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/mktree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/mktree.c b/builtin/mktree.c
> index 2dc4ad6ba8..94e82b8504 100644
> --- a/builtin/mktree.c
> +++ b/builtin/mktree.c
> @@ -98,7 +98,7 @@ static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_miss
>
>         *ntr++ = 0; /* now at the beginning of SHA1 */
>
> -       path = ntr + 41;  /* at the beginning of name */
> +       path = (char *)p + 1;  /* at the beginning of name */

... and we need the cast to un-const p such that path takes it.
Makes sense.
