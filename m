Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE433211B3
	for <e@80x24.org>; Thu, 13 Dec 2018 20:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeLMUXr (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 15:23:47 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52594 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbeLMUXq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 15:23:46 -0500
Received: by mail-it1-f193.google.com with SMTP id g76so5663440itg.2
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 12:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klH4kocA7ZOBBqdHFM89FbZ/RzIX0veNaWbow3R4bU0=;
        b=DNy/HcqY/i+xetkx88p7f5wdsvAsdDSxtp60C136VbxHcZnbPdceuXB1lG7OvwDrIp
         jvCchNJ6dzHkeVkBSH8fgdc/DZ57xMeh18t00GnmI+ySJLJOX5wZqK5mUtoZSbg3zoxB
         UncC2hCQEOadOfSkk+ya4klySJEVACZ9zAMgj8oPQWfxRXc3fUrO3Nki4NNW0R6t4lae
         qWnQJ+OzT5dShSfFSy3aerG1vPunWuBQoEMOCVPLZ37coNkhgbSzWutu74XYTiSV5/5z
         SdLHhbgw2YrSil6Fq+KIaBjh2h9sX8iDMz8R0GggN3/5Rfx3pbZe5xE1rNS2THpGFXb4
         MwvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klH4kocA7ZOBBqdHFM89FbZ/RzIX0veNaWbow3R4bU0=;
        b=N5YxJSr6gg/w/S1Nr28W9VprwzZ5R/OhgkIbgc84wJCwP0s4h5vbBOCdEz20pObvm9
         KcQTyq5zYcMdKsdeeVrcBRErm0gqsGIdRUS84/4AC1MjTQMmETQEaqYzWJI47a8ro5SG
         ZEbj2CRiunIKybkv6M6f/c9q0Ae8lHGE2Ap9UHAwwPX0JkgA/v6tKRETxHIkEQIeC4az
         XH9neh76LwbMLhOUlHCiD+uCekUzae/AjNEgUkc4s1YXQ3L+ss8VgQXt/ppVM4xPK5l9
         F8uS16mAOVc4j13P7aURDivh0Jz/cv/+TO7bcxsF2+UiUZfc4IY+VFenfBCJssGK7NwD
         KzXg==
X-Gm-Message-State: AA+aEWbt5ReEI7Vt7zc+df9XxSEjB2WxO7KFa25kRLkna4HKQxGfkxHv
        BBbXfQvZmrwgjdiUskySbPuwqlje7pFEB1KXIbk=
X-Google-Smtp-Source: AFSGD/U5qR86RYng/qbCgAvVKB+Pgg7TbkKZO2gbLGzDjllqrqXHKpL2Fs3Pth4qDUiiseIw1qQfEyaSgM/kNkGB5NY=
X-Received: by 2002:a05:660c:81a:: with SMTP id j26mr781242itk.70.1544732624101;
 Thu, 13 Dec 2018 12:23:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.100.git.gitgitgadget@gmail.com> <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
In-Reply-To: <13ee60e44f91ca06d182ff50fa4c69e137650fd2.1544730848.git.gitgitgadget@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 13 Dec 2018 21:23:17 +0100
Message-ID: <CACsJy8AsRT+k4kdwC3gGjDOPiDn-L0GJs7-SQHb88Ra_gt4OcA@mail.gmail.com>
Subject: Re: [PATCH 1/1] worktree refs: fix case sensitivity for 'head'
To:     gitgitgadget@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Mike Rappazzo <rappazzo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 13, 2018 at 8:56 PM Michael Rappazzo via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Michael Rappazzo <rappazzo@gmail.com>
>
> On a worktree which is not the primary, using the symbolic-ref 'head' was
> incorrectly pointing to the main worktree's HEAD.  The same was true for
> any other case of the word 'Head'.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
>  refs.c                   | 8 ++++----
>  t/t1415-worktree-refs.sh | 9 +++++++++
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index f9936355cd..963e786458 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -579,7 +579,7 @@ int expand_ref(const char *str, int len, struct object_id *oid, char **ref)
>                                 *ref = xstrdup(r);
>                         if (!warn_ambiguous_refs)
>                                 break;
> -               } else if ((flag & REF_ISSYMREF) && strcmp(fullref.buf, "HEAD")) {
> +               } else if ((flag & REF_ISSYMREF) && strcasecmp(fullref.buf, "HEAD")) {

This is not going to work. How about ~40 other "strcmp.*HEAD"
instances? All refs are case-sensitive and this probably will not
change even when we introduce new ref backends.

>                         warning(_("ignoring dangling symref %s"), fullref.buf);
>                 } else if ((flag & REF_ISBROKEN) && strchr(fullref.buf, '/')) {
>                         warning(_("ignoring broken ref %s"), fullref.buf);
-- 
Duy
