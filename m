Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43894C11D00
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15BE820659
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 00:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAlzdxqe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgBUAfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:35:03 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33450 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgBUAfD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Feb 2020 19:35:03 -0500
Received: by mail-ed1-f68.google.com with SMTP id r21so281678edq.0
        for <git@vger.kernel.org>; Thu, 20 Feb 2020 16:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QIuD8YPaBsVX/DV3BwiwcVDQfdJBgt0sCerjtAYHHzg=;
        b=iAlzdxqeIdJAgEF9iNWGmoBsq9cgingjB1ftNRzj/5goRYH1Yy3a79Mf6C369ZIdTu
         OFuzueSIAfqMJtihw+ohaRg6VEC/RGmRBV0gsMcXXyNHjgSXVhSgO78C7SNr//pT8SRW
         sG4OYl0b6mxUP1oNuM4odvZWffb+gc08YJ6iZ8VeShkS+ZiOaw4HEC8x9CEaIpI1C4md
         X9Mi+kXPTRv6mSp6YDkVhysth1yfvR9PU7GbEpNzBZ/j7NNhPZXjRiWFiG7xDByyz9Sl
         DBLPliAXblBEApOx4hzjJi61C+iXvBIQXNoWYaaAX3Gew6HS/vqo1YeIRMJpjUCZYTFF
         e0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QIuD8YPaBsVX/DV3BwiwcVDQfdJBgt0sCerjtAYHHzg=;
        b=XXvq7kJ8vGM67a20SjhQQDZDqyUIlqXhyerN/HLjsPv8aweqqDpC9H88qlfz7oldMy
         vOarw57zYREW2xTUAnZkeZ6tJEMolA4SGaZm3YIOj3K84vpWwIGxK6qFm2fSo1Hz8Z1h
         9xJOBl6DLJ0k3u6T6ZRclUwuVgHdUdCWg4/XV1ZgDtkzAVUUv/8Wfk4qeH4Ji2W5QjLA
         vYaBOFyonwcLrrX/OQ8XBmBBgVuEDOJRYm12UZKsGKmsYxU7TMUhAdclcbzohDdiJbVS
         mTka5O2KoSHgQln5/cxT3JTYuijTzNIQCWHZYtwAj7HcULNA6DBD6id16HtPxzUd1sFQ
         iB0A==
X-Gm-Message-State: APjAAAUCD0zgFUlySIiTzjNHwuDavry6PLc5LUCWbdRkryt3eSPev2iB
        p73lxErkac43DrrSx+vWDG61CMlHXPlIvz66dIs=
X-Google-Smtp-Source: APXvYqwrch+kQBwA+UYaoBZgkdQTt4oN05wR11Vq0Il4VjkyMt2XA/sQRfy79W+49UeBJrTAyb+Cxk3IRQjE5sxC6yk=
X-Received: by 2002:a17:907:375:: with SMTP id rs21mr32270979ejb.352.1582245301284;
 Thu, 20 Feb 2020 16:35:01 -0800 (PST)
MIME-Version: 1.0
References: <pull.548.v2.git.1581889150.gitgitgadget@gmail.com>
 <pull.548.v3.git.1582144442.gitgitgadget@gmail.com> <a2a145c705e2751d4ced9cc71e62d5c560adb6e6.1582144442.git.gitgitgadget@gmail.com>
 <20200220014205.GB2447@google.com>
In-Reply-To: <20200220014205.GB2447@google.com>
From:   Heba Waly <heba.waly@gmail.com>
Date:   Fri, 21 Feb 2020 13:34:50 +1300
Message-ID: <CACg5j27MDAq6dHD02SUZ-vyiYePUf=B1vJrrjxoj0RbLS=qEng@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] advice: extract vadvise() from advise()
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 2:42 PM Emily Shaffer <emilyshaffer@google.com> wrote:
>
> On Wed, Feb 19, 2020 at 08:34:01PM +0000, Heba Waly via GitGitGadget wrote:
> > From: Heba Waly <heba.waly@gmail.com>
> >
> > extract a version of advise() that uses an explict 'va_list' parameter.
> > Call it from advise() and advise_if_enabled() for a functionally
> > equivalent version.
>
> Hm, I'd put this patch before the advise_if_enabled() one, so that each
> commit makes sense by itself (rather than adding a bunch of code last
> patch only to remove it in this patch).
>

You're right, that was me avoiding the commits re-order conflicts but
I'll give it a second try.

> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > Signed-off-by: Heba Waly <heba.waly@gmail.com>
> > ---
> > -     for (cp = buf.buf; *cp; cp = np) {
> > -             np = strchrnul(cp, '\n');
> > -             fprintf(stderr, _("%shint: %.*s%s\n"),
> > -                     advise_get_color(ADVICE_COLOR_HINT),
> > -                     (int)(np - cp), cp,
> > -                     advise_get_color(ADVICE_COLOR_RESET));
> > -             if (*np)
> > -                     np++;
> > -     }
>
> I see - this hunk that I commented on in the other review is actually
> duplicated from advise(). Hm, I still think it'd be useful to put this
> functionality into strbuf, but I guess since it's not new code you're
> adding there's not a lot of need to sweat about it.
>

Agree.

>  - Emily

Thank you Emily

Heba
