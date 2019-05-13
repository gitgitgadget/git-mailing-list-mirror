Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80D21F461
	for <e@80x24.org>; Mon, 13 May 2019 13:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfEMNYw (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 09:24:52 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40262 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfEMNYw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 09:24:52 -0400
Received: by mail-vs1-f67.google.com with SMTP id c24so7973196vsp.7
        for <git@vger.kernel.org>; Mon, 13 May 2019 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Krin/i/cigeWmiXoIQ0Kg0MaN4tmn9oTWR680ghQZh0=;
        b=TPyJII+WqKaK4Igg9wMKAd11744ckV/nk5ZY/mNUCwDDqNli7oVYq4QaKEHiSnR5Ru
         c5jyXOfn/8SqlBXUZI167TfP/hRFuuZLXOSCglTf+VFuDidKbv7i5Hm8WUH7TO0EZBDk
         2u8+sjusUVpmC+90ZT3hNFFMpJNwHbWX6xuDOGUnALC5KNrdpOnIEtPqAAFo1S1BS0aS
         yXpPc4JFjoL7ZWlesBSA7v322/ZPhd54wDVdv2e/SST2z3npu2CNLgmTj7jAuGiS7PmK
         qQ92q7QeKjv6m0fjovg/BP3t7AxNVK/oSAobUvz+I/5mgYXUcfSzUh6YLj3R7jRzxpCJ
         eF1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Krin/i/cigeWmiXoIQ0Kg0MaN4tmn9oTWR680ghQZh0=;
        b=mjNUgcZEL7SCaiDWl+L6AutGjeiKH1yyjHfrym3dFiG73uCqDGiwRJtdBTICFbbyJn
         QobaWfxTN0eQorojWDQDw5n/YbDKXS22jUZTKBD7mKGE6+7uKCPEdff4J3cBMOBBwFQ7
         2LLdcz6RdPLMcDUq4nJ6W2JFRUVqyIxeveTWKg14vlZctKsFVlqq0Qxr5KuIwBNgF8dv
         262cgOaHBilMs9SkTon7PBHJtfynjbVuBwyIqWcHcJ/adnAqOVf4z+4QzJOqNlKQcpIv
         9KZRci1yusBkv5pZUgG1T5i4i6P557S7mfRHagE/FtwhrXrsQa2qapectqQOjNpbKNiB
         EKDQ==
X-Gm-Message-State: APjAAAU+AU1Ctwcip1mSVIWlueONQgsgNzJj+5gjzd7I+tZy1l6ZRt1U
        ws1ClbfilE76QDvHCrUwYkEhxfe4XO5tO81Hcl4=
X-Google-Smtp-Source: APXvYqwdh2co5m6+h0msr1BwiVIld1du65FYFmqnSQLvUWo63xYAGHY7q47tSGo8eubyfIt03GLBSR16gYykj+HyEsY=
X-Received: by 2002:a67:f985:: with SMTP id b5mr13597401vsq.136.1557753890967;
 Mon, 13 May 2019 06:24:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190430182523.3339-1-newren@gmail.com> <20190510205335.19968-1-newren@gmail.com>
 <20190510205335.19968-6-newren@gmail.com> <20190511210704.w2mxw3jv2ra2dr7w@tb-raspi4>
 <CABPp-BEzaSW_eY1yTpLr8tXHei0WV54PFGXmjCLAJNN03Zi3eQ@mail.gmail.com> <xmqq1s12dcci.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq1s12dcci.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 May 2019 06:24:40 -0700
Message-ID: <CABPp-BGmbvpjWep8F0XGczKyKWVHwQNaJQ4zS=Y1zGrHT7O7DQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fast-export: do automatic reencoding of commit
 messages only if requested
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 12:48 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Sat, May 11, 2019 at 2:07 PM Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
> >> On Fri, May 10, 2019 at 01:53:35PM -0700, Elijah Newren wrote:
> >
> >> This one is good:
> >> > +     if (unset || !strcmp(arg, "abort"))
> >> > +             reencode_mode =3D REENCODE_ABORT;
> >>
> >> But here: does it make sense to use REENCODE_YES/NO to be more consist=
ant ?
> >> > +     else if (!strcmp(arg, "yes"))
> >> > +             reencode_mode =3D REENCODE_PLEASE;
> >> > +     else if (!strcmp(arg, "no"))
> >> > +             reencode_mode =3D REENCODE_NEVER;
> >
> > Didn't realize there was any such convention, and even have difficulty
> > finding it with grep (CONTAINS_{YES,NO} appears to be the only example
> > I can find), but the alternate wording seems fine; I'm happy to adopt
> > it.
>
> I am OK with Yes/No.
>
> Don't we want to treat this as "bool or literal 'abort'", though?
> Other options that are "bool or something else" tend to accept
> "true" as a synonym for "yes", and I am wondering if we want to
> follow suit here, too.

Makes sense; will do.
