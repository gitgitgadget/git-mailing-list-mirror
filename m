Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F95A1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 20:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeA2U2p (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 15:28:45 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:55099 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754258AbeA2UQE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 15:16:04 -0500
Received: by mail-wm0-f53.google.com with SMTP id i186so16752863wmi.4
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowanthorpe.com; s=base;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pzBvPg5MJJu1JePbVDWPeT40RnvfhO5gm1w7Qhi0Yvk=;
        b=a0dEl41r99DEWpo6b3w+bQKQ0X0cZexakJDlv9DuyjZayM4LwQnMX59jzApMVUMUD2
         UdAFfDnL4XEJVnWwQKfCqq4D89scucHCGQ02XVfxdJ+9gGFQg4ePjJ3g+chfaZ73Q6st
         guku8NMsp0jKaePkhZj8zPS+Gnz9JRa4bi6zE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pzBvPg5MJJu1JePbVDWPeT40RnvfhO5gm1w7Qhi0Yvk=;
        b=tfF80nnhucVnYErVzNw4y4f6y2NNWQ7L0qvkuAAWhUanK6C3QBp7YGFYYoCgOHP8EY
         Q9I4mT/VJo9Vc0HsvU5k+uTOkLS0svnMX4kZIgeOV78Hbf7c/XjGPHZqTHvDvnE26YYR
         HgwDYp2S78hIUG8+G2pF0ddChYSuBKeoFx2M3B7/Dn3T0AQzsquHbWQSNrvMHRW8WIqY
         uOkHTiO6H4tSZQlGcim/Q/X/BMCO/lMyiNqf1LrEreslJHxzKCgXMauGWLGvKXPlfZ54
         F5wx3n3Sm7Zmz197oC8WKG1OhS27o6QnmD6pAr74hijgmn8Hf20ds8gAPU3vydjpsYHw
         czyw==
X-Gm-Message-State: AKwxytfDfFkWMZHywh4uBY86dsKVkhdFOe5/TkYZ3bPQ88Zwo96jpIPc
        8mcInhTJtenPrsiaMLAwp/B4jMWSTb3GC8B8JCSdLQ==
X-Google-Smtp-Source: AH8x227KdDGqv6konX2il3dmHpE8JSOshOg6JlxqiVWd+EASdOExLeH9s9jvD8t85tjkSq96cL3kpq0+RlIrgYfza10=
X-Received: by 10.80.143.162 with SMTP id y31mr47064360edy.1.1517256962783;
 Mon, 29 Jan 2018 12:16:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.176.69 with HTTP; Mon, 29 Jan 2018 12:15:22 -0800 (PST)
X-Originating-IP: [79.166.136.209]
In-Reply-To: <20180129171127.17097-1-szeder.dev@gmail.com>
References: <CACgDUr6XG+dZ+GJcf9+11Edf=q-=QLSkmgpGf=XmondaLaescA@mail.gmail.com>
 <20180129171127.17097-1-szeder.dev@gmail.com>
From:   Rowan Thorpe <rowan@rowanthorpe.com>
Date:   Mon, 29 Jan 2018 22:15:22 +0200
Message-ID: <CACgDUr6_LCMJaMcBBTfqTEH6nJfLKXRqu-HKMDanhqdLfHzbPA@mail.gmail.com>
Subject: Re: "git fast-import" crashes parsing output from "fossil export --git"
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29 January 2018 at 19:11, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrote=
:
> > ..[snip]..
> > Just commit some weird filenames, even one with a newline in it, to
> > test the code.
> > from :26779
> > M 100644 :427 :abc
> > M 100644 :10049 abc
> > def.txt
>
> A path like this must be quoted.  Quoting from 'git fast-import'
> manpage:
>
>   A <path> string must use UNIX-style directory separators (forward
>   slash /), may contain any byte other than LF, and must not start
>   with double quote (").
>
>   A path can use C-style string quoting; this is accepted in all
>   cases and mandatory if the filename starts with double quote or
>   contains LF. In C-style quoting, the complete name should be
>   surrounded with double quotes, and any LF, backslash, or double
>   quote characters must be escaped by preceding them with a backslash
>   (e.g., "path/with\n, \\ and \" in it").

Ah, thanks. I had skimmed that manpage quickly but obviously too
quickly and somehow missed that paragraph. I will post the bug-report
at Fossil, where it belongs. Sorry for the noise.
