Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A054AC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 19:21:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiDFTXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 15:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbiDFTXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 15:23:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1181D4685
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 11:18:37 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id d7so3620447edn.11
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 11:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=upGTl6rRWICtnSVFmYx9BtDY2Pjcw+sqnk6pCUmr0Vk=;
        b=T79GlM1ap0NObjsicjVRpyWDiqYOKcUQqpZp7F2mvNgxjR9Wl4Ntp8plM/lZgt8FV/
         5nwU/nLL4ZI6Wn9X0egtLaUfP0WZOuvWzYHVMdosgdxqFuCXN9ULfMrSirDL8UHDqKnw
         pxMbQp6gvCmd3+9vppYUxgQ82OMaww1CJsswVBSaa7P2wu++y+8+PV0GbbzR0oZNi9t7
         PPrsPHyaIQYJ0kN16Tc+R/0JMKtjrdhpFXNW0l0fkNhNCKBa7274xtFCSwYhTlyDB0dA
         JK5Q6d3WJ1H8jo7iLHvpPTFg6uHdeq1rZXwvLU7DrTbwnaCpXTpFYosWGbj2mQDgPwDx
         AD3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=upGTl6rRWICtnSVFmYx9BtDY2Pjcw+sqnk6pCUmr0Vk=;
        b=0YRelI9kmoLy5GdTrI3FFjQsso6JC0ort4VRbxHxgD49SCs6mgQ4UY1t3wnuCt/PHn
         Q3SLdA/iDtEp8Xm9sE1xVK2bOv295SUw9kFdl4ZNnVJQnnr8vqKDBH1CWkIICjhO60qH
         uni50fyetLG/00ZGr7YkLWtQQPg9wP+zTfXqjWpSxB1ASvxWXWh8eVcct1K2+l6ASSLT
         KU5R1xGvb09gEPlFGnWcqlMf0SuD0ovyoVC7U3IFA/QpxrPrXXqselTEjvB7J4NPNRZw
         3ah/DGFGBH3PpruHKobXIScQMOC1YtlOS9hDYyMyACHs8rLKdJwas2E6T66ucaFHtuzE
         lcqw==
X-Gm-Message-State: AOAM531hUPrKgJjcn/5MKEX5E0wErDh9cDrUjnIJR1D+7D0lzBownSTf
        w4K0ZaB1QKfAeEQxlw9SA5LpeUZeMlY8No53h4gTeQ==
X-Google-Smtp-Source: ABdhPJxnogRERmEC9Zz5+U9ZhC/OzJgIeIv6E5w7OrYK+GxkBQJUNdQTUvFfFHZ3q0bg9rx3Od1STzNWEHr4goukrA8=
X-Received: by 2002:aa7:cad3:0:b0:410:b188:a49a with SMTP id
 l19-20020aa7cad3000000b00410b188a49amr10117903edt.416.1649269115583; Wed, 06
 Apr 2022 11:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220405053559.1072115-1-alexhenrie24@gmail.com> <20220406180434.4zlb2bwpu6cfumta@tb-raspi4>
In-Reply-To: <20220406180434.4zlb2bwpu6cfumta@tb-raspi4>
From:   Tao Klerks <tao@klerks.biz>
Date:   Wed, 6 Apr 2022 20:18:24 +0200
Message-ID: <CAPMMpohYRTSaTcRVTJ6y=Q7+FSOcSNjHjwDvUMhVv4JO7QDB_g@mail.gmail.com>
Subject: Re: [PATCH v2] convert: clarify line ending conversion warning
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 6, 2022 at 8:04 PM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:

> May be we can use "updates" instead of "touches" ?
>
> "In '%s', CRLF will be replaced by LF the next time Git updates it"

Makes sense to me.

>
> Or may be
>
> "In '%s', CRLF will be replaced by LF the next time a `git checkout` upda=
tes it"
>

I believe we should stay away from the word "checkout" because it's
neither accurate nor clear, for at least a couple of reasons:
1. We have long, in principle, been promoting the use of "git switch",
and it's not obvious in a message like this one that this is
considered to be equivalent.
2. Files can be touched/updated by other commands/processes, like "git
pull" (and "rebase", and probably others I can't think of)
