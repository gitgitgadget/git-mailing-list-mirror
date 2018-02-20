Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA9C1F404
	for <e@80x24.org>; Tue, 20 Feb 2018 21:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751155AbeBTVvW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 16:51:22 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41789 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeBTVvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 16:51:21 -0500
Received: by mail-wr0-f194.google.com with SMTP id f14so14133434wre.8
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 13:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=TNSgQBR/a4I7nMmE9G1A1b3ZHfrSBRyUMpPWSErsFNM=;
        b=EeYtyRQJCDb0zqNN86DO88czkkwr40fqqnKao5NX780c3C7uHKviQK61QKHdgvCea6
         OZWEaVOP9zWqUj73t9utSKiGaUjAZB3de59rTO5Hc07yI6wwlcu0k+mba0m5stz5kFkq
         IUM9Aqn+5oyTIjyc2o/l90r1E3zYWWbCEM7RlPA7e7nG9NUmCqgKAqxX6tri0dOSvmp1
         7NdH+0HX57c/9jXMMEpGbYPZW8gdhP9thpuMCpBaokOcGKozINLrM0rNTQ7XTZNuNtR8
         x/g/uDGNzL3SGu0+IKGOkpuZjrpqj3GiormotGzx1uf18NW6RFafWQ7j2y44Igk2lWC9
         inGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=TNSgQBR/a4I7nMmE9G1A1b3ZHfrSBRyUMpPWSErsFNM=;
        b=V5G5zkxb563Q6Zx/7Pg8dkPlUY8JgfSGxXE5T7YJTA7yASafGOW4JHb/ZsjTnbz1wW
         wyIW5LdmpEVi04SryLlQTDYFpRggNVtvSanX3d/4Pf9VOSFIGEJ0q1GQP+QUsl8L3vPb
         57YHUo0t/9KY3ptR+qaXTvFzpedKIdIu6gJFmXD3JBLsPlQI/8AtUVdCVKp6JAmjbNEq
         lgNnYU5uvClTKK3ElAI+RPK05o/tWyoXfbFbB5FUWkhaZgkA8yNCrOiPgZDfOWJqLg2N
         sK5FcCjA2gOHyb9kirrF6f7eRMCLHK8e5Rt/+rW2fLXdBxHMIY1+oYR5eAMQW3iNsau/
         POtg==
X-Gm-Message-State: APf1xPA3BWyro8d59QCX1xQyxa6Eda+6VztIe/H1lhrxDQzeus/fNDU6
        BpAzKBAGVyZz5SgNQz5hWZc=
X-Google-Smtp-Source: AH8x227XNpIvI848Ow263+2bsLdFqrku2FR4x6tCj82jaQp+jlSh9bOIf1G14/MA7LJKKKlk6Bejfg==
X-Received: by 10.28.210.77 with SMTP id j74mr332528wmg.13.1519163480312;
        Tue, 20 Feb 2018 13:51:20 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s2sm14220574wmf.0.2018.02.20.13.51.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 20 Feb 2018 13:51:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, peff@peff.net,
        jonathantanmy@google.com, szeder.dev@gmail.com, sbeller@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 03/13] commit-graph: create git-commit-graph builtin
References: <4d1ee202-7d79-d73c-6e05-d0fc85db943c@gmail.com>
        <1519066406-81663-1-git-send-email-dstolee@microsoft.com>
        <1519066406-81663-4-git-send-email-dstolee@microsoft.com>
Date:   Tue, 20 Feb 2018 13:51:18 -0800
In-Reply-To: <1519066406-81663-4-git-send-email-dstolee@microsoft.com>
        (Derrick Stolee's message of "Mon, 19 Feb 2018 13:53:16 -0500")
Message-ID: <xmqqvaer1ga1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +int cmd_commit_graph(int argc, const char **argv, const char *prefix)
> +{
> +	static struct option builtin_commit_graph_options[] = {
> +		{ OPTION_STRING, 'p', "object-dir", &opts.obj_dir,
> +			N_("dir"),
> +			N_("The object directory to store the graph") },

I have a suspicion that this was modeled after some other built-in
that has a similar issue (perhaps written long time ago), but isn't
OPT_STRING() sufficient to define this element these days?

Or am I missing something?

Why squat on short-and-sweet "-p"?  For that matter, since this is
not expected to be end-user facing command anyway, I suspect that we
do not want to allocate a single letter option from day one, which
paints ourselves into a corner from where we cannot escape.
