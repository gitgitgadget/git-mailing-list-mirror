Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C37A31F424
	for <e@80x24.org>; Fri, 27 Apr 2018 19:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759129AbeD0Tqr (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 15:46:47 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:52523 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757592AbeD0Tqq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 15:46:46 -0400
Received: by mail-it0-f47.google.com with SMTP id f6-v6so3285106ita.2
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nSGfjXoPVImoE4IxN0a+lCtrHFrS8ZqUfV3QxQdqjV0=;
        b=giPhgmnmnKRXPC8rNFV2XRSHxXHpw6SayqOuu23Od2uczHIEOuAwLWBO6hdYdaQxja
         PgbMCoJNF3XzmoynS7fe5UMumAQnWvk3IqOCWZD4kUmm/sg38t1+0dGi+psjIl0rUy+w
         x4mQUwqDRvup6iRrg+7A/uOpXisEMa2/mk0KGjAE5y0W3B8h5Ul987aR2GNaoHEdFgEy
         58o7IlwvWi5lItejeDCUROStCNdsLOhGieAmIbbyBHQwSL/zSVEfTZsAwIo38eueMqHx
         bICk/EJF1mbDFqj5b+dh9z2NqyPw+BRAGzValebw8PVg7W9WHX8Vq24Eh7Qs4hwxX64o
         03Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nSGfjXoPVImoE4IxN0a+lCtrHFrS8ZqUfV3QxQdqjV0=;
        b=aJGOOcOISh3veCT0puUer/SIIhtrXAkGVB4kbuuVaUgu4B1cSxMrNsK8Bv/tqXD1RR
         SIlI5pgjtHAfPpB+8gcW1SnW40u9u77C9U0MY324iU6daTRaR2x1IEVx7T2Ca7HuVpjt
         njsJ4R5eSLQl1Uz+3XMHCjf1zpi66ymWtO/UXKUAes46XhojuYMkDfjlC9UiZkaIjSB6
         ywmNvdZtMI25wQ3iiDRWRuwdk/ijT538t0P8+kBXaYNxDrH3glyJ5hc6BBQu8TzsAicw
         kGkYoII4YPVsmqhHQydxfSLd0UnPoxMxBJK2U5zYn4kRo7GgXpm6UWOpSL3wXdD2JY/2
         REAQ==
X-Gm-Message-State: ALQs6tCcxE6ERTy7P8kzcIX9RU6z1byZUFBvM/F/k1Vniah1YOIU2jkY
        6hzpXgPKU15UpcazLw4OsLkuC1iTqzymdZzr2QU=
X-Google-Smtp-Source: AB8JxZqDx9ZmMBebn7RHQNK4FaOdt9qre4iYFsOTy79jAe8CcSYKJKaegGTf1TirA8K3xjgDJZkRE8Jd5DYj8UmK8Tw=
X-Received: by 2002:a24:2e8f:: with SMTP id i137-v6mr3385524ita.124.1524858406307;
 Fri, 27 Apr 2018 12:46:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.149.81 with HTTP; Fri, 27 Apr 2018 12:46:25 -0700 (PDT)
In-Reply-To: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
References: <CAKk8isrAmWOdioJe2CdY+2F_AzKxcTGwd+kBsrAmGx-U=ZHGgA@mail.gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 27 Apr 2018 21:46:25 +0200
Message-ID: <CACBZZX7HFnEMD8PKWj0c7VWqv=yeYCXYJjy-5YPZnF_pJAy0jw@mail.gmail.com>
Subject: Re: Fetching tags overwrites existing tags
To:     Wink Saville <wink@saville.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 24, 2018 at 9:57 PM, Wink Saville <wink@saville.com> wrote:
> If have a repository with a tag "v1.0.0" and I add a remote repository
> which also has a tag "v1.0.0" tag is overwritten.

I feel like this thread has gotten somewhat side-tracked by the valid
discussion about whether we should have remote tracking tags, but the
much easier thing to fix is that the "+" prefix for refs/tags/* means
nothing.

I noticed this when working on fetch.pruneTags in the last release,
but didn't dig further.

I.e. if you clone git.git and update "master" and a tag:

$ git fetch origin 'refs/heads/*:refs/heads/*' --dry-run
From github.com:git/git
 ! [rejected]              master     -> master  (non-fast-forward)
$ git fetch origin '+refs/heads/*:refs/heads/*' --dry-run
From github.com:git/git
 + 969e05fae2...1f1cddd558 master     -> master  (forced update)

Here "+" does the right thing, but then:

$ git fetch origin 'refs/tags/*:refs/tags/*' --dry-run
From github.com:git/git
 t [tag update]            v2.17.0    -> v2.17.0
$ git fetch origin '+refs/tags/*:refs/tags/*' --dry-run
From github.com:git/git
 t [tag update]            v2.17.0    -> v2.17.0

Here the former shouldn't be clobbering the existing tag.
