Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 230791F576
	for <e@80x24.org>; Mon, 29 Jan 2018 07:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751412AbeA2Hep (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 02:34:45 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:40814 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeA2Heo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 02:34:44 -0500
Received: by mail-it0-f48.google.com with SMTP id 196so8191444iti.5
        for <git@vger.kernel.org>; Sun, 28 Jan 2018 23:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Xu7wlBgyNSrk7Qq+6rRmkMjVWuGzH1vbZDnx49Cduwg=;
        b=ZVi6iMKdFTVcK/w+oM2FzEkzbULVrDJtK8J/mgqVocWFKjuiQwWBy4goUuiuTHq3uH
         BprHS4hyH8LMnqpIYUMyKjdKdW/nmz0P3hRAMADPwsaX+dxNC/c23y3Up6b4Z0e25DwB
         VbM0oqQr6rjw+KIvWtFLKjsV3P982GLRrMFZw0bHrf3JgrHScBMP17Cxna71yIN1hr2q
         aSvFdhc53t8Kjxen6DbiEiKazwPU4XxSlhLXTYLpyYACrxAeI3TeS2GcRpt59ooLcnvD
         fSMO6MtJkOUkf8rgLmHlyEv+yKJYjvNYOk3GNyc5uvt8KqPG6CLfFD77B76zCMqqpbA/
         DOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Xu7wlBgyNSrk7Qq+6rRmkMjVWuGzH1vbZDnx49Cduwg=;
        b=nc1iVc6NGBpNo0xq0hpiPIIIOxWCjBusY1wraOctKxyBygIz79V4OXsaAt5CuKCrXV
         CbYjF7WlTGTe7O9D387QGM3lcSM7NCbWpaYN02vAHFq9WlmCOIRkWoDD2les0Q0fMzq8
         3yArCTs9ZDFli60yeZKsmo4BOH/qI59eJ8DNtJdRZz/M71MLa81alMVlSTLaN3zZqjsy
         cAm6b9YyeO+GpcVTTS0UuFbzBM/6YJ+g42+RnldF0NQvK0K02y/U666Y7a0lWqBSaiBH
         HwhUPWSiA9NMM3l62wa0JO2IzdPimTQPyD6VlSJQ9/CREbIXXCKJl7gqvRgxXm05kgw8
         aZZA==
X-Gm-Message-State: AKwxytcxspzCvtAsGR0YQuIe8WQbjmOv2Aa9QKYr57xNcQocNxW1zWOD
        eC5j1LdojloGk88p+4tCKIXSp/dpA3QFpmmvJyQ=
X-Google-Smtp-Source: AH8x2269UFcEHf7ZvDYiPobhrqoe0nq0aHH7ahm+P0Szwyl2S5K7gCt4VwpfskRVDQgnnsnhHk/sA72J9q9ORnw9ZKc=
X-Received: by 10.36.137.84 with SMTP id s81mr26794353itd.75.1517211283472;
 Sun, 28 Jan 2018 23:34:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.149.87 with HTTP; Sun, 28 Jan 2018 23:34:43 -0800 (PST)
In-Reply-To: <CAPig+cR77RTTw3uJAwK3XmmvzE7umv3_7M=NkaDEb=uXyNL4FA@mail.gmail.com>
References: <20180128111843.2690-1-chriscool@tuxfamily.org>
 <20180128111843.2690-2-chriscool@tuxfamily.org> <CAPig+cR77RTTw3uJAwK3XmmvzE7umv3_7M=NkaDEb=uXyNL4FA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 29 Jan 2018 08:34:43 +0100
Message-ID: <CAP8UFD3-sTC+eknu2Vfjx+QX7j3AeDaqMMi8L2LQPuSCn3L7Jw@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf/aggregate: add --reponame option
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Philip Oakley <philipoakley@iee.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 28, 2018 at 8:57 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> Not a big deal, but the extra indentation (and noisy diff) could be
> avoided like this:
>
>     my $environment;
>     if ($reponame) {
>         $environment = $reponame;
>     } else if (exists ...) {
>         ...as before....
>     }

Ok I will reroll with something like this and also the typo fix
suggested by Philip.

Thanks both.
