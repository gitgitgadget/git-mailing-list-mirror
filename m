Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214CBC19F2A
	for <git@archiver.kernel.org>; Sat, 30 Jul 2022 18:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235588AbiG3SxR (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jul 2022 14:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbiG3SxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jul 2022 14:53:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDC455A9
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 11:53:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq11so6523183lfb.5
        for <git@vger.kernel.org>; Sat, 30 Jul 2022 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=ISA8CaIoVoTzkKz3ZFLxrLQnMQIsTk+RNe6x+4ShqTc=;
        b=KiJsD2bN8CfoDj7CChi/URO4IFRCdBJeR9FaF6cu40UGJ47eakmLxJDYfH+tfHLLex
         A0EyRxH9vQL4T/a0Wb+QmJQ3wx9h3HMIFZqJu/YZaUUCQunGlEcZAXs+/CbOj6wI7voe
         CnKPo7tr4jdyKeHREhLAQCXp1H0dRtmYdBtwlpZIzBOWZLAc9q4sswdrePGFXMHKDJqn
         l1tzS4/YM7vbRVUBi3ipoE8zvuM/siQZhoih4KEYFqxVcden3cny/qYIok44iHHsj5ki
         7sfoN+0X2W48bguweZRgGwpCSA5/scKRCmgZTHelCPd7fE8gDgAWC3SHU7WB+oKkFopF
         tzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=ISA8CaIoVoTzkKz3ZFLxrLQnMQIsTk+RNe6x+4ShqTc=;
        b=gUs9pWgSYSu/LanBZhAJ9mAl4sYp8VVrNjG3Z+hoffAWqMJKivsx5b6EEfVEqTqf7Y
         IdyqnNNRdbVDG8x+DKpo0dKuOnzY6it45xCepNUUqToiH/xR4iCUqfYCAyaOAtpcYPak
         wZ6aQKk+yjKGbQplbSqiXhg3ESINyf1Ud6L4DwKz/kW2ZYUAYPk9ghF7lWGj9S5F7wlI
         t/fMqGB4EnUevfYsrHqeaTrinzPyWN0ZhaF7tx+HjWZ3hwVLGrM8lZPf3KvMvrMxnw7/
         wql8YT6sBChSTW7I35yAe+RBP6fOyZXOmDJ9EI0lyJ5YZ4f2FIh71eCJXMNn/766opg4
         yAgg==
X-Gm-Message-State: AJIora8O1CMhk0O7ROzx9/CrjB/bMEMiDhjNuSa+EkMxvya4Hly3HGsw
        DvFQT5RUrRNjahlm19fxcA6zaG1ycsFSs0cVVIsvyDDjmc0=
X-Google-Smtp-Source: AGRyM1sUhNTnJoL9yQ38Y0TD9NF7rfaQ9m5th9yZ6ZTlmUXh8EJyscj3ozQv7tSU65JJAZKgWi74dhptjHcIdU124WM=
X-Received: by 2002:a05:6512:1318:b0:482:ae30:fc77 with SMTP id
 x24-20020a056512131800b00482ae30fc77mr3267793lfu.279.1659207190817; Sat, 30
 Jul 2022 11:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657819649.git.matheus.bernardino@usp.br>
 <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com> <patch-v2-7.9-08d98767384-20220729T081959Z-avarab@gmail.com>
In-Reply-To: <patch-v2-7.9-08d98767384-20220729T081959Z-avarab@gmail.com>
From:   Matheus Tavares <matheus.bernardino@usp.br>
Date:   Sat, 30 Jul 2022 15:52:59 -0300
Message-ID: <CAHd-oW4yABvvvifHe9WqZgQcErzYmiyXqZr4ssHx8ozN0w6raQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] log docs: de-duplicate configuration sections
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 5:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  Documentation/config/log.txt | 18 +++++++++++++-----
>  Documentation/git-log.txt    | 33 +++++----------------------------
>  2 files changed, 18 insertions(+), 33 deletions(-)
>
> diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
> index 456eb07800c..12ede8e31b8 100644
> --- a/Documentation/config/log.txt
> +++ b/Documentation/config/log.txt
> @@ -1,12 +1,11 @@
> -log.abbrevCommit::
> -       If true, makes linkgit:git-log[1], linkgit:git-show[1], and
> -       linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
> -       override this option with `--no-abbrev-commit`.
> -

Why was this moved ....

>  log.date::
>         Set the default date-time mode for the 'log' command.
>         Setting a value for log.date is similar to using 'git log''s
>         `--date` option.  See linkgit:git-log[1] for details.
> ++
> +If the format is set to "auto:foo" and the pager is in use, format
> +"foo" will be the used for the date format. Otherwise "default" will
> +be used.
>
>  log.decorate::
>         Print out the ref names of any commits that are shown by the log
> @@ -45,6 +44,11 @@ log.showRoot::
>         Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], whic=
h
>         normally hide the root commit will now show it. True by default.
>
> +log.abbrevCommit::
> +       If true, makes linkgit:git-log[1], linkgit:git-show[1], and
> +       linkgit:git-whatchanged[1] assume `--abbrev-commit`. You may
> +       override this option with `--no-abbrev-commit`.
> +

... down here?

>  log.showSignature::
>         If true, makes linkgit:git-log[1], linkgit:git-show[1], and
>         linkgit:git-whatchanged[1] assume `--show-signature`.
> @@ -53,3 +57,7 @@ log.mailmap::
>         If true, makes linkgit:git-log[1], linkgit:git-show[1], and
>         linkgit:git-whatchanged[1] assume `--use-mailmap`, otherwise
>         assume `--no-use-mailmap`. True by default.
> ++
> +The behavior of `log.mailmap` is impacted by the setting of the more
> +general 'mailmap.*' configuration variables, i.e. `mailmap.file` and
> +`mailmap.blob`.

Good.

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index ed802bb8e12..69c4e13833d 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -42,6 +42,9 @@ OPTIONS
>         shown. The option `--decorate` is short-hand for `--decorate=3Dsh=
ort`.
>         Default to configuration value of `log.decorate` if configured,
>         otherwise, `auto`.
> ++
> +This output may be colored. See `color.ui` in linkgit:git-config[1]
> +and `color.decorate` there and in the "CONFIGURATION" section below.

Hmm, is this related to this change?

> [...]
> -log.showRoot::
> -       If `false`, `git log` and related commands will not treat the
> -       initial commit as a big creation event.  Any root commits in
> -       `git log -p` output would be shown without a diff attached.
> -       The default is `true`.
> -
> -log.showSignature::
> -       If `true`, `git log` and related commands will act as if the
> -       `--show-signature` option was passed to them.

These two have a different wording on config/log.txt, but they are
arguably better presented there anyway.
