Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEB381F403
	for <e@80x24.org>; Sun,  3 Jun 2018 15:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbeFCPOr (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 11:14:47 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:38686 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbeFCPOq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 11:14:46 -0400
Received: by mail-ot0-f194.google.com with SMTP id n3-v6so34655674ota.5
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bDS+RAdURjHFDo62aZkizDTTep+qHHFUFcSRSegLR/c=;
        b=inNp4nL7BfphwX8rZ0wyFvP1H6jE2t14hkWBKPnqMe53pH0J7l+f1MO017LFz2X5sr
         laSIzHrPB9F7cJy781DXgEQOEeHXWGLIa12udNzyhPU8jlAws0QKV5KZ8lSbzluhac9b
         LKZ5SHnt598NSLCsjr8C2gLzwy++yOakuBipZ3c+68zdYjtq95UycVZFS35PrwZmmgfD
         ++rTRBuUjC2MrseCEVjpdOFYZQ9DmRsrMYsI694hXKd/qfzEYqEkoABF6/xDPQM9fWMw
         kd0DXL9LuPStJMuzXOgFz1NVRSL2T8KM3OBb4Qix0vclhrgB1+mmMJS14Sqs7qdjQkEJ
         Vpfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bDS+RAdURjHFDo62aZkizDTTep+qHHFUFcSRSegLR/c=;
        b=KPjdIpEIQiQ8koxbVrfjer6BI2+s9ImwIrDw33yD+hpHrqcuDH+27wy4+R0wDKVPX0
         k9CQPpogD0IbTQQQ5OfzNaXCn5NdKRweYLrEXyuhJJIvGAjRtS4l9LghLI12j5tFO5ps
         9lah+yqDrISH45SYhbflF7XVh0fKEy3HfAQQeVhose5TjMb8JepdQmpGGPwnaPNCU9qg
         QuxD7dHcb5BJSxQyNWrmQbFAbgYJmr2Z0lmqhaNBwKR//aWqI4LPCW0VB74RVScOoMmD
         SIr1d3fmooW8DRqj9uAlPQ5+Gh/AOrrabNRcP4aIcDR8Oelr4uMqOUKhAZG0/Ge2k9fs
         RyAw==
X-Gm-Message-State: ALKqPwediUorGpYDYtNzX/+0IU5plkxBzBAYslC5/iJXnObdIkvbQaw9
        2MPaDPZDNYCygS0+E7kO7qH3V4bSD0ghyGnMEBE=
X-Google-Smtp-Source: ADUXVKKjqZn3H/YbA3CxBgOVCcRMSrjdoi1VixCreiJyjAU+pIoLT9HRDW4pgfZ2GXRiUFSJlbCg7kOb4i1aajjzxi0=
X-Received: by 2002:a9d:c61:: with SMTP id 88-v6mr12820270otr.173.1528038885694;
 Sun, 03 Jun 2018 08:14:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:b285:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 08:14:15 -0700 (PDT)
In-Reply-To: <CAPig+cRCJbZxaO6vmt+8D7aOLZDGrDVDMB97zfRAfwmtRPP_Zg@mail.gmail.com>
References: <20180602043241.9941-1-pclouds@gmail.com> <20180602043241.9941-20-pclouds@gmail.com>
 <CAPig+cRCJbZxaO6vmt+8D7aOLZDGrDVDMB97zfRAfwmtRPP_Zg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 3 Jun 2018 17:14:15 +0200
Message-ID: <CACsJy8BXHDK8s-tSVkMG8sSu+DXwKxSkGqN+7ME8Lm9CjOx9GQ@mail.gmail.com>
Subject: Re: [PATCH 19/22] sequencer.c: mark more strings for translation
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 3, 2018 at 10:16 AM, Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
> On Sat, Jun 2, 2018 at 12:32 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y <pclouds@gmail.com> wrote:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>> diff --git a/sequencer.c b/sequencer.c
>> @@ -2597,15 +2597,17 @@ static int error_with_patch(struct commit *commi=
t,
>> -               fprintf(stderr, "You can amend the commit now, with\n"
>> -                       "\n"
>> -                       "  git commit --amend %s\n"
>> -                       "\n"
>> -                       "Once you are satisfied with your changes, run\n=
"
>> -                       "\n"
>> -                       "  git rebase --continue\n", gpg_sign_opt_quoted=
(opts));
>> +               fprintf(stderr,
>> +                       _("You can amend the commit now, with\n"
>> +                         "\n"
>> +                         "  git commit --amend %s\n"
>> +                         "\n"
>> +                         "Once you are satisfied with your changes, run=
\n"
>> +                         "\n"
>> +                         "  git rebase --continue\n"),
>> +                       gpg_sign_opt_quoted(opts));
>>         } else if (exit_code)
>> -               fprintf(stderr, "Could not apply %s... %.*s\n",
>> +               fprintf_ln(stderr, _("Could not apply %s... %.*s"),
>
> Did you want to downcase "Could" for consistency with other error
> messages, or was this left as-is intentionally?

I'm not sure. Others start with a prefix (like "error:",
"warning:"....). This is a bit different and makes me hesitate.
--=20
Duy
