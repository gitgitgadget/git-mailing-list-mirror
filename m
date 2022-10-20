Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34ECC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 12:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiJTMqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiJTMqR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 08:46:17 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95BF42AC7
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 05:46:16 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z8so13570102qtv.5
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 05:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/vSvr6TBcmTUnmW+NayAXyklJplSCD/f4BFHWtgNXBM=;
        b=brmkIMu7v8BxtOjPr0z/LuDzdJGfW6UO1wYb9vHwY/ft0gdf+Wv+y7TG5H4evyl1OG
         H5thNpZAQmdlzQaWCcUcBhDBYnM3uf/y/upzV8szoIn3yKqPWnAQMnR5DMKv27kfX7bU
         1cEZm8KZCF3CDya+Beq348F9rydKB9ie51/00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vSvr6TBcmTUnmW+NayAXyklJplSCD/f4BFHWtgNXBM=;
        b=zRCjn7ovRoC4mdhAhT+s1mftBcUBviVBzN8FxNNOUaqMyUBn68m+nRgz0NSKh8Lyxw
         nAqwAUnpcjHaCd7aAO3PUaH2ZZCtvMX/rZQP+Vfx69xtYtp/f54QEomykl1gZRQF+0lF
         H+gX13EashOH6LZp9SXAzI3fkqe6f6t+Ue1CQGlvzt14jidmAIA+Dfb/61EdYLhWkmya
         RekzLEi3oKM4YXEHhWWGuzVKq50C94EHEULzxcora8tQ1u5EFLdl/A7ozt5dM7lNT+Hg
         a/ieV9S2Ci4P1FImDyu7DBT45IXvOYSh1Dg4Pcm5kATWe84KTSf1cYqLdZDxbQE1G4Ym
         FnEA==
X-Gm-Message-State: ACrzQf2sIHozRsJ2cJYoFw0tr6QIt270WdBC7teQ6ebxOagjxOBlXf+z
        BcomM/2T1ga3+1O+RklJ4do1HGFBnB38cQ==
X-Google-Smtp-Source: AMsMyM4EhrL7QedVQgbUPj6iorqvdZspYLRxT/F5M1OeDXuFep9hidK92bIyTM1HMngcUycyit/jqQ==
X-Received: by 2002:ac8:5f47:0:b0:399:aa82:3c6f with SMTP id y7-20020ac85f47000000b00399aa823c6fmr10700177qta.627.1666269975502;
        Thu, 20 Oct 2022 05:46:15 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id i11-20020ac85e4b000000b0039cb59f00fcsm6166082qtx.30.2022.10.20.05.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 05:46:14 -0700 (PDT)
Date:   Thu, 20 Oct 2022 08:46:12 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     =?utf-8?B?TWF0xJtq?= Cepl <mcepl@cepl.eu>
Cc:     git@vger.kernel.org
Subject: Re: git-send-email with GPG signed commits?
Message-ID: <20221020124612.xivhb4xk52yvy5nk@meerkat.local>
References: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4eb8707f-4686-e304-2aab-a6afee11abc9@cepl.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 06:26:49AM +0200, Matěj Cepl wrote:
> Hello,
> 
> did anybody even think about %subj%? Is there some effort somewhere making
> git-send-email(1) supporting transfer of signed commits, where I could join?
> I like hosting sites like sr.ht, which support git-send-email(1), but
> unfortunately using that clears my submission off its GPG signatures. I
> guess, it would be necessary to make some modifications to git-send-email(1)
> and git-am(1). Is there some effort somewhere in that direction?

Linux Kernel supports end-to-end attested patches (including using PGP), but
the implementation took a slightly different direction, because there are
important downsides to PGP-signed messages when it comes to patch workflows.

See the following project:
https://pypi.org/project/patatt/

There is a section on that page that describes why PGP-signed patches aren't
the preferred way to go for many people.

Best regards,
Konstantin
