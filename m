Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5600B211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 15:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeLEPht (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 10:37:49 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44501 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727182AbeLEPhs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 10:37:48 -0500
Received: by mail-vs1-f65.google.com with SMTP id g68so12314271vsd.11
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5pY0Bg/8peUNIWJkjnPbvF9AX/4E8NqmCm1wzdF+B1o=;
        b=hMUmKiWZp5zG3ypW7qLX5O0w5ECV+ioB5aX1bSetCR2X+HV4IxfKmlUm1svV9r54IS
         Voz7HdEKRHIHTloV1IKplgadWZYDJ4aoIjxpuozITMEuchHQV9wWEmm2SVUhBJdYqMG/
         Tiw+xS16M0Mgq1gmo9o8NRNZjs2KlenS2p2LDVvBn2zpN96Ksl0cxAkvwyWcg8LVlQR/
         xNwlcBDqI+RvMl4j6L7kurJA1LbgQ/QEYNpcnc1vRHzwdXX23Ui6fz8hHxr1WVP64jDL
         tQqUJMd5vnzPIlOnd2iuX2xKUHAdTWq01DVCl8cpkQ+VzLw5gndKJVtoinu6EYqNlk5+
         EgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5pY0Bg/8peUNIWJkjnPbvF9AX/4E8NqmCm1wzdF+B1o=;
        b=g/FfXTEkDjpEQ74NQJaznJDBFLoO1XcAaV3mYmI/FflqHYVu2AY+qEX8P8n3RoYxz3
         XLnG6zHcwmRX9gK96BeDV5OqWSsDbQ5qgqy9n+K8lUTZzUdFd8bqmAlF0VvZocsgfzYG
         AnMVR9cHEXlJdZ/DOBJQAvfVKJRlDWj2XTQOnRCYdpM9eQ7b/qqbNMcJUNJTQNkDQXjm
         NRal2NqV7tBCrjDJPU7kmJBz5ZqDKW9DLGXlK3ECaKaw5TI0J1J/XFW0wEDVmcQkwc2z
         ZP84MeON/0Z8NGnWVtrwPYyq5T024gOBUEZ8yD/h4CDpp45XKJEg9aIosU2qHufn8Bn9
         3o5Q==
X-Gm-Message-State: AA+aEWYtSj0GfvH86ok3QNKSCdWxc+QJQG/nk5fc0lW/NIGwpbWU9vWt
        jJnXvpSDqoRIJL1+nAwqmUaFqWE67CTzMG8pG9rfmeQV
X-Google-Smtp-Source: AFSGD/UMPf9Xj+QdD7HFcuic/emkQ41nvp1vLYYa+5XydjF5lvYrY4W/h2at3CWaQu5WgWvQTyTft2kn6wbMsp/aeXE=
X-Received: by 2002:a67:e44f:: with SMTP id n15mr11352071vsm.116.1544024267244;
 Wed, 05 Dec 2018 07:37:47 -0800 (PST)
MIME-Version: 1.0
References: <f2ed3730-03f3-ae92-234c-e7500eaa5c33@kdbg.org>
 <20181204231709.13824-1-newren@gmail.com> <xmqqo9a0d3w6.fsf@gitster-ct.c.googlers.com>
 <CABPp-BG=4K9VCc8zuUm0KTRG5cHPijtvQTK4QXWRVbSFu3o_fQ@mail.gmail.com>
 <76537e8b-3b66-e1f1-eb4d-e9e1c18012df@kdbg.org> <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2ewbevt.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 5 Dec 2018 07:37:36 -0800
Message-ID: <CABPp-BHzESYnQy5JwXvtXyLHgHR9u3UNVOZF2gU1m_uTMGkyfg@mail.gmail.com>
Subject: Re: [PATCH] rebase docs: fix incorrect format of the section
 Behavioral Differences
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 4, 2018 at 11:40 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Johannes Sixt <j6t@kdbg.org> writes:
>
> > Please let me deposit my objection. This paragraph is not the right
> > place to explain what directory renme detection is and how it works
> > under the hood. "works fine" in the original text is the right phrase
> > here; if there is concern that this induces expectations that cannot
> > be met, throw in the word "heuristics".
> >
> > Such as:
> >    Directory rename heuristics work fine in the merge and interactive
> >    backends. It does not in the am backend because...
>
> OK, good enough, I guess.  Or just s/work fine/is enabled/.

So...

Directory rename heuristics are enabled in the merge and interactive
backends. They are not in the am backend because it operates on
"fake ancestors" that involve trees containing only the files modified
in the patch.  Due to the lack of accurate tree information, directory
rename detection is disabled for the am backend.

?
