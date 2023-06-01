Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B19C7EE23
	for <git@archiver.kernel.org>; Thu,  1 Jun 2023 06:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjFAGSp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jun 2023 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFAGSi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2023 02:18:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2743899
        for <git@vger.kernel.org>; Wed, 31 May 2023 23:18:37 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2afb2875491so5259901fa.1
        for <git@vger.kernel.org>; Wed, 31 May 2023 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685600315; x=1688192315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lchYZMJAS0dI9n0znXSxuHE9batmGmhiCkGp48RZKM8=;
        b=Gfs9E8FQWoUzOExH7VOaMGQ7FHddmFAsIzXaa06udZPNd3JAfRO094g1O4EwluVM9K
         ahtbI0vVEPIwI2xv1VKhP3ESFnxrv+h4OYFbB8ZEZGq3KUcuKN5MR7HRlP3hUWv36PLY
         t1isSL/Dm9FEXXo3n+ZnTYCPX6GjlxI7fHpdjf8SukRom5bTUQN2w0NS8JRO4Dc9JslS
         Kb6H2ymckksCNiePwvY4hc5PTBJrmq7+fmawgYiEPBlxlsstqmiwWLZyndNkcwHZgnNT
         N7P5EX5QtUKhpHFQXo0Q00zFNpC5mN2TQBCqfLxezCjk2svjtHLCRvolRv5LEEdKp5y3
         uJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685600315; x=1688192315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lchYZMJAS0dI9n0znXSxuHE9batmGmhiCkGp48RZKM8=;
        b=M3PUnQDYQ9DEAAa0WQEnC/ZR4CpEL2rJn21BBU2LIRH1KxhUKqrS847PJnDZe+qYkS
         zn6fdB/VkIcYf/nO/hVGjdpbbRE92Njg3ABaWSWcb7qv1qI06XN7WXNWdPH3yEv8Pf0t
         a8pZ9sH1pnSvzinJIkMTFEFbF25xGUXu0OjO3ss/32bg/TaNCNVvhQNodOzjI7xzZS80
         5UYRNrdGhoPIXxfQ49c9aqTwxBnAmUBr+6k19mqquwfaTwQkOykRXRTJnGGM46/pBRyK
         ah1mJioRk2fEOIZfxePMERkvZuu7oepyThXA6/R8LbWxGqPwaQZIi2XSyAjzsHVPhbK8
         qvUg==
X-Gm-Message-State: AC+VfDxqcKOG9i10FZM6qi33UlmShwlgfDfYDEBLDcYhDba1vl21H0S7
        hATRQ0H03MpobgSTOTy3a01rN5WMEzu/9FuGkFjBWAHIaFE=
X-Google-Smtp-Source: ACHHUZ4osi3zBxXJHOQ5TxXq+bCbRQYz0Y7mNgGsITZb1/AkFZBPfSXb4gU0ay4N2pWW5ALZ85kwIvsPPHuRig0rdgA=
X-Received: by 2002:a2e:8382:0:b0:2ad:ad0b:d0fb with SMTP id
 x2-20020a2e8382000000b002adad0bd0fbmr4077618ljg.30.1685600315050; Wed, 31 May
 2023 23:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com> <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
In-Reply-To: <pull.1515.v2.git.1684783741.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 31 May 2023 23:18:22 -0700
Message-ID: <CABPp-BH+vT_dEKUwn1M2D-FuCtF=hRM8OAFj9m1x6rkV97oEDA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Document 'AUTO_MERGE' and more special refs
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>, Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Chris Torek <chris.torek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 22, 2023 at 12:29=E2=80=AFPM Philippe Blain via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks everyone for the review!
>
> Changes since v1:
>
>  * Addressed typos and wording suggestions from Elijah
>  * Incoporated Eric's wording suggestion
>  * Added a preliminary patch adressing Victoria's suggestion, based on th=
e
>    what Taylor sent.
>
> This version is not a "fixups on top", it's a complete new version. I don=
't
> see the point of merging typos to master if we can instead wait for 'next=
'
> to be rebuilt after the upcoming release.

I re-read the whole series.  It addresses all the things I brought up
in v1 (except the bonus idea I threw out there about mentioning how
AUTO_MERGE is related to --remerge-diff), and all the things I
remember others bringing up as well.

Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks for working on this!
