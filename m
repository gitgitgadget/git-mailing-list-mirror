Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DD9E20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 18:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbeLGSqs (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Dec 2018 13:46:48 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33260 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbeLGSqr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Dec 2018 13:46:47 -0500
Received: by mail-ua1-f68.google.com with SMTP id t8so1764175uap.0
        for <git@vger.kernel.org>; Fri, 07 Dec 2018 10:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rGZr2Aj8gp6rjDminSIwiR45ZjRoyzk/E8BU2dFQxcM=;
        b=uYsKCIH/zJ/98FBHXdd5zMCtJBHaFb55KtitZ2UlgE85DoR3x2dDpclVn7pXEx6F2d
         fMROQsNCy7XHUEdeRHz4vxy9Y5F1DOEZblxwqj5/uSASrL/kgs3PVH6hTGLkQnQmOXx/
         w8Bu6XY7WxkQ56GOA8V7ZwU8z6X9462i9ME9UoVy5B2T7853Q6l5R8JeI8LTC53gb5Rf
         yMdX5BAW2b797b3t8XVoFaadaIJEOxns+Kq9yw2SHVjoAaXzRH6N3OHK6rdJsDSN03E1
         xDLEuE6Hinn507tMXG6+Y+9RCJhQ8P7gCTWQhQFmMADs1y2Q5Bn7Hv/n60916Z7E9oUd
         5LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rGZr2Aj8gp6rjDminSIwiR45ZjRoyzk/E8BU2dFQxcM=;
        b=a5mThMTUMpVuLyQlYMjq1Al7f7zQu3JaCJ76BWrz7LS25VM9NJv4n4vc15tI0BHS6H
         pGo98JIiiRWGdLqyB09gG3PtjRwWROZyeeUw3UhT63u8uBP7EOifhrn43lF699Cfu6DO
         AQ4gpvTsWjj/opBRmDTYpqDFJemRYRA4CVYbIYWsHTyI6nX3yvVulLK5B8RHMz7cz6Jr
         yQtvfx1TnzxEhrVl8j/gfkFcmYqLkjcNlsq+lTXGvp0YKT4RalZ3ZAXmMXEdIIvs0HkC
         cfhXwim8Y2Lqq28mEA4AUgZvcPnOoC9In+NjKiYHiFhSPBAyymh2wCFeAe7KJWDw1rdv
         ZZIQ==
X-Gm-Message-State: AA+aEWahDguv22/FtSi6zdELrQN5PPa/q0coca8c8ABIJE0nJWm0jhrM
        1tU/qFCPyhLmlXgby3hweOkTYDZyquVF4tIn48g=
X-Google-Smtp-Source: AFSGD/WLi6+C3Rcp8V7YSBtj9dnoeKds+OmCjqFTr8WOZWt7nLied/fU+HYy+qlYMjISDS8RGaO8AfObA5uYwg+rnOc=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr1484730ual.20.1544208405314;
 Fri, 07 Dec 2018 10:46:45 -0800 (PST)
MIME-Version: 1.0
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
 <20181204231709.13824-1-newren@gmail.com> <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
 <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
 <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org> <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
 <CABPp-BHzESYnQy5JwXvtXyLHgHR9u3UNVOZF2gU1m_uTMGkyfg@mail.gmail.com>
 <bd67cd33-dbe8-03a0-e760-c7bb23854084@kdbg.org> <xmqqmupjbnhq.fsf@gitster-ct.c.googlers.com>
 <66479695-d17e-c9cb-4cb7-8c74e3855032@kdbg.org>
In-Reply-To: <66479695-d17e-c9cb-4cb7-8c74e3855032@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 7 Dec 2018 10:46:34 -0800
Message-ID: <CABPp-BGSmyAb_d52TLS=7oQyMYxt=EYjNdDofY4nzLd9CYvwuQ@mail.gmail.com>
Subject: Re: [PATCH] git-rebase.txt: update note about directory rename
 detection and am
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 7, 2018 at 9:51 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> In commit 6aba117d5cf7 ("am: avoid directory rename detection when
> calling recursive merge machinery", 2018-08-29), the git-rebase manpage
> probably should have also been updated to note the stronger
> incompatibility between git-am and directory rename detection.  Update
> it now.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>   Documentation/git-rebase.txt | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 41631df6e4..7bea21e8e3 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -569,8 +569,9 @@ it to keep commits that started empty.
>   Directory rename detection
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -The merge and interactive backends work fine with
> -directory rename detection.  The am backend sometimes does not.
> +Directory rename heuristics are enabled in the merge and interactive
> +backends.  Due to the lack of accurate tree information, directory
> +rename detection is disabled in the am backend.
>
>   include::merge-strategies.txt[]

I was intending to send this out the past couple days, was just kinda
busy.  Thanks for handling it for me.
