Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60A8D1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 16:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbeIYWTh (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 18:19:37 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:55581 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbeIYWTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 18:19:37 -0400
Received: by mail-it1-f171.google.com with SMTP id c23-v6so7990040itd.5
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DOEY0eg+e53FdOtEBTO17wQ3jaQ0f3qwPK1IfDHRWTo=;
        b=hWM9A2obOe/Efq/DoZPGxKuCk2lBl+fGwWezuOxzfofwGSbdn/nOq3S2fcSqdb66nO
         cbn1of2iriSLvq0fH1jskuadGinG62u9Q2XiuBFBvmHWUZdvlJqu1X5ubJUcLlT/hxhR
         3jtT1sO2nViEAShNnFktoa75XA+0EOn5KemDtpjDs6fyqmdm1Y2R8itAIV21Z+tgyoaR
         AhYNx55QJYb+zbbGmT0Uh7P3VLF7OQyEBSt9Pd/dbcmXDatQPJwCz+e8u1GHNviGmIoc
         yYrLGf5PO6tmIlxtX01LI/a3FoHaITOrrHuuprGggYQwgSG/s0nG5TdWOh7CO3rF1i3g
         eZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DOEY0eg+e53FdOtEBTO17wQ3jaQ0f3qwPK1IfDHRWTo=;
        b=bATScnt7UEMMC6llQvJ/Hxgwrpo8OfGVnvmDeoAf/j0wPBTQD6eSbz9+fnjp3ntLwH
         AgX/3D3aAY//lHRKj6Qrds5KQre/EdLezw7eI2HJ1rIOC+bh9DPccaZ8UrKA1H1h2Dee
         guYhPHyX6NPIeYP+8PStvNswRQQ0jFkL0r3yBrBfSiXNR6best9P9LLROSUatmFk1BvC
         fN09nJaOKUzRNdyEzqOA5suZmEKpEanzBYOMSvhlu0wqjKX8t+yn3K92Dq/hd4D6GT+A
         OsQSVUW/dzPYEDmnmxIw+usnBJY+4s+Re7uozfIRrzsPR5BSlnlDpdV6NdGffzPcYzpX
         njCw==
X-Gm-Message-State: ABuFfojYbkAfYlWrUWYcKXB5X2qPoPZZX+Bnlvi4ZhWCAaoC0vBnqVY4
        aVa+UOb6R40e+UoV3ZQD9mHYUQRIPaiSI+EJc/I=
X-Google-Smtp-Source: ACcGV63WQZ+ru+I6/4zFTbv66/bUpm5Mt4xJpKj3Sxtwt08nxQnPxlFMxCvPcuuOeKJRd0WJcwPKlf0qQVj6LoMAm0w=
X-Received: by 2002:a24:7605:: with SMTP id z5-v6mr1338741itb.62.1537891885659;
 Tue, 25 Sep 2018 09:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <fd340f7b-61c0-2661-bdca-c239e51bc464@highlab.com>
 <xmqqefdir0tz.fsf@gitster-ct.c.googlers.com> <dbd2dcef-c892-3628-119e-f688e74f3599@highlab.com>
 <CACsJy8C4+cj=K2NetC05rmwenY0cArQ7NehZZ+Df90fmzBVThA@mail.gmail.com>
In-Reply-To: <CACsJy8C4+cj=K2NetC05rmwenY0cArQ7NehZZ+Df90fmzBVThA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 25 Sep 2018 18:10:59 +0200
Message-ID: <CACsJy8C+WWkwFjoFT+Y-Ga2ZxSbOn-OkKCyKYFU4qJfXyuJY-w@mail.gmail.com>
Subject: Re: bug in 'git describe'?
To:     seb@highlab.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 25, 2018 at 6:05 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Tue, Sep 25, 2018 at 5:41 PM Sebastian Kuzminsky <seb@highlab.com> wrote:
> > That behavior seems to me to be different from what the (2.11) manpage says:
>
> Good opportunity to improve the man page anyway even if Junio is
> right. I agree that the section about "search strategy" is a bit
> misleading because it does not mention anything about time stuff.

If anybody's updating the man page, I think this is the commit that
changed git-describe's search strategy: 80dbae03b0 (Chose better tag
names in git-describe after merges. - 2007-01-10)

--
Duy
