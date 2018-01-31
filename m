Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D99B91F404
	for <e@80x24.org>; Wed, 31 Jan 2018 21:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeAaVEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 16:04:49 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:37071 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753069AbeAaVEm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 16:04:42 -0500
Received: by mail-qt0-f172.google.com with SMTP id d54so23706148qtd.4
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jUqXSalKpz7WStcXUcSrno07iHrVP0t/DLTKuty3O8c=;
        b=q08TD6zMHZRYX8bLBXTOJfo111wTBD0Y/a0+3LhZ2ci7A4Jt7Rfm2DWrG5xPGxeuqg
         IF2OMW+aGx+qX1P9lai6ivFuXaEoqdEKeDyLy7JVBDSGmLAKa8eFt9PxKGFaz9/v8IQr
         2sd/Up5lyEwO+6xgkz3gZgCWS00v7qN/xZLlRosy3Bx7fMBnlOZSnWniKBEiR5puJZ6r
         959kaN7MaMQH2u3SlRZ0ZhZSNuE9h6u9U3NjFoUTQwtaE8zynReFZc6E6kwcXTttTs8q
         eelh6+cXgkSUHGk6KFVAgvoS7RtCxcbaQ28OA+OXywWLUJwP8IsQc9YN5ozCdKdO7kY7
         zAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jUqXSalKpz7WStcXUcSrno07iHrVP0t/DLTKuty3O8c=;
        b=nuUC93Cpdj1Plwou5eeB45Rfij6/TaZlVuCDDrifVHcbK6ElcZEk+loGY2zc4hh3wZ
         9LxId0OJAjWpuwgtcoFh0WV72wCsY7X3peHh0IBqWxe1k6j8Nldutrn0+3H1+pYF9TDG
         +vLnJ1enQeGd36B2D6FHX/jighNwzqNPC3j/J9E1nPepycTTiKEdCbP3j+VcsVrO4h5J
         izV8DtiBRJ1Myeq7f2GxfzBgUoVLTQhm/0SQGJS8i7PkQabbO150e4F4FYrSWyB4D1ps
         Vj29ZQLfBOkoupOsLRQa+GcHBLvCVmyNCrs6Z5Os1fVIuTeQb2u02GlJ6MOyZXb+IAOn
         U5rw==
X-Gm-Message-State: AKwxytccwOuac4C9GZYz/8mozHj+BX4XiBUXm+NJjB8RzDHI7+kvwFwB
        CgvEf58ThybTsAXMMAxC0OvHjWHFoWuePU9bYSk=
X-Google-Smtp-Source: AH8x227y6Te+Ja2cyUGGU6A3A/mRQuAfl6HtI8iUGn89ElEZ8O0IkvZI4YNQqYXM4U3TM0k9g7tumB5hRUcEsMgMET8=
X-Received: by 10.200.27.91 with SMTP id p27mr13752414qtk.254.1517432681135;
 Wed, 31 Jan 2018 13:04:41 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 31 Jan 2018 13:04:40 -0800 (PST)
In-Reply-To: <20180131110547.20577-2-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 31 Jan 2018 16:04:40 -0500
X-Google-Sender-Auth: gJK7UA_Z_d-fvjQzqbRwJok0OKc
Message-ID: <CAPig+cT5GkhFJ9XFDSirGjfoji4qUCM8LA6abdRsaT=g3prznQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/41] parse-options: support --git-completion-helper
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 31, 2018 at 6:05 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =
<pclouds@gmail.com> wrote:
> This option is designed to be used by git-completion.bash. For many
> simple cases, what we do in there is usually
>
>     __gitcomp "lots of completion options"
>
> which has to be manually updated when a new user-visible option is
> added. With support from parse-options, we can write
>
>     __gitcomp "$(git command --git-completion-helper)"
>
> and get that list directly from the parser for free. Dangerous/Unpopular
> options could be hidden with the new "NOCOMPLETE" flag.

I wonder if this option should be named DANGEROUS rather than
NOCOMPLETE to better reflect its intention. The reason I ask is that
it is easy to imagine git-completion.bash some day growing a new
configuration option to allow people to complete these "dangerous"
options, as well, rather than us imposing, with no escape hatch, our
idea of what should and should not complete.

It's not uncommon for "bug reports" to be sent to the list stating
that such-and-such option (say, --force) does not autocomplete. Our
stock answer is "oh, that's a dangerous option, so you'll have to type
it manually". If git-completion.bash gains new configuration to allow
dangerous options, then our answer can become "oh, that's a dangerous
option, if you really want it to complete, then enable
GIT_COMPLETION_DANGEROUS" (or whatever).
