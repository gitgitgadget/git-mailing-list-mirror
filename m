Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6104F1F453
	for <e@80x24.org>; Mon, 29 Oct 2018 16:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeJ3BEX (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 21:04:23 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:38508 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727597AbeJ3BEX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 21:04:23 -0400
Received: by mail-it1-f193.google.com with SMTP id i76-v6so10074746ita.3
        for <git@vger.kernel.org>; Mon, 29 Oct 2018 09:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ks/XkH8ijcuQnT4cXgIUF5Y4U5gmgcbwJkyPckcC8bI=;
        b=O1J9nvgMEP9Hkzz36rVVmNGV2dczj1X1mlZb6E+vJieIeSMdipNoZCVowRdW2tc7cX
         GzhX/kmZAuHofc6oPu4M0LZkocl5wQmbFdnxt+/NwE1UaZNQaIiApvOddylN+YehJNb2
         1uk3+YPYKVl/xPtzeyC9KiW/s2IWtG7MmQBRrrtKNND+TfOYBA+v3eQdlwz1Eyn0ah3a
         4XbkCG7MAGV0MUMshcsgzNlXnLK1V5QJKhTaCDNo16Dr5Z9cu5utO0R8yJCbGTVQgPHW
         cxOEPGluxLsHy0tULIA6Vn3rODWwnTOsgMUXcMF8xwRVZ5kqpOUZdNzKyCU+J2A8bYkk
         +uSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ks/XkH8ijcuQnT4cXgIUF5Y4U5gmgcbwJkyPckcC8bI=;
        b=LEKi/WKz3oVoeecTRGGf6h4L7AgsihadCFO08hM/AQkS1SPg6EgmTaInFSOZk5dmLW
         NjsuJi4p9qDSGTpC8m3I3cOdkFBIKgEd8BPkpaWR/CHq1CkbiPXJO/WVFZuDvk6OK70w
         1aSpYKXTfOwKZXGDVklO40EUarborBokN3OKwC+C3EuKzFNjIi6GMNVaHGvZC5Nq4bkw
         n6OyYdluu7OZbjneykNS1q0S9suZD5B3bQBvwfpl/04jUZesIiqExUbb/dHFX7dYKZ7I
         JJPNRE1I1d4TfC2FqB7O8UWA+UTQHi7h7vG8a+BMBD4FbTlbzWnwLjWlXnZDl8Az5zHj
         tU5A==
X-Gm-Message-State: AGRZ1gKj7Wqa2ezKi9yeIuK/LYU0ddsQMgClRIP5rivUtn0iQ0f1YKKw
        zh/IpBYVBZIJrwFoKvM/fFeek7l/Z2wpu/2cqfc=
X-Google-Smtp-Source: AJdET5eWnoK8tfLEuPvrS6KoXwF/rTIVYZe0GELp/o2SN8ortoz17gucfMX2U/cK/KhZyJbs9EONsB5MINCArp1X9BI=
X-Received: by 2002:a24:b64b:: with SMTP id d11-v6mr1681506itj.10.1540829706451;
 Mon, 29 Oct 2018 09:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20181028065157.26727-1-pclouds@gmail.com> <20181028065157.26727-13-pclouds@gmail.com>
 <20181029105304.GP30222@szeder.dev> <xmqqsh0o3kuw.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqsh0o3kuw.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 17:14:37 +0100
Message-ID: <CACsJy8CE2mi69kXcs2sFYm34txfDb24Qqm4bgv_w3WAcYEEFLg@mail.gmail.com>
Subject: Re: [PATCH 12/12] fsck: mark strings for translation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 29, 2018 at 3:09 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> >> -    fprintf(stderr, "%s in %s %s: %s\n",
> >> -            msg_type, printable_type(obj), describe_object(obj), err)=
;
> >> +    fprintf_ln(stderr, _("%s in %s %s: %s"),
> >
> > Are the (f)printf() -> (f)printf_ln() changes all over
> > 'builtin/fsck.c' really necessary to mark strings for translation?
>
> It is beyond absolute minimum but I saw it argued here that this
> makes it easier to manage the .po and .pot files if your message
> strings do not end with LF, a you are much less likely to _add_
> unneeded LF to the translated string than _lose_ LF at the end of
> translated string.

Especially when \n plays an important role and we don't trust
translators to keep it [1] [2]. It's probably a too defensive stance
and often does not apply, so nowadays I do it just to keep a
consistent pattern in the code.

[1] https://public-inbox.org/git/20120308220131.GA10122@burratino/#t
[2] but then translators can crash programs anyway (e.g. changing %d
to %s...) we just trust gettext tools to catch problems early.
--=20
Duy
