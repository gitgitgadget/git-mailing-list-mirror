Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C91A1F404
	for <e@80x24.org>; Fri, 14 Sep 2018 20:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeIOBYs (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 21:24:48 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38863 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbeIOBYs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 21:24:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id n5-v6so5757299otl.5
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 13:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XjCgIBwdaWFMSGwwJ0gJUo0lkIPGV9Fs0DhIlDa8PYM=;
        b=IvFeDeq502ASmmi89L8yhbp8gwTOC1K/lPOsQwG//B8JI5/YD6KgEMTRFfVBI02MOg
         Prs9jROcnc4d1vvdNzfpJtiszNK+eyOMHgDbffQ5oPiBrwMv9CalfwNtRPwucNvpSaxW
         6ULsZy31Q40xcEaRHHdOHndKLG3oSrAnfnSgPFV9fgvGVZHk6hfla9x5FgX9rjCZVB6K
         uEOe4UMo7Mwx0JoNvnjN4mSNgwlEd0ZnVN1kyNchCMYXo1tuCii2YwFvYsEsJrHkqg7n
         w1YSOLFmr6M+kYdnPf3sXau7gt55lSvp1KiTfukHZpUYEW/dsuh7fON0zFeJsxkb5NVo
         dI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XjCgIBwdaWFMSGwwJ0gJUo0lkIPGV9Fs0DhIlDa8PYM=;
        b=BjOc6Hy7caYyzFYVoLmS8idf93sdSSnsnIOXqbtNZy71U/pEapXSsXa/9BVtVWMy2h
         b+vS8Sk9j6/yyinDXD5XDg5bPAgGkqyyxhH9tqfAGIbvtmVQgjR/NaTdEZlIdRhH+NCr
         sTpEQGRosda9Yev8GQBSN0Lpp2N3XUfVNrnJikocrB1v4otUBbXeCBkm1epd9BMrZueu
         +OjAmWqZ5UubMK8CNYD2IcAkoz3QLL0edupFesznE7HvWTFVXvegnJVPEWZTilaAJ6xk
         n6fVe5C6zalc8FqfIrbMw1lq4ENtVXAxw7c+S9LYTAqC9KPX29qCmZD72ZQ1yW37/IBe
         7Y3A==
X-Gm-Message-State: APzg51C+94OByAsIFJtbKXZo+4BXCUNh/HAyg3ZC3DgywodUylAH3D+O
        XEOI9ImyOBTr7l2eZOrExv3w/OfUbVCwYwWqSNqY
X-Google-Smtp-Source: ANB0VdbHvpAhhft2VPiaIFlgXoFOgkCcaYt/Vo4dgHvK9p9UZ1P1KOPD7ZG0gwHl6Wo88tkQ3nj/8cOQ101cAV2jkg0=
X-Received: by 2002:a9d:522d:: with SMTP id e45-v6mr5166390oth.250.1536955728500;
 Fri, 14 Sep 2018 13:08:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1536885967.git.matvore@google.com>
 <ca25f5914a98455cb6908a34146c10101d3529b0.1536885967.git.matvore@google.com> <xmqqzhwkat8i.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhwkat8i.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Fri, 14 Sep 2018 13:08:36 -0700
Message-ID: <CAMfpvhLkn1wbDwzQycW4SX92qmyof6n3gMXe-f-5JdQKk4P28g@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] revision: mark non-user-given objects instead
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 14, 2018 at 10:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matthew DeVore <matvore@google.com> writes:
>
> > Signed-off-by: Matthew DeVore <matvore@google.com>
> >
> > fixup of 6defd70de
>
> That's probably meant to go below "---".
>

That line shouldn't be there at all, sorry!

It came from me putting that text in a commit which was meant to be a
fixup of another commit when I ran rebase -i. I asked rebase to make
it a "squash" so I could edit the commit message of the earlier commit
(6defd70de). Then rebase merged the two descriptions and let me edit
them, but I didn't remember to delete the latter commit's message.

I probably should have made the earlier commit (6defd70de) a "reword",
and the later commit a "fixup", rather than "pick" followed by
"squash"
