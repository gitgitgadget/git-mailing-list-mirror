Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A159CC433F5
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 820A061004
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 01:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhJTBYI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 21:24:08 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:38508 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhJTBYH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 21:24:07 -0400
Received: by mail-ed1-f54.google.com with SMTP id r4so13014100edi.5
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 18:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c+ocK2NpxwPrd32LIat3spITwPUBvL7PgJUZGVLfA0w=;
        b=0z6/ci0Rqbq3N9OCcbmZn1onQPKlpO4jZS0iMJMy6i54aJ7sNyWOWhjN4mGrLvXIaA
         BH9CEXmLFjmLMhKXgqInE7vFqhrIu2RH3TKppkJOiWMsaDucMe9kHstuF4zloU7Xbd8/
         aZWNbc817S3NZLwH0WDW0CHerNhbB1RjQ0UAmzmz8Mw7BsL0YwxSttFB3jH85vSWX4KN
         znm2jr37pC5hmKsFu6prOOL+DdCQLLR3SbhIliEn2k8CzgNZP/MH8JyfGgIeekrIO6Vv
         uyPwG+J2ZvYY+Gp/T+4Xyb7ZrbVXBznA9Br3hZvQepHB9ro+0o+rDKU+GnLpn8ugM2yp
         Gs3g==
X-Gm-Message-State: AOAM532VnSzsSMcBE0l+0o/Ve6LSVL+QMSPiduXzBMGeZa7y1mU/2KEE
        oiGbVVFRZz6pcftYSt4bwFN/CTBBe5LuDia8j0Iy0zJqyf4=
X-Google-Smtp-Source: ABdhPJyHu0hLikKGU+gP0sbTVzBgskvIN2SJvEJ4cm3/gVc/Ehje8TKu1rqiutRRBUA0UkzbNR8k+FB9HZ+XJBTTuR4=
X-Received: by 2002:a17:906:3842:: with SMTP id w2mr43232993ejc.28.1634692912977;
 Tue, 19 Oct 2021 18:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211020010624.675562-1-sandals@crustytoothpaste.net> <20211020010624.675562-4-sandals@crustytoothpaste.net>
In-Reply-To: <20211020010624.675562-4-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Oct 2021 21:21:40 -0400
Message-ID: <CAPig+cTn4fZtssPrn+z582E++Kdc2+z+=iNtp2kodR=QJVeycg@mail.gmail.com>
Subject: Re: [PATCH 3/4] gitfaq: give advice on using eol attribute in gitattributes
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 9:06 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> In the FAQ, we tell people how to use the text attribute, but we fail to
> explain what to do with the eol attribute.  As we ourselves have
> noticed, most shell implementations do not care for carriage returns,
> and as such, people will practically always want them to use LF endings.
> Similar things can be said for batch files on Windows, except with CRLF
> endings.
>
> Since these are common things to have in a repository, let's help users
> make a good decision by recommending that they use the gitattributes
> file to correctly check out the endings.
>
> In addition, let's correct the cross-reference to this question, which
> originally referred to "the following entry", even though a new entry
> has been inserted in between.  The cross-reference notation should
> prevent this from occurring and provide a link in formats, such as HTML,
> which support that.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> @@ -464,14 +465,25 @@ references, URLs, and hashes stored in the repository.
> +With text files, Git will generally the repository contains LF endings in the
> +repository, and will honor `core.autocrlf` and `core.eol` to decide what options
> +to use when checking files out.  You can also override this by specifying a
> +particular line ending such as `eol=lf` or `eol=crlf` if those files must always
> +have that ending (e.g., for functionality reasons).

The first sentence in the paragraph is unparseable.

> +# Ensure all shell files end up with LF endings and all batch files end up
> +# with CRLF endings in the working tree and both end up with LF in the repo.
> +*.sh text eol=lf
> +*.bat text eol=crlf

Maybe: s/end up with/have/g
