Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 156AB1F404
	for <e@80x24.org>; Mon,  5 Mar 2018 00:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeCEAwe (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Mar 2018 19:52:34 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:40889 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752067AbeCEAwd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Mar 2018 19:52:33 -0500
Received: by mail-qt0-f194.google.com with SMTP id y6so18504343qtm.7
        for <git@vger.kernel.org>; Sun, 04 Mar 2018 16:52:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Sv7DDrsuDyZdtUCpxRIk2NRb/oorG5nkwULwDG6G5wg=;
        b=lvBW41VHYCzrKPLTZ8OgmQY//mBpnn7W4UuHp8eXIBjAYa4atm3hQo3ENUnUr8xGvj
         IUoaFj6rKgpkDQ3dlsA0AesGG6qMmvHqMk4tWHSDD0VZENNtDa3282V681vbyEi+cyIo
         /lNIoULAM7JCLw3pLt1IdcS3yhpNSDzKd3tIW4Jt3xHkmXT6CjbgUWk4686WD3QBmQ6W
         3o+4/AY+66fDB5QGaA3+0kRw7dknLC8uxz/RIeetLKnSW4tRrnlbspEtFyB4kEKvQPuA
         a5cwJoftK+jX6YRUY8GcMp6Q8w941GikS4oWivAxA2Xa7qegtO59FuuAuP/IIHVcEOEm
         gVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Sv7DDrsuDyZdtUCpxRIk2NRb/oorG5nkwULwDG6G5wg=;
        b=A+b338s9wOqkerFHjf4OyY0jT4m8BjePTdTEDO5N+NaKjwSjShwHJeY8sAXa0CIfNp
         CN/thR/tam0RGvH1PGcSZSuWC5LchJdLk8s9xBuq6SVwk64Whj2lPl5QMTS2rPOyglge
         fMF58uV5fCNwcQWbmyaE33L28z4JrHxO1Khbg0wp61Ppksm2tGkvQb0Dw4eSPtmIe5v6
         Ws3qIpCcP9NzJTMP84QAe7yNE0Iaz0zXHB4abgM8tIFWSvAOoY+CtdY/46YAC7HlAVoD
         OXB7RKK2ETJsPyMjzEUhnrpM+KyM+fU6xyghiiMbHksphYj5DButtrDWAdbaCpSO2+d+
         1MFg==
X-Gm-Message-State: AElRT7FbbAAmeZH/f/RgEAD08qIj3CfLVYylls7pgsGg9O+ad0uzc+VN
        JFLPJa8NsOR1LrIYVUYJ4xwCn7SAbQE6yq6q+w4=
X-Google-Smtp-Source: AG47ELtaqxFIpn6y681Vxdf1D/UHaY2KPu0KGlLXtJDoUOlP/IDz23GTrkqxHycU0r0/VFmEK1UDMDsnFaqk1H35cVM=
X-Received: by 10.200.28.8 with SMTP id a8mr12440764qtk.280.1520211152808;
 Sun, 04 Mar 2018 16:52:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.142.14 with HTTP; Sun, 4 Mar 2018 16:52:32 -0800 (PST)
In-Reply-To: <20180304112237.19254-1-asheiduk@gmail.com>
References: <20180304112237.19254-1-asheiduk@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 4 Mar 2018 19:52:32 -0500
X-Google-Sender-Auth: Ks3mkNxlU5CZj4RZfgcDtwYlHUI
Message-ID: <CAPig+cQARx4eZFHyRpikHJYaz42NKq18fjt-=KYOX2GddDPNDA@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-svn: search --authors-prog in PATH too
To:     Andreas Heiduk <asheiduk@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Eric Wong <e@80x24.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 4, 2018 at 6:22 AM, Andreas Heiduk <asheiduk@gmail.com> wrote:
> In 36db1eddf9 ("git-svn: add --authors-prog option", 2009-05-14) the path
> to authors-prog was made absolute because git-svn changes the current
> directoy in some situations. This makes sense if the program is part of

s/directoy/directory/

> the repository but prevents searching via $PATH.
>
> The old behaviour is still retained, but if the file does not exists, then
> authors-prog is search in $PATH as any other command.

s/search/searched for/

> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
