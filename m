Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 429261F461
	for <e@80x24.org>; Sat, 31 Aug 2019 20:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbfHaUks (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Aug 2019 16:40:48 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39060 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfHaUkr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Aug 2019 16:40:47 -0400
Received: by mail-ot1-f65.google.com with SMTP id n7so2793905otk.6
        for <git@vger.kernel.org>; Sat, 31 Aug 2019 13:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VP/hRyOe7b4+mK4GY0Pigffcx1I2PPOCvSVKeRpODZg=;
        b=boFCtGv/nJZRuOPEjU2XkaZSoc+KSDwl5R/8rbs6lPZECgx/OlxB8p6z5pZOFtvpcA
         V5OKt/+Vn/A3yqv9sj6c+vfKosMRgAJBYaioAXEskNCfe6hdBWsjJ4JEIRUz3WwtH5Tt
         j49W7GpIlUsXEQ1bxV4RIvWFyTvdRJjO/UFAGl8TIUzYne1xEuiM5GuyA+X3CanaZKVZ
         7OdceSI+WwKW/qdetvYMoanWKU3LZXWanJ5Pa5gg7Ys0erwHllmnBQ38sVT5MFN0rKvG
         dAC6LafCZgw9jV2fpToPBsLKCIiHiPmUG830pdZVPOlU7bxNLF41JC18+eV2+FsaKhTO
         T5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VP/hRyOe7b4+mK4GY0Pigffcx1I2PPOCvSVKeRpODZg=;
        b=Bpa2VUCt7i+KkuUYorb+cpPoc9Bh9gZmb8Hsy9Qmo31aRQf3Jw9NL22SB+TVYBb4hL
         vbu6fBhsoPtL7fQfxfM1XOOSF+RaWpjhXK+YTOmZ+WVGDqUziQDhRmdIYLAan6QKSFmR
         oOSTcUhH54wVm7fwBPhW0KlIR4aJFY1QGR94KxB7R42ACWpCd4Zg4bGLv2rbLjxDIc4R
         cRFmzhaFszZhzzf6XKBx7aHcIBVbhO8byxmzjzKovXnlbZumUex3QJ0Y6m7DNUYayM0l
         LT0LBD/9nKiCKutLpIzwaSObJ/sJ+79ZBQ20TLb9X7LHJEKoPe2WCuVxrIszLmyqM6qe
         9lUg==
X-Gm-Message-State: APjAAAVgzhBFe3/3mUfeAIMxKxmHDjHNoV7YgirTYQAP9agPC7X4VDT4
        J3BRzqDZNZCN1gVPBPn/9jcQAFDfLC/zcj0Efzk=
X-Google-Smtp-Source: APXvYqzo1CQmPhihj2porESbmJEsyy42FxVrOapj/cePhBqT/SnpazkqyFxxIKXHgVN4UPdVuq+El5SQSV2VI9Io3gY=
X-Received: by 2002:a9d:6a11:: with SMTP id g17mr14305922otn.251.1567284046740;
 Sat, 31 Aug 2019 13:40:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAAQViEsZW4PzHr5BrkDHU2kSd_e04n02McGPgrmXGZMpgaTePg@mail.gmail.com>
 <d31b871a-5c2d-99e7-5616-6f43759bb948@kdbg.org> <CAAQViEv1_YXPxLRN=eT7yQhro55K4audnouzAjjbHhJsU7pgQA@mail.gmail.com>
 <34935414-4e69-114b-7a32-f94514e3679d@iee.email> <xmqq5zmkkn4a.fsf@gitster-ct.c.googlers.com>
 <CAAQViEsL+X5ZYmmSjG1JBksGjthHCUyWa3525b8dN7u1XAbvJg@mail.gmail.com>
 <xmqq4l224d0x.fsf@gitster-ct.c.googlers.com> <CAAQViEv1wWGTzQ29t0qi9rYoRY=Y86GL7E5rR4XySOBoeRx2pg@mail.gmail.com>
 <xmqqd0gmzk0c.fsf@gitster-ct.c.googlers.com> <20190830202635.0bc7e14f@kitsune.suse.cz>
 <xmqqmufqxxof.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmufqxxof.fsf@gitster-ct.c.googlers.com>
From:   Albert Vaca Cintora <albertvaka@gmail.com>
Date:   Sat, 31 Aug 2019 22:40:20 +0200
Message-ID: <CAAQViEufHT70-c17hdPqFh4HxB1Wy1dF6huF88P2-n+LWkhamQ@mail.gmail.com>
Subject: Re: [Feature Request] Option to make .git not read-only in cloned repos
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
        Philip Oakley <philipoakley@iee.email>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 30, 2019 at 9:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> But between these two:
>
>         $ git clone --no-read-only-file-in-git https://github.com/foo/bar
>         ...sightsee...
>         $ rm -r bar
>
> to avoid "f" in "rm -r", vs.
>
>         $ git clone https://github.com/foo/bar
>         ...sightsee...
>         $ rm -rf bar
>
> to clone a repository you only have a tentive interest in just like
> any other more permanent repositories, I am not sure how the former
> is preferrable.

I would permanently enable --no-read-only-file-in-git for all newly
cloned repositories (via an alias, or .gitconfig if possible), so
there would be no need to type it every time.
