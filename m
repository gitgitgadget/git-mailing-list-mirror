Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C886FC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A477E615A4
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhJDRaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234027AbhJDRaI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 13:30:08 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E44EC061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 10:28:19 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id q13so900495uaq.2
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yxjkQuo+JrBQVW5jsMJKlRLI/Cm+CfAkEf/rYRZsemQ=;
        b=gS6XQm8vsJppSmJybC3LVPlOknpOx3iJA27k+F7uLyHhpWDlKgdxQhElT1o+11lRFZ
         iPx1/Gu57RRnhsRHZlLp7wOXkcB1nKdXRO6Q0qPiKG7WFwe/1hdbdzB8jVgVBShaGNM1
         Md44KdMRCsuk6AnnNqqHWFHRL6YqS6aFP9xxCAUCskpp7Iac5rvvAjuKCVQsVwnaw6vj
         yjJzBhSw/BJFAdx3NxQeebxlUxOAv3gZbT87PIX5e1spLX3uEIMgp3U5xTp1vKxwke3q
         ft4TcZ8iZb0rmxG7Vz6/6kTYVmeP+7GOp+0AhyleS2SAEyXzUk3atZRrR4ZH+Z1tQDYo
         fkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yxjkQuo+JrBQVW5jsMJKlRLI/Cm+CfAkEf/rYRZsemQ=;
        b=OtihmPJ55G0Gmcc4Ab6WJ+sqAKXLQcH5D1DTPoFNX7vvM5Jxbo3aVjNNE++PXDbQHo
         aUsTZZOdT4Cc/Xdvft+TFwJY+AXRTZgVNNd5asdurUEmvjjfaEdIa/Xit1/+fCfqUlau
         +WM4FfXv7nILEXGh83UFuTbPwkTU0jG3f3n465og2ti/yT989mfjeH2Zojsj2dLYv943
         BqcUY39+n3nBqOE7X3lm/ya9BzQoXforn/zDA721JjDjAtPKPkE03FNvduRUu8f8Ul+P
         b4X7kb71EpMs29om3ObAJ0afSFLl5aHIrmv+oJw1x/Yo5dfwwKtw7b+/Yc3+BqteZCxq
         oHcQ==
X-Gm-Message-State: AOAM531zzd3j2NMV1yu4N/Q5H5J5NvQkCk0ki0F0UwTayM+ZBNGsxV4w
        2qq9gF+oFQTQzP5nhZG1jkFWNzZVd8OoD+WjMBFXSHqSzoA=
X-Google-Smtp-Source: ABdhPJxOMMXPfqHVFvrSHM3JpaHMwKWPAW3PW4RLm1h2WMPlCpqDTkzoDzT1aolWSLcsefgMIMjBzoAotfA4BrDy6zk=
X-Received: by 2002:ab0:5928:: with SMTP id n37mr7898390uad.15.1633368497907;
 Mon, 04 Oct 2021 10:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
In-Reply-To: <cover-0.5-00000000000-20211002T091212Z-avarab@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 4 Oct 2021 19:28:06 +0200
Message-ID: <CAFQ2z_PyPCx3MB_ky=tjck8jwu7AochU4gAX3UGM0g9ixj3sdg@mail.gmail.com>
Subject: Re: [PATCH 0/5] COPYING: modernize, steal boilerplate from linux.git
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 2, 2021 at 11:19 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> There's patches to git.git to add a BSD-licensed reftable/ directory
> with its own "COPYING" file[1]. I think that for such a thing to be
> in-tree we should have some note in the top-level "COPYING" explaining
> git's license, but that subdirectories or other files could be under
> their own licenses.
>..

Thanks for looking into this. This all seems reasonable to me.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
