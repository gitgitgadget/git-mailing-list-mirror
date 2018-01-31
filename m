Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7C51F404
	for <e@80x24.org>; Wed, 31 Jan 2018 20:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeAaUXB (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 15:23:01 -0500
Received: from mail-qt0-f177.google.com ([209.85.216.177]:32910 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeAaUXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 15:23:00 -0500
Received: by mail-qt0-f177.google.com with SMTP id d8so23566610qtm.0
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 12:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=rtvFF4aewuR1hxxkscj3XoMFfTaPBt4zM4KVwRlKgOc=;
        b=Y/vmIFWcQOj48OT9L0nkVsqYyghyfnvdbkrYQN/pquKeUbsTWE0TVtrLXtpArYVFjm
         JztXk6uBRJzvhB9Oea1w6kqEGDZc0lAMEJeNDMir8de1OdAFLyKRutqtTbthDSdKggCB
         i3ybhL2GjJ3HWF3sQbUlgWs4ioAOtS9aDflBg+A1+/PqogAWCqzwzMF0iSCTdofVsl9i
         /SYiowUYC3iAgVl3jGE+WSCZrx5W4UYcbKk1DGnFnnTGKwP/A9N4rKIm3UVv9AAC26FO
         8Fcx+lmeKEmzo44gaJc9UuTQjWK+bP9OUskUCt7jbohH/aPo5gVws6L8ikTLqZhz6Iqt
         lNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=rtvFF4aewuR1hxxkscj3XoMFfTaPBt4zM4KVwRlKgOc=;
        b=ObtWNe/vtZT3GAXZ4OYCEgOfpZuA3jCXDiNhl1Cwo36g6cn8nbLWmjii6fAVK1UURB
         VyrEjsQspiuJcxVK1Jq237/SmK0b49eGKITpu2gxVY2T2rebIARF/Mp3nx3T6W6d+q9F
         B+bAh1UfQRo7JTJ8bwuL8dUT1nYOcTah1T79RoUriwbCrd+Qy2w1wUULuzGPqkge4CsW
         IY8j97R1uJwc33Y9DELl7wND+C6DuFM2Ntif2weX3m/VcwyW2ZfFtXZHsHpeqZED/UEB
         G2uVsu5o1lXglmLfSR1C3gvDpwg2ISwnQRzGWE8J2qsvjxKyYWqihnryr23vw91iOgV6
         wcQQ==
X-Gm-Message-State: AKwxytfVaGYKZiPDMiBl9YfFAmT7QxTQQxwi11vaR9ZL/jVrs+DEfOPI
        Oaytj/fkMUezfWh87PeY1rUvervshidZpdQFKK8=
X-Google-Smtp-Source: AH8x225oYLI6ZjmcvpG8+0wBHA8hc/ZYy3b4NOM02JwwwkhF1Xl8dhVAYoTN/FYB3evC0OEoh8D8gEG3rd0dzbZtyDY=
X-Received: by 10.200.47.130 with SMTP id l2mr54067987qta.277.1517430179504;
 Wed, 31 Jan 2018 12:22:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Wed, 31 Jan 2018 12:22:59 -0800 (PST)
In-Reply-To: <20180131110547.20577-2-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com> <20180131110547.20577-2-pclouds@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 31 Jan 2018 15:22:59 -0500
X-Google-Sender-Auth: E2LAQSVn3ToG0dyKMAmYvdq62yY
Message-ID: <CAPig+cQ8WAk3FeXSza4_Zm+LQitnndTBCwsYWpbSNuXzfFD5rw@mail.gmail.com>
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
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
> diff --git a/parse-options.h b/parse-options.h
> @@ -89,6 +90,8 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx=
,
> + *   PARSE_OPT_NOCOMPLETE: by default all visible options are completabl=
e
> + *                        git-completion.bash. This option suppresses th=
at.

s/git-/by &/
