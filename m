Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BE411FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeASAGu (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:06:50 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:33987 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeASAGt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:06:49 -0500
Received: by mail-oi0-f65.google.com with SMTP id a70so1792oib.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=799ixpFqNGyZgHt2UiSRA9kKIFyHZC9AoDR8U7YrFsU=;
        b=YbyZWun5Nd4V+v7tmZ1Vtq4eM1YnnVBJH+chw9HnydqSDiIy0QnfK0G8sgKum6lmHO
         K5w7lW+GfpCfFTMyiEqx18UvaPHRMe7Qij0wiOm5thVtdI+33FELLQ+mK74NUrLF8go3
         uR/uHhwCI42bzVpu6VqdVlqknIkx+Laf99C/r2M8Xb0bjmciFnEFc+kH/N0Ja+wnCt9m
         9LMioHVdeyfy9lzvp85QgCyrMTUjQYBC7R/g+NawmS0by20qE6K448XkkqryYN8d4LIL
         ekA0Onm/J3IQZLzzLfbSo8j60logXow2TyI0ws5jX33E8NjjnGRZfkvZBCqtTur/lLeJ
         3SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=799ixpFqNGyZgHt2UiSRA9kKIFyHZC9AoDR8U7YrFsU=;
        b=j6+anUXOfOkBsltIMJ9/GTwVdno8QwxRUuoqyzhd2ZZdX9R6E7DO9jWQnMawcUrncn
         +97eC96CvKWQDg1Ya0NQsEfBCvLmWh7SYtTNCdce4tXkVuOOuWgYh9agpoiBy1mc14y/
         gTG45lcw7b1PKa4a/yLBQU+nT94IX6L4C1+exA+2JQwOy3KIAS+Q1z68lND59FVHPpFd
         4zvZH4goRD/ATAWv0x43wLBsa0MD4FzrtXOzcyRP60tmjv5LUab+6WtcW4ESJeWJgw/n
         FfQV79TtiNaSv3WqCpGMiFvMQndU55q2I3V5F4JadcHjLywFlrPXvPQXuved9ABOdbZP
         I8VQ==
X-Gm-Message-State: AKwxytcFHrSPvWOmReogbS4goSoGejjU+aO2/lKOF/2wh2MzzTpppik5
        pTjoPWRX3uNhC12kEzeBB6inYEqItqCOEgY4fCfXUA==
X-Google-Smtp-Source: ACJfBoumL9MIdL08sb6RbRX/E9OZGeqc98MdsdI0KpW3rav7/Qxqfx76uc212Ugm9ZldCYdtQa44shFInDb1PAgrPEg=
X-Received: by 10.202.76.214 with SMTP id z205mr4152762oia.183.1516320408364;
 Thu, 18 Jan 2018 16:06:48 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.141.5 with HTTP; Thu, 18 Jan 2018 16:06:17 -0800 (PST)
In-Reply-To: <87bmhqj1y6.fsf@evledraar.gmail.com>
References: <20180113132211.13350-1-pclouds@gmail.com> <20180118100546.32251-1-pclouds@gmail.com>
 <87bmhqj1y6.fsf@evledraar.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 19 Jan 2018 07:06:17 +0700
Message-ID: <CACsJy8CXPP_75TEHvcWStm1ZneMDP+ioA=7iYcL25oEUiVHKxw@mail.gmail.com>
Subject: Re: [PATCH v2] diff: add --compact-summary option to complement --stat
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 4:23 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Wait, isn't there a bug here in the existing --summary code, its
> documentation says it'll show information "such as creations, renames
> and mode changes".
>
> But even though your --compact-summary shows that the file is being
> added and its mode changed:
>
>     $ diff -ru <(./git-show --stat 0433d533f1) <(./git-show --stat --comp=
act-summary 0433d533f1)
>     --- /dev/fd/63  2018-01-18 21:11:51.186570555 +0000
>     +++ /dev/fd/62  2018-01-18 21:11:51.186570555 +0000
>     @@ -14,8 +14,8 @@
>            t: add tests for pull --verify-signatures
>            merge: add config option for verifySignatures
>
>     - Documentation/merge-config.txt     |  4 ++
>     - builtin/merge.c                    |  2 +
>     - t/t5573-pull-verify-signatures.sh  | 81 +++++++++++++++++++++++++++=
+++++++++++
>     - t/t7612-merge-verify-signatures.sh | 45 +++++++++++++++++++++
>     +     Documentation/merge-config.txt     |  4 ++
>     +     builtin/merge.c                    |  2 +
>     + A+x t/t5573-pull-verify-signatures.sh  | 81 +++++++++++++++++++++++=
+++++++++++
>     +     t/t7612-merge-verify-signatures.sh | 45 +++++++++++++++++++
>       4 files changed, 132 insertions(+)
>
> There is no difference between --stat with and without --summary on the
> same commit, shouldn't it show "create mode [...]" ?
>
> E.g. 95450bbbaa will do the trick for both:
>
>     $ diff -ru <(./git-show --stat 95450bbbaa) <(./git-show --stat --summ=
ary 95450bbbaa)
>     --- /dev/fd/63  2018-01-18 21:14:20.770050599 +0000
>     +++ /dev/fd/62  2018-01-18 21:14:20.770050599 +0000
>     @@ -14,3 +14,4 @@
>       git-svn.perl                    |  1 +
>       t/t9169-git-svn-dcommit-crlf.sh | 27 +++++++++++++++++++++++++++
>       2 files changed, 28 insertions(+)
>     + create mode 100755 t/t9169-git-svn-dcommit-crlf.sh
>
>     $ diff -ru <(./git-show --stat --summary 95450bbbaa) <(./git-show --s=
tat --compact-summary 95450bbbaa)
>     --- /dev/fd/63  2018-01-18 21:14:30.646016210 +0000
>     +++ /dev/fd/62  2018-01-18 21:14:30.646016210 +0000
>     @@ -11,7 +11,6 @@
>          Reported-by: Brian Bennett <Brian.Bennett@Transamerica.com>
>          Signed-off-by: Eric Wong <e@80x24.org>
>
>     - git-svn.perl                    |  1 +
>     - t/t9169-git-svn-dcommit-crlf.sh | 27 +++++++++++++++++++++++++++
>     +     git-svn.perl                    |  1 +
>     + A+x t/t9169-git-svn-dcommit-crlf.sh | 27 ++++++++++++++++++++++++++=
+
>       2 files changed, 28 insertions(+)
>     - create mode 100755 t/t9169-git-svn-dcommit-crlf.sh

Interesting. 0433d533f1 is a merge commit, perhaps that has something
to do with this. Adding --first-parent does show "create mode" line.
I'll check this later.
--=20
Duy
