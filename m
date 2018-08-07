Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18A22208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 03:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731923AbeHGF7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 01:59:43 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:40887 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeHGF7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 01:59:43 -0400
Received: by mail-yw1-f47.google.com with SMTP id z143-v6so4435803ywa.7
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 20:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7akjCVVkaZ3k4W5UuTe1LFzSaVUM+285g6DlN3DJ4UU=;
        b=iCQbSZ7zNiOcI+C3KW6pGPluG099BK5x80vsWGYpZsowFoNAlA16SK7ydUzhJO0agd
         ApBkdOCPXgxXxXHAPetgkwJUisv+MEKY9VQdaUCjvGwrGgsQA2ZLjzTNGAClz5DXOidN
         Yy1uX/cbKLhOJ7D4MOv1nnacOAjslgzh/0RtQR7azVlaxHaTzjwKlryLYtA6qHdrt0TD
         LOC971smU2FlrJ7C1j4uskWqYPqsOnfRBYE4mKK30qSV3oIOHLqrDLzWAkU1wvC+Olt0
         LMOh7Gtef56v18IhWJCy979RFxF55LXgFDN1ytl0nSrP5j4BmyXe73LaX+eU3JRJ/Pv2
         FN/A==
X-Gm-Message-State: AOUpUlHHuUy0O6DfgJ/UJmFvl2wNdAQhaKRVX+W/MU9tewYN//4TYXWY
        oEm5CIbCMtLzH+nuZjdfbKBWI2zj/2cTGmymNrc=
X-Google-Smtp-Source: AAOMgpeWLo2jSvtgqPwOI9IeXVRmjWAER3yJZXGQ00pyV4xuCGOLGBSvRH5TtIfcOj/yjB3/PvCpk2UbrSLNA3pOkG4=
X-Received: by 2002:a81:7bd4:: with SMTP id w203-v6mr9213433ywc.70.1533613645420;
 Mon, 06 Aug 2018 20:47:25 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqtvo7m8c0.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 6 Aug 2018 23:47:14 -0400
Message-ID: <CAPig+cRoxiPUhXFA2vdZWh0iLfitFeN5CbUDduJuRZ0JGw=fvA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #02; Mon, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 6, 2018 at 6:36 PM Junio C Hamano <gitster@pobox.com> wrote:
> * pw/rebase-i-author-script-fix (2018-08-02) 2 commits
>  - sequencer: fix quoting in write_author_script
>  - sequencer: handle errors in read_author_ident()
>  (this branch uses es/rebase-i-author-script-fix.)
>
>  Recent "git rebase -i" update started to write bogusly formatted
>  author-script, with a matching broken reading code.  These are
>  being fixed.
>
>  Undecided.
>  Is it the list consensus to favor this "with extra code, read the
>  script written by bad writer" approach?

Phillip's original "effectively one-liner" backward compatibility[1]
seemed a reasonable compromise[2] between the choices of no backward
compatibility and heavyweight backward compatibility of his
re-roll[3]. His reference[4] to an earlier "one-liner" backward
compatibility solution given similar circumstances bolstered the case
for his original approach.

[1]: https://public-inbox.org/git/20180731111532.9358-3-phillip.wood@talktalk.net/
[2]: https://public-inbox.org/git/455fafb5-3c92-4348-0c2c-0a4ab62cf2ce@talktalk.net/
[3]: https://public-inbox.org/git/20180802112002.720-3-phillip.wood@talktalk.net/
[4]: https://public-inbox.org/git/c7b8629d-7b93-2fbf-6793-0d566e86a229@talktalk.net/
