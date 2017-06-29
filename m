Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CA2620281
	for <e@80x24.org>; Thu, 29 Jun 2017 17:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbdF2RDa (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 13:03:30 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33077 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752713AbdF2RD3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 13:03:29 -0400
Received: by mail-pg0-f54.google.com with SMTP id f127so50800453pgc.0
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 10:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bnmUX+jM7wg7cX1QUVw3WDpWvaPcSLympr7xIiDNEDI=;
        b=I36IbdNjEyXlTAwMDZMnTuq+agcDSKDWwZiojbbxAf7uWLGkdHCsXgQoTeUcT/Hr8c
         dct30xIK2UHOjA6PolTpFVmA1kGD91yEKZG6EU/nrThNiN6YwZCXFM+EtXh9bpv+jcS8
         B//WIqBXqLvQa/7Adpl90OMoHku5ctyHH9u1N5kmcvRJqks4LrGR5YMuWJhgybg6RebD
         oIcR2mmuiai6rBhxPrZ/anFtTGn6KEekjW+e0YbbCR6t/4gvRJ3GF2Y+/M9qJE4lyA5J
         MY8kU04Eq7EIsgBI2L2j2QR5dL39ltDjhKZtg9CigUYX2NZpW4Ijm9oRU/H6iFp4KZLA
         DyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bnmUX+jM7wg7cX1QUVw3WDpWvaPcSLympr7xIiDNEDI=;
        b=bCKUUWWn9XV03LJKHaBzRyzIoXgjMvSZOWO5TEVYiZwhIHGMnk3HCstMxtkcTJ2zg2
         mC5KbvojRUoGjvP+8MSQyEVFvSp7tuYdl/dItyDbV5lpIhShwRwd6Y+uuYoW+W4byo7O
         JfXhVGEZ7dHGEMb8s/z4jRaR2/F8Ixs0ARQKGZ+Ym3Ny8ZKJAjwyXun9v3SP4ukmtc6/
         i8eZ8I3Tr+c+djWQwU5P2qYVUeQwfb8oA4GVwTLVEHqUxS+CUrOofHcQ7TguHGTzKiYd
         ZkdSHop8XMzmQk3qevyC45YRJCSaFotmu3OHn+RXC7Nu9WCkSR11kc2nixN/OfPzDHB6
         Oc4Q==
X-Gm-Message-State: AKS2vOy9/VQO30stQuMvS9DQ0YHCo31zG3AcZ6eOo4VOHD7DwbroWixZ
        cRDE4AdE02S2mxEu2kZw5OKU17WlogWB
X-Received: by 10.98.19.136 with SMTP id 8mr17513072pft.105.1498755808178;
 Thu, 29 Jun 2017 10:03:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Thu, 29 Jun 2017 10:03:27 -0700 (PDT)
In-Reply-To: <20170628215809.23060-3-avarab@gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
 <20170628215809.23060-1-avarab@gmail.com> <20170628215809.23060-3-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 29 Jun 2017 10:03:27 -0700
Message-ID: <CAGZ79kb0a2EEALj3eEAMUwQSWamhGuOFOYPrWbv6uCtC7EXgAw@mail.gmail.com>
Subject: Re: [PATCH 2/5] grep: remove redundant grep pattern type assignment
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 28, 2017 at 2:58 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Remove a redundant assignment to extended_regexp_option to make it
> zero if grep.extendedRegexp is not set. This is always called right
> after init_grep_defaults() which memsets the entire structure to 0.
>
> This is a logical follow-up to my commit to remove redundant regflags
> assignments[1]. This logic was originally introduced in [2], but as
> explained in the former commit it's working around a pattern in our
> code that no longer exists, and is now confusing as it leads the
> reader to think that this needs to be flipped back & forth.
>
> 1. e0b9f8ae09 ("grep: remove redundant regflags assignments",
>    2017-05-25)
> 2. b22520a37c ("grep: allow -E and -n to be turned on by default via
>    configuration", 2011-03-30)
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  grep.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/grep.c b/grep.c
> index 29439886e7..6614042fdc 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -80,8 +80,6 @@ int grep_config(const char *var, const char *value, voi=
d *cb)
>         if (!strcmp(var, "grep.extendedregexp")) {
>                 if (git_config_bool(var, value))
>                         opt->extended_regexp_option =3D 1;
> -               else
> -                       opt->extended_regexp_option =3D 0;
>                 return 0;

Instead of having a condition here, have you considered to remove the
condition alltogether?

    if (!strcmp(var, "grep.extendedregexp")) {
        opt->extended_regexp_option =3D git_config_bool(var, value);
        return 0;
    }

This does not have the effect of not assigning the value in case of 0,
but it may be easier to reason about when reading the code.

This would also conform to the code below in that function, that parses
grep.linenumber or grep.fullname

Thanks,
Stefan
