Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82C591F42B
	for <e@80x24.org>; Mon, 13 Nov 2017 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbdKMVGk (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 16:06:40 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:55329 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbdKMVGj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 16:06:39 -0500
Received: by mail-qk0-f178.google.com with SMTP id d125so7030917qkc.12
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 13:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Emqu5XeT5y6bpGXANM57Qyy4VYpbhHqXeBMn7rK50Wo=;
        b=fh2NyQ7rjT/PgxTYE8XFbvraAuhuwGJxUzQVeKILbaQ0mON72lCcaQuTDHFXGSEcXG
         0jId7jHsFiQ3qpM1iQBWMktvbUyJ1EBwSJwiPUNTxAIBjxFkvwm1SNDdFQW9GukhXsss
         b9Io4LhiEkbvaxGRph9R3fomF3fTwwdAwNBBoQW5KaAmLRFaEu1XtEiAl9FFIxz/cdsx
         3mpaWjhTki1UzTUPyeNblU3krrVAC73MFB/AjvyWsn8vLPWWEQ/cX1WERNFQaqVs/6H4
         MmPcDCoQhGTUlKjg1xAyPVs5fvpi+P+arGLuQZcxPHFcsQKEMY7GkZpRW1sOsMAnlV3C
         sWOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Emqu5XeT5y6bpGXANM57Qyy4VYpbhHqXeBMn7rK50Wo=;
        b=c8mjLBi74eA2CyApKj+TOIMfUOe5PvNvwBmFBu5HJwhLA9Y4Ep3U3QuqDK9Sq5F/iK
         V0r8+UMlx82pGjEyIO9GIYC7yacwb90nJJtzEzmxvsuCqhi6Wr++d4pPjQASO7/eSMoY
         Xfml2Jh0gsDeBV2z/MaUr2DxHC1vAKHBtDiXqxAtmHyT1HEElicmMmVSgkjkBH7SVkzq
         jTL6sCO9xnB7rt+6uxV+VPtRN6RuuVKGdRbcvjJ2iz5ZLxXR+mEMS4+KT6bgUVVMqf7o
         5pYXO5SquxqLAtJFiDuMSsQkQTGh3eaje7JLEjAWL/KriZ2PueqlIixPS3UydiHMZAXH
         SxyA==
X-Gm-Message-State: AJaThX6mMQ30AE63zdIv5A7ciO7dbQO3Uz6u24F+paZftkNiUIXyjshD
        o7rrs1VMm7qgtZxlH4iSA1kXHk7aZCuwkWsY+x61NA==
X-Google-Smtp-Source: AGs4zMbrQHNdscT8JqDwqtlqAqNb+xPOKSrWapoP/PIHvW897s01nI2HYfvzisPvXq/RZtAUCPr+t3ycX5Fchn69x0I=
X-Received: by 10.55.111.3 with SMTP id k3mr15416825qkc.332.1510607198485;
 Mon, 13 Nov 2017 13:06:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 13:06:37 -0800 (PST)
In-Reply-To: <20171110190550.27059-4-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-4-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 13:06:37 -0800
Message-ID: <CAGZ79kZ7d7fMp3Cw3Yy4bq9-Mh5Z_jhM5XDQbkVLoqzm6ONzDg@mail.gmail.com>
Subject: Re: [PATCH 03/30] merge-recursive: Add explanation for src_entry and dst_entry
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> If I have to walk through the debugger and inspect the values found in
> here in order to figure out their meaning, despite having known these
> things inside and out some years back, then they probably need a comment
> for the casual reader to explain their purpose.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-recursive.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index 52521faf09..3526c8d0b8 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -513,6 +513,28 @@ static void record_df_conflict_files(struct merge_options *o,
>
>  struct rename {
>         struct diff_filepair *pair;
> +       /*
> +        * Because I keep forgetting every few years what src_entry and
> +        * dst_entry are and have to walk through a debugger and puzzle
> +        * through it to remind myself...

This repeats the commit message; and doesn't help me understanding the
{src/dst}_entry. (Maybe drop the first part here?) I'll read on.

> +        *
> +        * If 'before' is renamed to 'after' then src_entry will contain
> +        * the versions of 'before' from the merge_base, HEAD, and MERGE in
> +        * stages 1, 2, and 3; dst_entry will contain the versions of
> +        * 'after' from the merge_base, HEAD, and MERGE in stages 1, 2, and
> +        * 3.

So src == before, dst = after; no trickery with the stages (the same
stage number
before and after; only the order needs to be conveyed:
base, HEAD (ours?), MERGE (theirs?)

I can understand that, so I wonder if we can phrase it to mention (base,
HEAD, MERGE) just once.

>     Thus, we have a total of six modes and oids, though some
> +        * will be null.  (Stage 0 is ignored; we're interested in handling

s/will be/may be/ or /can be/?

> +        * conflicts.)
> +        *
> +        * Since we don't turn on break-rewrites by default, neither
> +        * src_entry nor dst_entry can have all three of their stages have
> +        * non-null oids, meaning at most four of the six will be non-null.

Oh. That explains the choice of /will be/ above. Thanks!

> +        * Also, since this is a rename, both src_entry and dst_entry will
> +        * have at least one non-null oid, meaning at least two will be
> +        * non-null.  Of the six oids, a typical rename will have three be
> +        * non-null.  Only two implies a rename/delete, and four implies a
> +        * rename/add.

That makes sense.

Thanks,
Stefan

> +        */
>         struct stage_data *src_entry;
>         struct stage_data *dst_entry;
>         unsigned processed:1;
> --
> 2.15.0.5.g9567be9905
>
