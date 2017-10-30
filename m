Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3F50202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbdJ3RpT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:45:19 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:50880 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932115AbdJ3RpS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:45:18 -0400
Received: by mail-qt0-f193.google.com with SMTP id d9so17452852qtd.7
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NIFK0lKNy5TW+wgC169eEcxpGoAIedOJq/dgZUJQObo=;
        b=Tyu76BweYHAV5g79L3cwABfE6DnqWw1VMuCtfvRvFQxgIRcnR2VCnpchX7qmiuxS7L
         VGM5ljZZXKfGR2NS3qb/10dK8D8oZXFtvNKTMWPS0vGVQ9TrrM796CCCr7m4rgF4/63b
         +irnv9X3v1wb1Eg3OZeNhPkufWihmQM2ygwo1yUoUfOHS1aey9qYbrepzMRQgQuFjVNz
         OGaClXW3SobrNVhGQEdbBoLHSmm/CawH9I2wcvLQFJhhmphYbuCKOAfGS+qwbErf4Ly8
         HlvB63MO6AGumw8DpOhljJiQhguJL9ZnWuxO99noCyBBlQhkiaBXM1077wn7A9LIYDC0
         M9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NIFK0lKNy5TW+wgC169eEcxpGoAIedOJq/dgZUJQObo=;
        b=YzpmpYaSyflhS4OmCNiz6PIUcrYE0ns7AmzjOFnKlNLUe8fHEXTeKoBCPn6UK+ugM7
         bMlHBEcG+gfyZI+pbVpRp4XJSNdXctM5dEPQ7UNQJCM+EytB0pS87tSt8wDYknNDCejy
         STv1nsnVqpbyURZ95LI6VlphQdWMfmqZRomV9pm8g50ELJvhVVnlXuL8zE3WUb1Ch3K6
         ckO3XB9H5IbrDTOF2yzZ7xotB+S1Vd7DRWUmSMT6zqtDTe0Q4FJnLB8EyizNOtevcLpf
         0pHzUSsm6h/5mn4yRVJoE4gsbFww8IXNkph9/5zpq7ErcoUAXuza3yJY+eQ593XQqKXe
         cPbw==
X-Gm-Message-State: AMCzsaXMECg/6KpQzuDGvlFTj9KZrmdyQNG6JDaZrdpjvim2WR+hzOaj
        5pqWk6VWlCmOtWl4ZuXJpJ3/9hE5WH3MdLVhnek=
X-Google-Smtp-Source: ABhQp+SOjlxPp5zUpL1urEUFUk1I7lh3TT0AIntpCaD8pGzvLLlDbvw3oHOY0kD2mqCc4NxRb84YFuY8AZytfimD9/4=
X-Received: by 10.200.52.56 with SMTP id u53mr15121313qtb.16.1509385517941;
 Mon, 30 Oct 2017 10:45:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.28.246 with HTTP; Mon, 30 Oct 2017 10:45:17 -0700 (PDT)
In-Reply-To: <CAN0heSrWbgNEfeXj0D0SBiyC_9i++qecBcb5Kuf4WtS1wFxKDQ@mail.gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
 <0102015f5e5ee303-449f1b76-ff53-433c-8973-8b4850466810-000000@eu-west-1.amazonses.com>
 <CAN0heSrWbgNEfeXj0D0SBiyC_9i++qecBcb5Kuf4WtS1wFxKDQ@mail.gmail.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 30 Oct 2017 23:15:17 +0530
Message-ID: <CAFZEwPMp_sMNVaQxVJNuNGBt0S28J9Ho41ESLuFgsudc+VLbsw@mail.gmail.com>
Subject: Re: [PATCH v16 Part II 6/8] bisect--helper: `get_terms` &
 `bisect_terms` shell function in C
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Martin,

On Sat, Oct 28, 2017 at 1:34 AM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
> On 27 October 2017 at 17:06, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> +       for (i =3D 0; i < argc; i++) {
>> +               if (!strcmp(argv[i], "--term-good"))
>> +                       printf(_("%s\n"), terms->term_good);
>> +               else if (!strcmp(argv[i], "--term-bad"))
>> +                       printf(_("%s\n"), terms->term_bad);
>
> You seem to have lost --term-old and --term-new. I also wonder why these
> would need translating. You break GETTEXT_POISON here, then fix it in
> patch 8/8.
>
> I'm not even sure you need patch 8/8. If I drop these two `_()`, I can
> run `git rebase -ix "make GETTEXT_POISON=3DYes test"` on the entire serie=
s
> without failure. Patch 8/8 also switches to `test_i18ngrep` for some
> usages of `git branch` and for some checks on `.git/BISECT_START`. I'm
> not sure that's needed.

Maybe. I am not quite familiar with what does GETTEXT_POISON exactly
does, so I will probably investigate further in this.

Regards,
Pranit Bauva
