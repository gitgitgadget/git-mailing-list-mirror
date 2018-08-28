Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CECCE1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 19:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeH1XVC (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 19:21:02 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38440 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbeH1XVC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 19:21:02 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so4042108ite.3
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/DlbiJlqvYUNtvruob8doyyz4eY70sFDsHsA/oQeUJI=;
        b=qQHZHOA5kW6hVrJfMGE++e5iegZYME6PF7wN5iHUhl5Mjt13irKWSSjFmFu0lqi14o
         /inN7WiM/iEv3LmSHQpZcCs0PP6XXT4Y7E8RRxzKWeR+oBninucqGB+IPy54F6sdLTX6
         uKPahjb59RUlzaYdA4n7Ro1jsuC/V6yG/VxgSF93B2gjW5lagGQQyvCRh2L3zyKQElgm
         rmmau3cSAyAaISre/Y+FX5++vGHeyb+dB1xAQMfYQKSdRD+FIks5zqKXuHAoQt6BMk3p
         BnXG+A8ZDRwHEE/qdrX5qJ0iYt9eZ8ytljjqFx0INxaWLik+fzKJU9Nist8ymLADyDkN
         0K+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/DlbiJlqvYUNtvruob8doyyz4eY70sFDsHsA/oQeUJI=;
        b=qAos7ViCUbqaMXF3cRi2DbWVcaxxn7ZSWsypVOyJ7iMMuEaAhMRV6rjMDYGFgksnbH
         y+Ps/jxjjdVq0h6Fg5lb4WfWdkpFg2JEAppfVTAISSq7pDIDuyecE7m6djBsCRJLcH6R
         s3NhmKk4ApkWFnJp11Kq7v66B382gVBO76akmY8jVRCtBfJnFcunaaPJFsYCR9S8fdiJ
         +RXqBQGOPF2MPAGWoD+KiuthKkEZUC65MCgUzpuiOXH2D+mLe0ODWSvX+T8QdSyvH7s7
         6suqTxpc59yJFuDM3KbS35jT78phpkZNH/vDktVokEAsxzAtrmvQ12aX7aS4nVS1GF3l
         k9Eg==
X-Gm-Message-State: APzg51DOd7g2K669hzCRnuK28tq0yl9Dq15dw2QdmPBpbuE/+uTxse9B
        7+0xTYrOEkmbnR1QfdTMQ7xnQ3kAZ2BkWV/Q0sysRw==
X-Google-Smtp-Source: ANB0VdbS7a9+B4JKQFk7PAnYEfQoGfkSOI3YraAodnki3ef5gvTlQRzBbpdxt+XEv9fuE1PvlUG4cMk4GbvcW3ylayE=
X-Received: by 2002:a24:144:: with SMTP id 65-v6mr2646529itk.62.1535484476746;
 Tue, 28 Aug 2018 12:27:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180826100314.5137-3-pclouds@gmail.com>
 <CAGZ79kbZRuzaoK=922b2JyfY9u8kOqm44KzKmbpWdWAkJ=SVDg@mail.gmail.com>
In-Reply-To: <CAGZ79kbZRuzaoK=922b2JyfY9u8kOqm44KzKmbpWdWAkJ=SVDg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 28 Aug 2018 21:27:30 +0200
Message-ID: <CACsJy8CYUcL+BNBYqX51vCZXahG6sO03=GJZCihCvh8MLn3KqQ@mail.gmail.com>
Subject: Re: [PATCH 02/21] read-cache.c: remove 'const' from index_has_changes()
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 27, 2018 at 8:37 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Sun, Aug 26, 2018 at 3:03 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
> >
> > This function calls do_diff_cache() which eventually needs to set this
> > "istate" to unpack_options->src_index (*). This is an unfornate fact
>
> unfortunate
>
> > diff --git a/diff.c b/diff.c
>
> Unlike I thought in the cover letter, this is just adding the repository =
all
> over the place and not adding new code, despite the size.
>
> A cursory read seems to make sense, though I'd nitpick on the
> choice of the variable name as I used to use 'r' for the repository
> struct. I am not saying that is better, but we could think if we want to
> strive for some consistency eventually. (for example most strbufs are
> named 'sb', as they are temporary helpers with no explicit naming
> required. So maybe we could strive to name all "repository pass throughs"
> to be "repo" or "r").

"r" it is! I forgot about it. But this is for local variable or
argument names only right? The field name (in diff_options for
example) should stay something more descriptive like repo, I think.
--=20
Duy
