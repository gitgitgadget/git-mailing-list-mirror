Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7824E1F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 08:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeCYIXD (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 04:23:03 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:33511 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCYIW7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 04:22:59 -0400
Received: by mail-io0-f193.google.com with SMTP id l3so19771031iog.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 01:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2vc5HAWhqA6mNull+Kp9PnBq8P4kIElmmFUPnaE0EaU=;
        b=EqH02hFevHh5NVnU1ARJPKZJ4HriJAd/NwFADr4XkCbyCZNn3lix107QmdQ0XYrjQI
         kOTmdAvtwSvzpjSY6HEUu4qRNKviCJaF9ng4r/t/gYthFDsjPUY/QpnmB8GEpKPWz77W
         1bQyLMtwyq5cEE+mOB/NuSlJy/1pOxamNvIBPhf9JjTiFH4p207z+jgrdEhS+Mw2pyS6
         BjAKUVFhVXSv3khRAG8QbdYAg/CIZlaUVQmTTaVICfx6BzxFyWKjSuaGBtuPvdTYaC0M
         BrtAq0GqDKthlJ9bgPzYvPGINf06Adr6dUiLJvxZd141xPOwCHkHd4+IbUfdABv+M/Ov
         WVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2vc5HAWhqA6mNull+Kp9PnBq8P4kIElmmFUPnaE0EaU=;
        b=IoFj/53BbKK2fTyvS9kktjJNSx8DPAs2W/DeyZH+H2ZV4lZn8UuMcr2o5cZc9CgDwl
         Bpkn4XeO2sq0CZiGa2XkqAPoRUF8PwRQ9Mjk3Z9UseYv/N1SM6AQa/I7P0gpxJtNVJQY
         GfENBgm630XZaUZgBXiti81SdvqKP1XJQni5YhoRCH9Dk6lLjwL6YUSQLLx06cibH+Yo
         Yea7VLnmetSK+vd3qXacIv0w9BXmOEe6QNrVhU2ykRWwJ5pzqotU35gRPyFcz0EKEvWB
         AnOY4Se61RVtOlfInqEF6xvbCdaIOB6W1VR2D7MfzQKnS5T4rB+bt6Pw2CbDMvwyffuq
         gIlg==
X-Gm-Message-State: AElRT7FLChkjcD3TvgPDRQOIhPwHNKbR0DNtWQ5I87YjeXvUsRyliHax
        PNOwNDyD08vWERPppgT0tCMIn6OaALVXI4pH410d3s+0
X-Google-Smtp-Source: AIpwx488EtNK7b/gWdfVFfW3eSUbharzFFC554fkUo+dylsQXg07NeRW5Ge4ZEMw/aew7T1p6bcNSSdnyptxWMmHJTI=
X-Received: by 10.107.5.82 with SMTP id 79mr6898842iof.223.1521966178742; Sun,
 25 Mar 2018 01:22:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.9 with HTTP; Sun, 25 Mar 2018 01:22:58 -0700 (PDT)
In-Reply-To: <20180324173707.17699-3-joel@teichroeb.net>
References: <20180324173707.17699-1-joel@teichroeb.net> <20180324173707.17699-3-joel@teichroeb.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 25 Mar 2018 10:22:58 +0200
Message-ID: <CAP8UFD0Rmyiom0pEY6u7OVzCZbs9rg3VjEsW6Rs8S6m40uKrPw@mail.gmail.com>
Subject: Re: [PATCH 2/4] stash: convert branch to builtin
To:     Joel Teichroeb <joel@teichroeb.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 6:37 PM, Joel Teichroeb <joel@teichroeb.net> wrote:
> diff --git a/git-stash.sh b/git-stash.sh
> index 92c084eb17..360643ad4e 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -736,7 +736,8 @@ pop)
>         ;;
>  branch)
>         shift
> -       apply_to_branch "$@"
> +       cd "$START_DIR"
> +       git stash--helper branch "$@"
>         ;;
>  *)
>         case $# in

Can the apply_to_branch() shell function be removed from git-stash.sh?
