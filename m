Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F37DD1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 22:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeAYWGS (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 17:06:18 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39636 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeAYWGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 17:06:17 -0500
Received: by mail-pf0-f196.google.com with SMTP id e11so6809015pff.6
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 14:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GKVOMh9mMzUU42sdBZ0cIL89ea6c9nhxQFiwd0/3zKw=;
        b=lrgWiIjjxRP/PaJm433B8aDURDFQvPOHVA4NHoJpjLyTl1rb4vTy/8RvsbwvfKlY7y
         dKWgPPnUMFG4Vatx58PNe5oHOtEEHTUVV+ZxhWa4jJ3mZputV0XiZNXYW5S56hmouOoG
         adQ2tievkOfkXQrAAg5gkT0NyA/Z8vRzbQkdN3nU0ZKan3hjZlnM2GjD73qizSZp59zK
         srWITsRkjPqbJTNBsEWf/FVX8L8nHjMqhbKpgSXqka7dzO0lcavIZg5LBMFeVK4jB4MX
         5Tt1jmtnkjEUZAE9Tdde47gYT+2cFg4H//TgPIQdPXyifMjNftgYVyEYHKaTW2C4DMlV
         dTkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GKVOMh9mMzUU42sdBZ0cIL89ea6c9nhxQFiwd0/3zKw=;
        b=MDIH0PiofPQbpOkwqjiPD5rfoyS5rarHPaxKm20kPWadqhKYj2CVgp2ePDOUQkyAQL
         wV8ViPJWDedIkP6GGHU235yL85DNtwz3p0assD5P4skw1HlX91HJrX5oM1HK65CXbx1O
         jjgSorqTeO+FBX/yyvW5oYNOVLmVqpiFRQQ8IvrGpH4SrORwceSoNW3ZKdx6sdmTxHTN
         USypmSaFfa2OEErlt4Lyl8BxkmuJai8mKC7jNUkRE5Ug1/8uNpUfiGg2iGy1riG7D8xt
         eJdyhz67wKULhj0PR7uQFhc35UEIt+EWszdLqq6xQWhXo7UMgZ2iSZB28Ab4PhfXmzVl
         PUzg==
X-Gm-Message-State: AKwxytdAFiuKbM1fy9ltU6KVLalmaAfc/bP9WoKu8fsQrUNgvXGQSn+c
        FhGu75KSAX6i2dz4f3gZW9g=
X-Google-Smtp-Source: AH8x224+yZqZnexVQ1VemGHRPoJvpX64NeMJ5KFrjU0mdZho0U6gBnRLacD1l/4xI8wBqqX5ofxyzw==
X-Received: by 10.101.68.200 with SMTP id g8mr4133419pgs.132.1516917977013;
        Thu, 25 Jan 2018 14:06:17 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id n66sm15464626pfn.111.2018.01.25.14.06.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 14:06:16 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: Re: [PATCH 04/14] packed-graph: add format document
References: <20180125140231.65604-1-dstolee@microsoft.com>
        <20180125140231.65604-5-dstolee@microsoft.com>
Date:   Thu, 25 Jan 2018 14:06:15 -0800
In-Reply-To: <20180125140231.65604-5-dstolee@microsoft.com> (Derrick Stolee's
        message of "Thu, 25 Jan 2018 09:02:21 -0500")
Message-ID: <xmqqr2qd8ug8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> Add document specifying the binary format for packed graphs. This
> format allows for:
>
> * New versions.
> * New hash functions and hash lengths.
> * Optional extensions.
>
> Basic header information is followed by a binary table of contents
> into "chunks" that include:
>
> * An ordered list of commit object IDs.
> * A 256-entry fanout into that list of OIDs.
> * A list of metadata for the commits.
> * A list of "large edges" to enable octopus merges.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Documentation/technical/graph-format.txt | 88 ++++++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/technical/graph-format.txt
>
> diff --git a/Documentation/technical/graph-format.txt b/Documentation/technical/graph-format.txt
> new file mode 100644
> index 0000000000..a15e1036d7
> --- /dev/null
> +++ b/Documentation/technical/graph-format.txt
> @@ -0,0 +1,88 @@
> +Git commit graph format
> +=======================

Good that this is not saying "graph format" but is explicit that it
is about "commit".  Do the same for the previous steps.  Especially,
builtin/graph.c that does not have much to do with graph.c is not a
good way forward ;-)

I do like the fact that later parents of octopus merges are moved
out of way to make the majority of records fixed length, but I am
not sure if the "up to two parents are recorded in line" is truly
the best arrangement.  Aren't majority of commits single-parent,
thereby wasting 4 bytes almost always?

Will 32-bit stay to be enough for everybody?  Wouldn't it make sense
to at least define them to be indices into arrays (i.e. scaled to
element size), not "offsets", to recover a few lost bits?

What's the point of storing object id length?  If you do not
understand the object ID scheme, knowing only the length would not
do you much good anyway, no?  And if you know the hashing scheme
specified by Object ID version, you already know the length, no?
