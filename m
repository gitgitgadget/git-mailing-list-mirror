Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D810C1F803
	for <e@80x24.org>; Tue,  8 Jan 2019 13:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbfAHNPG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 08:15:06 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45525 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfAHNPG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 08:15:06 -0500
Received: by mail-oi1-f196.google.com with SMTP id y1so3213364oie.12
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 05:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ILk1iFQY3xIZpBbURtXLi/YVCaF7stZX4Dc/18Fp2KY=;
        b=iF290Yp5LoWmb9Xv+GBGcEu5yZ5koCjJmL7mexUmD11YPP8T8CU0YOGKFfA703e0cN
         1H6iA2B1N5xCHrPM4Zv7z4MyKZ78OJWWCN0xjNwb1IELoZjH5zjfgls77rel36TE9nTK
         988J433nmN5nON89H7faqoAkAgA6TgkjVEj2unC4kqQT72OFzX1KuFoEe4Ql3nutVUpf
         r+U2x3hkRsjuXxdfxJYO30fnIjhlPetjwLoc5lxbbAN7SQbRf9AdWPtYbAymD1ldmJs5
         mAw0egGNAbJ7R6yEbu3paXr7fS0mKmKvfxJ2g3oXeuHMBXNhW/T2hdBZpYe2oz403aPW
         XFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ILk1iFQY3xIZpBbURtXLi/YVCaF7stZX4Dc/18Fp2KY=;
        b=HdZzKqF6wk6/iBUoHYCj/KUmJwHl25UaJHSUnKokt6Dlz+d9rlv2B2IZYPAAniOR4o
         XCsTDhJhSgfl0yIN21Sf4W+l0YyOcdm0WA/TybYrsZqVpofnco9F2ADqkVoRuHUcjTmR
         anSUcvbAoQdLcI40aMxiWrSDf14jXjIdGgXFcGqPGCdbE1OLpWjgEr5PDvZWppwPzvDt
         SndOCu+Vkz898kmBSdqm/0ifMBWqnLAELe5cP5RE4RHD+vLlEyBHUlpZU6v45EXtDQcn
         EArgoR0tvpS8bL3v41qQlsAH8fQ2C+ElRn5rDqFfa1XPeUUAh/v0NAr4rzN8a0TZpRCa
         MdhQ==
X-Gm-Message-State: AJcUukd6octeKUPgwPr1YzmlZojtyAI5W5F0xgXotOwtzIfEyvOyepIp
        86Xqa38kFhwE/Wd9Gz3EooRsPbCTxVPs0AFIrys=
X-Google-Smtp-Source: ALg8bN6ngYPESvIxgXLp6nITBEm2owTheYkXitNQa6EfVaX9ZL62HlgiptGzu1TR9r5jIzOcADCIWXe11hqFETIMkJ0=
X-Received: by 2002:aca:3209:: with SMTP id y9mr1070675oiy.198.1546953304769;
 Tue, 08 Jan 2019 05:15:04 -0800 (PST)
MIME-Version: 1.0
References: <20181231045335.12883-1-issac.trotts@gmail.com> <xmqqmuoikg6x.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuoikg6x.fsf@gitster-ct.c.googlers.com>
From:   Issac Trotts <issac.trotts@gmail.com>
Date:   Wed, 9 Jan 2019 00:14:51 +1100
Message-ID: <CANdyxMxZGdOLmmXNy+MF4UJWuZFvUABuMq0JP+y-CXPE323WSQ@mail.gmail.com>
Subject: Re: [PATCH] log: add %S option (like --source) to log --format
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Noemi Mercado <noemi@sourcegraph.com>,
        Issac Trotts <issactrotts@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 3, 2019 at 6:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> issac.trotts@gmail.com writes:
>
> > From: Issac Trotts <issac.trotts@gmail.com>
>
> I think you want to have
>
>         From: Issac Trotts <issactrotts@google.com>
>
> instead, so that the authorship actually matches your sign-off.

Makes sense. I'll do that.

>
> > -     if (source) {
> > +     if (source || (rev->pretty_given && (rev->commit_format == CMIT_FMT_USERFORMAT) && w.source)) {
>
> I am not sure why the above is not simply
>
>         if (source || w.source) {
>
> but needs to check pretty-given etc.  Care to explain why?

Good idea. Your simplified version passes all the tests.
