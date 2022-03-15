Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F93C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349939AbiCOQNF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 12:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350000AbiCOQND (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 12:13:03 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C4A9FFB
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 09:11:50 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h11so27193507ljb.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e1QqV42bZ/CzWkzjgP6lTqDHx3emid/nuUh4sTwLltg=;
        b=MM4Nhhe77hCnPaoPkyNwvNa59jBQ49oWg1qM5XHthuUWvmrz/ULeDtZUypN+9bLnHs
         9DzsY4P5uSBLgWaBIBNtrY5SYh2bKKLIZo3XiMcDv3CbsPjwLAp13JwNiTPs0C8NBBCX
         CJbCeRvyYTptElPtOadV2ccCBfAleSPvCM6wwClpQY/l9D6Pxg9dWwtsQfJ9F5/HVWER
         UKMqY6CEIUZHXfwvPpPdd+bQBC0KZB7zPGiKXHLTuNYXyUQlY+gj1IhwypkKFlUfpays
         2NCfKmL+m+q7FrBm3doloYNiO1hTyjmfVisGXsPNnGzvvzLVWJixNT3OkplqaVwzyGWj
         Qf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e1QqV42bZ/CzWkzjgP6lTqDHx3emid/nuUh4sTwLltg=;
        b=cnIcKYFEXN03e/qkOyiLvm6uR1FDPGYqZdlarHFjS/4MPj6Lz9gC66S/NyrRiLGYXp
         A4y5PDt2n22xcHtZIwClg5D/rv9fGjrWneAGLCMHJifu6s3jDQw6iZzho9Y8zdjqa2AG
         2i7SBtOerLpGAxwYqv2zzZfavMe6L9xLlyjn23RHcsHvPAvrt9D+YIpUJeES/FaxIOs0
         NFI+4EcDGPt5oBSVYeVtco4NLtOTxVbxsnclCSo6l+l5Z+dsUeRqGfauxby57w/ORDvT
         WlGFUaRmWA10SK8sbG2ruAagCmsWqSea3Dgf8W8LgRTTLeBonkS+K2SVovMR2O24oKTq
         6DJA==
X-Gm-Message-State: AOAM5336rjXgb6f9ucUOkASA/AM3Td5XuNvd/tr14+I7c5wgCU+Z4496
        y3UA+ERNo+XIzcNkXs4r0kiNdFk1zaaiNxbubs36e7AJVkM4xmLP
X-Google-Smtp-Source: ABdhPJwqCBqyhHT/vRY+dFLhSaoWqdnjboUpLgy8ZDfJ3+7IH6SozCc0DBy3Rjaffn4z61Ixwb6gpVjKgYXiIr359Uo=
X-Received: by 2002:a2e:b5b9:0:b0:246:b30:64c8 with SMTP id
 f25-20020a2eb5b9000000b002460b3064c8mr17253912ljn.17.1647360707765; Tue, 15
 Mar 2022 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220313105031.1081110-1-gaurijove@gmail.com> <CAP8UFD0GeGr3ARkYycHNYU0r5vTC-PDdbLYrkYSohbtWBt9HSQ@mail.gmail.com>
In-Reply-To: <CAP8UFD0GeGr3ARkYycHNYU0r5vTC-PDdbLYrkYSohbtWBt9HSQ@mail.gmail.com>
From:   Jayati Shrivastava <gaurijove@gmail.com>
Date:   Tue, 15 Mar 2022 21:41:36 +0530
Message-ID: <CANsrJQd-E9JcFD0jtK=kMexm0Oc4Vc2HSXJ7nM2u3g4cN0zstA@mail.gmail.com>
Subject: Re: [GSOC] [PATCH 1/1] t7403: Use helper function 'test_path_is_dir'
 to check if the path is a directory
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

Thanks for reviewing.

>On Tue, Mar 15, 2022 at 2:20 PM Christian Couder <christian.couder@gmail.c=
om> wrote:

> Thanks for this patch! I am curious what tool you used to prepare and
> send it.This is not a big deal but when there is only one patch I
> think [PATCH] is preferred over [PATCH 1/1]. Also I think the 'From:
> JAYATI...' line is not n=C3=A9cessary if you are sending the patch using
> the same email address as what's in the 'From: JAYATI...' line.

I am using git format-patch and send-email but had previously made
some unnecessary modifications in the editor which I have now done
away with.

> It's nice to say why it's better to use functions like
> test_path_is_dir() rather than `test -d`. Also it looks like the last
> line could be formatted to be around the same length as previous
> lines, instead of being significantly longer.
> The sentence should end with a full stop.
>
> > Signed-off-by: JAYATI SHRIVASTAVA <gaurijove@gmail.com>
>
> It's also not a big deal, but, unless it's really a personal
> preference, you might not want to use only uppercase letters for your
> name, as it's not usual here.

I have modified the commit message as per your reviews. However,
I am not sure why my patches are still not showing up on the mailing
list despite passing the --to/--cc/--in-reply-to options correctly to
git send-email. What do you think might be the reason?
