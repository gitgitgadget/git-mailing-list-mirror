Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF8CB1F404
	for <e@80x24.org>; Tue, 17 Apr 2018 17:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeDQRVr (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 13:21:47 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:52541 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752503AbeDQRVp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 13:21:45 -0400
Received: by mail-it0-f45.google.com with SMTP id f6-v6so16861079ita.2
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 10:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HnaFvuw8gM2bXPDLkRhlgXHtEvSSBjbG6opRi6BBud8=;
        b=f1QR0aEzS1H3+bQ+DawA08V6d5dQPBIggkXB7439nlhIwRncCRfHh31RxJcZYYoLd+
         L6b4uboQLYveG5xTw/M35FxXhaKST/KjPqXZ/ChTCV7qVyyN/HJM3BK2KRVquGXgI4/j
         DGm6ek1gvnd3SCpMuqKUbQDL+Ae6k5l7KAAddjdI7+LVrn1grC1+1B+kgNanbWmIeFtk
         9noTDdtfTNWwQIt+F1W7KIVbWVkbzGnn/VSaQnGFpjpyv4kYv5nKR4sVn5vRyva4fD8i
         PyfcevelOuaUSCLzgDr6VBnL8ROS3/1UlJ4Ot5S1VmBeBzLx4IqZHhr14UuKHNm9SsIJ
         N2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HnaFvuw8gM2bXPDLkRhlgXHtEvSSBjbG6opRi6BBud8=;
        b=ZoWfCO8Ehy9uqxsUNxlo3G8TjIBcVP1oR1LJAEGLf/9h4GqZTgJgRN6w8LXgneLkKk
         /OEfDmE6q4UJOpGE8TLhGHiOW12F30na15cw8B08wKaY7jioRcHuhceKh0dHqZYU/WH6
         sLc/ynaLMsTxMggG27oZzZDCQw98u+X+3PWn0TSFI/a/ifYyydALWbt2gnQrKmFF85Qm
         3VEKqxVZZUeSy3C96Z0McC+HqfHcR/XsFaoifyGBsu8z1rQF/INPECpxK15TwtKZW5QA
         tD3L12FQA5oxa3WQOXISRAqFyO0AvBLCAazcg/nAW007BPUEd7TPvwWj2fA4iCweiQez
         ysag==
X-Gm-Message-State: ALQs6tCdpAV9Vn6Z8dZO5gVqtTc42hsUhOiT7niLHCjQnH/TMezO6Dq8
        B7rYOp0Z7gcRidc0+QPSH1avLnpZnUVadf7dwbeWLQ==
X-Google-Smtp-Source: AIpwx4+DLS/IvMshbiszZbJQpYgoJ/4nbUyCa6/i8h8jn8IO/ZaA0RNc2h/Tt1rpP/QpXDb5KDi1hW99ir9kmdV0g9g=
X-Received: by 2002:a24:230a:: with SMTP id u10-v6mr2035204itu.49.1523985703247;
 Tue, 17 Apr 2018 10:21:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:a78a:0:0:0:0:0 with HTTP; Tue, 17 Apr 2018 10:21:02
 -0700 (PDT)
In-Reply-To: <cover.1523981210.git.amazo@checkvideo.com>
References: <CAJJpmi-pLb4Qcka5aLKXA8B1VOZFFF+OAQ0fgUq9YviobRpYGg@mail.gmail.com>
 <cover.1523981210.git.amazo@checkvideo.com>
From:   Thandesha VK <thanvk@gmail.com>
Date:   Tue, 17 Apr 2018 10:21:02 -0700
Message-ID: <CAJJpmi9OQicqEonVwWMo+yimU5MBdJ9gwzbtY1GXSMB+E69AGA@mail.gmail.com>
Subject: Re: [BUG] git p4 clone fails when p4 sizes does not return 'fileSize' key
To:     Andrey Mazo <amazo@checkvideo.com>
Cc:     git@vger.kernel.org, luke@diamand.org, gvanburgh@bloomberg.net,
        larsxschneider@gmail.com, miguel.torroja@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

*I* think keeping the filesize info is better with --verbose option as
that gives some clue about the file we are working on. What do you
think?
Script has similar checks of key existence at other places where it is
looking for fileSize.

On Tue, Apr 17, 2018 at 9:22 AM, Andrey Mazo <amazo@checkvideo.com> wrote:
> Huh, I actually have a slightly different fix for the same issue.
> It doesn't suppress the corresponding verbose output completely, but just removes the size information from it.
>
> Also, I'd mention that the workaround is trivial -- simply omit the "--verbose" option.
>
> Andrey Mazo (1):
>   git-p4: fix `sync --verbose` traceback due to 'fileSize'
>
>  git-p4.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
>
> base-commit: 468165c1d8a442994a825f3684528361727cd8c0
> --
> 2.16.1
>



-- 
Thanks & Regards
Thandesha VK | Cellphone +1 (703) 459-5386
