Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 347BF20A1E
	for <e@80x24.org>; Mon, 10 Dec 2018 17:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbeLJR2N (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Dec 2018 12:28:13 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:39270 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeLJR2N (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Dec 2018 12:28:13 -0500
Received: by mail-it1-f193.google.com with SMTP id a6so19436859itl.4
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 09:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WXcVpd/D+mNIJ9FDYhU1ZvbvxZnaXgAL/VRwoeX4kNE=;
        b=OOXTYYLV5U2pSvJarMjffUSLKxxKy02JONTZhEqgwGvli1J+agwaw6mGufwwMl8aM+
         54bZp9QsIWdbTm4GSDFcHzNYW1NV0NBHWWLBfE0L8O7+Ykw3zQz/XrWE4lslGYJWjyv6
         qDKo8NBNfA3SAUK+WQFdpKX708rh6hoY0qW1utbjGU6tgLXXEi9tkXdzwVz1McE1RbEt
         exDSZAcgJ6Qb/3cbMtkmn86VKNp4qIpKoCWTdWemmGER+P5IAEG3+CLS2uo6Boi4AaJa
         QErZDF3CJvIzeTgpfjQuJZ4qnbAHidV4lTGTOkkCAjcsaJ0WEvHmDQRMFrK24d2mcOBU
         ng5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WXcVpd/D+mNIJ9FDYhU1ZvbvxZnaXgAL/VRwoeX4kNE=;
        b=BWtPbEipe476QIhxJ75s5ZspwMrnkNbSAeDgE0eCMvxHGMEGzBZ7c180PfkJvZ184C
         fOEYSF2loaQHlzpTFW0NuyA2s8kmCQNos+fAwDVRBShv3VtOCXAXLwIIAtCc5OQsXgaW
         zPFFQxmOu8Y8cXBCxc46gOCYGDOUfuOJD0j6lIe1FjJQqK5xYAU+AyBkMkXaNh7DqBli
         af4araF0aOKnW0eO4LwSxyqFjnGnRDn1mbvm4DY7mut1zQVcOSTDO/m5jLWROBuw5Icy
         2Q76HkMo8J0leJCoiL0BY+p7f6VxwTa3+TFGbv+cZqYcuUtGKNDe3CmaOOj6/ksnuvCH
         hMYw==
X-Gm-Message-State: AA+aEWZq08TD0C4Sp2hqEUWQCmL4/SiYQKb45o9HHhn1mYt2xCat9vpX
        /YlUssE7WP9KYOJDmHg0s6bqJ9UKJmYN5/69MCiaHQ4M
X-Google-Smtp-Source: AFSGD/X+8TbpYl1pRrBWrzWhAT+o/S89c2oEt644+bpYE2sgMrxbbBVAgX49CRhOkS3cBuq1OFfKlPVBsvfzND2Xoeg=
X-Received: by 2002:a24:e1ce:: with SMTP id n197mr11737041ith.123.1544462892197;
 Mon, 10 Dec 2018 09:28:12 -0800 (PST)
MIME-Version: 1.0
References: <20181209200449.16342-1-t.gummerer@gmail.com> <20181209200449.16342-3-t.gummerer@gmail.com>
 <CACsJy8AGerhjnT0O6vT264tND78N5cbgFREzYtdmriXERu0Jtw@mail.gmail.com> <CABPp-BE15jfe76q3hqSxnifv8MNB1e6_GDT=5=ZmTE__XuTmLw@mail.gmail.com>
In-Reply-To: <CABPp-BE15jfe76q3hqSxnifv8MNB1e6_GDT=5=ZmTE__XuTmLw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 10 Dec 2018 18:27:46 +0100
Message-ID: <CACsJy8BgceLwH71SkkA0n_etrOrC8ucGBpkK2+RB+PU3F=0RgQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] entry: factor out unlink_entry function
To:     Elijah Newren <newren@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 10, 2018 at 6:23 PM Elijah Newren <newren@gmail.com> wrote:
> > I wonder if we should move the 'removal' variable in symlinks to
> > 'struct checkout' to reduce another global variable. But I guess
> > that's the problem for another day. It's not the focus of this series.
>
> "move the 'removal' variable in symlinks"?  I'm having a really hard
> time parsing that phrase and the sentence it's embedded in.  Could you
> reword for me Duy?

Sorry s/in symlinks/&.c/. There's a global variable named 'removal' in
symlinks.c which is used by schedule_dir_for_removal() and this
function in turn is used by unlink_entry().
-- 
Duy
