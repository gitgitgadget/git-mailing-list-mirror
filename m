Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C8C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84096613B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 09:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235263AbhD0JYA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 05:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235213AbhD0JX7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 05:23:59 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A56C061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:23:13 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id g24so7402563uak.11
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 02:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MDItZ30zhNehatip2qLUyX3OqD7lAKe4/wDcGPbFH+o=;
        b=X823nYv12FGmz2REPkkxl3pbYRjr1bHptFIirvtpQ0RMNTUxjkBAOG8Citve3QA776
         R4D8nTGB+07/JFRGXhNZXFds+D+quWz7G5FayBAhY/HmMBUooa3aK8hLQ5SYk9LygTdi
         BDNLK6D48099nWxKshMHxfa8za1oDO5vbjL7+btEN90oRuln4mptZuYSTWJIkk80ZHiZ
         brZJIBrhxnU1rAaG6bmKCVUtCQI0x6bJMIEPpNpymeOIr/crKHgMS/V6g0HGdIRbaf7n
         oKjhZHNTx3+n6BoOJDDjQ2h1amVJ3besA0dX+qlA2cjW/Ljxhi73JdhdWDHoG07y9/Uz
         QpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MDItZ30zhNehatip2qLUyX3OqD7lAKe4/wDcGPbFH+o=;
        b=bpMuLzJFHvn8OHRCPMCC5h5gDYN7E8+oPo+GrMjEdoxku1e73/xd7IuAQI/NzjG7CX
         4CMBI/7F5BebLJCcD4AN9efMb5Q60toirwf8Q+m+AmCvYO0GnYa2ogVRKykRGtG6xsJ5
         l1umDGyUlLCK5q52twvIu+xtLs6NTk2vKgFhL9lShNJ4RsYJIxutPjCdZJoBi+RUDzoh
         U7Pm+MdQnsjzgHyR5nu4njld9LeeP6aZMy8Jz8fIu7rgnIxU3kggSu4GxpFg4XhvneXH
         VnNVLt+KJkp1kauuHQvgOouB0wZGIQP2XxHr20GdCnSwOQzZjzyvYaGqVLk0l9UK9xcs
         dhrA==
X-Gm-Message-State: AOAM533rfTC8EbhQ0ofJjduEpopQg6pz0NAaa0Btc4DlIGQMTlJHb1aA
        kG15v1fQ4FMOcOwHr6LnPe0XgiUoAp0uZOPVq5UA7Q==
X-Google-Smtp-Source: ABdhPJyDpYsG+GtkXoW6K/6VwJf5HxaGhXd/Tym+8ShTppRZE36RrSe7a/gGq1aO/9jb/Zetgja0KwhqPxSXH2V9Tts=
X-Received: by 2002:ab0:274b:: with SMTP id c11mr155918uap.80.1619515392992;
 Tue, 27 Apr 2021 02:23:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
 <ba575839e422dfe241f7b567de14c10ec648f2e3.1618829583.git.gitgitgadget@gmail.com>
 <87v98g413h.fsf@evledraar.gmail.com>
In-Reply-To: <87v98g413h.fsf@evledraar.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 27 Apr 2021 11:23:02 +0200
Message-ID: <CAFQ2z_PDpquxUDzFuZBE+TJZWEkP2A-xTC1-nhkQ9+AGQthXsg@mail.gmail.com>
Subject: Re: [PATCH 09/18] t5304: use "reflog expire --all" to clear the reflog
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 8:13 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >  test_expect_success 'prune: prune unreachable heads' '
> > -
>
> Similar to a previous comments, a few tests in that file use this
> whitespacing. I'd say let's just leave it alone unlress we're doing some
> whitespace-only commit earlier.

Done.

> >       git config core.logAllRefUpdates false &&
> > -     mv .git/logs .git/logs.old &&
> >       : > file2 &&
>
> Also, if we're re-styling things: ">foo" instead of ": >foo".

Done.


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
