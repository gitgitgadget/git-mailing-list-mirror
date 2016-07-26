Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 227C8203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 17:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776AbcGZRWK (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 13:22:10 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:36492 "EHLO
	mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648AbcGZRWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 13:22:09 -0400
Received: by mail-it0-f54.google.com with SMTP id f6so120939182ith.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 10:22:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=okMlvCSM+yuCAy63uXtGh4D1Rsh0O3jCa3HCLA41n4E=;
        b=EkYdTtYrmjaH1FT+3Db3kWcXEzoibcFffz5NNfEo6h7sDTHvxngs010gpJRAj03Btq
         1+EIY9o+TFVfKMPyhHP8WHw6zHAM8JIwLlOlaKS0xqMpkdnCa5aGJbrqcs9LZyYt2qOy
         YTbs9UC/1UehV4o+ydfhoY1zQ2U/Vzmjek8Ndr4aAJ+1mK6ZBUwtBG719GwUTdK5cTqh
         H4SkOf5gpPYWagnE0LO41QRCNqDF9PSwI7YvFcuriq9/xdBRMxjNMOHu6XTLLrDcvFFX
         eSGl/Ikh63Pzn6tMNX4CrnmUod/G+n9w/5LRxXvul4pJ1h8IxR7qx4TuyzxWHZ0WRi7z
         R2HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=okMlvCSM+yuCAy63uXtGh4D1Rsh0O3jCa3HCLA41n4E=;
        b=EBQ5yjSQ64nWdqIjwII9IrmI/3a0f5EdaZnne+f3dYq/ye0tI8UrdXwHGx0Qt6oKEY
         9bD7v7tC51CSNxHlruNNLlatVxDhDPKs9qWR+sHzDbrsRVu2pUU/kVb1UZZfK+x92pLF
         YFosHis8HSEFJjA0nVIDJ9OxAIkW1WA/3d3AXKWvibwqzijNTyRBZmLcMsFI6BB45BBe
         /Ik1k3ZzSz6X9KXff+M4oZuijd1wTH1Tm+vamXSGz9d312yz4IEvHZmn+clxIP6QVPYF
         j0p5bCFLzjvzjqomyehLyfAMVesFoWyoEq5bgV59QC5EFqJGlc+VEO7YvwjPFextCr4i
         Wk+Q==
X-Gm-Message-State: AEkoouuwdufTzhkC00H7px27T95hdy6mNym5mL+2HA5Kiteoopzvji0fCutSVvb7d7CmS0rQduOytZ7A9GSljwNq
X-Received: by 10.36.127.7 with SMTP id r7mr27515197itc.49.1469553728513; Tue,
 26 Jul 2016 10:22:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Tue, 26 Jul 2016 10:22:07 -0700 (PDT)
In-Reply-To: <20160726094913.GA3347@book.hvoigt.net>
References: <578E7A07.8080006@web.de> <20160720082515.GA823@book.hvoigt.net>
 <57911AFF.7030107@web.de> <20160725143706.GA4872@sandbox> <xmqq60rt933m.fsf@gitster.mtv.corp.google.com>
 <20160726094913.GA3347@book.hvoigt.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 26 Jul 2016 10:22:07 -0700
Message-ID: <CAGZ79kaOf3NRAXh+krM=onwswSjAF3yy_zpa1d+9CFOBNke6-w@mail.gmail.com>
Subject: Re: [PATCH 1/2] fix passing a name for config from submodules
To:	Heiko Voigt <hvoigt@hvoigt.net>
Cc:	Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 2:49 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:

Thanks for continuing on the submodule cache!

> In commit 959b5455 we implemented the initial version of the submodule

Usually we refer to the commit by a triple of "abbrev. sha1 (date, subject).
See d201a1ecd (2015-05-21, test_bitmap_walk: free bitmap with bitmap_free)
for an example. Or ce41720ca (2015-04-02, blame, log: format usage strings
similarly to those in documentation).

Apparently we put the subject first and then the date. I always did it
the other way
round, to there is no strict coding guide line, though it helps a lot to have an
understanding for a) how long are we in the "broken" state already as well as
b) what was the rationale for introducing it.



> @@ -397,8 +397,10 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>                 return entry->config;
>         }
>
> -       if (!gitmodule_sha1_from_commit(commit_sha1, sha1))
> +       if (!gitmodule_sha1_from_commit(commit_sha1, sha1, &rev)) {
> +               strbuf_release(&rev);
>                 return NULL;

This is a reoccuring pattern below. Maybe it might make sense to
just do a s/return.../ goto out/ and at that label we cleanup `rev` and `config`
and return a result value?
There are currently 6 early returns (not counting the 3 from the last switch),
4 of them return NULL, so that would result in just a "goto out", whereas 2
return an actual value, they would need to assign the result value first before
jumping out of the logic. I dunno, just food for though.



> @@ -425,8 +432,9 @@ static const struct submodule *config_from(struct submodule_cache *cache,
>         parameter.commit_sha1 = commit_sha1;
>         parameter.gitmodules_sha1 = sha1;
>         parameter.overwrite = 0;
> -       git_config_from_mem(parse_config, "submodule-blob", "",
> +       git_config_from_mem(parse_config, "submodule-blob", rev.buf,
>                         config, config_size, &parameter);

Ok, this is the actual fix. Do you want to demonstrate its impact by adding
one or two tests that failed before and now work?
(As I was using the submodule config API most of the time with null_sha1
to indicate we'd be looking at the current .gitmodules file in the worktree,
the actual bug may have not manifested in the users of this API.
But still, it would be nice to see what was broken?)

Thanks,
Stefan
