Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C394C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5653B613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:25:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhFDN1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:27:08 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34486 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbhFDN1H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 09:27:07 -0400
Received: by mail-ed1-f44.google.com with SMTP id cb9so11167698edb.1
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+H5KKI0dZKJ4/43puAE6mhS0OtMXCUCO/kY4kWa8UpE=;
        b=Njto0O3Z00VWvBJy2EPdPAc0jCWtjmT99lnOXGj0gj9+sFx+VwktsMqvns7dw9i/WE
         FO7bg5E0I27D84c6GiKpjxqWjRZVJ6OYUUf+5EkCw3WXzUTg+Hgwal27Djls51wADbwG
         tJFIVhC6emivL89l6SW/Ve+Fcp7dqy2Q9kX7JeaOnkGs6kfNFh2Up84hfz03Bt5F7Ty+
         RiTSeHpnHfnGm4m8unjmTfJiQ74RwUr/0i+tIwOBxLZcF9Rw0cDd7B8aXFFNuEUguInB
         /Kxi+dOO4nreM38EE2i/wvyAXxifNy+0SgS1x/PDdKFe+1tl76B0ltfGsqC/n7h+d/jY
         O+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+H5KKI0dZKJ4/43puAE6mhS0OtMXCUCO/kY4kWa8UpE=;
        b=nhigQBwZOIJT08NyBHs6WU5KFY39Ew5+q6d5ES/bgGioCkwcWHT/HXO8smT4kPc/gb
         o6hziUZe2H5Ryt/7yyt2T7Pd1IxId36Gp8f+4Fdat8KcFwdptcFZUAI7Slq0u6Y08KEf
         csRbVgIDNzkkiTGl4GLTj/QM/vxrOBEzuUkMjNR2X0AcDGVexeUftCI0YfZhNYtRdA63
         oqyH9/Gmj03bz8ni2R6lvfT508BstXzAUAcj80n2NlGobyru4VUskwb9iwEeJWORQlmC
         +tlshbnC1sJ09LUBSW1C8BcvUfDYZaGFTUbqKwOR7QUwyRvyw7H7epA3fXii6wHAyqMD
         k5iA==
X-Gm-Message-State: AOAM5301YFo2kd/eOJXLupogudDTGTkGV8LKICcL+36jV9Lcfz7AOZvJ
        6d48GyhnlyUr+1ESzbNFSyJEhxFaSlIi9qRSdds=
X-Google-Smtp-Source: ABdhPJyOQkmOF0RxcfUMso3XBXS5DlHxPwuhFv3QWAGJWTp8e3D5uKIHqRDr0+p8casyIlIGFhbdU+yW6nEWbi5s7ZY=
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr4608044edc.362.1622813049995;
 Fri, 04 Jun 2021 06:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.966.git.1622558243.gitgitgadget@gmail.com>
 <pull.966.v2.git.1622808751.gitgitgadget@gmail.com> <0efed9435b59098f3ad928acd46c3c7e9f13677d.1622808751.git.gitgitgadget@gmail.com>
In-Reply-To: <0efed9435b59098f3ad928acd46c3c7e9f13677d.1622808751.git.gitgitgadget@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 4 Jun 2021 15:23:58 +0200
Message-ID: <CAP8UFD3m-=4=a9XX6Nu45+-4QdeNYi54rXgqizR7HrOh_qk8OQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 2:12 PM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> Add new formatting option `%(raw)`, which will print the raw
> object data without any changes. It will help further to migrate
> all cat-file formatting logic from cat-file to ref-filter.
>
> The raw data of blob, tree objects may contain '\0', but most of
> the logic in `ref-filter` depands on the output of the atom being

s/depands/depends/

> text (specifically, no embedded NULs in it).

> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index 2ae2478de706..8f8d8cd1e04f 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -235,6 +235,15 @@ and `date` to extract the named component.  For email fields (`authoremail`,
>  without angle brackets, and `:localpart` to get the part before the `@` symbol
>  out of the trimmed email.
>
> +The raw data in a object is `raw`.

s/a object/an object/

> +
> +raw:size::
> +       The raw data size of the object.
> +
> +Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
> +`--perl` because the host language may not support arbitrary binary data in the
> +variables of its string type.





> @@ -1765,7 +1815,7 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>                 int deref = 0;
>                 const char *refname;
>                 struct branch *branch = NULL;
> -
> +               v->s_size = ATOM_VALUE_S_SIZE_INIT;

It looks like a blank line was removed as you added the above new line.

>                 v->handler = append_atom;
>                 v->atom = atom;
>
