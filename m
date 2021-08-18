Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9224EC4338F
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 14:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73D42610FF
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 14:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbhHROOO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239267AbhHRONM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 10:13:12 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90B6C061764
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 07:12:37 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id o10so4901256lfr.11
        for <git@vger.kernel.org>; Wed, 18 Aug 2021 07:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=xoA1VZE84nZ9kdUa+pR5LqPVw3y5IvprMbCSt8sopU0=;
        b=O0dBqXXSBloJA0c7BYgVJg+OSmu2QdoR0UIbrFeF/nNjLh6R0yAr9k8YgEmHnNF8VY
         GmG+wSz/UPj1+1gN3wPCpNPtN4+3Lz27eHlvVzYRi7MCoOqxhXxEGPcvYRf6++s9no1/
         fQhDR5f7kxt/UGWn4Q7lLhoFi7yThRpqvzujx0eF8mdn590L839/hhf2VsThZuwbomAU
         w0tio6VE5UWxwnoN3SuhqhY9Q9JnyDl3JMO+rKriQ8/StcfYa1nR9pb1DvLL+n19FZAq
         cHbiEIRlQrvH9F1FEEWrPsLrLwU7LwpoXHzw8IjJc4Kb6U9FHBpmFjaZyw2W1LcNBkAL
         w61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=xoA1VZE84nZ9kdUa+pR5LqPVw3y5IvprMbCSt8sopU0=;
        b=k9rVLpk5bbb7i2q7CHVuJBGFkrMnCi+8BmFPFxNh/FwGk+8gSuCeOHDh7fGLhiPQCh
         xJJxXLRXYUGKCylO4Oo8ytkag+qrBQasSccRG3OgYOBL+FX6HZFyxKscxoCYbpFYjEMM
         uiKyJTojM8Ko9uxLVlpKhNwI17QnGVgYg71S7Bj5oE2DRG7Gy2DEEu0vgIFa5LUYV/If
         Fn0XtBeGk9xSJ74GiP+4Ltva+MbwWUzCEpbOVtCRJe1xVZQgugurJdQFn6I3kfr/uJNG
         32YJVnKxkQTfufZvFnG9NkMJ4WkiFtU4tMKoPVwoLvnY8WK/rsKps9xq9qHj02daQJdp
         rWvw==
X-Gm-Message-State: AOAM530JaDvkUVMnYK7csQ2TiW05UqfrnFRaUxzUC/PkMQMAWFrYuFQ3
        H1CmXFqeJzvzhouSxRJfmH2BYqDfEgvNWJ/vIIvPQXAnjRkNtA==
X-Google-Smtp-Source: ABdhPJwj2uwggxWjBaeUhuMYFuLS8FueWWeWgskSXpo2pbWWfxwqMF3Rx5rG7SX2Se3yeSwXDtnpYtPAdzghHT8DNks=
X-Received: by 2002:a05:6512:139c:: with SMTP id p28mr6536226lfa.523.1629295956174;
 Wed, 18 Aug 2021 07:12:36 -0700 (PDT)
MIME-Version: 1.0
From:   yan ke <yanke131415@gmail.com>
Date:   Wed, 18 Aug 2021 22:12:34 +0800
Message-ID: <CAJosSJ5FZGp6PtUVgq2o7+vxV5jeO=i+nJiXJE5V6wRX-NVfDg@mail.gmail.com>
Subject: gitk translate msg files not installed correctly
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,
 I found a problem with the gitk translation msg file in windows, the
details are below:
1. The default gitk msg dir in windows is
[git_install_dir]\mingw64\share\gitk\lib\msgs, but the install process
does not install gitk msgs, no that dir exists
2. I use innoextract to unpack the git windows install
file(Git-2.33.0-64-bit.exe ), and I find that the gitk translate msg
files are not in the package ,is this correct?

So I think the gitk translation in windows does not work correctly, or
something i find is wrong?
