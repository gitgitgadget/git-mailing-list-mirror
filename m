Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 17CD11F462
	for <e@80x24.org>; Sat, 25 May 2019 10:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbfEYKh3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 May 2019 06:37:29 -0400
Received: from mail-it1-f175.google.com ([209.85.166.175]:51255 "EHLO
        mail-it1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfEYKh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 May 2019 06:37:29 -0400
Received: by mail-it1-f175.google.com with SMTP id m3so19901296itl.1
        for <git@vger.kernel.org>; Sat, 25 May 2019 03:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zPUMz0Y0MuTRFuO2pjA4I+SFRvj5zvbc9JVhAYx/KG8=;
        b=alSU4l6SajpUGRYmSbn+IEzjxWhRfCSEjrpJpB2+HD6x6nfC2AncW91Hscc+wYoPYA
         IXbYmPq0+SvR9W4IPHWGUVyvT3CR3bylfuXkmG3AJfQN0OQDRaBKTOsLHNTh8ucXacvV
         j5w9VkayBL7ASs9zcenuvoagt5qzBnfbYQnPnsgyqoHWOR2mcl2WNnoLHyVYQ85OH0/6
         N6OFMpfYIwR+ca3Qv9PX73yWN3tlzWAcx7KMZ8nxETxRN4JoSVgQ+GNQV8B+Payrl3TB
         CvCCD1lcHcplPQ628gsnVTNA9qOfvI4Uv9IKUB0ctyUdqfd/5PrUqOmGljhKKbKZ0D5z
         RkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zPUMz0Y0MuTRFuO2pjA4I+SFRvj5zvbc9JVhAYx/KG8=;
        b=mkdWAKO5VTHL8Jb4Rs3kh6oa0tG/nWcf3xE1K8mi0cdLBgCSuNKb11kA5eqJj/e/Jj
         nKg3YrOw8L7LazblhKepKx4nXifQt6VzjBUSkAvJT0vtmHeKYYTmvBKf9IYnUcQTN2Jr
         7n/xBjCKoUvZejMO6qKAAERhvnQsyJfwLB9KBW0FKB4i7Uk4k+MmOepcP8azQ1TwhmFe
         JEsEw9SJb9mU3+l0iC5VxFK9auY3LcymNm0DmJiejU/AkR53vVeb+WE0K3SmDhyXhybi
         fhZd2lBaH0D+0V6LX44Aq+P6HAufUPKfGSR8BIyzGsBmteTrS0PoFQ01Le5Hs0uqcGqY
         q+5w==
X-Gm-Message-State: APjAAAX0pW4wEmALIX6b8RB1AfG1kmDueeHPWpQgOZdFP6D3lebOjRqa
        neg7TijdL5R28ry7lSl5rxDOZm8sRdKpnfrvH2w=
X-Google-Smtp-Source: APXvYqxAxQGDAn4SChTsSpHSlUzINzVXBNiXukVbc6lLNY3GUSQs4gsFI0QgNmhemshYGYayTUEcRQyn395NnAFaDXA=
X-Received: by 2002:a24:47cc:: with SMTP id t195mr20518116itb.117.1558780648439;
 Sat, 25 May 2019 03:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <82f79cd9-5273-b9a4-744d-f5fa95dd1f47@ramsayjones.plus.com>
 <CACsJy8BHeVDDnEYXaOAPtEoesTVNCiPGSgnJYjtL6aYSU0-J5A@mail.gmail.com>
 <791da98b-4065-e477-92cb-ceac80cc04e6@ramsayjones.plus.com>
 <CACsJy8AzY4EO_io_8R41uVDsbCj+_Fn8YOQ8e+JmAC27dFW7UA@mail.gmail.com> <87mujcf9l6.fsf@evledraar.gmail.com>
In-Reply-To: <87mujcf9l6.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 May 2019 17:37:02 +0700
Message-ID: <CACsJy8CrTEAHesK3ZpwLJqu4fCvMGcW3YH-AkSYN79Db_KmdtQ@mail.gmail.com>
Subject: Re: Incorrect diff-parseopt conversion?
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 24, 2019 at 5:08 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> >> OK, I just had a look at the code in parse-options.c.
> >> Hmm, somewhat ugly! :-D
> >
> > Yeah it's a bit hackish. The problem is parse-options (and also config
> > parser) does not allow passing user data to the callback. Changing it
> > would affect all callsites at once. It's just too scary for me to do
> > it and I chose an uglier way but with smaller impact.
>
> As an aside because I've sometimes wanted to pass such arbitrary data to
> the callback.
>
> Do you mean it's painful to change "struct option" because of all the
> macros around it?

No, it's updating all the callback functions to take a new parameter.

> Instead of all callsites, wouldn't that just be a patch simliar to
> bf3ff338a2 ("parse-options: stop abusing 'callback' for lowlevel
> callbacks", 2019-01-27)?
>
> I.e. a special callback that'll be called to return a void* to arbitrary
> data, and then we'll call the callback with that.

That allows more gradual conversion, but we'll add a bunch new OPT_
macros. Not exactly nice.

If we do this, I'd rather go with converting all callback functions at
once. Though we probably want to avoid going through the same pain
again, by passing a single struct instead, e.g.

int some_callback(const struct option *opt, const struct optval *val);

"arg" and "unset" are in this "val", callback data is in it too. And
it may help reduce those -Wunused-paramters that Jeff's trying to
kill.

> Or, just passing it around in a global variable, since we know the flow
> of when we setup the data, and when parse_options() is called.

This might work fine with parse_options() at top level (e.g. cmd_xx
functions) but apply.c, diff.c and other should not really depend on
it. And we could almost avoid that with parse_opt_ctx_t.
--=20
Duy
