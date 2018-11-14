Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 272B51F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 21:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeKOHsm (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Nov 2018 02:48:42 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46785 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeKOHsm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Nov 2018 02:48:42 -0500
Received: by mail-pf1-f196.google.com with SMTP id s9-v6so8544465pfm.13
        for <git@vger.kernel.org>; Wed, 14 Nov 2018 13:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FpgigO1OquziBbGCQUcK0VoZBiuPVBcwRMdUHFANJGQ=;
        b=BGCok2MXj1nv9qxPfzXszsQp4U4Yotg600Vj1P82ldfLhNPYHyozYmhh8PLXVbwFZX
         trTUlman9lhbIESo6tXWpweMSA8MQD+9wwHleXlcLq55CrDRln0JEXQVjQ4QFjrT0+jp
         927OEUWb/EjVAGGEV757ZBIouwCqRD0jW1e+/4HyT4X4t7kDLrMQz8C28BEDBnat2pUX
         3vgmvRF+FoM1zCMUP53e1NdnqDr4noeA/TRE15mX3gt0/6f1B1bJuaYhxlUVG0D23emN
         +2CIC25Rs9OTk2V6JDIK4nRomYCHxPXui3oUpi34t7V8RyK/+vvYZpXmmtdCraG34WF9
         ws5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FpgigO1OquziBbGCQUcK0VoZBiuPVBcwRMdUHFANJGQ=;
        b=KS25e0BlPeyowsoDrft5DIK9ivg9dNpy67CRqa6kAdNy3k26N0RD5N1cbIMFqThV29
         aiqvYcl/+s7FRFAVc0X2uxq/AwoumQpJNr03sH5460ZWwWpO9MQMAImlsxxE3mfE3lrv
         qsy9H/S7rPpwo8HG3LDeM6fp0wxqjckW3ZlgZM4IUmAAfMHw9P+NRnx66bOiE5hMQgZZ
         Nsv2EBXG7hFNKrfYIPT9t99J3GHrUPpT3MVBQt6mUpG7ytvHq0wSvS8DnYO+oHeB2v2S
         InlwciaTMjwyvDLGr3V38933Cy7qo2Qia2uzW9R4hss6haEjGjPKW+xeYyISshvYuocE
         x8OA==
X-Gm-Message-State: AGRZ1gL3z0kY68T4jtSitVcNEGGkxBZ0TcXroBSSUShDzzajG6Q2UiWl
        sdCHjRX1kndQusat6GiR6U7rSBdA3pyaX5bFng8=
X-Google-Smtp-Source: AJdET5elF5fB3/Bzacn3euwZWT0dK3IjC8WEa2u76lC+BdlEYQS+nEjvDGCXNaF56uwlG4MyZGioKFqyQFItXbcCdvo=
X-Received: by 2002:a63:b94c:: with SMTP id v12mr3280239pgo.221.1542231824557;
 Wed, 14 Nov 2018 13:43:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.79.git.gitgitgadget@gmail.com> <pull.79.v2.git.gitgitgadget@gmail.com>
 <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
In-Reply-To: <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 14 Nov 2018 22:43:32 +0100
Message-ID: <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] bundle: cleanup lock files on error
To:     gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>, gael.lhez@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 14 Nov 2018 at 16:26, Ga=C3=ABl Lhez via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> However, the `.lock` file was still open and on Windows that means
> that it could not be deleted properly. This patch fixes that issue.

Hmmm, doesn't the tempfile machinery remove the lock file when we die?

>         ref_count =3D write_bundle_refs(bundle_fd, &revs);
> -       if (!ref_count)
> -               die(_("Refusing to create empty bundle."));
> -       else if (ref_count < 0)
> +       if (ref_count <=3D 0)  {
> +               if (!ref_count)
> +                       error(_("Refusing to create empty bundle."));
>                 goto err;
> +       }

One less `die()` in libgit -- nice.

> +test_expect_success 'try to create a bundle with empty ref count' '
> +       test_expect_code 1 git bundle create foobar.bundle master..master
> +'

This tries to make sure that we don't just die, but that we exit in a
"controlled" way with exit code 1. After reading the log message, I had
perhaps expected something like

  test_must_fail git bundle [...] &&
  test_path_is_missing foobar.bundle.lock

That relies on magically knowing the ".lock" suffix, but my point is
that for me (on Linux), this alternative test passes both before and
after the patch. Before, because tempfile.c cleans up; after, because
bundle.c does so. Doesn't this happen on Windows too? What am I missing?

Martin
