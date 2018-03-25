Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 64ED21F404
	for <e@80x24.org>; Sun, 25 Mar 2018 16:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753620AbeCYQwR (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 12:52:17 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:38002 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753521AbeCYQwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 12:52:16 -0400
Received: by mail-yw0-f175.google.com with SMTP id x20so4458327ywg.5
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 09:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WvGIR98zxSlnoNigQHO/e+rD8kfIpXU7h3o0N9qV9ZI=;
        b=B4sB3ZERtTd8Hcqu+c9dbDDL7yqfMiF3fdBUamADVZfpNPc6W27r+CKIHzroiedT0Y
         ifKo73bFXuZ8/uSoxELRKEkcFA1KDX9bGVJ0BFXr5RU+K9qsBt+LzOmlcPxK7AeVnoda
         C3JY2jyQsc2GLKl4OuBL0m9H287BURuhxKOlTB07aM/pn6rsl1D9NOJ3JZjwErzECTSt
         wOcqzj2ixklWcYa2sn+YktVprwtCn65NX/mpKQkhW+xyit7JosHsDyaGt0S1N5ff0oyf
         hEu/CAXoMDwLDg0oaPmR/vk3IU9gbcv+DiuDXGehtxGUDoLBR5FOFBm/D0A1ZjlxvhId
         oYdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teichroeb-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WvGIR98zxSlnoNigQHO/e+rD8kfIpXU7h3o0N9qV9ZI=;
        b=yzaek/y4E0RYqHpqldPlzCla2fCh7G1gkY9YP5c56aeNzCGv0v0XbKDYt645JvtG87
         oLT9uzkJOq1DoXWCbPHsHGccE0tofeSip9WzwXpahN7Vb5CUW4TwJkjiLrtX8UIISGeq
         Czyisz3QfoExGLcMHPB4qtLZFIIT/pqoQwGIbcslyI6hv6vNAzFZeWAmg2xA4mBs+mLx
         fTNX/f9nkBc/pI8llHHTNLBckhOibPJiHeuK/6qWr4eXtdD74DZlCQFsNp8n00gb858N
         DfAy2hLzxGyYlYyqfcx7KjyTu6sUmlBr9yepDhYAYw0fSrmgIe/ZvlSzu87ncpRySobu
         id8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WvGIR98zxSlnoNigQHO/e+rD8kfIpXU7h3o0N9qV9ZI=;
        b=AsFi1EYFCjQa3JIIjrqX1ZjIFo0tNbyjAaNFRvWErbmVzcLwcGVrWECFVYce+SQQ2W
         xtvy11qfDCYrzHJ7AOlUO93mLVlhwzZELoViaO95gQ+6kG+2mYXvWh9M2jpFQAUpa74O
         6zwi7mXPy/yV24Y7B5EREAY36CJzcmZ44a606LITYJGbyO0a1ZioSOXqXazYhdELSgvr
         zFWqJem3cxI/yVmu6i+jJN1tbzXEez03PFgs3NUHLAjJ3Ho01j+IhEXoYg87Wj9uyXIb
         oaZFe4tgUiDYBcdZgJQi68Mu/QmSNGpf8fNvr+jMHRG6uz/f8n6HXcsSykzw6l9RNwUx
         bdtw==
X-Gm-Message-State: AElRT7Eiixg8+hKa0Ug3qYAnCpA4xWTBG+lgjPen44zCQmpPc0W2JYcc
        6FM4P9h+maJpZ2Z9GYyqLykw5ELZBEQvzJq/zqrC2w==
X-Google-Smtp-Source: AG47ELv2g0nfqpxjKCCQNPKZ6sy3X4yQlFBXnoNfOKFe8gQKwc1EQ/D49uVnPdXx3U59xksfA1xhsdrAZIJFXqYEvOc=
X-Received: by 10.129.47.15 with SMTP id v15mr20995660ywv.248.1521996735914;
 Sun, 25 Mar 2018 09:52:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:1042:0:0:0:0:0 with HTTP; Sun, 25 Mar 2018 09:51:55
 -0700 (PDT)
In-Reply-To: <CAP8UFD3Qxt2YMqTtHwU8n7EDvD66QjGSywRQoxJDnncv7=2BUg@mail.gmail.com>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-2-joel@teichroeb.net>
 <CAP8UFD3Qxt2YMqTtHwU8n7EDvD66QjGSywRQoxJDnncv7=2BUg@mail.gmail.com>
From:   Joel Teichroeb <joel@teichroeb.net>
Date:   Sun, 25 Mar 2018 09:51:55 -0700
X-Google-Sender-Auth: o0zWxlwo3l5PIQNB8DRau5qhc8s
Message-ID: <CA+CzEk9QpmHK_TSBwQfEedNqrcVSBp3xY7bdv1YA_KxePiFeXw@mail.gmail.com>
Subject: Re: [PATCH 1/4] stash: convert apply to builtin
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 1:09 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> It seems to me that the apply_stash() shell function is also used in
> pop_stash() and in apply_to_branch(). Can the new helper be used there
> too instead of apply_stash()? And then could apply_stash() be remove?

I wasn't really sure if I should remove code from the .sh file as it
seems in the past the old .sh files have been kept around as examples.
Has that been done for previous conversions?
