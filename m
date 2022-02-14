Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8A4C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 17:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355827AbiBNRSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 12:18:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242400AbiBNRSr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 12:18:47 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EAC65179
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:18:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id e7so34790931ejn.13
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 09:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=/mzfHobVBsxsYJGHySgQJC8Fpit1BWCoHS8XtPRrniw=;
        b=EBOuDDm4Bn6SQkC2c8sNXh1/a/jXyialBpJ8FFW5qE7+FlCbEZGbTFvF+Y8SNxGVr2
         qbB1njML3vmEGNyPz1zkcELA6TP59DscRRcBEYlEFwbTUxg91IQpcNmY3q0SqX2nBkxi
         fd1K+JBMQF9AhtE8FiN2XvFhcp5z7r+tlKQb/HdOZLUhc8oE1N0pLaQsLRXxt1Ix8cPx
         u5iMdY25ZVtq3kDhBJcj0sjyoYCBAONgZ0meLW1oMVOjNwhIqloFxqzhhJ9M4OgxbdXU
         qUqHkWJV75TVMF8zSUobDQkw2HJ4WslRMBDinNQMwBE2I/2uwo1i7pRJSvpDdTh770Yz
         PriA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=/mzfHobVBsxsYJGHySgQJC8Fpit1BWCoHS8XtPRrniw=;
        b=fRNexTFD583fT9Egt9H1gARS78Izj8UM1khuTyAYEvSdme0sWL+8RgeM8Cq/N1+OY8
         lhHaj1TdRI3I4KAW21fdasZZxEXYnbGMDFjKf7qek8ufNmh8F7okxffpJqcgOAFiSrbJ
         A0sT2u6fPRb1kaSkSAZyMGTeRZqo4pN6ypcfwQsvNhgF2zUsaxIx9t0IsWw13D6bfOcd
         nGbSbbKkPtRkZaMrIUSdb+Ii63M0faKBFxVty9qHf3y+QQRXb8/PpMluU7oZPhPfEmXo
         erHgt57Lh+LrE6XTfNXxoiI/elTQxYeGvIyD7z1TZEtsRGhpx7AAC+FVc4UGU3ZCTCuX
         DviQ==
X-Gm-Message-State: AOAM532Ep45NAWQwxhd794FqvscUHeFlev+6eDqK2JG5d1D+Chg8tH2s
        M0kpyZLxL8lepYYD2ih2ZxdB4DnvxUE=
X-Google-Smtp-Source: ABdhPJxnKhGSB3QdxhUUr71IA41+n+uRKaVpxKPxy0uBtLaTPrSJ8qNWLAr2OVuhGktUv0bdvfMt/A==
X-Received: by 2002:a17:907:3da1:: with SMTP id he33mr440391ejc.603.1644859117646;
        Mon, 14 Feb 2022 09:18:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q12sm15347104edv.99.2022.02.14.09.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:18:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nJezk-001aeI-JP;
        Mon, 14 Feb 2022 18:18:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] mailmap: change primary address for Derrick Stolee
Date:   Mon, 14 Feb 2022 18:17:19 +0100
References: <pull.1142.git.1644857153590.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <pull.1142.git.1644857153590.gitgitgadget@gmail.com>
Message-ID: <220214.86leydxt77.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Feb 14 2022, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Stolee transitioned from Microsoft to GitHub in July 2020, but continued
> to use <dstolee@microsoft.com> because it was a valid address. He also
> used <stolee@gmail.com> to communicate with the mailing list since
> writing plaintext emails is difficult in Outlook. However, recent issues
> with GMail delaying mailing list messages created a need to change his
> primary email address.

Yeah that sucks. You might be interested in the tips I had for working
around it in
https://lore.kernel.org/git/220202.86leyt8uly.gmgdl@evledraar.gmail.com/;
and others have suggested subscribing an alias address for the GMail
address.

> diff --git a/.mailmap b/.mailmap
> index 9c6a446bdfb..07db36a9bb9 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -59,8 +59,9 @@ David Reiss <dreiss@facebook.com> <dreiss@dreiss-vmware.(none)>
>  David S. Miller <davem@davemloft.net>
>  David Turner <novalis@novalis.org> <dturner@twopensource.com>
>  David Turner <novalis@novalis.org> <dturner@twosigma.com>
> -Derrick Stolee <dstolee@microsoft.com> <stolee@gmail.com>
> -Derrick Stolee <dstolee@microsoft.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
> +Derrick Stolee <derrickstolee@github.com> <stolee@gmail.com>
> +Derrick Stolee <derrickstolee@github.com> Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
> +Derrick Stolee <derrickstolee@github.com> <dstolee@microsoft.com>

FWIW I think only the addition of that last line is needed since the
.mailmap syntax supports mapping A->B, followed by B->C.
