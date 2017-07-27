Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0E451F89D
	for <e@80x24.org>; Thu, 27 Jul 2017 11:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdG0LUP (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 07:20:15 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:35526 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbdG0LUO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 07:20:14 -0400
Received: by mail-ua0-f177.google.com with SMTP id d29so128472659uai.2
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 04:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=El3vrSMss2bd39fJEFFLJUSohnCHX7sEEhZeuom4v3U=;
        b=Ii65IHNTVpsD2ZHfuK6hnL1FbB40Shz0u1A2kzR/F8JRFw+jGpyFrbZtXTollU+X/o
         DGnyjr/pC8VbphvNkn75JtAGIxi/u8bvrXctxyPzAemjxJc4G80I1jK0RTZlxJ6mkQVN
         3e7771ALaHHjSMTTODTinhk4A8EXlt5T3Ziavu6jt2ZPKZby5drp9uKPLbFuFpli+XEm
         /x1SxU2ggy9wFjkYD+v4ycSpRe+/2lDCXuxPirZwW98EkApQpRANFju/KdQ0kcATNvmq
         aRZzIK1C6h5ie6za5RqyyeQsInxgdhPm5BXj7V5yFwz+XeZmrpY7HIOzecfnvBMUKRI2
         Ur/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=El3vrSMss2bd39fJEFFLJUSohnCHX7sEEhZeuom4v3U=;
        b=fuuXXB5MtRy733pJUl1Ke7Fcubk0iLwyJIjE1GJlsHN56PxMHUhvxfCCCRgUqCidBo
         bpe5PHluaSyxDUqS7CL+eTus9/Fuzw1o1H4Sfjxei3su2nY4Bb/Pnf6heNHZIHiZlbR9
         BbgSTAFxrBl+V6nCRxnPNVR000vA8N4FlIAFB5mhUr08ChrIcKZN4yEpStT29wH/XMgk
         8QD05hCLhNrk19P6uGmU4xg/FWPrgYTVPKrTuH9BR4oD/GwtphOjqmkHBuXBDbH8rEGC
         eS/ISHGnR+RbY7rgcUquj3xQGqHE6TkC+9kHeJjmz4bRxwmrzY21cXDOQBiogEVwwCgV
         IKyA==
X-Gm-Message-State: AIVw112XSdh+xfDMMc+kgR9GYKag6BLuko+B6jeuyIGj37MgNgXqR8f/
        uCbVW29/AstAmUxf15dQSm6QqiUNqw==
X-Received: by 10.31.146.138 with SMTP id u132mr650030vkd.166.1501154413301;
 Thu, 27 Jul 2017 04:20:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.42.7 with HTTP; Thu, 27 Jul 2017 04:20:12 -0700 (PDT)
In-Reply-To: <xmqq4lu1ej0d.fsf@gitster.mtv.corp.google.com>
References: <CAEBDL5URsbMazLBy-kWLJzECTEQ=61DN07xuu5NaO2Hw6r=j+w@mail.gmail.com>
 <1E42613B0CD743C6ADA24B9F1B43F0F9@PhilipOakley> <CAEBDL5X3wr=4A+W_sQzSE9BazoxoS2bwcOBZV5Jw=WCWZHAi6A@mail.gmail.com>
 <xmqq4lu1ej0d.fsf@gitster.mtv.corp.google.com>
From:   John Szakmeister <john@szakmeister.net>
Date:   Thu, 27 Jul 2017 07:20:12 -0400
X-Google-Sender-Auth: eMFT1UCsIfYs0KIOTQvRyoKLJ8M
Message-ID: <CAEBDL5U=pcqwzeQstiBBJpXngXeB4xTfKb7mos68kRAeumc5Rg@mail.gmail.com>
Subject: Re: Expected behavior of "git check-ignore"...
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 3:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> I am reasonably sure that the command started its life as a pure
> debugging aid.
>
> The treatment of the negation _might_ impose conflicting goals to
> its purpose as a debugging aid---a user who debugs his .gitignore
> file would want to know what causes a thing that wants to be ignored
> is not or vice versa, and use of the exit status to indicate if it
> is ignored may not mesh well with its goal as a debugging aid, but I
> didn't think about the potential issues deeply myself while writing
> this response.  As you mentioned, use of (or not using) "-v" could
> be used as a sign to see which behaviour the end-user expects, I
> guess.

Is there another way of checking to see if a file is ignored?  If so,
maybe we could suggest that instead.  Perhaps using `git status
--porcelain --ignored` and examining the output?  I'm not sure how
well that would work with directories.

Thanks for the insight Junio.  I'm going to let the exit status thing
drop for now.  You don't seem like it's a good thing to do, and I'm
not particularly fond of having it behave two different ways based on
`-v` being present.

-John
