Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FE9F2018E
	for <e@80x24.org>; Tue, 12 Jul 2016 19:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbcGLTpk (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 15:45:40 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36437 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbcGLTpj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 15:45:39 -0400
Received: by mail-wm0-f49.google.com with SMTP id f126so3012181wma.1
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 12:45:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=to4sjLrVNm0EFB2UJOCbXd8P1V0KQiV5h4fDvQpQIeo=;
        b=0Eg7HPcdlUTq2MJfy184ecgSQdCsgNHrfkKbN4Kx10a0Y1M3TPKRQJ0WZYkZ/Ja610
         x/Ea5SHIDBTbdJScZy+115w2/LixWj57+1K4WvKZFxEJiLkkOa4iVPBFSri2OuvcQwev
         9dtgIsiiQyAkG7KNEnnRV5rhVtIchsEiI1q0kkZcmKmU4YPDNQ4TwfgwXLs2MBhcuneQ
         moMjGMzOm0gLigYtpev8lNWmCNHQwM4ag9iJEddLIx0ylpjS8Cm/fv+uUxME0ORam1qE
         JC/scNBu4vMS2/jqW+RkPb7OF1Q1seUtTq2f6AAlrJKrfDl0pB/cASYWgIl72lilgNW+
         tB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=to4sjLrVNm0EFB2UJOCbXd8P1V0KQiV5h4fDvQpQIeo=;
        b=hCYglgeD0BM48NZCK8nk+xJyRs7+pFFEsz8nLJY8K+vtHoypeIS4GPZwIDS4LOOPh/
         DZIJyIKAUSE6yJ7JifSzUDzcKjSG8fz7/tKBIP/uaEmKP9eJvtCPkNnQ/M9C2KBVoyp6
         1mMihm9kCwX2ptUv3Ig5kxxIkW0wTzEdsEGRFNTv7puBC1D58ox/acWkj682tLZdO5gc
         p67xtl1jDKL2U6Vaf7MkkEzGLoy30xajnd/eNlZnt6CDfghaXbNx0q1wYfxCOhbdTgkC
         cUXvGRv3gyiy5V7zaucmiXcaBEextHXQT6r1YwbT7M8LA3RZMAZtTS/cK2Fc+DykgkiZ
         qIFQ==
X-Gm-Message-State: ALyK8tI1JNrsQp+mTVpNHE9xx9j7nVWo6sX3vLgrxkv+AGM+vdNdGVcjMXmwrfzPnuz+Zvks3KZYHWDpuM40HQ==
X-Received: by 10.28.88.144 with SMTP id m138mr5241123wmb.79.1468352725797;
 Tue, 12 Jul 2016 12:45:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.151.134 with HTTP; Tue, 12 Jul 2016 12:45:25 -0700 (PDT)
In-Reply-To: <CACsJy8CEimmc=W=bNcLw+TP0tGRPCL5rr3uNeFMJ=Ms9HkyABw@mail.gmail.com>
References: <20160711172254.13439-1-chriscool@tuxfamily.org>
 <20160711172254.13439-9-chriscool@tuxfamily.org> <CACsJy8BqMFASHf5kJgUh+bd7XG98CafNydE964VJyPXz-emEvA@mail.gmail.com>
 <CAP8UFD01MiMnz6qNGYa9WEjZ_EOy-hBqO4gGKGyxUc71aOyp4w@mail.gmail.com> <CACsJy8CEimmc=W=bNcLw+TP0tGRPCL5rr3uNeFMJ=Ms9HkyABw@mail.gmail.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Tue, 12 Jul 2016 21:45:25 +0200
Message-ID: <CAP8UFD2pes3MD9FNBtvLYS5785aJoGPz00Fj+fHjy03j0aKjFg@mail.gmail.com>
Subject: Re: [RFC/PATCH 8/8] read-cache: unlink old sharedindex files
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 12, 2016 at 5:12 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>
> No. People could create an index file anywhere in theory. So you don't
> know how many index files there are.

Maybe when an index file is created, its path and its sharedindex file
could be appended into a log file.
We could check this log file to see if we can remove sharedindex files.
We would need to remove the entries in this log file for the indexes
that are no longer there.

Or instead of one log file we could have a file for each index file in
a special directory called for example "indexinfo".
So we could just delete the file if its related index is no longer there.

> It really depends. If the shared part is too small for old indexes, we
> might as well unsplit them. In practice though, the only long-term
> index file is $GIT_DIR/index. If we don't delete old shared index
> files too close to their creation time, temp index files will go away.

We could treat $GIT_DIR/index specially so that if there are no temp
index files, there should be nothing in "indexinfo".
