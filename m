Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD08202A5
	for <e@80x24.org>; Wed, 27 Sep 2017 11:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbdI0LaD (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 07:30:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:37680 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752296AbdI0LaC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 07:30:02 -0400
Received: by mail-io0-f193.google.com with SMTP id 93so6071502iol.4
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LBPJMfYLfwv3Xw0zY8uhD8Mo0k88zAuBda4fFogQqE8=;
        b=b7fVlqkUIX2mC+ApvgVxcm4yOlFwFebeeusKqg3p73tc6jErS+X+ZaFr3AHv+lD3oP
         eiFkZwOoGGD6e0656SRSaK60x+kbF1UtahJ6TdO39VGRN2NWXiazcG2km/0HSQ5hBlpz
         NQyOafZn97ngaloM2ly820oVNQtIyHvB5H8kiKTHLLV/dxJMM4ne7jtIktY4c6KBvEkZ
         D/6c8KPY5aXRhF7SP0w+fpYmegunI3ga2Yh/ko1nUSPXeJsEpPs9LdQD69tB3uCNdkar
         57MV7ubaDH24W9sAQ6yVqt0srynTOxSGESubRXRrZMP+qR7vOBdmFQo4DC0UNFj7MrWV
         3mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LBPJMfYLfwv3Xw0zY8uhD8Mo0k88zAuBda4fFogQqE8=;
        b=Rw7NoPHX0nqweDp5OgBlGP2ahwYwNF7DI7oQ6LV1K3tnCXa8k81m56GgXG0mwp9S8P
         6TFvckunRu5EGVnpY2RWFLvfPB38Xwfs6Y/YeWak1ATJYk1TKHAqviYzdHVdfukogrQW
         vzTE0uO/Tdpt+xpZK8Zq8nn2Mrqx9fgQDZl5fh3c88Q/yy/4eOI7kjK3+LhurPK6gTYL
         x9h+laQHVJ+kxKZNQo71uG4sRMAvs3Mr67dIIk1dWvY4WI7IqK5a07OmvHkw9CQ8BANQ
         O6qaMqaFjyTro5znlhtacH0Vbxr/rzxKc9SypXs8F2pidXkuDQlafySJ7R9n3gzrfIQQ
         OGrw==
X-Gm-Message-State: AMCzsaW0Sf1b09z1Ro4FJ3YIIaylC/+FOXPUQ0rnACmTmjp33fYAmg6E
        y61vdfqJ8eWMBjrzUqAPketNkBPNIgYgcY5KKjI=
X-Google-Smtp-Source: AOwi7QAhPx80EWyMyK92kkkBa8C5NZki4DqSHlxVvblcC1U3SNzVD+YAZo0+LB00P8cnJIlFjh+YQwwKBSYHfIhWpww=
X-Received: by 10.107.147.8 with SMTP id v8mr1573390iod.45.1506511801353; Wed,
 27 Sep 2017 04:30:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.107.136 with HTTP; Wed, 27 Sep 2017 04:30:00 -0700 (PDT)
In-Reply-To: <CAL21BmnvJSaN+Tnw7Hdc5P5biAnM5dfWR7gX5FrAG1r_D8th=A@mail.gmail.com>
References: <CAL21BmnvJSaN+Tnw7Hdc5P5biAnM5dfWR7gX5FrAG1r_D8th=A@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2017 13:30:00 +0200
Message-ID: <CAP8UFD24A8rxMfLMFmSStWnBMMeB58SqUdNoo3niQuc7LqRMMg@mail.gmail.com>
Subject: Re: [PATCH] [Outreachy] cleanup: use list.h in mru.h and mru.c
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

About the title, we don't usually start with "fix:" or "cleanup:" or
"feature:". We usually start with the (main) area of the code that is
changed.

So maybe something like "mru: use double-linked list implementation
from list.h" would be better.

On Wed, Sep 27, 2017 at 12:18 PM, =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=
=B5=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
> Remove implementation of double-linked list in mru.c and mru.h and use
> implementation from list.h.

It is important in the commit message to get a good idea of the reason
why the patch is a good thing.
So for example "Simplify mru.c, mru.h and related code by reusing the
double-linked list implementation from list.h instead of a custom
one." could be a bit better.

> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>, Jeff King
> <peff@peff.net>

I think it's better if Peff is on another "Mentored-by: ..." line.

> ---
>  builtin/pack-objects.c |  5 +++--
>  mru.c                  | 51 +++++++++++++++-----------------------------=
------
>  mru.h                  | 31 +++++++++++++-----------------
>  packfile.c             |  6 ++++--
>  4 files changed, 35 insertions(+), 58 deletions(-)

Here we can see that saying that we simplify things is probably true
as the patch deletes more lines than it adds.

> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index f721137ea..fb4c9be89 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -995,8 +995,8 @@ static int want_object_in_pack(const unsigned char *s=
ha1,
>          struct packed_git **found_pack,
>          off_t *found_offset)
>  {
> - struct mru_entry *entry;
>   int want;
> +        struct list_head *pos;

It looks like there are indentation problems in the patch.

Did you try to send it to you and apply what you received?

When I try to apply it to master I get:

> git am ~/Downloads/original_msg.txt
Applying: cleanup: use list.h in mru.h and mru.c
.git/rebase-apply/patch:18: indent with spaces.
        struct list_head *pos;
.git/rebase-apply/patch:152: indent with spaces.
        void *item;
error: patch failed: builtin/pack-objects.c:995
error: builtin/pack-objects.c: patch does not apply
error: patch failed: mru.c:1
error: mru.c: patch does not apply
error: patch failed: mru.h:8
error: mru.h: patch does not apply
error: patch failed: packfile.c:876
error: packfile.c: patch does not apply
Patch failed at 0001 cleanup: use list.h in mru.h and mru.c
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".

I am stopping here as it's quite difficult to read patches that have
indentation problems.
