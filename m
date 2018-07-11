Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52A1E1F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 20:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732979AbeGKUoo (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 16:44:44 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:40098 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeGKUoo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 16:44:44 -0400
Received: by mail-oi0-f68.google.com with SMTP id w126-v6so51704066oie.7
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7wHgGSk7sTchyZvf2RYI8i2cMgZmEVwAxWHxx+a8rHk=;
        b=XckMDMxZww4qOKjdEF2dKaghZfxoX6EmYR2OVy1az0ejLVJ1S/1I3WkDBM6jBwR2A8
         MiIld7jd56bZRN6NUrfi4FaJIg9dLmNElE/DzUN15rEvRrApeiR+AZBlt6t/giHmtg7B
         pmZIkcT1RP9MH4hbq5F+w7tEi/Uw9uxDk82vsnULHto53rLVl2rC9b+oo4NTWqpw+juz
         9X04sR83LChCDdZhJ3EQdoWqUzjGZb9hXzLT72QudajjikPMBqYQUT0aYJ5/ivs28Phs
         UCtMM/DCAJBlK8VmkyuOoxV6P0TDnKU2ELZ3eitmgYhGJRKSy1t/1xwCYwY/ZGKsZQN4
         VvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7wHgGSk7sTchyZvf2RYI8i2cMgZmEVwAxWHxx+a8rHk=;
        b=tmKIhQBSzrIqA7GfCq6nHoGPN9A3/yEtX7TGbZCHDlqkppDwKMKqq3V/gL0ZdIBF9R
         ilxZgsndZgU68/buGEL9UaG47wMSB+7Z4lEvyXFl8fX2zLmoP57/3ziAcokN3yfhU5Q9
         QZX14IF4g5d/krjPRjfMk51+lFyK/p/jGVeXzz+kdcToQ2LvSP/ehTI/rX1OYh6Tic0k
         xw3N8Qm7TNE842mCOMWUR23SyMY1dVVGFOKBcl/S8pAaq/vk6q2m8eZOGp8XpZp4MmYX
         narjCJBffzX9yuoZUyOAqyuhk2Ns9UiquJuj4UvPTiAtBaxcX35eqW2WkJpjjOaTsYme
         MIiw==
X-Gm-Message-State: AOUpUlFt0D3lY22/b5BFiKUP1t/uarfHnHS4ZM0zG6QOA+F8xLart7xR
        9ZJgWQ5zpLf4cATjuEJNGuKeJg0GOqOi68vOibY=
X-Google-Smtp-Source: AAOMgpfF1saO7+ZOu+BLw6RDMR+My2ckZRjcVZ+0yl5CQIt0lvkNoxE1YPGjd5giNEqxRRZlwpuw1+fSCdkKCFbka0g=
X-Received: by 2002:aca:b841:: with SMTP id i62-v6mr220780oif.290.1531341519794;
 Wed, 11 Jul 2018 13:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.999.1807071238410.18818@i7.lan>
 <alpine.LFD.2.21.999.1807071502260.18818@i7.lan> <CACayv=ifE5BQVtxXCVEhS3uO7iz1z+ZPrF3J_n=e-uoYOpwNtA@mail.gmail.com>
In-Reply-To: <CACayv=ifE5BQVtxXCVEhS3uO7iz1z+ZPrF3J_n=e-uoYOpwNtA@mail.gmail.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Date:   Wed, 11 Jul 2018 22:38:23 +0200
Message-ID: <CACayv=jM0Q4x=U+4=_YqJHto_ZdZAz8r89xALOcW5a+n9w=LeA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] Add 'human' date format
To:     torvalds@linux-foundation.org, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 11 Jul 2018 at 22:34, Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> Is -1 an OK initial value for timezone if local_time_tzoffset returns
> negative values as well? It looks like it doesn't matter for from functional
>

meant to say: "It looks like it doesn't matter from the functional
point of view".
