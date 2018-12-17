Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FC7E1F405
	for <e@80x24.org>; Mon, 17 Dec 2018 00:14:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731152AbeLQAOt (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 19:14:49 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:40776 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730788AbeLQAOt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 19:14:49 -0500
Received: by mail-pl1-f180.google.com with SMTP id u18so5250542plq.7
        for <git@vger.kernel.org>; Sun, 16 Dec 2018 16:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j1tQnjhrFtHCJsszoehHBkjXh6mFfSdtK5PZNg3OnkU=;
        b=tV8ToNQPOJTk4VcSKzBRBKLdKpTS1E/1UIBK63XKPEUcBEuxnlcG5Q3i9rkkAcRQPp
         vYh33MjSO7RGDcN2RAiiza2vFVKo8LpunKZXNQDc1Px1XbX11m/E7a/zxALiXhuEf9sS
         t+mJ6qK8gfwAyNzxKGQlaWwZ5I9Ko5wBQ2IGU8X9cj8zni0qHkWVf+wCaqWqTQPkGWPT
         Xm/2MjjAMjX8bli8WqVHW0ko52mteFXUKLj3jZ+Kkf/flNXyME7DJ5u/7hRImeYiGfd1
         q7NNQ3f/tLQF+WcOBN7Lhs0+PvX0mASSlUjlkaiyrcp0M4UbkL28vTGErPzSbNN4M3ZO
         I9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j1tQnjhrFtHCJsszoehHBkjXh6mFfSdtK5PZNg3OnkU=;
        b=foFnnFrOSn1XS9yOPW2m3hH4gMpjBegBWx0Lz2iIWQnb510eqB+wWoXMJwEei8XfUY
         Jlss366F8VULRtoPBcXTknb1FqvaNa07u2yBUPNqG2zaR+c53ZWwWmMH6J0sF5/5Dnoi
         ieHXT0b9g6o4ZBRDtouWIVVjr0z3Dil+pn0mssaOfhI2mJdF09Z2Crbjv8FyHOZSJuXO
         X0ye5R0BFXDtyoVZmmcQCQIPouCaeUbbmbkQqbIlmSQl8RwIERF9FDZT4Rn7AoOmmet/
         QYNpN8BudU8rEKvzRK9N/tMsqmvT4DXJsDKxKggkWB1SUEkOWPQXEvbH72t11e0aKcQN
         4U4w==
X-Gm-Message-State: AA+aEWYDaVExSdYUKNC55jylOj05dlvtAc+5nZNlx3SwT2IssBdDzXu+
        VEFlHbTap7/MaIh1DA2rA8s=
X-Google-Smtp-Source: AFSGD/WSd8VJVv0ym3RJeqERHjsOvZ0T4T+qgJYqUPgophXdm8QccZctRKFqaduKKHKHmsteABlhpA==
X-Received: by 2002:a17:902:42e4:: with SMTP id h91mr11022867pld.18.1545005688333;
        Sun, 16 Dec 2018 16:14:48 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id p77sm20104741pfi.85.2018.12.16.16.14.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 16 Dec 2018 16:14:47 -0800 (PST)
Date:   Sun, 16 Dec 2018 16:14:46 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Farhan Khan <khanzf@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: pack file object size question
Message-ID: <20181217001446.GL75890@google.com>
References: <CAFd4kYCHefqRsiFK=K7MHp=MTwOBXB5979WobEm3w1J5q1bZ0w@mail.gmail.com>
 <20181216221457.GH75890@google.com>
 <CAFd4kYAaMLvOhR_XvwoQ=y4c6CZC=+-q5BmAXO79qTKOLNFtZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd4kYAaMLvOhR_XvwoQ=y4c6CZC=+-q5BmAXO79qTKOLNFtZg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Farhan Khan wrote:
>> Farhan Khan wrote:

>>> I am having trouble figuring out the boundary between two objects in
>>> the pack file.
[...]
>              I think the issue is, the compressed object has a fixed
> size and git inflates it, then moves on to the next object. I am
> trying to figure out how where it identifies the size of the object.

Do you mean the compressed size or uncompressed size?

It sounds to me like pack-format.txt needs to do a better job of
distinguishing the two.  Under "Pack file entry", I see

| Pack file entry: <+
|
|    packed object header:
|	1-byte size extension bit (MSB)
|	       type (next 3 bit)
|	       size0 (lower 4-bit)
|	n-byte sizeN (as long as MSB is set, each 7-bit)
|		size0..sizeN form 4+7+7+..+7 bit integer, size0
|		is the least significant part, and sizeN is the
|		most significant part.
|    packed object data:
|	If it is not DELTA, then deflated bytes (the size above
|		is the size before compression).
|	If it is REF_DELTA, then
|	  20-byte base object name SHA-1 (the size above is the
|		size of the delta data that follows).
|	  delta data, deflated.
|	If it is OFS_DELTA, then
|	  n-byte offset (see below) interpreted as a negative
|		offset from the type-byte of the header of the
|		ofs-delta entry (the size above is the size of
|		the delta data that follows).
|	  delta data, deflated.

which suggests that the "length" field is something between the two:
it is the size of the inflated form of the packed object data, before
resolving deltas.  It's useful for allocating a buffer to inflate
into.

The zlib container format (https://tools.ietf.org/html/rfc1950) does
not contain size information, so I believe you'll have to use a
"deflate" (https://tools.ietf.org/html/rfc1951) decoder such as zlib
to find the end of the deflated bytes.

In index-pack, you need to inflate the objects anyway.  In random
lookups, the idx file tells you where to look, so it doesn't come up
there, either.  So this would only be expected to come up if you are
doing a sort of partial index-pack that wants to skip some objects.

Thanks and hope that helps,
Jonathan
