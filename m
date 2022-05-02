Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F228C433EF
	for <git@archiver.kernel.org>; Mon,  2 May 2022 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244204AbiEBSH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 May 2022 14:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbiEBSHz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 May 2022 14:07:55 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F2D311
        for <git@vger.kernel.org>; Mon,  2 May 2022 11:04:25 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2f83983782fso156617297b3.6
        for <git@vger.kernel.org>; Mon, 02 May 2022 11:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22/csglGEgSrrDbWUAvl/j8risY9E9lJzvomVPnyO/E=;
        b=X6Z6ID9Sp9nqYqnULT+41FeDv81ZWssR5iEs6QXpBUfU3DZsA94ksmzQoUqma92goM
         mBzZH33g4rJLuz7SLAdK6gUjYxGy543wHIIlMO1ZTIPEAVw+No+Hd2dQDADfRaPmB43P
         rubL1K/mJ5naoXKaZS21VbWZqfC6RC+Li8IT5VWXnW9ZXI7375bIewhacAxNPDvVPlHR
         7JnVtMy67/3J6FzuD6pBl+so4iJudcsjSrtEbFBO3E8DhI6cG9VBDXXD7jCkw/9A5RwO
         lXo/t+26ANXtzWrZrk2hpP7GlCCydVytgdd3g6cMYWgQ7WAwIQN8RpdTLByksx4ZbgCH
         JMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22/csglGEgSrrDbWUAvl/j8risY9E9lJzvomVPnyO/E=;
        b=mqjt2o4rTJCu+qZzHYzx5Nqt6+3WTgLdZp8dFuMntKfcQQDoO445tmx8ixiRlkVp/E
         Y2E7XkML99uikEXmDTkg423mZvTwq8R20Z7mdZVDhtwnQuZ4AW4zfe0DbIPenWgh3HD5
         YKTMLr2HLctdpbB37/9axQYBoilcy6lJrxQjudMXXKUgHEpBSBwoNF+Gm/Zbzh8IXO5s
         LSNrvI0Jf/lhNkDNIxcbzGXmyGYbSLTeztu6nbL8HrMNx3tF2Q0jSTpYnKGKfwpIir3Q
         1C4HjxkPxM88DClM/YuH+ETRcCcREFllTNQ4gR2lbBQVBU0pLxzIDWjg7bWPCddFR4mw
         uyqA==
X-Gm-Message-State: AOAM531cylf0ZHGYuhfUcFd0Fb7qG/1zLpGMmmt1cxBq82IlSn+T4/QF
        43nbRXrWRXwCzxC43/SzUrFl6qpuoZ+O2qq0WT+usWsu
X-Google-Smtp-Source: ABdhPJx3hjLJyG1AIksHt1qUMsc+sKRExV6/qVOLtvYlQvNC7UueSDwlMhXTSvNqipUIda1bWbEKjRViqylOXgYBBLk=
X-Received: by 2002:a81:183:0:b0:2fa:2107:affb with SMTP id
 125-20020a810183000000b002fa2107affbmr1757801ywb.239.1651514664890; Mon, 02
 May 2022 11:04:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAKepmahKwpe_YVrVrS0L3hMAu44W8VgbmvHY2LRpbrC6CQ0AKQ@mail.gmail.com>
 <1c11f705-596f-9e51-8017-2b59cac5f19d@kdbg.org>
In-Reply-To: <1c11f705-596f-9e51-8017-2b59cac5f19d@kdbg.org>
From:   Jack Adrian Zappa <adrianh.bsc@gmail.com>
Date:   Mon, 2 May 2022 14:04:14 -0400
Message-ID: <CAKepmahchaMVvOoWhnHzeBzKoYEHvmMJgHJ6fNBJ6C8bKMDjrA@mail.gmail.com>
Subject: Re: Getting an odd diff
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git-mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 30, 2022 at 3:16 AM Johannes Sixt <j6t@kdbg.org> wrote:
> I am a bit reluctant to diagnose what exactly is happening here because
> your word regex is outside the design space. It is definitely not a good
> idea to declare whitespace and even line breaks as part of a word. And
> in fact, when you remove the trailing (\\r\\n?|\\n\\r?)?, you get a more
> sensible word diff:
>
> var result =[-((-] resx.State == ResultState.Succeeded[-) &&-]
> [-string.IsNullOrEmpty(res.ErrorCode) )-] ? (byte)0 : (byte)1;
>
> But if I were you, I would remove all subexpressions that match any form
> of whitespace.

Interesting... IIRC, the reason for the leading and trailing line
breaks in the regex is to stop the diff from messing up the alignment
of multiple edited lines.  I don't remember the exact sequence I was
seeing, but removing them doesn't appear to mess up the alignment so
badly anymore.  Still, I'm surprised that removing that trailing line
break capture would have caused the issue seen here.  For now, I'll
remove the captures and if I see what I was seeing before, I'll report
back to the group.

Thanks,


Jaz
