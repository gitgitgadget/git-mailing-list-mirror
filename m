Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358811F87F
	for <e@80x24.org>; Tue, 13 Nov 2018 19:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbeKNFVj (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 00:21:39 -0500
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43811 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFVj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 00:21:39 -0500
Received: by mail-ed1-f47.google.com with SMTP id e4so11488269edv.10
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 11:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fvg20TB/PiSIQZLm07EHowuHbu687uIT/PL6sfIG790=;
        b=N43J+mC7qCV7vf+D+9OaMLBCjfRG6SKY+YeYyFMGXi4g5705P1MpSmkdww9miEPT+8
         svOXdcB6iOxP+z1LAm+mJb/8v3yabuyA0SNMKEtoDL7FIVBLW/RtKfU/pXWGQcfWdvKG
         0V8nqAlnR1CA0gd/mNq0ilAv5efMl9OquBiN7pFnIwN+dk9PXtJehjjDr8l0dsySfdMT
         0pdwzOsUYvwvdQ88aq+fcldLxZKx3H5llMFF0fW17s0WYcNMtu7JSeqqlivEDr7AD3lT
         cb0Lb5UrCnrTawS/9k0zAcHfNXUfrQMueHhPNCFtCxn/xgdL092c+m8eoPvie5j0VhxU
         W6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fvg20TB/PiSIQZLm07EHowuHbu687uIT/PL6sfIG790=;
        b=CF7ANn8yXsSsHX7IZMOle9ejRpvOEMbcc60oUJiONGCc8Gi17YeAnf4CoHeD0DNafN
         eYcN6eDtvcbEi38Th5Ni+WSdQf+u5fqkAWoSo0RtEOep4pd83NxmPqcBNfpsg0YNrWei
         74tBlmk3pd4tOiVTF7fTlxsHwEL/tJYaqr47jaGpu/rlnPFWxzY/LdwN6K8vM/jLG/M9
         9/wSDDxHJ9lSeMfACkdTE+loWulYYq+kMPOdtvhP/721agivMtG3k9QWcSxZLBIkMVBJ
         tkdPmU3n7KrpcBV6wr1L0jgUTphi94gFnV8aqb+LauXefD8CJlvYwkBV6wcErwS3BzPZ
         Qa2w==
X-Gm-Message-State: AGRZ1gKpXaOk8cjqTBB8znrjdckXn5XOqsIjecsPe23R3P2ViJENiQGY
        6Kdwa0CXcsVw2qOm2EmUfEFxZRPKPwFrLDdXzRGcYw==
X-Google-Smtp-Source: AJdET5eD+SZNcFGpm92yrj1rYgDLJYnEQOs3MIMvjL/9CV4Pf3EOLxBjAomLKYDx+qi+E3ITOWJ5dng8O2Ma/vJami8=
X-Received: by 2002:aa7:d9d1:: with SMTP id v17-v6mr16874530eds.25.1542136927218;
 Tue, 13 Nov 2018 11:22:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1539305180.git.steadmon@google.com> <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
 <CAGZ79kaPjw3UbYY=XL0gyKp2VxghwaUOJJoDhiO5sQpT8OWerQ@mail.gmail.com> <xmqqy39xwtfs.fsf_-_@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy39xwtfs.fsf_-_@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 13 Nov 2018 11:21:55 -0800
Message-ID: <CAGZ79kYv_a8-6dppo3XcNb8wc0RuTSJeOj71Q+3FmEZguBBUiA@mail.gmail.com>
Subject: Re: Re* [PATCH v3 1/1] protocol: advertise multiple supported versions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 7:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Stefan Beller <sbeller@google.com> writes:
>
> >> +       if (have_advertised_versions_already)
> >> +               BUG(_("attempting to register an allowed protocol version after advertisement"));
> >
> > If this is a real BUG (due to wrong program flow) instead of bad user input,
> > we would not want to burden the translators with this message.
> >
> > If it is a message that the user is intended to see upon bad input
> > we'd rather go with die(_("translatable text here"));
>
> Yeah, good suggestion.
>
> Perhaps we should spell it out in docstrings for BUG/die with the
> above rationale.  A weatherbaloon patch follows.

"Nobody reads documentation any more, we have too much of it." [1]
[1] c.f. https://quoteinvestigator.com/2014/08/29/too-crowded/

I would have hoped to have a .cocci patch in the bad style category,
i.e. disallowing the _() function inside the context of BUG().

That said, I like the patch below. Thanks for writing it.

>  git-compat-util.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 96a3f86d8e..a1cf68cbbc 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -420,7 +420,16 @@ static inline char *git_find_last_dir_sep(const char *path)
>
>  struct strbuf;
>
> -/* General helper functions */
> +/*
> + * General helper functions
> + *
> + * Note that these are to produce end-user facing messages, and most
> + * of them should be marked for translation (the exception is
> + * messages generated to be sent over the wire---as we currently do not
> + * have a mechanism to notice and honor locale settings used on the
> + * other end, leave them untranslated.  We should *not* send messages
> + * that are localized for our end).
> + */
>  extern void vreportf(const char *prefix, const char *err, va_list params);
>  extern NORETURN void usage(const char *err);
>  extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
> @@ -1142,6 +1151,17 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
>  /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
>  extern int BUG_exit_code;
>
> +/*
> + * BUG(fmt, ...) is to be used when the problem of reaching that point
> + * in code can only be caused by a program error.  To abort with a
> + * message to report impossible-to-continue condition due to external
> + * factors like end-user input, environment settings, data it was fed
> + * over the wire, use die(_(fmt),...).
> + *
> + * Note that the message from BUG() should not be marked for
> + * translation while the message from die() is in general end-user
> + * facing and should be marked for translation.
> + */
>  #ifdef HAVE_VARIADIC_MACROS
>  __attribute__((format (printf, 3, 4))) NORETURN
>  void BUG_fl(const char *file, int line, const char *fmt, ...);
