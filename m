Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE9F82055E
	for <e@80x24.org>; Wed, 25 Oct 2017 20:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751921AbdJYUKK (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 16:10:10 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:46691 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbdJYUKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 16:10:09 -0400
Received: by mail-qk0-f182.google.com with SMTP id k123so1643301qke.3
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=X1F9UN9zhMkP66dRIRunejt2uUvlIDSrDYQCk0KahG8=;
        b=L5rt31E+K58VJ0Yv4GZq8lHxXvD0BDDmEOGSeAe8XfEShpoPrd0FjTOxDfgansjFaG
         0RGCiV3VCPTiO6at/4z4gq3eG8+v3W2t12fdO4D0zLNh7XoBF2eZoelBZgHDMKoo3s6r
         a+Kh0x1hAc8o4mbWaNr9K7pI7Hvn0Na9sEsXUsfRRB40R3rOf+C7BfuMW3BOGNm6hmu3
         vBlii7SjkJa9hlmTV7yJy87IPQSwu2xbSJ5p27v5a5y3TDndcunw1Of68zJSKvqf0jy9
         PKdCUyTpcsaVAenPk5tSHubLgryY7leXZJVUZFoeavGqWm5HkbY2KbvNncRV9/I+FDT0
         rtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=X1F9UN9zhMkP66dRIRunejt2uUvlIDSrDYQCk0KahG8=;
        b=bho0FomP1mgAj5ssHTsuyA/J2g/CNjnLXyoGe87XQNG6yq5HYkmU1hzrT+TBnVY7As
         fR4HqPgJWDVF15ERe7xOUMFVAxoUvbMsW/APYGqWA2JSx04AR9ywkJFgH9wCZGFUPImZ
         gMpKjjd5wCcSvPf77ZGNU+IQd97adlgAWtSRw8OSGVB8lzt5ao9ZqBDMo/PBQjWAvZOm
         YagOL89aDafh+qXmmfMl8wFGmRbRX8AUjGLSHnvzy6vH9PS56q5oZzUbkP2jZIqRBdY3
         agtfI25q3qMY0YpYOnz0g3wohkLKgJ3TaDIUbYPttxIpy4gYYXOpF0vLrhm3jJgYRj+V
         t/DQ==
X-Gm-Message-State: AMCzsaV0D1lyM/2vGfFRTVlw/n4+2Cv0rol8l1WajIJFYOXhhyIsMjEx
        qppqRmZk5H5o8b9lPkdZfkt1S097v3zssS/G50s=
X-Google-Smtp-Source: ABhQp+S5PUeGCHmSGwu/dHcv5LY+bezf8C30Tq1NYI36NAwFDgRQ18P4eK6knkAR9JnLw0/Z2Reg0UbFuYMbOT4HPAk=
X-Received: by 10.233.222.134 with SMTP id s128mr4561378qkf.14.1508962208942;
 Wed, 25 Oct 2017 13:10:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Wed, 25 Oct 2017 13:10:08 -0700 (PDT)
In-Reply-To: <cover.1508924577.git.mhagger@alum.mit.edu>
References: <cover.1508924577.git.mhagger@alum.mit.edu>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 25 Oct 2017 16:10:08 -0400
X-Google-Sender-Auth: rCBCnQJO4GDh45Iy9QV0vMmKUl0
Message-ID: <CAPig+cSrjiyGUm0n5dvowjNYZMSGvb+SZJ=haTsxXi9NcThA7A@mail.gmail.com>
Subject: Re: [PATCH 0/2] Avoid rewriting "packed-refs" unnecessarily
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 5:53 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Since commit dc39e09942 (files_ref_store: use a transaction to update
> packed refs, 2017-09-08), we've been rewriting the `packed-refs` file
> unnecessarily when deleting a loose reference that has no packed
> counterpart. Add some tests demonstrating this problem, then fix it by
> teaching `files_backend` to see whether any references being deleted
> have packed versions, and if not, skipping the packed_refs
> transaction.
>
> This is a mild regression since 2.14, which avoided rewriting the
> `packed-refs` file in these cases [...]

Should the above information (that this fixes a regression) be
mentioned in the commit message of at least one of the patches
(probably 2/2)? Without such context, it may not be clear to someone
later reading those commit message -- someone who wasn't following
this email discussion -- that this behavior had been lost and is now
being restored.
