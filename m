Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0410920136
	for <e@80x24.org>; Fri, 17 Feb 2017 18:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934671AbdBQSZO (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 13:25:14 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35607 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934211AbdBQSZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 13:25:13 -0500
Received: by mail-lf0-f65.google.com with SMTP id z127so2045879lfa.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XtD0Xcm5bsJNh0tygcWtmLB3FEnEo2oh8sb5BDEyHDc=;
        b=E3nsooJ1khhyvjqZJsAcr7D/j+CawRBWeeB1ElFJkUYgexWVTcX0lemRbx8GuUqqCy
         Lr/vnaKpkNaH9EZ4EvfpCeQGKSIQWAn3mVdSieuYYUYLzu9mDl1xq/qA5PJa9v6t2phb
         PXTD1kVdryL+2WqhI9179MTSOq+NAwohDjNZnl/QOoSpJ8H4uAj128MxIbvIHgWdVzF2
         HRqgtGhZwMe8zBq/1xlDARO8hjvT1xAoqM2lfJF+ofgJGfdJaHdWNUbQow2baaImCSYi
         /rSEQ+fzBEJPDTtQ+jj8/5v4wg58OapjUWzCTziiv9rYcH8sh0dTeoYsmGzX/B9NdCE8
         dNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XtD0Xcm5bsJNh0tygcWtmLB3FEnEo2oh8sb5BDEyHDc=;
        b=Hvte68CnKB0QFNRyJNXjPjXu3CFvOVKzJpQaD7EUkS0Td/JhiDeGHI/ZVLU8fClRo3
         8OC4kDBuJRBs2FhjXAUKPXEPYtEBcUqeNf7zHQOXzFCzkCqqF1SaUzaQ21mHNL5G15ew
         qLqxalbgUWI+4QSCRJ6vyJsHwEDdxJM1MgX7r3SCPpnrFzv09xtLzmscVs1Mg7R5As3R
         +6ssHU9CbS4mZI2XEVGk14JR+gc0soQOWulkSzaPpjdqhUES+Qz8nn/LwcN4KkOhx57c
         bCaZ/B1RQKQmTR5ssjACkDbmKew+U7mTi5lFf3myMKX09jVC6W+AeCQUcaiYjPsWgLIw
         39JQ==
X-Gm-Message-State: AMke39kMEtYaqse1KLV1Duanvq322ITT9YYwOAvHd5/1nTDzvg00qQFu6+9hLxBM6AIizoffTH4X1S3CBkPsBQ==
X-Received: by 10.25.87.196 with SMTP id l187mr2674736lfb.143.1487355911830;
 Fri, 17 Feb 2017 10:25:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Fri, 17 Feb 2017 10:24:51 -0800 (PST)
In-Reply-To: <20170216003811.18273-7-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com> <20170216003811.18273-1-sbeller@google.com>
 <20170216003811.18273-7-sbeller@google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 17 Feb 2017 10:24:51 -0800
Message-ID: <CA+P7+xozip8TuvyUe9vAPYLAg=QFieExhOyR7a0pgGFhiuO3jw@mail.gmail.com>
Subject: Re: [PATCH 06/15] update submodules: add submodule config parsing
To:     Stefan Beller <sbeller@google.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 4:38 PM, Stefan Beller <sbeller@google.com> wrote:
> Similar to b33a15b08 (push: add recurseSubmodules config option,
> 2015-11-17) and 027771fcb1 (submodule: allow erroneous values for the
> fetchRecurseSubmodules option, 2015-08-17), we add submodule-config code
> that is later used to parse whether we are interested in updating
> submodules.
>
> We need the `die_on_error` parameter to be able to call this parsing
> function for the config file as well, which if incorrect lets Git die.
>
> As we're just touching the header file, also mark all functions extern.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 22 ++++++++++++++++++++++
>  submodule-config.h | 17 +++++++++--------
>  2 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 93453909cf..93f01c4378 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -234,6 +234,28 @@ int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg)
>         return parse_fetch_recurse(opt, arg, 1);
>  }
>
> +static int parse_update_recurse(const char *opt, const char *arg,
> +                               int die_on_error)
> +{
> +       switch (git_config_maybe_bool(opt, arg)) {
> +       case 1:
> +               return RECURSE_SUBMODULES_ON;
> +       case 0:
> +               return RECURSE_SUBMODULES_OFF;
> +       default:
> +               if (!strcmp(arg, "checkout"))
> +                       return RECURSE_SUBMODULES_ON;
> +               if (die_on_error)
> +                       die("bad %s argument: %s", opt, arg);
> +               return RECURSE_SUBMODULES_ERROR;
> +       }
> +}

Ok so this function here reads a recurse submodules parameter which is
a boolean or it can be set to the word "checkout"? Why does checkout
need its own value separate from true? Just so that we have a synonym?
or so that we can expand on it in the future?
