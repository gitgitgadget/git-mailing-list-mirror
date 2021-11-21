Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D40C433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 02:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbhKUCDr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 21:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237562AbhKUCDr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 21:03:47 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58D6C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 18:00:42 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id y12so60093979eda.12
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 18:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQMOJJLCIRUa+91pCG2fuHck5TQBqEm6GXuBc/jCSiQ=;
        b=i7/gXB7zltMyWBRVeD1N1G+5IzM0Z7DVavXKW4q8xSscWDUV6QGs5sRJXl1i91fKoo
         0B15NGZ3OGjH68pLcdM0Hj+PwJ8N/7DqhAQdJEipTx/lkVy+QQc/xYdqq0jz4ze93cOa
         IVYHL55dipol13B/3APuUyrLtE5+SGSo6oIwZAfAlKZ/nAMccEsWpJD+nxcZWtTdIVBN
         OTNQdyjd0QPBqecxl40Bj7Fspalx0hDm/23uf/CXqcF6C8RpzD+8Iki5rIbuC9C2wG3C
         /SaMYf9k4koJLOnfR8//ZfWWODOlXdkPUzBMlSjJkfSPcQXfKsHwaGvh7bhLtY1kMmJM
         uzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQMOJJLCIRUa+91pCG2fuHck5TQBqEm6GXuBc/jCSiQ=;
        b=s+MJc6Mwf1DZwdLxmye+Ehq9Nk4DyXNSIo+f4S5UffwX/ophN8LV2RMjnNGAibZzTA
         Lp3SLpTEtF1OAjT6ARn0xvVP9WnRoO33NlpHCrvwhPa1OJOcDOCU22BsVYKoI5kexl/C
         5y7JLemm+jKWQ+qC8ZNtp51PkvEMcx0FoR1gs6MqGP7ZZNJsTl79vLw5Hy2GTrkqU5fA
         ET2BANL3dHezwnee5tfBkv3Ft5zqsZMiICw8T7YQRln+Q1O7hlFL8tFhggp2BqFF4KYL
         IqTzQTYfDab1hio3AxpyjUVK+IPLI9OwhZqtUj6irP70Q9KyLz9jzJ7JNAhlcAcsGsmM
         1CSQ==
X-Gm-Message-State: AOAM530RoibVay/X5TfeoNsXXJnbpiiSKWc1JEmMofWuYNm0g+dpALFq
        zlOgKHwK3bDYFm5LAFXMwB3Kpckiv8eGN2cvvA0=
X-Google-Smtp-Source: ABdhPJzmzGg2Li1+SVNFf8CYsKDZSyn0CEMbXyZ2ZIigc9J4U2CWyaFgTjalp2kRxZx7EBLO0lwG5zex77Sdb7qyjpM=
X-Received: by 2002:a17:906:3a4a:: with SMTP id a10mr14803889ejf.253.1637460041311;
 Sat, 20 Nov 2021 18:00:41 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6hznvz1.fsf@gitster.g>
In-Reply-To: <xmqqa6hznvz1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 18:00:30 -0800
Message-ID: <CABPp-BFEhD6MPbw79zpvpfs1_Pug46vi_MWRmdNGpqP8WYec_Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #05; Fri, 19)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lessley Dennington <lessleydennington@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 19, 2021 at 11:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * ld/sparse-diff-blame (2021-10-27) 3 commits
>  - blame: enable and test the sparse index
>  - diff: enable and test the sparse index
>  - Merge branch 'vd/sparse-reset' into ld/sparse-diff-blame
>  (this branch is used by ds/fetch-pull-with-sparse-index; uses vd/sparse-reset.)
>
>  Teach diff and blame to work well with sparse index.
>
>  Expecting a reroll.
>  cf. <YXgpqJIS2OgOgS+k@nand.local>

There was a reroll since the reference you provide here, and
additional reasons to want another reroll beyond that.  Your status is
good, but perhaps update the reference to
<1a269d05-49f6-6c49-860a-044070f14ffc@gmail.com> ?
