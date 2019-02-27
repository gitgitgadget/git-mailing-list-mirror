Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412B720248
	for <e@80x24.org>; Wed, 27 Feb 2019 16:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbfB0QCu (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Feb 2019 11:02:50 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:42650 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfB0QCt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Feb 2019 11:02:49 -0500
Received: by mail-ua1-f67.google.com with SMTP id s26so5155469uao.9
        for <git@vger.kernel.org>; Wed, 27 Feb 2019 08:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qyor3uKjzG8nKodkg5na3Q8EFgJBhYxFsoWPVf/OwrY=;
        b=UEVdcuxoqFGdh26gnL0+it7HSpPyuR2crPRAEhtX/KBC4BAPzzfvCvMuxWiqJdNhOY
         UUUgv8jc6XlYa0R+bctEz1qrJTm6x4yjPMoeK/iPOtZU0IiKF1KFnjn6nbbFjWEWM0mv
         Kd8BBuhsqoRKltfiHqHd+N08YuqphKXNjpOp1/dEerpMqpPoBh96P9TAwnUAGMdFkYmV
         B5Fjr0OLNVUiIyKIxeKuO3dHhyYiqn0EpWK3Rw/ZpCiIZLMFRqgLUhQNht0BSrqx2u78
         DzBoImB388HCY975wM6pcRRFKeRAiZK2IxqZ/C3XJsHMiDXOXLhG0muWejR+DeSxI1q+
         X3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qyor3uKjzG8nKodkg5na3Q8EFgJBhYxFsoWPVf/OwrY=;
        b=gq8hRN9rlh3bJcJV1LQx5M05vKJslh5I/R6iinHkQ0udHePgTV7lndEdiNaFJcsyP1
         nc/UOsfCF3V+GJvUiO5THxJvYdbfenrJG84hHWPEj24glCs+fEJ8GYYojvSQritKaGpo
         VPRywQ0KfZhhvIKjvuhfmg5TpNp7FsDrfo29ol+cwlYCJazCUSxR5dvUNIwxjHO7UEIY
         lyo1+e5cYgXFj2RBXefNtTERg2LbDzGLs9ySWeGgk4kGv4Z2VP3Q6IpKVo5oMVi9QKhY
         66YEoWahavsy5fPxibrw4wrThOQsveeSrMV56D3YczI87ONYe7Qq9R167bUMzLWB4AD8
         GxuQ==
X-Gm-Message-State: AHQUAublu7ddt3yd7XggQYqa9KjIJgUpd/o1hgbIZzLmLH4vxrYSFAEP
        mWNKbPdgdvO9ku4MNXaVRDDjzFHM3d7T5JaXvLngrA37
X-Google-Smtp-Source: AHgI3IZaRLUaxyAL2RNaeH/Bx1g5KYPWmRdASYItlpRHv4rBrJP2cUlCmTnMQbDinGMslgQPPYcZQ+qZKeTLWzXiBKM=
X-Received: by 2002:a67:7247:: with SMTP id n68mr2074778vsc.136.1551283367993;
 Wed, 27 Feb 2019 08:02:47 -0800 (PST)
MIME-Version: 1.0
References: <67C5CE5D6EC13D4DB8FC51E2F9BD262F022B8B3151@Triton.ad.trimma.se> <512993fe-51da-745d-031b-37ea162499fb@gmail.com>
In-Reply-To: <512993fe-51da-745d-031b-37ea162499fb@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 27 Feb 2019 08:02:35 -0800
Message-ID: <CABPp-BGbrWrS0622yfTRUqRzWzNsZ_v9cAWW6ucXBYXqD26qHA@mail.gmail.com>
Subject: Re: [BUG] All files in folder are moved when cherry-picking commit
 that moves fewer files
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Linus Nilsson <Linus.Nilsson@trimma.se>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Feb 27, 2019 at 6:30 AM Phillip Wood <phillip.wood123@gmail.com> wr=
ote:
>
> Hi Linus
>
> On 27/02/2019 12:47, Linus Nilsson wrote:
> > Hi
> >
> > I have found what I suspect to be a bug, or at least not desirable beha=
vior in my case. In one branch, I have moved all files in a directory to an=
other directory. The first directory is now empty in this branch (I haven't=
 tested whether this is significant).
>
> I suspect that because you've moved all the files git thinks the
> directory has been renamed and that's why it moves a/file2 when fix is
> cherry-picked in the example below. I've cc'd Elijah as he knows more
> about how the directory rename detection works.

Yes, Phillip is correct.  If the branch you were
merging/cherry-picking still had any files at all in the original
directory, then no directory rename would be detected.  You can read
up more details about how it works at
https://git.kernel.org/pub/scm/git/git.git/tree/Documentation/technical/dir=
ectory-rename-detection.txt
