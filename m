Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E59C4332F
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 17:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242412AbiAFRtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 12:49:24 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:41542 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242286AbiAFRtW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 12:49:22 -0500
Received: by mail-pj1-f41.google.com with SMTP id b1-20020a17090a990100b001b14bd47532so3981251pjp.0
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 09:49:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lrb9yxl3/2s3heMUSJ8PDVegjr7O2BRdDEEptglY02A=;
        b=2H1zNERTnmEnrrQuLixJuyg06yQe5imOoydb7VTwM4Kyw4QivPJ+LUQjDE0fBFkd4S
         7pxI8Q87JZPjpX/x72MnM7bdZSaeTIe3GhEU2hEAtlUmezi9b7tpqgwUB/pJWlnDQL7x
         Klj2fSmseGyzcBGb05NE1pMzCazYnMkdBSo+FKPsgp88/o/odDj0ag5v/MNNZ/nlEL2n
         cEg1KaeV7OfzwxjASt1xPgRLv61GPsaFiRA1GOajnTQBB4ecPhEYqQbUfBbx77EOzYqL
         PP12Wunqxj209++URy/BSBWJKj9z2LlussAVSmPsd2Gk8pBGuIuWu5hJnfHB8XXxAs56
         xa9w==
X-Gm-Message-State: AOAM533mGipLw/KytpDvbmR/n+b7BHROh54fUHAcxFt4Srsfx9+aLHOV
        haKbJNPqXBdLMDgcFgJxGcBVE2lZQWzUiuLW4Jc=
X-Google-Smtp-Source: ABdhPJyEvtSMgOHdWKxfwRLC54RHP9VkTvPZdcTvQOl1xE5G9yLp5qa4zW8PXnyCT2THAE7nWWJGN1qjCl0qX4WFQWc=
X-Received: by 2002:a17:902:b688:b0:149:a1d6:c731 with SMTP id
 c8-20020a170902b68800b00149a1d6c731mr33981467pls.145.1641491361526; Thu, 06
 Jan 2022 09:49:21 -0800 (PST)
MIME-Version: 1.0
References: <20220105141427.48861-1-jholdsworth@nvidia.com>
In-Reply-To: <20220105141427.48861-1-jholdsworth@nvidia.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 6 Jan 2022 12:49:10 -0500
Message-ID: <CAPig+cSe8i9VxhJifFui0Or22fXMbD_vgy-cdRgYcA20WkGhTg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: fixed instantiation of CalledProcessError
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 6, 2022 at 1:56 AM Joel Holdsworth <jholdsworth@nvidia.com> wrote:
> CalledProcessError is an exception class from the subprocess namespace.
> When raising this exception, git-p4 would instantiate CalledProcessError
> objects without properly referencing the subprocess namespace causing
> the script to fail.
>
> This patch resolves the issue by replacing CalledProcessError with
> subprocess.CalledProcessError.
> ---

MIssing sign-off.
