Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73C8C1F453
	for <e@80x24.org>; Tue,  6 Nov 2018 16:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388925AbeKGBkT (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:40:19 -0500
Received: from mail-io1-f45.google.com ([209.85.166.45]:34864 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387685AbeKGBkT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:40:19 -0500
Received: by mail-io1-f45.google.com with SMTP id 79-v6so9628037iou.2
        for <git@vger.kernel.org>; Tue, 06 Nov 2018 08:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mCc7QBWdT4g61nVbwxMGLj62kfpKZqGnAm1/6PpzCRA=;
        b=JIcAUkVkIEk4l2uR/eFyMszrSJoenM6Y/zKmMaT25FRlAtOH1/vjx8rXJgrFfI3wZy
         LNfhzE7q47NJpvkmKaq+U6udgwv5P0qHsuWoAX4gncvrIR3QWID9NVhPG6LvWZm7/oaV
         2gZ+y173UfXcAIPhZFNjVf54+uGVBMLtGkN37/arvSC7Ee4qime9iPUwg0tSzf7jj0nC
         3FH0X++qBOjM3ab4iZp6O+/+MQRq4vanatdD7tSZKG8V3fRlqBK0bdebgqZnqlaDbyoW
         xqegdYne+Kmm2ucWwFtyfspZCqD3kE2fqpXqC9gq+YnPw8AESD5AemiY2nJ3+RNRWQU9
         geWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mCc7QBWdT4g61nVbwxMGLj62kfpKZqGnAm1/6PpzCRA=;
        b=sdQ8s+GJUMY6CFZiYL+4KwhM4IZLmddcK1+3r+PAHXDlgEdl8IMALY3mazgkK6pBti
         yC1TJrkkrNYldRU0MROkLlC2XKqakP6gp7jdvghJMBa2TIx4NhRmKA5QXVo+rX/VRjRw
         YqlmoYU7dljIdbzkEshPHbWcVSCbXM9mlsiga3n4+bN0Onnw0F+JEBtS2xLjznq9n/49
         w8lbzvkFXx6Pr1fogUIeaJ1/Cxh1Q56vj0LFMFXOVR0bIDepq07x/xkvhRja/jhF0499
         k0/90XESFsbTyfAbCMhnP3UjDITqtpLt+O2HjFo2Bu5tnhYjcAcgc9BL/yC7gzXsSVan
         Bljg==
X-Gm-Message-State: AGRZ1gL5woDTyF+UYimbK749P8pAYpNbJ/MnN8t9+X18RqbO9gGgpHC6
        16uUEHIbrHHEGZTrdTHnuMy5TLg/svh7Atrr92E=
X-Google-Smtp-Source: AJdET5fVhozTJa74fHfgf6W+tBDnHvQmGtu12bZGbnoU5kqA5pgbwAWJOtNM3WBddWH79lVCT/PCsFeeb5Ic78HJclU=
X-Received: by 2002:a6b:6f06:: with SMTP id k6-v6mr18582652ioc.236.1541520862383;
 Tue, 06 Nov 2018 08:14:22 -0800 (PST)
MIME-Version: 1.0
References: <20181104072253.12357-1-pclouds@gmail.com> <87bm727fcw.fsf@evledraar.gmail.com>
In-Reply-To: <87bm727fcw.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 6 Nov 2018 17:13:56 +0100
Message-ID: <CACsJy8Cm6EBVDf6pk47dBdbpe+qdJAM97vQXXW-B1VHF10nTmw@mail.gmail.com>
Subject: Re: [PATCH/RFC] sequencer.c: record revert/cherry-pick commit with
 trailer lines
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 6, 2018 at 9:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
> Leaving aside the question of whether the pain of switching is worth it,
> I think it's a worthwihle to consider if we could stop hardcoding one
> specific human language in commit messages, and instead leave something
> machine-readable behind.
>
> We do that with reverts, and also with merge commits, which could be
> given a similar treatment where we change e.g. "Merge branches
> 'jc/convert', 'jc/bigfile' and 'jc/replacing' into jc/streaming" (to use
> git.git's 02071b27f1 as an example) to:
>
>     Merge-branch-1: jc/convert
>     Merge-branch-2: jc/bigfile
>     Merge-branch-3: jc/replacing
>     Merge-branch-into: jc/streaming
>
> Then, when rendering the commit in the UI we could parse that out, and
> put a "Merge branches[...]" message at the top, except this time in the
> user's own language.

My first reaction of this was "but branch name is a local thing and
not significant anyway!". But then if people use one branch as a
bundle of other branches like 'pu', then the ability to recreate
branches (with the right name of course) from those merges may be
useful. So... yeah, maybe.
--=20
Duy
