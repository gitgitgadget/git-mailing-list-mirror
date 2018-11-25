Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242891F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 10:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727274AbeKYVKR (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:10:17 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35831 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeKYVKR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:10:17 -0500
Received: by mail-io1-f65.google.com with SMTP id u19so11690995ioc.2
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 02:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wDFu5ZTjT16CMnvwQwBs9lE+sPY8eLKNQmoz6/UZUdc=;
        b=pBpuF7jeOJxwZe81yQj1X3BrS9sz9Fmrblv3X1ibW7hglfznLjbTbUfvK50eY1gXTk
         wc6RhT4SwBJfGuyqtlLstmIlgazN/luk4Z6UYwZ9K0LF2VRDzKnQgy7l5cvsXmaaRKKv
         uqe7haW08cm7xtUsHzZwzisd+jpAkJiktc78nddytWGvfxFyHC5RdBJodu2WEXopQ9Op
         U8tuGUAUz3MsAtWCwjM/OC74115vdLwEZIiQyF9idBI0xwa5RTPLjDnCK1zY89BcpYfV
         ns96c//oHp1ztzFBO3sNq8CFOWJjrz1+XU7OXOK+et8B1ZRUxOTQKH7GlcrQz+7bvSKq
         wg1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wDFu5ZTjT16CMnvwQwBs9lE+sPY8eLKNQmoz6/UZUdc=;
        b=qhmdZGT4ruI9FfBvt/S9T968aafP+M+kDCBANmSIxq000E8eOi3q++4x4wYj5De0MD
         9lzibh6bCNoxPwKu3lQnmZdZZxOD3614t6IB3B6Bypvg4bGxGVB4lKXExBARlheUl7/O
         cHVjl+525LCgnbqoiy7GT5touMO+bSCzCx4ZbPkU1pIFUvMk6EMYyrIAWCyWIR95+mvg
         tq1r+AYG3U7ZsZy0ZOMGR4eMYAQfA+tNCyMcGSj0mu2h4wKHEPczm1afkzptBemp7zL2
         6owK9PHnFvwe19UpvVUhP6FLqm08PS4QQoJIe1Sl17Brg8q07ckPDK+99cVZTTHzyq/P
         xV0A==
X-Gm-Message-State: AA+aEWZi1e2jyIOB7764WI9mMno5xoKiqbK16av/30t8WTJg9StQhcuF
        QB94ltdKhWscbFn74XqLN1bY5f3g6SimUhfT5GA=
X-Google-Smtp-Source: AFSGD/XiVN/fkPNADstsdIK5DDtxhAEaJeai8EwMhCkzDjrEdCS4eKjh3JQP4+eebs6HCdi1ySlS5/2fDBLatQc4SKY=
X-Received: by 2002:a6b:3b4f:: with SMTP id i76mr8488926ioa.266.1543141171852;
 Sun, 25 Nov 2018 02:19:31 -0800 (PST)
MIME-Version: 1.0
References: <87a7ly1djb.fsf@evledraar.gmail.com> <20181125045816.12185-1-pclouds@gmail.com>
In-Reply-To: <20181125045816.12185-1-pclouds@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 25 Nov 2018 02:19:20 -0800
Message-ID: <CAPUEsphe9eXk8zLE35iRq-M9a-tukj8APQ0gHzR6PHfNZNLxLA@mail.gmail.com>
Subject: Re: [PATCH] files-backend.c: fix build error on Solaris
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        newren@gmail.com, peff@peff.net, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>

clang with -Wpedantic also catch this (at least with Apple LLVM
version 10.0.0); recent versions of gcc also include that flag and at
least 8.2.0 shows a warning for it, so it might be worth adding it to
developer mode (maybe under the pedantic DEVOPTS), would this be
something I should be adding?, what are the expectations around
warnings and compilers?

Carlo
