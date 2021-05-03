Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154C6C433ED
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB8E961166
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhECOXn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhECOXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:23:42 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7DC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 07:22:48 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id y9so1973555ljn.6
        for <git@vger.kernel.org>; Mon, 03 May 2021 07:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BDEhvwFUqiyhu9Nj1ZjG8cNhdBsKgVyQphWpr2JufRc=;
        b=EK1GmyfTg4zjxzuhtAHrU2dxl9rIh/k1kNBYBxP1KbrFKfJPHeP/Uayvqjh/qdNiPk
         NV2O3U4UmaT6U/KHCsFaieuwQNczTtn8nAMx6oATAt7yuZ8w8u/hs+vfKltWB4NtnVXW
         zVt+SknZn6tw6YDIxr0DercycA2qF36R3R8qv/wQoacwfmQhTfyprxmVFqgdLVY48bjW
         XijM9M0ZsFw/uDv+wUtMbA6z9n3njKN00ewgAncozPs09X6SuZC3f32Ifocj2scQ0L/I
         ZsEwY2YmBHIiSChQmL8ll7jH9Mvo5WCnhj9E49SgZYF66dE1JvuPlIqW74q4/AinnydO
         j25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BDEhvwFUqiyhu9Nj1ZjG8cNhdBsKgVyQphWpr2JufRc=;
        b=qV663AKnT7Id8bRXcyYyKAIYOlf6UnKzJPm/IEODjQlUCWn5ql9vdr+N5S2H3by++g
         He5d4HHdD0e27r+qFi8S9V3UMU9pZo6phMp7TBimq2kCyO2MdTxbqC7OlickBg28VEkM
         jOOY3QEdrpF/RG7wuq8pDBWmEFc56+jTIWvbVT299zJhxe2PXNP1VyF7j+tDFsZ138p0
         TFbnvB1+HC/QyAnWbddTSRA1oX9kzLavf3+1oysjZ00nBx/wl9MhsyzVtyXs6wzn2tXo
         VRY93iKqMl0C23cwPmTO7gomBoo+RVs6Ijli4vedM/itbkTWQvVrfx0+dIlwWJxpG6rj
         1PuQ==
X-Gm-Message-State: AOAM532U0b2FUSMScW9Qcd1INwcMwLwgH7+aAKe6ZpfpC/StK/iksfJz
        Yu6ULHjtVdo8293ZvNZz6eZ3mmsK14E/MIntplL2oQ==
X-Google-Smtp-Source: ABdhPJyQB9mubLS9amUqO9+5zSyFg8wo2GY27Pu+yCiaP4AjqYGhIR9lFql44KEiiCIDwKBOiyEPRH8HdsQcPfBMz7A=
X-Received: by 2002:a05:651c:513:: with SMTP id o19mr13759990ljp.291.1620051767372;
 Mon, 03 May 2021 07:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619818517.git.matheus.bernardino@usp.br>
 <0fe1a5fabc8cb5f7c2421afaefae030d399d28ed.1619818517.git.matheus.bernardino@usp.br>
 <CAP8UFD1X6ZZXCMfEDfJDjr0mB2XwQAvuhTAT0beJka-QR2k6nQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1X6ZZXCMfEDfJDjr0mB2XwQAvuhTAT0beJka-QR2k6nQ@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 3 May 2021 11:22:36 -0300
Message-ID: <CAHd-oW7oeoQmoqkWCYRvsJ9JbqdrefQhQceami7BgohLYmYRzQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] checkout-index: add parallel checkout support
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 1, 2021 at 2:08 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Apr 30, 2021 at 11:40 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Note: previously, `checkout_all()` would not return on errors, but
>
> s/Note: previously/Previously/
>
> > instead call `exit()` with a non-zero code. However, it only did that
> > after calling `checkout_entry()` for all index entries, thus not
> > stopping on the first error, but attempting to write the maximum number
> > of entries possible. In order to maintain this behavior we now propagate
> > `checkout_all()`s error status to `cmd_checkout_index()`, so that it can
> > call `run_parallel_checkout()` and attempt to write the queued entries
> > before exiting with the error code.
> >
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
>
> > @@ -142,11 +143,7 @@ static void checkout_all(const char *prefix, int prefix_length)
> >         }
> >         if (last_ce && to_tempfile)
> >                 write_tempfile_record(last_ce->name, prefix);
> > -       if (errs)
> > -               /* we have already done our error reporting.
> > -                * exit with the same code as die().
> > -                */
> > -               exit(128);
>
> So when there were errors in checkout_all(), we used to exit() with
> error code 128 (same as die())...
>
> > @@ -275,12 +277,16 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
> >                 strbuf_release(&buf);
> >         }
> >
> > +       if (all)
> > +               err |= checkout_all(prefix, prefix_length);
> > +
> > +       if (pc_workers > 1)
> > +               err |= run_parallel_checkout(&state, pc_workers, pc_threshold,
> > +                                            NULL, NULL);
> > +
> >         if (err)
> >                 return 1;
>
> ...but now it looks like we will exit with error code 1. I see that
> you already answered this comment in the previous round of review, but
> you didn't add the explanations to the commit message.

Oops, good catch! I'll add the explanation for v3. Thanks.
