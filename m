Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9B64207B3
	for <e@80x24.org>; Fri,  5 May 2017 14:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbdEEODu (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 10:03:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35950 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751489AbdEEODu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 10:03:50 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so1546863wmu.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/BiTYW1NjpWrQae9jl70Cdi/y2EdvVfAy5QsZPWAUEg=;
        b=S52Pv81wJC4+T0stVJ4mcKP/wqNqVqVYmJwwdqmrJYMuH+YrpmYImp3J+iMIqfJzA4
         h7NA6WigLIIt4kvaD6u957s8pBmD20rLDdLyc+jIl8fCk9WsNB9MlC0d5ElhcSr3OGEa
         kkiKgfeblbVO/rnk3Y+78jD6D03TFtm1z17EsauerFD/5lpw9JJmvic8PvDv8FpMfzlU
         8fj/jzD/Fx6mir0PZkUX+3nDp1itSwleLXoqN2ynRn05pYSQNJ46tb4ZS6RnezZgMZV1
         +YnN3NNnVbQ2gX34aWWmzBMro82WEHjtzPfXXhAfSdwbjPbrmuBbV2sxhOf6alT3nGCE
         4EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/BiTYW1NjpWrQae9jl70Cdi/y2EdvVfAy5QsZPWAUEg=;
        b=nlCbLCE4Qd1FYBEcE7Mra54Sedjg6gmkaOJWXbF8eACEtjiiH8yxusOWweuOh4veDZ
         W/BHPFPVSu2KjajQcWg0grN3bk63UNaDwAwZyPu9iqsJoxf0orVfJID6fN85ws08QJjN
         aevu65gD01js6a0EQAU1MjXGHUUOVFYpDbTUv9dS2hM1vFd42fYG7RucInhdgSQj6ZtF
         HfXkT1gYbhXYRdOPnBVLLj7rwxksyA9weuw2DLHeqBLzkxVZdj19JuGSzZfr9lYOhHAu
         zNPUIFfSymh63z9fdQcfZJiJppgIg0c6NrGmLG81NWRi+4bUx+pHL6Fb36yng3anlymt
         s3yA==
X-Gm-Message-State: AN3rC/4rxdIPErgEWO2zSKn3uFlIe4m+KMz1/G6uYZnPxsGxsFPbC0e1
        NgisGN0pqARXUBZDaoBDdWe4pH6XwQ==
X-Received: by 10.28.134.136 with SMTP id i130mr5583061wmd.25.1493993028638;
 Fri, 05 May 2017 07:03:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.223.132.34 with HTTP; Fri, 5 May 2017 07:03:48 -0700 (PDT)
In-Reply-To: <CAPX7N=6tQi+WidagvV1BA-CoaiNJj7OO4U7GYXNE-QzyvD=QRQ@mail.gmail.com>
References: <20170505052729.7576-1-whydoubt@gmail.com> <20170505052729.7576-2-whydoubt@gmail.com>
 <CACBZZX6EuS86Kp5H+zPf9a_4PrOQqnxPwKdpEdYCXWPspYYp5A@mail.gmail.com> <CAPX7N=6tQi+WidagvV1BA-CoaiNJj7OO4U7GYXNE-QzyvD=QRQ@mail.gmail.com>
From:   Jeffrey Smith <whydoubt@gmail.com>
Date:   Fri, 5 May 2017 09:03:48 -0500
Message-ID: <CAPX7N=5H9vs4LB8SXd6gVd-1APrfhBxaHbFK+AxsSXeKNqOWfg@mail.gmail.com>
Subject: Re: [RFC PATCH 01/10] Remove unneeded dependency on blob.h from blame
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While it was added there (it was part of builtin pickaxe which was
renamed builtin blame), it was actually needed then, but I do see
what you are getting at.

It was no longer needed in commit 21666f1 ("convert object type
handling from a string to a number", 2007-02-26) with the removed
use of blob_type.  I will update the commit message accordingly.

Thanks

On Fri, May 5, 2017 at 8:52 AM, Jeffrey Smith <whydoubt@gmail.com> wrote:
> While it was added there (it was part of builtin pickaxe which was
> renamed builtin blame), it was actually needed then, but I do see
> what you are getting at.
>
> It was no longer needed in commit 21666f1 ("convert object type
> handling from a string to a number", 2007-02-26) with the removed
> use of blob_type.  I will update the commit message accordingly.
>
> Thanks
>
> P.S. Sorry for the duplicate message =C3=86var. I forgot to reply all
> the first time.
>
>
> On Fri, May 5, 2017 at 2:07 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com>
> wrote:
>>
>> For commit message: This was originally added in commit acca687fa9
>> ("git-pickaxe: retire pickaxe", 2006-11-08), but has never been
>> needed.
>>
>> On Fri, May 5, 2017 at 7:27 AM, Jeff Smith <whydoubt@gmail.com> wrote:
>> > Signed-off-by: Jeff Smith <whydoubt@gmail.com>
>> > ---
>> >  builtin/blame.c | 1 -
>> >  1 file changed, 1 deletion(-)
>> >
>> > diff --git a/builtin/blame.c b/builtin/blame.c
>> > index 07506a3..42c56eb 100644
>> > --- a/builtin/blame.c
>> > +++ b/builtin/blame.c
>> > @@ -8,7 +8,6 @@
>> >  #include "cache.h"
>> >  #include "refs.h"
>> >  #include "builtin.h"
>> > -#include "blob.h"
>> >  #include "commit.h"
>> >  #include "tag.h"
>> >  #include "tree-walk.h"
>> > --
>> > 2.9.3
>> >
>
>
