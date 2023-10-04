Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058B9E936EB
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 22:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjJDWCm convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 4 Oct 2023 18:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjJDWCl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2023 18:02:41 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B5BD
        for <git@vger.kernel.org>; Wed,  4 Oct 2023 15:02:38 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-65b162328edso1298566d6.2
        for <git@vger.kernel.org>; Wed, 04 Oct 2023 15:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696456957; x=1697061757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P44uDb45mWi0sl/Udvmg+vD5n6v75KxZJ93qh88nuYs=;
        b=f8FWRyQGOSF+mt2O6JHAJGTAn4VhZBwPz/FVwcOZY2OKG7Cdi8IqII0lO6M8P4KOOX
         LiOqi+YJmAYgi4ezJ59z0i1JS2zkMASx/GW0FEKfaBidqGmvq3vBMXTpjqQYvqerhXdc
         QgW9MIDD5s7yzuXLpTaiXvcyiCLIhM9EGkqKSxnMDtGnH7iX9H7gEiSnSsdK/X3Jp/fE
         M+5li3SAc3fHmir0lEMG0iKUaLrZ3spPGazOQD2nLtDFyL4C22Z+2t7ODLFpxl+2ny2v
         avB0hqWcJv4UEtNHfm2hg2cEFmffGyXMcZo4tth37tY0sG/SlYFgppbRFScyQvxVcKcx
         5cww==
X-Gm-Message-State: AOJu0Yy32ZgH5GdnhfDa5P0sm3Xu1GJoXvx5befsb1yLzg4ay4/Fuyl/
        4twUETSMXZckEcLyMuLKAl9sQmRRBWPgfyOpAkkwLv6E
X-Google-Smtp-Source: AGHT+IFjQIW5v9X54l0OFXSMyW9kQdxlM3SE7FyhY5vQpwMcYJXPv6pZTtxFQuNZSSfLqoov+S0tya0+dfiFgVdFGOw=
X-Received: by 2002:a05:6214:5b0f:b0:655:ddd7:fcab with SMTP id
 ma15-20020a0562145b0f00b00655ddd7fcabmr3730582qvb.49.1696456957304; Wed, 04
 Oct 2023 15:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230909125446.142715-1-sorganov@gmail.com> <20231004214558.210339-1-sorganov@gmail.com>
 <20231004214558.210339-2-sorganov@gmail.com>
In-Reply-To: <20231004214558.210339-2-sorganov@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 4 Oct 2023 18:02:26 -0400
Message-ID: <CAPig+cT63L2+XmDRKw4Pc+iDmUL+UFcyummOcOtS+3wYaNbFvg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] diff-merges: improve --diff-merges documentation
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 4, 2023 at 5:51 PM Sergey Organov <sorganov@gmail.com> wrote:
> * Put descriptions of convenience shortcuts first, so they are the
>   first things reader observes rather than lengthy detailed stuff.
>
> * Get rid of very long line containing all the --diff-merges formats
>   by replacing them with <format>, and putting each supported format
>   on its own line.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> @@ -43,66 +43,74 @@ endif::git-diff[]
> +-m::
> +       Show diffs for merge commits in the default format. This is
> +       similar to '--diff-merges=on' (which see) except `-m` will
> +       produce no output unless `-p` is given as well.

I'm having difficulty grasping the parenthetical "(which see)" comment.
