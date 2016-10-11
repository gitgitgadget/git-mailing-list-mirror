Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B712F1F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 19:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751953AbcJKTIx (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 15:08:53 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34968 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbcJKTIv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 15:08:51 -0400
Received: by mail-oi0-f44.google.com with SMTP id d132so35288196oib.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 12:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=TpOpau1x/v81LPQLqy/9oRP2YwwoH4WAENpM0mbXo/k=;
        b=qtL1Gt0TKfPU14rYaPiXtaA6/+EST8azZfUrTbNJeV2VgsbRasK+T2qNK9v2vtW1Nw
         dSbsvRrMCgHuqRFhgPsCAiFQhFg0/aSnsw2d80pTyXxXuJjPU2yv/WVN6XavoiaRuPO3
         1xZIVwaPNABG8p1kdQvgyv9XX/qb9s8Nb9jJJ+QDpVOidj7RJrE0xYcI4QRWAw+Jli/f
         E6PBr41r5gkPBFbQZoiLVczegzO+xN8e35I952vzwnw84RqeQvCDSINiK7lU0yLk8iN8
         bpGSkb5j28qzjRnLYcWYFvawS2Tohy20DTFeVxXMHSvFMkSxq3zOe5zUQsZti+0t6O4R
         9BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=TpOpau1x/v81LPQLqy/9oRP2YwwoH4WAENpM0mbXo/k=;
        b=k2jEaChuSabB0boqyZkWcgqZHydLUV6AS0OscCmP9h8GeyJS8RndmvSfnWKfVxZ6QZ
         mCjPKjRjxX5ruN1fcbj0Xf9bQIm4k4m/tQ8UGQCIOiwPV6Z148CCpYOPKpa7FkkEATn3
         5dx6fMxyqktGD5Z9kOJXjRwvDrH331LNwWuVfH3Pazs8Ge32aalqVO5uOWw4v3E//742
         aAZyE7IAaYEHRJWfMqsnlDzmZnnSdKJs2+gfuGA8xih5ZGX3VmOu0iJRhbzeoIAafGLT
         fKHget+SwJ4gv+Vki09ATt2AERAxzcdlH3kHGl0LBto7D6A8qyl0kLmKXPoSCEUarvl1
         KXXg==
X-Gm-Message-State: AA6/9Rn0FXjniWgWfijI4PLkXlHUUt6n1A3jvW5LzjDD8hWgQtvCkqfXTE1bVhhjR8ATmuD5+nWn81Bzh2+bOg==
X-Received: by 10.157.43.124 with SMTP id f57mr2993943otd.83.1476212861057;
 Tue, 11 Oct 2016 12:07:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.21.198 with HTTP; Tue, 11 Oct 2016 12:07:40 -0700 (PDT)
In-Reply-To: <20161011190103.fovcwsze77hkew4t@sigill.intra.peff.net>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <20161011190103.fovcwsze77hkew4t@sigill.intra.peff.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Oct 2016 12:07:40 -0700
X-Google-Sender-Auth: c-HrJJhnDcDrVyrQqvEcvHaMpZI
Message-ID: <CA+55aFzw24pHGOYFBFVvTbU1Cudcr8zcPt_RvdQSxrKY5weCbQ@mail.gmail.com>
Subject: Re: Allow "git shortlog" to group by committer information
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 11, 2016 at 12:01 PM, Jeff King <peff@peff.net> wrote:
>
> My implementation is a little more complicated because it's also setting
> things up for grouping by trailers (so you can group by "signed-off-by",
> for example). I don't know if that's useful to your or not.

Hmm. Maybe in theory. But probably not in reality - it's just not
unique enough (ie there are generally multiple, and if you choose the
first/last, it should be the same as author/committer, so it doesn't
actually add anything).

There are possibly other things that *could* be grouped by and might be useful:

 - main subdirectory it touches (I've often wanted that)

 - rough size of diff or number of files it touches

but realistically both are painful enough that it probably doesn't
make sense to do in some low-level helper.

> I'm fine with this less invasive version, but a few suggestions:
>
>  - do you want to call it --group-by=committer (with --group-by=author
>    as the default), which could later extend naturally to other forms of
>    grouping?

Honestly, it's probably the more generic one, but especially for
one-off commands that aren't that common, it's a pain to write. When
testing it, I literally just used "-c" for that reason.

I wrote the patch because I've wanted this before, but it's a "once or
twice a merge window" thing for me, so ..

>  - you might want to steal the tests and documentation from my patch
>    (though obviously they would need tweaked to match your interface)

Heh. Yes.

          Linus
