Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03A141F576
	for <e@80x24.org>; Tue, 30 Jan 2018 09:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751322AbeA3JLI (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 04:11:08 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:46177 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeA3JLG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 04:11:06 -0500
Received: by mail-oi0-f45.google.com with SMTP id l6so1075673oii.13
        for <git@vger.kernel.org>; Tue, 30 Jan 2018 01:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZrqu/pVHO+QcYkwUSu4r5/IyR+BmE7ngh8OIartLnE=;
        b=bB9c6JPvtptkENrePtgGBwhw+Iuw3kTjuij5D57AgFE4kLlrCvMUWAuRwZD20MhUsy
         zgXp3cSkiXfUUaKhXXF5WoxXiwEkqJ9AiCGJHP0+U27GiM5ayuokXyT2Zu30+H0t+j3g
         HPkAdxZblVt1l5IUoVKTnPONEPSgZ0wGj7vqY+bjKHbnCxjNa2rnM4aLujebaZw6llGP
         F6UYW8JrgPPvbbOHWH8zluYEzldSouwAQew3QdQ6EQ+J6oY9Ys0cUyoeIfT4UseAHWey
         zCGfv6RGLy7DaHjACOGL8Yseh07YdCYIjt7qCXN2IgbTPf4PkteJdeWwlog15d73iQnI
         ODGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZrqu/pVHO+QcYkwUSu4r5/IyR+BmE7ngh8OIartLnE=;
        b=P9doQPCTrqcCE6+NEsBtPbaBHTCoHPLllosdxoD6BYS3M1XsaC47JU0WS6SAI5Grw1
         lwKy7H+s1rcXw/TUndzVuNhNfMTD8coAKIxe7r2ga0o653OU3PLTc8BEAyRhFWvnwpbq
         RQWUFHWGpExjYDMxkKYI4te6HHopuXjdpGqAFy2+EMvMb/8sMKmjkHuQ7dCm0AtD/7aP
         UAm8ZrdapHeNRQ0ciQhIg/lBQ+5Va1yLwHdZpGsQQtXKjiFT8+uEqoATDXyiCqxVlDfu
         Y7MIYg3QTW4+0LxDh+Z+87lTnq+L11KMxhwUvKjBSWpK7vjUKD/FJVJswu8z+v2nvTm3
         iDrA==
X-Gm-Message-State: AKwxytdWc3Q8s8DgSo0bwaHwzFXfeoTT4oeHRhbQLRVkzo6PPeF8pUCN
        g5jKxqqbwTprdYiAGbCb7HU2pvgv0+/6t4mFyUA=
X-Google-Smtp-Source: AH8x227AP85OZCJhW5ehcx0pplYhv/xQeroXS5x9s7ipnLh1TuFRefABhRzongiFwbixINh6gsuKC8haN0v1X0pTD80=
X-Received: by 10.202.49.73 with SMTP id x70mr4165018oix.351.1517303465475;
 Tue, 30 Jan 2018 01:11:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.102.205 with HTTP; Tue, 30 Jan 2018 01:10:35 -0800 (PST)
In-Reply-To: <nycvar.QRO.7.76.6.1801291609060.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180126095520.919-1-pclouds@gmail.com> <nycvar.QRO.7.76.6.1801291609060.35@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 30 Jan 2018 16:10:35 +0700
Message-ID: <CACsJy8AH+xg3AB3qaqnFud4B8HHeyaO=8DqHL+p4HTTeSx6uYg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add "git rebase --show-patch"
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 29, 2018 at 10:09 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Fri, 26 Jan 2018, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> When a conflict happens during a rebase, you often need to look at the
>> original patch to see what the changes are. This requires opening your
>> favourite pager with some random path inside $GIT_DIR.
>>
>> This series makes that experience a bit better, by providing a command
>> to read the patch. This is along the line of --edit-todo and --quit
>> where you can just tell git what to do and not bother with details.
>>
>> My main focus is "git rebase", but because rebase uses "git am" behind
>> the scene, "git am" gains --show-patch option too.
>
> Makes sense. I am not a 100% certain that 2/2 catches all rebase -i corne=
r
> cases, but I think the patches are good enough even for `next` already.

Not so fast :) With Tim's suggestion about using a pseudo ref and
AEvar complaint about potential confusion, I might actually go with
pseudo ref for rebase (and leave "git am" in the cold for now).
--=20
Duy
