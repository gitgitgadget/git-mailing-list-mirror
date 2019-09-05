Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 834E61F461
	for <e@80x24.org>; Thu,  5 Sep 2019 17:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfIERnP (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 13:43:15 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:35650 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfIERnP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 13:43:15 -0400
Received: by mail-ua1-f65.google.com with SMTP id u18so1121507uap.2
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m47ocPyjA+BTgZU+S8IAMFokh7oLEKJU9P3UXhYDmyA=;
        b=R81Z5jMgJoYhUJ0DsJzDGYT5Sj38YXZJzhlOq05cMT9UUxjzEp/9zFQiG24vlKkKeK
         xjWGYrraceVOqWjfWcXUpnRk7LlkI1KfcjriMJ2hL8TBDVqXDqM13LiE5R7oKqIVarqz
         cBJPXzYVRCyC0wiYO/BG0n9he6eOMQEU05H7pLlMiAZus1AqDc+ZFeXmxsZYXRPSeWk5
         rZk1aVCCRBzw9ZoIWrLWxEDQbdiKwcQqyHtlQU61ZKs1l4+Ln57n443KgNGt/WPXBMKa
         zXQ4rYW95neJl8d4H+/ziUSJFU5QLvWpdFj7BzDOUHRFSTETi4jLtMvBOjx40OeZE5Mb
         utaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m47ocPyjA+BTgZU+S8IAMFokh7oLEKJU9P3UXhYDmyA=;
        b=Y1A76ldS9i6OLEcHYWmLw7gmLI1cBqcJFJGjb3+oPPc6TQ+w7HVwqgJY6o8wKh/0BJ
         9RGNEPQuBKkkJMNVab7tqJg4mzkAqt0tdIzpz+7mJQGAhQVOIuqJL3Ge/bhd7i2nw850
         kSqGQ1JFv46VE7udzxnJrVrAIAPxjvn0XlZRepWOKmwwuCEt4x7BE9m0nFrH4VzrPCDH
         rUXCfzDmeyzBrY3mjVSeVCAI+pY+PBt63r2wRU7n9fd/LoKYrPwMpwzLccfJkt2mTuyI
         67SN1FsrcXDFfpr/HFaTK/+lR0djj0eMoWtdV5/UDHBw58OcWaDSmL3PqUAA2Mcbn1X3
         fFFg==
X-Gm-Message-State: APjAAAVTXt32k8zRy+78V5XYEE0kB2VWX3ugaHpccH3vb20Y48e7U0TN
        LC9t/SLUYQM9dDg0gh9zqvDS0MUds+tb3J3aPC0=
X-Google-Smtp-Source: APXvYqy6pO+iW4pqpxHfOHNQPiRRukAsKw0CKKl0AvNFQyKHO+lk40HePcCxye/4um+eMe6YsraRcvDAlAQGIZoolLU=
X-Received: by 2002:ab0:3d4:: with SMTP id 78mr2177886uau.51.1567705394533;
 Thu, 05 Sep 2019 10:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com> <ef44ce71-2ed7-0f17-faf2-06b3c7d193b9@kdbg.org>
In-Reply-To: <ef44ce71-2ed7-0f17-faf2-06b3c7d193b9@kdbg.org>
From:   Bert Wesarg <bert.wesarg@googlemail.com>
Date:   Thu, 5 Sep 2019 19:43:02 +0200
Message-ID: <CAKPyHN3w-21k0+Sm78N69MZ8HqgnS+TRFkvi4oE5qVF6R0JTdw@mail.gmail.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 5, 2019 at 8:22 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 04.09.19 um 22:43 schrieb Bert Wesarg:
> > these people did not saw the entered text anyway. they would have
> > needed to change the option (default to 75 characters) to see what
> > they have typed. which could have been garbage to begin with.
>
> Huh? When I type overly long line, all text scrolls out of view on the
> left side. So I definitely _can_ see the long text.

wrong memory bank, sorry. Though imagine you paste in some multi line
text, and one line is too long but the next not. In this case you wont
see the too long part anymore.

>
> > How about a horizontal scrollbar? This indicates pretty conveniently
> > and in a standard visual way, that there is more text to the side ;-)
>
> The scrollbar is an option, of course, but I dislike somewhat that it
> takes away screen space if it is permanently visible.

I already argued against an auto-hide scrollbar, which was also acked by ohers:

On 02.09.19 19:58, Bert Wesarg wrote:
> On Mon, Sep 2, 2019 at 7:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> True, and that reasoning would justify hiding scrollbar when not
>> necessary to gain vertical space.  Can we arrange the scrollbar to
>> appear only when needed?
>
> up to now, git-gui does not hide any scrollbars, if they are not
> needed. IMHO, I would keep it that way, as I don't like the flicker
> when it appears and disappears. Imagine you are typing in the bottom
> line and than you typed too much. The scrollbar appears, your input
> line jumps one up line (or is hidden behind the scrollbar), than you
> remove the too long line, the scrollbar disappears again and your
> input line jumps down again.

>
> -- Hannes
