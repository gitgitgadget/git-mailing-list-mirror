Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27ABE201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 18:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751275AbdBXS6c (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 13:58:32 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36875 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbdBXS6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 13:58:30 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so32864961ith.0
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 10:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xbjwIMBcN6FR01RtHmFLw1dKwgUSLTHjEmevB7rpFiQ=;
        b=km2dYN/HHAkT488zvcxB+dX71YGRG8WWAIyH7KAo0W02YaWnc7HrJsWDOvWQMpTgTE
         Ovsz7eKwud/6wGYh5ojpl99SdiQ0sWx1NXwQDgO67jspaj0hT4tZoaiJOAJwpR6WJGcj
         RwdnlHWckw2+0luWtj9/Gs2T0ufmh6FjBbYUUzHVgQspqfilNAoT+xYN13BH+mNpagA4
         yD9/P5snhoEyDt4BzScd3pXjXEWY/8GNorC8f+BqOquWoAVMxQ0dXLhxaAE4C6GMik4f
         Pvrb6d7LsG8g5qc7dkoNk/GnfEjm3GqTlDTw75aLAfwKXI8q3mMOg/If5fd4bIfaGr21
         6WbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xbjwIMBcN6FR01RtHmFLw1dKwgUSLTHjEmevB7rpFiQ=;
        b=KxhkfZUu6yDestrKSVuGwQ61h6FpiBiwWQbzXJJ3B6TCelLmS0Jwyxe6a2IiKnUBc+
         VMG1+0WGXr5RZcbB56g/c3sMAolYOI5Se8m0ixM13Gi4iO0mIOKuJJdSwup7MW2KdUQS
         Ixm9wPJH4nUfd2m7nU0N63QFKmqyNxrwLN5savnZXbPStAyggXkI5fcIzX/QUr1aOUdr
         GjzEChfWTotMioUARDHpmSAm6kXia0OUzoG0LP0S7zN8+sDRBv7Tg0YMd06ragwl0V8g
         W52B68u3k5MFh3hSUOLq1H6nBG5PRBygpYSOcdXfy75Kk47D1Ep9ySQeWpWjbl5zxUWH
         qadA==
X-Gm-Message-State: AMke39mPJaUxi1apes2IhWij9EXrr8daQgoZpophVtvwYob1bp8vSnU8Le7lxhVjfXNaYC90w1C9ADxAyTRqyCMc
X-Received: by 10.107.47.162 with SMTP id v34mr3707944iov.52.1487962709369;
 Fri, 24 Feb 2017 10:58:29 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.33.148 with HTTP; Fri, 24 Feb 2017 10:58:28 -0800 (PST)
In-Reply-To: <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net> <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com> <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
 <xmqqk28f4fti.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 24 Feb 2017 10:58:28 -0800
Message-ID: <CAGZ79kaZWe-8pMZnQv7uZtr8wXWawFeJjUa68-b0oa4yFo-HcA@mail.gmail.com>
Subject: Re: SHA1 collisions found
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Lang <david@lang.hm>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 10:14 AM, Junio C Hamano <gitster@pobox.com> wrote:

> you are inviting people to start using
>
>     md5,54ddf8d47340e048166c45f439ce65fd
>
> as object names.

which might even be okay for specific subsets of operations.
(e.g. all local work including staging things, making local "fixup" commits)

The addressing scheme should not be too hardcoded, we should rather
treat it similar to the cipher schemes in pgp. The additional complexity that
we have is the longevity of existence of things, though.
