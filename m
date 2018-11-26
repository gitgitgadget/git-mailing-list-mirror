Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7536D1F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 19:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeK0Grr (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 01:47:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44935 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeK0Grr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 01:47:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id y56so16919866edd.11
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 11:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pinJIOZppZqFRnHI+PJPCQXuofeiZ5dtEkBORdlh93k=;
        b=Te2s37nPjO8xMEcymO4eV25rfG800rpQkM6ayqopC7BekOg2/9CYXpMs9CIq5CilE2
         K7W7/otmiTeA9HfeZbxy4mAS6irFhyHvsrCV2T0mmzD/GGL/EIYUR/3imkA0h3rb+qzg
         RE2tKnvpdbFErndFyKuriQj+GwXxXSOi6YNfbbTDWE4ibSUfQU0cbrwlm/aEG9yoVuYd
         pLOIyZZGt5o4yC05e9nhGFEUcMsRXIpmcGndxPRhXe5amh1r9x8HAPS4azNTcCOVCNIR
         av7O8Y9qQamI0KbenLMHchO2DbDD0/aykBNTFiZpvndGVvFOkvfPryIYF0WBTvKaMsDF
         7dIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pinJIOZppZqFRnHI+PJPCQXuofeiZ5dtEkBORdlh93k=;
        b=L1irvwQglnZH5JUiN8h00d2k9pp6Aqu0XejCtt97h7ZpdM58/K6Mqa5r94kYGBd/Fh
         5Wg+uP+i8Upr+pSYLfGOe7QINIsKGUjWfUbUxalPTD2ygifp2WEjS+p7dvXAWSYz03z0
         GpSeiCZc4yFqjTNIi/Lmv+74MvH7Nk5U5TAEuPglZnp1KKVkYeanGPQHIySVsiu6RS/x
         foF/8k4OtHiGlE0RJhgXuuG8EejKnq5jRPepmSGzjy9PvS7mgCugS2FUBJSpNalxGlJa
         AUVVcjFvt/TsKqdbLQG/VATsHiDuxSevYSpNGSVA68WjRwfMoafoMUXsjsGYQkMdWrCn
         pi+Q==
X-Gm-Message-State: AA+aEWZCP+7TJvgirHgRBOCJSxeH6Lby0wD8ynVYvsdQX7ED/T50npSi
        xzeDEBylKHP6AZNSWVwIxUb9lnASqjQrwpVaTwleVUmCO8Y=
X-Google-Smtp-Source: AFSGD/WCpBhTwNTrnXzwL0U1ypjUrjTsDmxeXCP6U15WGT9e2IqzfjCtFqjUflYVXPLDJI8bkSMnQw3UaGVHXlir7BQ=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr23858577edc.76.1543261955013;
 Mon, 26 Nov 2018 11:52:35 -0800 (PST)
MIME-Version: 1.0
References: <20181118163851.32178-1-pclouds@gmail.com>
In-Reply-To: <20181118163851.32178-1-pclouds@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 11:52:23 -0800
Message-ID: <CAGZ79kZHFxahZMAZh2Ldscfqp0OWAae7dowAboLDac-UmTHwYw@mail.gmail.com>
Subject: Re: [PATCH] grep: use grep_opt->repo instead of explict repo argument
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 18, 2018 at 8:38 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> This command is probably the first one that operates on a repository
> other than the_repository, in f9ee2fcdfa (grep: recurse in-process
> using 'struct repository' - 2017-08-02). An explicit 'struct
> repository *' was added in that commit to pass around the repository
> that we're supposed to grep from.
>
> Since 38bbc2ea39 (grep.c: remove implicit dependency on the_index -
> 2018-09-21). 'struct grep_opt *' carries in itself a repository
> parameter for grepping. We should now be able to reuse grep_opt to
> hold the submodule repo instead of a separate argument, which is just
> room for mistakes.

That makes sense. Assuming we did not make a mistake yet, the
test suite would not need changes (further assuming we do test for it,
but we do as we have explicit submodule grep tests).

>
> While at there, use the right reference instead of the_repository and
> the_index in this code. I was a bit careless in my attempt to kick
> the_repository / the_index out of library code. It's normally safe to
> just stick the_repository / the_index in bultin/ code, but it's not
> the case for grep.

Reviewed-by: Stefan Beller <sbeller@google.com>

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
