Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 625C51F576
	for <e@80x24.org>; Fri, 19 Jan 2018 10:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754696AbeASKeX (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 05:34:23 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34350 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeASKeV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 05:34:21 -0500
Received: by mail-qt0-f195.google.com with SMTP id 33so2686635qtv.1
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 02:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=BXbXOhOuQMS0hKNxCJoWy+u344SCPBT4UgQ81DMAa6Q=;
        b=LYV/ortcEKcBDAvGoSbFoko5567pCUgIp7knjs624p7vR72De9OjnCzeNLfzl95Evg
         tHTz0mHUc1RSx55tqguAdtH7HKUsEGBp6Qqzin360vmaCYxMSJwscHIJcIzo5hBmy64H
         qbnF7wVp/haixAEZ4qymOOgbb02iLHWULLLy7K3LfYeoNKCbkaORxhD+VDFljETE7atA
         QKObw2260NxSmSL6ox4gYUQeiZpdxotLs1dzdlW6ZlmmFFuN/SPYscGLJsD4Maaw8voj
         EOTzBk+0w3L3hvGx9DHGSQ2MrVxKc31/V4iwyrYhqf/jKVJvNCWmmhzRnUDrqX9KoSAG
         txkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=BXbXOhOuQMS0hKNxCJoWy+u344SCPBT4UgQ81DMAa6Q=;
        b=lTquIvh6GyGVYUvsORYBtJBF1WXVlNULe+gmmsRFcK2712Q38ecYxMUvRsCaUQCPXx
         WGhvXaOAXB+Lf3ZPsIQAWvmm6E8PQt8WWfl3tywaVXQDoHFJzdSZ+LPqWawesWi9l8qP
         MRtwxzoa+8QiojJ+hqYHfPA8Kmv+LQRW9HnMQxiQent/bOZJ2ujZKJA3RgYBFf+whCxv
         SqJN682lCerfeonrE/pxoieF2ZaMy9LahxKuamn6v92/WLIMAWfOBP8prFihrVtEBDZb
         HBSDP4Tjhugq0vJx+2h8mH9rj7R7f4BlB/cw67aBfoMslsv/1SFy+osgtgjtF3p/uZu8
         z1/w==
X-Gm-Message-State: AKwxytfqs4Q7y1hNCwMmEVg4oUjYxg5mB/YBsNF7Pg7uD3QEcaFgPA4M
        FK6H/5jYjSpYmXL/kLaDwlXWLqsf7GZk6Pmi/V4=
X-Google-Smtp-Source: ACJfBotqYdTs3FEURutM89SqFEZuhBYmlIgMkfUQsekbUi/vgBUomWw3kixsTNpLAp+Xp1Rf1DieWd3z7wBcCryNlVc=
X-Received: by 10.200.7.74 with SMTP id k10mr28139503qth.333.1516358061186;
 Fri, 19 Jan 2018 02:34:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 02:34:20 -0800 (PST)
In-Reply-To: <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de> <b9cb2d915aa4ff564b1960ce0352664b1d26eecb.1516225925.git.johannes.schindelin@gmx.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 05:34:20 -0500
X-Google-Sender-Auth: dzXf1wreMNnZ_BT0raNPvP9aZC4
Message-ID: <CAPig+cSn_X-0iir-cKSd=P8p5QCxrR2qU_GBj7zDbv8zTc+AQw@mail.gmail.com>
Subject: Re: [PATCH 4/8] rebase-helper --make-script: introduce a flag to
 recreate merges
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 18, 2018 at 10:35 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> The sequencer just learned a new commands intended to recreate branch

s/a //

> structure (similar in spirit to --preserve-merges, but with a
> substantially less-broken design).
> [...]
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/sequencer.c b/sequencer.c
> @@ -2785,6 +2787,335 @@ void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag)
> +static const char *label_oid(struct object_id *oid, const char *label,
> +                            struct label_state *state)
> +{
> +       [...]
> +       } else if (((len = strlen(label)) == GIT_SHA1_RAWSZ &&
> +                   !get_oid_hex(label, &dummy)) ||
> +                  hashmap_get_from_hash(&state->labels,
> +                                        strihash(label), label)) {
> +               /*
> +                * If the label already exists, or if the label is a valid full
> +                * OID, we append a dash and a number to make it unique.
> +                */
> +               [...]
> +               for (i = 2; ; i++) {

Why '2'? Is there some non-obvious significance to this value?

> +                       strbuf_setlen(buf, len);
> +                       strbuf_addf(buf, "-%d", i);
> +                       if (!hashmap_get_from_hash(&state->labels,
> +                                                  strihash(buf->buf),
> +                                                  buf->buf))
> +                               break;
> +               }
> +
> +static int make_script_with_merges(struct pretty_print_context *pp,
> +                                  struct rev_info *revs, FILE *out,
> +                                  unsigned flags)
> +{
> +       [...]
> +               is_octopus = to_merge && to_merge->next;
> +
> +               if (is_octopus)
> +                       BUG("Octopus merges not yet supported");

Is this a situation which the end-user can trigger by specifying a
merge with more than two parents? If so, shouldn't this be just a
normal error message rather than a (developer) bug message? Or, am I
misunderstanding?
