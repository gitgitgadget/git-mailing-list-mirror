Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B18920372
	for <e@80x24.org>; Sun, 15 Oct 2017 17:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdJORHO (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 13:07:14 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:46511 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbdJORHN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 13:07:13 -0400
Received: by mail-wm0-f68.google.com with SMTP id m72so29573847wmc.1
        for <git@vger.kernel.org>; Sun, 15 Oct 2017 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Kd7UzyRhCz++UZNku2fucT5czGpjnHueN8EMuZ782hw=;
        b=fZYV0AYvNm77sFsLXeuxqJgoKM8TabLLPgndLv7udlrGYL10OHzT4y9M+CyLfMm0sd
         H7RQACd3XmI+/BhMvyBiP1J0CchJFpxK81qrq81GdqBACTZKG/Le4qe6VDE91SexmfWe
         IAkxoW2DQu70IG224rJtXhFVZA5nm0XAJP32I+t1A2m1nF2hpOvq1IlB3U3wHBPxKYKI
         Vso8SDOnaY/cIQN3Og6KJMd6uLY47Jvn4xFAWPgjlR9vRdp9TsaWpObvQ1UZ+o7O3HdH
         vtbs8dey3j8e2yf+nxxIv6DiU5ayhEcBcfnoXEW5dOAUWuP9W1UyLvyS7Og/a2j9sctn
         BqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Kd7UzyRhCz++UZNku2fucT5czGpjnHueN8EMuZ782hw=;
        b=m+DjCVaPdxQMVkFbk498N+rk+5yyEgL06TFr38DOha1etgnerjVwXdULdCc3tvBDnd
         t+M5XTYbTR+iZ3JH/ISSaiR6FsoAOH6Af4nXhAcWwJFVucqIPW2dC83arLB6ZINGL66F
         8e9fKt8yDFlGfZNEQeRWM4F6sYdqrQJy3nMQfLpVDyD1EaeGrmzsr0K5G+DVQPxZ5sCL
         yaEsFjmN+muTQj/oqw40mC+vN46fYlb76i3xepYh6hQwDnb9rquyaGfvB5PwXUZbsrew
         BQXeSyH1wrEuRGNppXoBCRea/qnfrYs7z+DnMDW0HjVOXhuTK3g2dhEw3aB8+mkBSw3X
         b3Gw==
X-Gm-Message-State: AMCzsaVG5HrjUX1xh3N+nP3ipMky3PG45eKwmpMftunhy/AwT2PYbPVk
        OsRk32QspTYd8oop2VilsEYhTINtJDDeJFNIlvU=
X-Google-Smtp-Source: AOwi7QAL8GEpO4pdWKVx7FGgyqidybQQuaGPQ9Rc+v/rIfY6e7yP+Vouhuq+4md0rduvrnri0uI9jWMNYmUm7i2fk5U=
X-Received: by 10.80.142.212 with SMTP id x20mr10172162edx.285.1508087232194;
 Sun, 15 Oct 2017 10:07:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.172.225 with HTTP; Sun, 15 Oct 2017 10:07:11 -0700 (PDT)
In-Reply-To: <58336f0d-366c-6636-1e94-22afbafdfe4c@web.de>
References: <20171013175157.13634-1-ralf.thielow@gmail.com> <58336f0d-366c-6636-1e94-22afbafdfe4c@web.de>
From:   Ralf Thielow <ralf.thielow@gmail.com>
Date:   Sun, 15 Oct 2017 19:07:11 +0200
Message-ID: <CAN0XMOKjhoi-_bWqOpF-uTtaF8YrmPfR_0RMDePZSzOxAi2bwQ@mail.gmail.com>
Subject: Re: [PATCH] sequencer.c: unify error messages
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-10-13 23:12 GMT+02:00 Ren=C3=A9 Scharfe <l.s.r@web.de>:
> Am 13.10.2017 um 19:51 schrieb Ralf Thielow:
>> When ftruncate() in rearrange_squash() fails, we write
>> that we couldn't finish the operation on the todo file.
>> It is more accurate to write that we couldn't truncate
>> as we do in other calls of ftruncate().
>
> Would it make sense to factor out rewriting the to-do file to avoid
> code duplication in the first place?
>
>> While at there, remove a full stop in another error message.
>>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>   sequencer.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sequencer.c b/sequencer.c
>> index e258bb646..b0e6459a5 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -2948,9 +2948,9 @@ int rearrange_squash(void)
>>               if (fd < 0)
>>                       res =3D error_errno(_("could not open '%s'"), todo=
_file);
>>               else if (write(fd, buf.buf, buf.len) < 0)
>> -                     res =3D error_errno(_("could not read '%s'."), tod=
o_file);
>> +                     res =3D error_errno(_("could not read '%s'"), todo=
_file);
>                                                        ^^^^
> That should read "write", right?
>

Sure. I'll send a new version of this patch to fix the messages. Maybe
someone else picks up the other things. Thanks.

>>               else if (ftruncate(fd, buf.len) < 0)
>> -                     res =3D error_errno(_("could not finish '%s'"),
>> +                     res =3D error_errno(_("could not truncate '%s'"),
>>                                          todo_file);
>
> Hmm, why call ftruncate(2) instead of opening the file with O_TRUNC?
>
>>               close(fd);
>>               strbuf_release(&buf);
>>
