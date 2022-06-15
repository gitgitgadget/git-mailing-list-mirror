Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5651C433EF
	for <git@archiver.kernel.org>; Wed, 15 Jun 2022 07:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346760AbiFOHjn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jun 2022 03:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346638AbiFOHjj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jun 2022 03:39:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0A393DD
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 00:39:37 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a10so10497411pju.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=NF2ZCMf5p/TQgAeeWJO7oxRCoViOwgfCl5RRknbNHUs=;
        b=eGjGiAsrmArQriQNnxkKCNiPZ4uY3fSuJ4RGNb2BPRawUbZpLfzll1xHCMSpUuAPFT
         CUuaf9Up3ZkseMd4mlMeWKtXDNd5iK+qP0We86cM2qb9OYfQOv2xEWmSRYzv24BhZvnq
         w0BC7EMXZqFK5N5yERW+eHIs1JrYQCHMsTY7o1VXGDztDMF22+AJlizzr7IS73To8A9m
         +J4wNU6hEo1PHj+FwA7sT8CB1iXHp2/LWKsaU55wk2gi+Rw+c4NyIgaIqL+vpNPUco0l
         6QGgJM6dI5iH63IVXVifAyrhFC9MkraD5EZHZGpXob0nTqLiFrZhRm2ir/l4r4krP6Wk
         T86Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NF2ZCMf5p/TQgAeeWJO7oxRCoViOwgfCl5RRknbNHUs=;
        b=ZPaGJR6D9BwWP8e/wuJu6VRNcoyZebqC9U91KwdBXOMjSJaJ8+JTp3fY9mmulVOj6B
         lAl8LbuggkpwmvrMwiSRIdlHMLvWR/A/7XqJ1DBwObWUURL/7jpZTVqqIDiX/pFXB6Mn
         dsd8k8w9PXZtgvt5/oK+9wHQJqqxBVpETyq8sHfO6HMWYuVo3A/rOO92ronppLssWt8t
         8vXtDUiqjmEzWKQHuXDLMF1ey3ORPK94/RWoQ8UPH4Ytov7dmF0znILrVH/+CSo99kOX
         GsTbuCF0spOfn0N3K2CPACytEMtgdNvxBgEgaAdfNQYWTuYxIOwxoojEZaulmHQ/qiIE
         n8uQ==
X-Gm-Message-State: AJIora/EausDNAfvDIGt1pGu4xBQEG7fwYbSHf4bF+Pt+mUa4bZZ4Q8V
        eGk/L77Zv14PPGfD0HnxLlMVDYGvqQu4goSziksvHWmVdkI=
X-Google-Smtp-Source: AGRyM1uWyp5PiXu3V+YSyBtkf3paaiH+mqi/Yk9+Mbv08Vj3qyfSt0N1yHxE78cr2W5zr9AO7IlIZn6eLmca7f4TY18=
X-Received: by 2002:a17:902:8345:b0:167:879c:abe8 with SMTP id
 z5-20020a170902834500b00167879cabe8mr7940951pln.7.1655278776635; Wed, 15 Jun
 2022 00:39:36 -0700 (PDT)
MIME-Version: 1.0
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 15 Jun 2022 15:39:25 +0800
Message-ID: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
Subject: [GSoC] Status update
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

Here is Shaoxuan Yuan. I'm this year's GSoC student for the project
"More Sparse Index Integration". My mentors Derrick and Victoria and I
are already in touch for a while on the Slack channel, and I'm writing
to let the community know that things are going well.

For the progress report, I'm going to do a weekly blog here [1].

As for now, I'm still working with my mentors to refactor mv.c for
sparse-checkout and sparse-index integration. This series is WIP here
[2].

[1]: https://ffyuanda.github.io
[2]: https://lore.kernel.org/git/20220331091755.385961-1-shaoxuan.yuan02@gmail.com/
-- 
Thanks & Regards,
Shaoxuan
