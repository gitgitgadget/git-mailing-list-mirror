Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E1DC433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 15:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbhLQPoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 10:44:20 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:45637 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbhLQPoU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 10:44:20 -0500
Received: by mail-pj1-f49.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so3157719pjq.4
        for <git@vger.kernel.org>; Fri, 17 Dec 2021 07:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=55wD9Sk5eFlcUg2XtrGozPH+UXthSpTs/y025NQqW7o=;
        b=2Aj1u2pwYNsD5kOwVcMx+3e848c22Z0OTg8GdKSnTFGplBtPL6sm7flJhmDgfwd/ag
         GGCNCGVFDtqtUiRJPgjq7ux3ND/AI8YmkFmxy4ncQcNwYblYrdqKW3yVsYMI6O5bq0aL
         UMeTV/y79/WSedbCCDUAOj0aTr6syZ7xAaAlj68RW8kdj4BhsA1udcX2mVjvLf89Fsgj
         oDuUBlkEYBSGNknIt5cEJFFKcMOZO2U8p2/ZaKsIn2Q5O07+OilFjeIU3kHwkS6aTWdP
         vBuuiEzOAEd7gwdsnG6jJht8PYqcthxgNmM9uPaytrZL2/ddIf+AqRc2JfYDb0nIiw2y
         qrrw==
X-Gm-Message-State: AOAM532bp0zfJBOE+DOChkEw0poVCNXJAbxSVhyu317HCvkF+mmteyfc
        8jdIkHbCgtuu2hygqTgGSRQ8RhXVR5J4Iyd9blWLWPR2sNm6Gg==
X-Google-Smtp-Source: ABdhPJzO91EDxRn5lsvuAdKbaaDt6GleFOfSTXTLCVKqWEVI8Hnr6ae/7mulNEaSDSibVJafW82M0RXfWrdUNUczf98=
X-Received: by 2002:a17:902:b942:b0:148:a2f7:9d72 with SMTP id
 h2-20020a170902b94200b00148a2f79d72mr3917345pls.145.1639755859750; Fri, 17
 Dec 2021 07:44:19 -0800 (PST)
MIME-Version: 1.0
References: <1e5dba11-fa01-44e1-b341-9d69bbdbbd39@www.fastmail.com>
In-Reply-To: <1e5dba11-fa01-44e1-b341-9d69bbdbbd39@www.fastmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 17 Dec 2021 10:44:08 -0500
Message-ID: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
Subject: Re: [PATCH] docs: add missing colon to Documentation/config/gpg.txt
To:     Greg Hurrell <greg@hurrell.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 7:13 AM Greg Hurrell <greg@hurrell.net> wrote:
> The missing colon here caused the docs to misrender in places such as:
>
>     https://git-scm.com/docs/git-config
>
> where, the `gpg.ssh.defaultKeyCommand` option lacked bold styling and
> didn't get an anchor link like its neighbors have; eg:
>
>     https://git-scm.com/docs/git-config#Documentation/git-config.txt-gpgsshallowedSignersFile
> ---

Thanks, this fix is "obviously correct".

Please add your Signed-off-by: at the end of the commit message.

Minor: The commit message could work just as well without mentioning a
particular site hosting documentation, so something like this would
also be fine:

    Add missing colon to ensure correct rendering of definition list
    item. Without the proper number of colons, it renders as just
    another top-level paragraph rather than a list item.

> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.txt
> @@ -34,7 +34,7 @@ gpg.minTrustLevel::
> -gpg.ssh.defaultKeyCommand:
> +gpg.ssh.defaultKeyCommand::
>         This command that will be run when user.signingkey is not set and a ssh
>         signature is requested. On successful exit a valid ssh public key is
>         expected in the first line of its output. To automatically use the first

If you want to tackle them, some other fixes would be:

* "This _is the_ command that..." or "This command will be..."

* in user-facing documentation, we use camelCase for configuration
names, so "user.signingkey" should be "user.signingKey"

* s/ssh/SSH/

* s/exit/exit,/
