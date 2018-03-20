Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB351F404
	for <e@80x24.org>; Tue, 20 Mar 2018 16:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeCTQmY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 12:42:24 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36097 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTQmX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 12:42:23 -0400
Received: by mail-ot0-f195.google.com with SMTP id 108-v6so2437773otv.3
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b1fvy9mQyFPdosjpjdPQqxJNFbjEPnGTXtlYtC4ytgE=;
        b=LzFCcQS0XZhlLhZydyAAlnX3pTBP1bwQ6QnX/7OIhDYTJXJg+5F83qdlOlVA5ptoyK
         H6X8055FV+K5Ga1ukO4y1jdJc8R2bUrbRoMQGfR1Zy+pEvMLUv9Xy3WQC3EX03VVicXO
         JH2Qau8/3KG+l2orCDp2aSY4ZdD6IJ65olMEK3yDhW5Jzd48G5Xu/laiSAGrYVZUCogT
         cqIejtn6hJqszFK4RT2zr2Rg+sCVyLOwSEind59t3fQQnJgyOFQhS+M9WrDj7189K9+i
         sxRV1OJR+3h9YmGGENdA1xoTVq62E4jQPod+FOV0DkJ/AuVQwn7oeuatyo9LsQySzgGD
         cFfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b1fvy9mQyFPdosjpjdPQqxJNFbjEPnGTXtlYtC4ytgE=;
        b=IL2qZSsoYp2vyeJtAGB49AtaS/RJK+tQGZ2QK/TfrFm9cEzbNnS+1iKx68B3j74Tqf
         wVqmLRRiouqh4EZN9DSGZ2XgF6UrQ1qusf5slQ0k8AGI1gNcrTcx7DG7bRCxHfO+Mtlj
         hHzlPppIMBXDgRkiZlpklSa1vuAtHWCoFXXrDnbGbF/kVhz0HRUwzLQQXINFpzKtzwq3
         Nnkjic1YV13Kd6VC5UnMAm3mrcUJHIbqZq1PnuyxfLJhHYCN3dKfPFkqzVzhg0bjK/uk
         CiJShNiwXhlZm88oHZNPVW2KBK6Ds6OphpMBzeFKBlCVmoRdpHjENKvakfNquYcvQb3a
         OeEg==
X-Gm-Message-State: AElRT7GR3fbgBMig6fIQgYQjekFffzucxAIM0G1LMvegS6Z+dTDbpSpS
        xMMYydJwnTU36PgUNd60KG5XPN/yNu9a7krEDO4=
X-Google-Smtp-Source: AG47ELuB5GyVnNGUOlyFQszw3toaVXOKnr+n3+LVsWTreg5X+JCTWOYytiyJwLNnsDaKbUEjb4dtXNE2jvvx2i4s53M=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr11454791otq.75.1521564142754;
 Tue, 20 Mar 2018 09:42:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.154.146 with HTTP; Tue, 20 Mar 2018 09:41:52 -0700 (PDT)
In-Reply-To: <20180320041454.GA15213@sigill.intra.peff.net>
References: <CAHnyXxRX4+sMJCNG6f9xtsDO6bdqRS-U6TAYO47OKQjH8bGzbg@mail.gmail.com>
 <20180320023423.GA10143@sigill.intra.peff.net> <CAHnyXxRcwq40W4tKm=Kscrsnb77yh7=eGDE=r5AZq073MPX9AQ@mail.gmail.com>
 <20180320040411.GB12938@sigill.intra.peff.net> <20180320041454.GA15213@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 20 Mar 2018 17:41:52 +0100
Message-ID: <CACsJy8CpwtNfp9oQGvECBuWGcwLEKK609iPJVEiXH4cDD6mpEg@mail.gmail.com>
Subject: Re: [PATCH] doc/gitattributes: mention non-recursive behavior
To:     Jeff King <peff@peff.net>
Cc:     Dakota Hawkins <dakota@dakotahawkins.com>,
        Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 5:14 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Mar 20, 2018 at 12:04:11AM -0400, Jeff King wrote:
>
>> > I guess my takeaway is that it would be _good_ if the gitattributes
>> > documentation contained the caveat about not matching directories
>> > recursively, but _great_ if gitattributes and gitignore (and whatever
>> > else there is) were consistent.
>>
>> I agree it would be nice if they were consistent (and pathspecs, too).
>> But unfortunately at this point there's a maze of backwards
>> compatibility to deal with.
>
> So let's not forget to do the easy half there. Here's a patch.
>
> -- >8 --
> Subject: [PATCH] doc/gitattributes: mention non-recursive behavior
>
> The gitattributes documentation claims that the pattern
> rules are largely the same as for gitignore. However, the
> rules for recursion are different.
>
> In an ideal world, we would make them the same (if for
> nothing else than consistency and simplicity), but that
> would create backwards compatibility issues. For some
> discussion, see this thread:
>
>   https://public-inbox.org/git/slrnkldd3g.1l4.jan@majutsushi.net/
>
> But let's at least document the differences instead of
> actively misleading the user by claiming that they're the
> same.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/gitattributes.txt | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index d52b254a22..1094fe2b5b 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -56,9 +56,16 @@ Unspecified::
>
>  When more than one pattern matches the path, a later line
>  overrides an earlier line.  This overriding is done per
> -attribute.  The rules how the pattern matches paths are the
> -same as in `.gitignore` files; see linkgit:gitignore[5].
> -Unlike `.gitignore`, negative patterns are forbidden.
> +attribute.
> +
> +The rules by which the pattern matches paths are the same as in
> +`.gitignore` files (see linkgit:gitignore[5]), with a few exceptions:
> +
> +  - negative patterns are forbidden

After 8b1bd02415 (Make !pattern in .gitattributes non-fatal -
2013-03-01) maybe we could use the verb "ignored" too instead of
"forbidden"

> +
> +  - patterns that match a directory do not recursively match paths
> +    inside that directory (so using the trailing-slash `path/` syntax is

Technically gitignore does not match paths inside either. It simply
ignores the whole dir and not traverse in (which is more of an
optimization than anything). That is coincidentally perceived as
recursively ignoring. Anyway yes it's good to spell out the
differences here for gitattributes.

> +    pointless in an attributes file; use `path/**` instead)

We probably could do this internally too (converting "path/" to
"path/**") but we need to deal with corner cases (e.g. "path" without
the trailing slash, but is a directory). So yes, suggesting the user
to do it instead may be easier.

>
>  When deciding what attributes are assigned to a path, Git
>  consults `$GIT_DIR/info/attributes` file (which has the highest
> --
> 2.17.0.rc0.402.ged0b3fd1ee
>



-- 
Duy
