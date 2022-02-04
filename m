Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A03CC433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 06:06:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbiBDGGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 01:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349254AbiBDGFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 01:05:50 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE42C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 22:05:49 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id p15so16050811ejc.7
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 22:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qg2niVgVwIfOPhdhCTmuyP86NeDFDyEVKit8mpfAeRA=;
        b=lKlNJNPaG689bIMR565VRElvSccD8zOyapQ1h12HDzLtbwcEU28w12iH4+7c/t3EXq
         bLxh6uIN/5Ky1b6C4EFKMc3UpxpeiDAVwbCZOnZuWtDwEo+HnucV388f7Y2E+R2L3tub
         3Kq64+1BwmbD2OA7jBONglsfI0niCUf5Q2Vc2RljKspyxHdd+92iNT5WamUaiYilAbLN
         Brct1srNB3rSSjtAZVEXqiN0Thy3pfygtKtoPJK/2H9rWecTcAkkiEzV0KiD37ryNi9C
         RSZSkdjdn4HHaVS2XWOJuIFOfvBRS1lDzZ+pnNuYochD7ZAq+HivGeALFCGtgfgqkxUf
         pLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qg2niVgVwIfOPhdhCTmuyP86NeDFDyEVKit8mpfAeRA=;
        b=oRU0CjEmvA/83UKhTijLT+xSIeNFJeKXVaGgqnRa+/jeViAf5VCIIhsWU7UwZ37uvs
         c+NMuYt0eltikNLbeP/DQFkBemeLlZmhcvByxBeNlqMRAvtyauUTB7Lg3eMNBBpMkN0d
         idsz5vaxaLRiCFbkCssMJ2S6Ic4C0wPSBA/yOHIDyvFQH6lB0i91cYV0Qi/1LZH2p0NT
         51SUreEqxaVdcNYxbGB+FW9ktvsfHzOrRSqg8wmc8nWy7xswt84Bcp8oAndrUxlNs7Kl
         Szj+p1foM4uiDAMvsT/jJsrMmOxUinCWL/t4EvmN2XVWo30lmOpRQ9FItDvLUhZsxnrE
         p6ng==
X-Gm-Message-State: AOAM5324gneMiiMP5WdEuwBi2XskIPYsGx6e3YLOarOAbUMe8K0Y0na+
        /VdCekYGU9JhyrZFTi3/UXo/8rUCqAH3Qn2XLyZoGaBK
X-Google-Smtp-Source: ABdhPJwibv8P6XPxH8bBWZFiAwzWgg9IFqOebDzO9fUyQCn5z8IvgqG3ZKDV7O5XehfrnwFXqs7vJosQTaoHZXMGN1Q=
X-Received: by 2002:a17:907:7388:: with SMTP id er8mr1130482ejc.269.1643954748010;
 Thu, 03 Feb 2022 22:05:48 -0800 (PST)
MIME-Version: 1.0
References: <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com> <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
In-Reply-To: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 3 Feb 2022 22:05:36 -0800
Message-ID: <CABPp-BGM0xu=Hgd_uKevAbpCtxR9ZY5NX=PWNn2Bqw8SaOJvLQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] completion: sparse-checkout updates
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        johannes.schindelin@gmail.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Feb 3, 2022 at 7:26 PM Lessley Dennington via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This change updates custom tab completion for the sparse-checkout command.
> Specifically, it corrects the following issues with the current method:
>
>  1. git sparse-checkout <TAB> results in an incomplete list of subcommands
>     (it is missing reapply and add).
>  2. Options for subcommands are not tab-completable.
>  3. git sparse-checkout set <TAB> and git sparse-checkout add <TAB> show
>     both file names and directory names. While this may be a less surprising
>     behavior for non-cone mode, we want to only show directories in cone
>     mode.
>
> The first commit in this series is an intermediate step that fixes issues 1
> and 2 above and introduces a simple fix for issue 3 with some performance
> and unusual character-related caveats. The next commit adds a new
> __gitcomp_directories method that fixes the performance-related caveat from
> the first commit by completing just a single level of directories. The final
> commit modifies __gitcomp_directories to handle unusual characters in
> directory names.
>
>
> Changes since V5
> ================
>
>  * Fix incorrect conditional that was causing failure of non-cone mode test
>    (and causing 'seen' CI to fail).
>  * Remove __git_comp_directories indentation changes between the second and
>    third commits.

This round looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>

Nice work!
