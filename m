Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5032C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 02:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60916113D
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 02:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbhJDCyy convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 3 Oct 2021 22:54:54 -0400
Received: from mail-ed1-f53.google.com ([209.85.208.53]:39443 "EHLO
        mail-ed1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbhJDCyv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Oct 2021 22:54:51 -0400
Received: by mail-ed1-f53.google.com with SMTP id x7so57703540edd.6
        for <git@vger.kernel.org>; Sun, 03 Oct 2021 19:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FajBJR/3IO0CXmc/KsQyURSGSrxxpwcjIcjyTDbk7SE=;
        b=idYd+yIt88//2YfAUdwr3oCK2OrP9iND/eEI5TndHZ6ugvL7c0Do2ExY4+UMHRRwnp
         i7keVIutQdnt4n35x9KZCk3QexGg+KC4vT+CM700QOy8osrhFyZKzkGwvmV+C1PyK2hZ
         7zvuGI411DmoCTSWZKCeTSTdPXapA1BEPMii9Np3AUAytoqfcUcUL/DbegRrtBYphNQe
         BrmfVQWDTCkiuC086UOTEx9kU6MDXXyjCEPSNMMvgdQRi3pJZQ9NHgbwkjqxQ3WS2uvL
         4QlKUOKUCg0Zlfqaw/QV/mOvlQ8fKud4Vunfyhusx1cM6BYMx0+4QwUZDejChXRwKxo8
         KdVw==
X-Gm-Message-State: AOAM533E7hdFxJeTyBHngZEUjuvb06Uf/Y6q3vD9cbVKwuXUwKLmOidb
        i8I0dgkq6Z1+dmtNovMRzfpm8tkwt407sTSqfN0=
X-Google-Smtp-Source: ABdhPJwscu5+5yC/pRv3rrBl6YbbTKTSijKGeHyy80Ug17SZ71wUliUlhDHfq+IzNSTsWNs9i0ZNIhQ9Zt8wyKK6Fo8=
X-Received: by 2002:aa7:d502:: with SMTP id y2mr9217007edq.231.1633315982261;
 Sun, 03 Oct 2021 19:53:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com> <patch-1.2-7085f951a12-20211004T013611Z-avarab@gmail.com>
In-Reply-To: <patch-1.2-7085f951a12-20211004T013611Z-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Oct 2021 22:52:51 -0400
Message-ID: <CAPig+cSnMe5M43vm2TjKayTE+PLJ_-m3Qmb6B=W_N1-fh2i5Ug@mail.gmail.com>
Subject: Re: [PATCH 1/2] object-name tests: tighten up advise() output test
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 9:43 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Change tests added in 1ffa26c4614 (get_short_sha1: list ambiguous
> objects on error, 2016-09-26) to only care about the OIDs that are
> listed, which is what the test is trying to check for.
>
> This isn't needed by the subsequent commit, which won't change any of
> the output, but a mere tightening of the tests assertions to more
> closely match what we really want to test for here.
>
> Now if the advise() message itself were change the phrasing around the

s/were change/were to change/

> list of OIDs we won't have this test break. We're assuming that such
> output won't have a need to indent anything except the OIDs.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
