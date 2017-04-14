Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D309620970
	for <e@80x24.org>; Fri, 14 Apr 2017 13:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdDNNBY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Apr 2017 09:01:24 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:33977 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751511AbdDNNBW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2017 09:01:22 -0400
Received: by mail-oi0-f45.google.com with SMTP id x184so3731141oia.1
        for <git@vger.kernel.org>; Fri, 14 Apr 2017 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zuI+spcUmY/qGyjd3xfBfgD6bKGXfzGPBxXkr0rhuSM=;
        b=qCvZh6Lr6QzEjsFAZZkc741kFZqIgev6leS3tQwtpJzl91Gp4sx7WdeEKtKxulwX7n
         Pj723IZK8b3a/P7UE+jvHEjBxg5xjeUZLLCVgrM0/tCLwcNpaVNTKks9cxSUCc0pqP8p
         zCw1ybcDbRjnloO6BoX7fjf+dCFqKP5jIQJLkswRLCQ21CpLSBn/OJ8q9PDKDTz7wIJu
         P1vddV3bXsKCjcbbIa7SkEKO47V/ajETJhiwgrSWxB57OAB2dGkKRTHyhOqlCUmYaxXT
         TTyi6ceHIHb7FD8D71Q505aoZ2uof301hn5QrGYbL2gB6d0lsHiZaxOJX5YzEdjyYeN1
         am/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zuI+spcUmY/qGyjd3xfBfgD6bKGXfzGPBxXkr0rhuSM=;
        b=NxVHhTS2fgfSTtN8YqaYbS1A03W9mAZgrhbGnRGkK/BwIgpG4tQNLzXgEVQK9CNOm7
         7UFptHazwXPtjUVC8kea+TTcmlcyz6GnDixROmiBX6FDnMQiDDoc09tZNl4pB1TcW6ok
         mV5MN7oYw+RlKXo57RCteHH1xYI9AUb9s/5/88ReOvLYiXryGNTA3whHwi8opuDNc6sY
         itU3bEkHzu5uMAtG1i/JEoI+mkc1P2L93rQkZVpH/Fnkby1tQ8qMUsbJLImVezn54Ewj
         GEclcPKhmwN1cLdoC0oxhaKO2N4Z2qME+eLv7S9n8WLSE6XUu0NMCN4k3/r4i///iZs0
         DmWw==
X-Gm-Message-State: AN3rC/774mtDJhlaCd9U5JIGoBKz7OJtjH05hyuogEqm0tcOTg5o54gr
        ccyFgDECBUT3C18yi9Twhb5YA/llGg==
X-Received: by 10.157.28.165 with SMTP id l37mr4908225ota.199.1492174882056;
 Fri, 14 Apr 2017 06:01:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.70 with HTTP; Fri, 14 Apr 2017 06:00:51 -0700 (PDT)
In-Reply-To: <xmqqy3v3orc3.fsf@gitster.mtv.corp.google.com>
References: <63F1AEE13FAE864586D589C671A6E18B0CFBF7@MX203CL03.corp.emc.com>
 <20170412135805.29837-1-pclouds@gmail.com> <xmqqy3v3orc3.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 14 Apr 2017 20:00:51 +0700
Message-ID: <CACsJy8D_S+KNTxLp7QT5KzvCmdjuQZ++saYAaikkO7beRDwzJQ@mail.gmail.com>
Subject: Re: [PATCH] worktree add: add --lock option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "taylor, david" <David.Taylor@dell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2017 at 5:50 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> As explained in the document. This option has an advantage over the
>> command sequence "git worktree add && git worktree lock": there will be
>> no gap that somebody can accidentally "prune" the new worktree (or soon,
>> explicitly "worktree remove" it).
>>
>> "worktree add" does keep a lock on while it's preparing the worktree.
>> If --lock is specified, this lock remains after the worktree is created.
>>
>> Suggested-by: David Taylor <David.Taylor@dell.com>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  A patch that adds --lock may look like this.
>
> This looks more like "I do believe the idea by David is a useful
> addition and here is how I did it to the best of my ability---let's
> make sure we polish it for eventual inclusion" than a mere "it may
> look like so---do whatever you want with it" patch.

It is a good addition, which is why I added tests and documents, so it
may have a chance for inclusion. I would not strongly defend it though
if there's objection.

> To me "git worktree add --lock" somehow sounds less correct than
> "git worktree add --locked", but I'd appreciate if natives can
> correct me.

That was my first choice too. Then I saw --detach (instead of
--detached). I didn't care much and went with a verb like the rest.
--=20
Duy
