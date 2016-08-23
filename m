Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D77561FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 22:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756312AbcHWWe1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 18:34:27 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34378 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754276AbcHWWdq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 18:33:46 -0400
Received: by mail-yw0-f194.google.com with SMTP id j12so5754769ywb.1
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=afCvyOmpkZQqynbMeRgzhUjOLZe8jezHUcaI42IVOHI=;
        b=dbL/pO50eZf/cNFKSNSFFUCa1HoxIxX4gols04r7E8/Zo/zxf+ewVp5shwihXuGtk5
         TL49kG9KcQlk2a1SYuqSzw/U08w48N0JbJ3FYRaqztSsTVkUfN8t3CY84nsLcB7sx4tv
         ZPtYyNuOE9DbdoXu/UbQ+hzAET3GavoF84iYtDoPuT5nGj3P7JUJr1n8UCKanX7vPvne
         D6RQac9epvUvuLHgE+QKL3ZXYNIIz06P42d4oZitEP2FlbYJaznZkr7OQA5rUu9zq++b
         cwqJYqBvcGgVPw41Hb3MmgaeJSRw7dKDGmve+ylBukQ6/tf7jHBhZSnzgcTpFtWOp3il
         oVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=afCvyOmpkZQqynbMeRgzhUjOLZe8jezHUcaI42IVOHI=;
        b=jk1VdPOGiZtOwGP8SzZ/6JhMhuKYW5i1z9Zyq5hIaW7Mz3kSi+GA0Q7mvlfR1tyVc6
         D9GuBcaBb24qhn3t1O9xsuySebJgA4zkAq3WwFSRFbmYSIQqLAxwXzjTOdTEVKSyVEaL
         fPU+PZ+JqOOZgxfhfn8yo23mnSqTr8j0QTctzpXXTwY3l709fY6thsRSaC1Qa6yNyK/g
         W0qcYhpyk7PLzcDyXjYDFUGxp5+L0kYf5cFuDkLZIaq19SOD6/uOIteworPDGiCZq9f/
         M1TBD3cH7iesJXURWvzKfChIQaVkfVy0oHxdX2GXxoyTsedxTmA4sITh8gISL7+dL7DX
         H/Zw==
X-Gm-Message-State: AEkooutBbjlZ+nyybcjnrgvS4HVBhGuF/HB1rfJ8rwbwwS4F+nefpYbUiogkubGOwFHxPC1UGlAUtrWpFrsrGA==
X-Received: by 10.13.197.195 with SMTP id h186mr23703877ywd.54.1471990854001;
 Tue, 23 Aug 2016 15:20:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 15:20:33 -0700 (PDT)
In-Reply-To: <20160815215327.15682-5-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-5-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 15:20:33 -0700
Message-ID: <CA+P7+xq9_kx7d5NMk2QxwZRQn8o6qgkJq5ryZL2FVrHaUmqKQQ@mail.gmail.com>
Subject: Re: [PATCHv5 4/8] submodule--helper update-clone: allow multiple references
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2016 at 2:53 PM, Stefan Beller <sbeller@google.com> wrote:
> Allow the user to pass in multiple references to update_clone.
> Currently this is only internal API, but once the shell script is
> replaced by a C version, this is needed.
>
> This fixes an API bug between the shell script and the helper.
> Currently the helper accepts "--reference" "--reference=foo"
> as a OPT_STRING whose value happens to be "--reference=foo", and
> then uses
>
>         if (suc->reference)
>                 argv_array_push(&child->args, suc->reference)
>
> where suc->reference _is_ "--reference=foo" when invoking the
> underlying "git clone", it cancels out.
>
> With this change we omit one of the "--reference" arguments when
> passing references from the shell script to the helper.
>

Yep, I see the API fix, and it looks correct. Makes use of the helper
easier and more likely to be done correctly.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  builtin/submodule--helper.c | 14 +++++++++-----
>  git-submodule.sh            |  2 +-
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index ce9b3e9..7096848 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -584,7 +584,7 @@ struct submodule_update_clone {
>         /* configuration parameters which are passed on to the children */
>         int quiet;
>         int recommend_shallow;
> -       const char *reference;
> +       struct string_list references;
>         const char *depth;
>         const char *recursive_prefix;
>         const char *prefix;
> @@ -600,7 +600,8 @@ struct submodule_update_clone {
>         int failed_clones_nr, failed_clones_alloc;
>  };
>  #define SUBMODULE_UPDATE_CLONE_INIT {0, MODULE_LIST_INIT, 0, \
> -       SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, NULL, NULL, NULL, NULL, \
> +       SUBMODULE_UPDATE_STRATEGY_INIT, 0, -1, STRING_LIST_INIT_DUP, \
> +       NULL, NULL, NULL, \
>         STRING_LIST_INIT_DUP, 0, NULL, 0, 0}
>
>
> @@ -710,8 +711,11 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
>         argv_array_pushl(&child->args, "--path", sub->path, NULL);
>         argv_array_pushl(&child->args, "--name", sub->name, NULL);
>         argv_array_pushl(&child->args, "--url", url, NULL);
> -       if (suc->reference)
> -               argv_array_push(&child->args, suc->reference);

Here, you now no longer pass in the reference as a whole, but assume
that it is actually just the value to pass to --reference. And below
you correctly replace the extra --reference. Ok so I see how you fixed
the API bug.

> diff --git a/git-submodule.sh b/git-submodule.sh
> index c90dc33..3b412f5 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -575,7 +575,7 @@ cmd_update()
>                 ${wt_prefix:+--prefix "$wt_prefix"} \
>                 ${prefix:+--recursive-prefix "$prefix"} \
>                 ${update:+--update "$update"} \
> -               ${reference:+--reference "$reference"} \
> +               ${reference:+"$reference"} \

From above, I see how you fixed this to assume (as above) that
$reference is "--reference <value>" and pass it directly. It worked
before but was definitely a bit "brittle" in that direct calling of
the helper function would not behave as expected. Nice!

Regards,
Jake
