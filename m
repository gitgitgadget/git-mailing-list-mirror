Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 286841F404
	for <e@80x24.org>; Mon, 11 Dec 2017 19:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbdLKTTT (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 14:19:19 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:46139 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751965AbdLKTTS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 14:19:18 -0500
Received: by mail-it0-f46.google.com with SMTP id t1so18483655ite.5
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 11:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tR6Bcv+T9i2kjQ5F+EbJCpNZfUi73pQhek/I43fGDWA=;
        b=wJV4f8BOX9zqWWHu5aj8WZI6gyw8jscGHNOlCciZdQ+4I+pQ1cTi11l+MhBfnkaij1
         uJUi5+sWOpVTq5teKSPwwh43k2AOfV6/sJti++dJdX1fgT65sMZd53kKT3YJJSbZn8Iw
         rLwd4KC2YCw4nCAoR3iji5vTnqp3NvC8P/d9HcVkO053yTbSjE4CBxE0V/jauvwXtwhc
         tlwzD6O065qRdwLUl4+EcwkT0bAhAqtcoQT2No/uyhk1EcvbB7IuWeXFBZ6U24Q8aSkq
         diXUeLidkgFvek0pscZEQbM8f1adkUIr24Fn7rr+bbwIW6YYxdkVa2uUPv0eZA4ZbP0i
         RjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tR6Bcv+T9i2kjQ5F+EbJCpNZfUi73pQhek/I43fGDWA=;
        b=mhfzRMbI/uyZNy/0JJLfVYBpRacPmLMnDg5Z3aTDvJtM+7os5ve8FO2NgZcCHDrivf
         9R8pgwMg8MU/CngCbMDmclXSIBJjA1NDxRyTCnkFtiZRu2sYXZ7t8ZdAgkiFbfFUOPdw
         3UiLlLCkM4YomFe9TlH5a4E+mhN8WQqBJPsH6TH/x1jCSdkmbxbMP6UMffRKCPJY4Aio
         75EoxQYwIO5POA20BGRbXdGDBpcmlc0f/YN9nyePVhLIHSgI+5LNyKoFg5TaS7rjKS1p
         gRHSXq5ifRqtwDGv4TN1U8qJ8uHyOIlmuVjgqBOLG//cXIr/cv3LFYjQDyXae0rMix5m
         t/NA==
X-Gm-Message-State: AKGB3mJ8O4k+FX9m5PMsbweIHubLC2hiKznDA/m0horFx8u6s7251Net
        dC/USoryml8o6mLClBYxI42yrZZdwnM=
X-Google-Smtp-Source: ACJfBosAqYRx8TOB7oiZ2H7MiTa9LdElAXrL1AoeFyOUK/GkfXju9pID7Exuh125OOyi0UjycjVhyA==
X-Received: by 10.36.7.80 with SMTP id f77mr2352980itf.77.1513019957948;
        Mon, 11 Dec 2017 11:19:17 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:909e:f3a:a55a:80a])
        by smtp.gmail.com with ESMTPSA id 30sm6778804iop.47.2017.12.11.11.19.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 11:19:17 -0800 (PST)
Date:   Mon, 11 Dec 2017 11:19:16 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v7 00/16] Parial clone part 3: clone, fetch, fetch-pack,
 upload-pack, and tests
Message-Id: <20171211111916.b3ea2deacba67f6e8416d285@google.com>
In-Reply-To: <20171208223010.GF140529@google.com>
References: <20171208155851.855-1-git@jeffhostetler.com>
        <20171208223010.GF140529@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 8 Dec 2017 14:30:10 -0800
Brandon Williams <bmwill@google.com> wrote:

> I just finished reading through parts 1-3.  Overall I like the series.
> There are a few point's that I'm not a big fan of but i wasn't able to
> come up with a better alternative.  One of these being the need for a
> global variable to tell the fetch-object logic to not go to the server
> to try and fetch a missing object.

I didn't really like that approach too but I went with that because,
like you, I couldn't come up with a better one. The main issue is that
too many functions (e.g. parse_commit() in commit.c) indirectly read
objects, and I couldn't find a better way to control them all. Ideally,
we should have a "struct object_store" (or maybe "struct repository"
could do this too) on which we can set "fetch_if_missing", and have all
object-reading functions take a pointer to this struct. Or completely
separate the object-reading and object-parsing code (e.g. commit.c
should not be able to read objects at all). Or both.

Any of these would be major undertakings, though, and there are good
reasons for why the same function does the reading and parsing (for
example, parse_commit() does not perform any reading if the object has
been already parsed).

> One other thing i noticed was it looks like when you discover that you
> are missing a blob you you'll try to fault it in from the server without
> first checking its an object the server would even have.  Shouldn't you
> first do a check to verify that the object in question is a promised
> object before you go out to contact the server to request it?  You may
> have already ruled this out for some reason I'm not aware of (maybe its
> too costly to compute?).

It is quite costly to compute - in the worst case, we would need to read
every object in every promisor packfile of one or more certain types
(e.g. if we know that we're fetching a blob, we need to read every tree)
to find out if the object we want is a promisor object.

Such a check would be better at surfacing mistakes (e.g. the user giving
the wrong SHA-1) early, but beyond that, I don't think that having the
check is very important. Consider these two very common situations:

 (1) Fetching a single branch by its tip's SHA-1. A naive implementation
     will first check if we have that SHA-1, which triggers the dynamic
     fetch (since it is an object read), and assuming success, notice
     that we indeed have that tip, and not fetch anything else. The
     check you describe will avoid this situation.
 (2) Dynamically fetching a missing blob by its SHA-1. A naive
     implementation will first check if we have that SHA-1, which
     triggers the dynamic fetch, and that fetch will first check if we
     have that SHA-1, and so on (thus, an infinite loop). The check you
     describe will not avoid that situation.

The check solves (1), but we still need a solution to (2) - I used
"fetch_if_missing", as discussed in your previous question and my answer
to that. A solution to (2) is usually also a solution to (1), so the
check wouldn't help much here.
