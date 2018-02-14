Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 647711F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162291AbeBNSrv (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:47:51 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:42421 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162277AbeBNSrt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:47:49 -0500
Received: by mail-yw0-f193.google.com with SMTP id e65so6904996ywh.9
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 10:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mycode-ai.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oP5LLHCgqxCBtxGXAjTKigMe/D6UIFIKqQxTQHl0ndc=;
        b=CHaqcVViKR6QeQl0U45upBBIM6sKwLXt18qI6dtALco4OR7P8VsGZDBcOfHqTqqTMd
         TCqSgENXXPoCd8+GJG0Brg9OBzqnzVn8VHqMPb1AaRBWmyFa/cZzr4kDbz9AQny2Kmuu
         wA4c1nriVEPfvZT+oty0ybCyEu2xXk+s6JhQr0tZUIFewzbqjdnFfhhh968J+WvHo6jo
         MYuN7KeOj5AtLzBaYMvwzYsdY6toovRg2fnC17wfFnMknWGANj2NDwXOd82Lsxp0GDDZ
         l+QxqZOvoCEnAQww9r7p4sa2/BgcWeDEkiZUNKQHYL5VER7HrsJSz47xBJWpT9Rvwf8s
         szCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oP5LLHCgqxCBtxGXAjTKigMe/D6UIFIKqQxTQHl0ndc=;
        b=NS2ws3BljwKRNnwgPzzRsFt1hEWNuVUnaz20yaX+VnxvaTzUGEqSgXiVRjsprJ77Oc
         iZo3taJu9DcD3yPbxNZlVe0UkuwTqfJ9KaqEV5uv896u4QmvBi/QYlhD3POsWHJwo1tz
         8bjOuxLABYrBJ1//5T6ohJraJ16YmUjMH//SZvvyqbON7EEOshFPmZWmvldlsFoojUZf
         BTwnttcgs16zplxoEkc6qtX24gH+Am7Rz0XF0p9w+o7ee4+bUvAjqNs8YA/qjGj77z4x
         UtcO+CTsvJEECPiZHaRMUhMOXhXGQtml4p1a4Wblurt4CRqZZjsY0gUH5ZSsYBRzAsB+
         7gXA==
X-Gm-Message-State: APf1xPAXUYn5uMpxtbm40MxJwbyEtQE+aoWZZ4uBks2u3bkeo0KVxRrC
        7lR0eA1Pz7xxA4Vfm2DIs8WpNhkSUxScczof6TMHhj6OelA=
X-Google-Smtp-Source: AH8x22671ypw2awUtTW4oN1XVSZnFhj4ZZUefNMyppC7dNIBGoZ+TY1+4+OZICOLBxXsrpX+BBrJDCBxzi4mJvnOxjY=
X-Received: by 10.37.61.193 with SMTP id k184mr188531yba.188.1518634068458;
 Wed, 14 Feb 2018 10:47:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.48.13 with HTTP; Wed, 14 Feb 2018 10:47:48 -0800 (PST)
In-Reply-To: <20180214180545.GA9919@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net> <20180214180545.GA9919@sigill.intra.peff.net>
From:   Code AI <techsupport@mycode.ai>
Date:   Wed, 14 Feb 2018 13:47:48 -0500
Message-ID: <CAGm8dMCdL_KWQSeTdC1B+-XU1E-ix=t0C6tDTdrrdbLEfUWCuw@mail.gmail.com>
Subject: Re: [PATCH 1/6] test-hashmap: use ALLOC_ARRAY rather than bare malloc
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff,

Thanks for the feedback!  Most of our users find CodeAI's fixes
useful, even if they are not exactly correct.  However, we are
constantly working on improving the quality of CodeAI's fixes.  The
more people who use it, the more we can improve it.  We would love for
you to try the system directly by visiting mycode.ai.  Its free for
open source users, and you can easily login using your GitHub account.
Also, you may attribute the allocator sizeof() issue to C0deAi.
That's the Github account used by the tool to submit pull requests.

-Ben

On Wed, Feb 14, 2018 at 1:05 PM, Jeff King <peff@peff.net> wrote:
> These two array allocations have several minor flaws:
>
>   - they use bare malloc, rather than our error-checking
>     xmalloc
>
>   - they do a bare multiplication to determine the total
>     size (which in theory can overflow, though in this case
>     the sizes are all constants)
>
>   - they use sizeof(type), but the type in the second one
>     doesn't match the actual array (though it's "int" versus
>     "unsigned int", which are guaranteed by C99 to have the
>     same size)
>
> None of these are likely to be problems in practice, and
> this is just a test helper. But since people often look at
> test helpers as reference code, we should do our best to
> model the recommended techniques.
>
> Switching to ALLOC_ARRAY fixes all three.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The sizeof() thing came from Code AI's original email. I'm happy to
> include a Reported-by there, but I wasn't sure of the correct entity to
> credit. :)
>
>  t/helper/test-hashmap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
> index 1145d51671..b36886bf35 100644
> --- a/t/helper/test-hashmap.c
> +++ b/t/helper/test-hashmap.c
> @@ -85,8 +85,8 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
>         unsigned int *hashes;
>         unsigned int i, j;
>
> -       entries = malloc(TEST_SIZE * sizeof(struct test_entry *));
> -       hashes = malloc(TEST_SIZE * sizeof(int));
> +       ALLOC_ARRAY(entries, TEST_SIZE);
> +       ALLOC_ARRAY(hashes, TEST_SIZE);
>         for (i = 0; i < TEST_SIZE; i++) {
>                 snprintf(buf, sizeof(buf), "%i", i);
>                 entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);
> --
> 2.16.1.464.gc4bae515b7
>



-- 
Sincerely,

CodeAI Tech Support Team
