Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5C4A20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 12:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeLLMk2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 07:40:28 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:44714 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbeLLMk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 07:40:28 -0500
Received: by mail-yw1-f65.google.com with SMTP id i22so6881304ywa.11
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 04:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RvRzH0HIK2jUS8W1nYfCDViRy+1Tfr41yYmwZ1zxg8A=;
        b=GA17Dm59C1NspZJT+gsFjkX/UUrmDc97PwmGeyKg4BGv9ZSs4dIDcVFK+cFw7wxQfm
         CG/fOPp6bY21VvxTbiRYsusGQvwGlLkbPdbu2iaKRMfUE68xU/yUIl9E+JNKpmZMVik2
         GX2w0HnGhXvLW2hAF9wEKEUgMNnfXtGT3zrA3mrfe6kVuPqLDTZ0B21qSOAchFzGwVmb
         9kC5raI55Fe1xUauyaFTGHmurXpUpI73hJFN4TA00DhlNAzPhXC7UN/fB41So/o8bvLZ
         pnjDNGQNahtkvLLm5NbDXqYCKWScwiWSaI5t8YvhZJQrLMLurqDwi4gS7PLgL61eU5AG
         B4tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RvRzH0HIK2jUS8W1nYfCDViRy+1Tfr41yYmwZ1zxg8A=;
        b=pFP59RqUyd54eoUpsCaJVVno0uzKtRfDWNEOt0oqK4jaA+4xkyNQs92PNYTyDBgwO1
         p3i/2UVsdVTK8zLCvGE5uRHk16SAiO2NJkg4BC561kQWvxUpNETYAAaJp1aZJxutjozC
         u4TKHKedIeSGsSCmq8dSjCF9OWke0ZVe0BR+aYkM99SftZkq3Ys2wdEpehCTyhGjdWkn
         t5Q5Ugbn9U5g/sTM/3c++g6SEkh53mIbT09LtVH9ClU12E/jKvTevEAMXYE8vmXaIGX7
         s+9nyIzYmbM653prsa0KEqJU+CQMmwd+k+U9Exonv/UQxomS/ZZ1TNoL69j9tkQwW7i9
         EPzg==
X-Gm-Message-State: AA+aEWZomUD6fBCl1Bw89Y1bBCW/V6tbnN/DmyAG6O97IJxjQRjhdwlf
        a5kMA3aeJqLGAwOcdHwAOoFBboiTZvM5txIJTfdkmsj4G8s=
X-Google-Smtp-Source: AFSGD/VqKyXibaYQEKfPwG38fS4BrMV4nesjdMxzyVgWrhrr9utMnydeu8Jk/zypiYO8JLHhGwj6XupDl7YzAtTllR4=
X-Received: by 2002:a81:27d0:: with SMTP id n199mr20730853ywn.350.1544618427277;
 Wed, 12 Dec 2018 04:40:27 -0800 (PST)
MIME-Version: 1.0
References: <5bf18396.1c69fb81.20780.2b1d@mx.google.com> <20181207170456.8994-1-tboegi@web.de>
 <CAAXzdLVTjCVDmBik-j9B_Z_2wgSj=_6baqmjmGEGBFOsjkyOsw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1812100938140.43@tvgsbejvaqbjf.bet> <CAAXzdLUKhCfvqdvsPryeMGJ2ttJxof4sUcyTx-xd5p2BaoryiQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.1812111429320.43@tvgsbejvaqbjf.bet> <CAAXzdLU7dJGOW689tDkYuRYko1zYHXMcj_2PaVa0qStYA7ELNw@mail.gmail.com>
 <be24f331-5c8f-954d-e6f5-d5b09ee4e5f3@kdbg.org>
In-Reply-To: <be24f331-5c8f-954d-e6f5-d5b09ee4e5f3@kdbg.org>
From:   Steven Penny <svnpenn@gmail.com>
Date:   Wed, 12 Dec 2018 06:40:23 -0600
Message-ID: <CAAXzdLU0Desw=kt2A3qHx8v=8hvKcN9OdV9fnXEcYiO=ht-t9A@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] git clone <url> C:\cygwin\home\USER\repo' is
 working (again)
To:     j6t@kdbg.org
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 1:29 AM Johannes Sixt wrote:
> As long as C:\Windows\System32 on my Windows computer contains only
> 64-Bit binaries, I consider the characters "3" and "2" next to each
> other in this order just noise and without any form of information. The
> important part of the name is "win".

sorry friend, but thats a logical fallacy :(

http://yourlogicalfallacyis.com/no-true-scotsman

just because the name "System32" is still in use (wrongly, I might add) doesnt
mean that "Win32" should still be in use.

Each name is a separate argument. The "Win32" name has been changed by Microsoft
and shouldnt be used by Git if possible. Its an easy change and I could send
a pull request myself. However just because Microsoft hasnt changed "Sytem32"
doesnt mean that they wont or shouldnt - as you said its just as misleading. We
should fix ambiguities where we can, not embrace them.
