Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B31E1F42D
	for <e@80x24.org>; Thu, 24 May 2018 20:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935797AbeEXUPf (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 16:15:35 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43637 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935330AbeEXUPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 16:15:34 -0400
Received: by mail-qt0-f194.google.com with SMTP id f13-v6so3749959qtp.10
        for <git@vger.kernel.org>; Thu, 24 May 2018 13:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=DSREyTm4cayaTiHJPkzEik3dx9D3nZKh+LpIxJFUsSM=;
        b=WgoTCBfWIz1GvwpO2LM+dlMVfWiywRhkTERdas0V9j7yh9+df3gruElj11AP+jRicp
         KkDmRG7TfUbYZL1exeuAMoq4CS4C5giP5ROPe2ACMfYRZQy2ndr24BO8/VbdnHGZLi9f
         k2VEzKFhcn89+EVyPtRtZE3u1ouH/PFM9MvbNaCQPOB/AVHdIJ/+lKCRZeCXA5jIVVD+
         22rSYADT2+a8V4k13vPWc4NSfJ+KyXS+BM3CIcW2h3AWb70Ze23nCHaGCHiDGDSgQQx4
         XoSD87EttDyvlFBITFrL0U1BvxFu44nu0Dtc4y6sN9ahp1IQdOINTVPGUKPD4w9C/4YU
         gGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=DSREyTm4cayaTiHJPkzEik3dx9D3nZKh+LpIxJFUsSM=;
        b=JuIpgH5CAkM+2lBBVbpSqwHP/dSXeEzy3CjkU0IQ7IGrDAzwcjUfg/QUrD+M6k8B+W
         QF/bIojfb/+1gy1wzDLSkVVzD/jfBeAaH1TBYI4g5CXjoiuxv1nTYpREpJB16Q/k5v90
         Ax2yU/xQMBZc4AXwpQ4fxdUSnnSwgCcQ1E1jjsFFdY99GijlrIuwXS4aT7fp/FC24yfC
         afvLE6qmaKWUXRp3MePiAr9RzlbcY5Oig8p4UV4uZom1FDVXZTvEw24jIaUacUI5r5LQ
         UXr1QQSjSrcrsvTlwOUinOdY82t5fdYmvHecSyjwCIdsrG3k3zTWUl5+OD9Zxeom1tzj
         5Gag==
X-Gm-Message-State: ALKqPwcFKNqVvqO4D7n84bH/YXaBMCcj+vz9+/YOk4yMLOwC3ntRa5UQ
        3bbmVrbw7UdvYBLu+oaJr0Q6q76SuXQamjPmKhY=
X-Google-Smtp-Source: ADUXVKIYehsAmxhKWD1xdT3Cb3S4oK5x+wQeT7itKQnBm/T8R3oVn5Py8a3Wb031aGrT3iwuXTA2mqew9k33wF3kGjo=
X-Received: by 2002:aed:26a4:: with SMTP id q33-v6mr8335511qtd.165.1527192934214;
 Thu, 24 May 2018 13:15:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:aa4b:0:0:0:0:0 with HTTP; Thu, 24 May 2018 13:15:33
 -0700 (PDT)
In-Reply-To: <20180524193516.28713-4-avarab@gmail.com>
References: <20180524190214.GA21354@sigill.intra.peff.net> <20180524193516.28713-1-avarab@gmail.com>
 <20180524193516.28713-4-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 24 May 2018 16:15:33 -0400
X-Google-Sender-Auth: qxXJ0RU6Qaop14qrXMqw3vLGqt0
Message-ID: <CAPig+cSd32O3ELaHxLD0_yRFmjMAo2k-jApopJmuEt7Z6W40-g@mail.gmail.com>
Subject: Re: [PATCH 3/4] config doc: elaborate on what transfer.fsckObjects does
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 3:35 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> The existing documentation led the user to believe that all we were
> doing were basic readability sanity checks, but that hasn't been true
> for a very long time. Update the description to match reality, and
> note the caveat that there's a quarantine for accepting pushes, but
> not for fetching.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> @@ -3339,9 +3339,19 @@ transfer.fsckObjects::
> -When set, the fetch or receive will abort in the case of a malformed
> -object or a broken link. The result of an abort are only dangling
> -objects.
> +When set, the fetch receive will abort in the case of a malformed

"fetch receive"? Did you mean "fetch or receive" (like the original)?

> +object or a link to a nonexisting object. In addition, various other

s/nonexisting/nonexistent/

> +issues are checked for, including legacy issues (see `fsck.<msg-id>`),
> +and potential security issues like there being a `.GIT` directory (see

s/there being/existence of/

> +the release notes for v2.2.1 for details). Other sanity and security
> +checks may be added in future releases.
> ++
> +On the receiving side failing fsckObjects will make those objects

s/side/&,/

> +unreachable, see "QUARANTINE ENVIRONMENT" in
> +linkgit:git-receive-pack[1]. On the fetch side the malformed objects

s/side/&,/

> +will instead be left unreferenced in the repository. That's considered
> +a bug, and hopefully future git release will implement a quarantine
> +for the "fetch" side as well.

If this was a "BUGS" section in a man-page, the above might be less
scary. In this context, however, I wonder if it makes sense to tone it
down a bit:

    On the fetch side, malformed objects will instead be left
    unreferenced in the repository. (However, in the future, such
    objects may be quarantined for "fetch", as well.)
