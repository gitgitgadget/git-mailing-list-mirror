Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7E0C761AF
	for <git@archiver.kernel.org>; Thu, 30 Mar 2023 08:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjC3IP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Mar 2023 04:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjC3IPY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2023 04:15:24 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6739640C9
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 01:15:20 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id k17so22455067ybm.11
        for <git@vger.kernel.org>; Thu, 30 Mar 2023 01:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680164119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gVVj6zu55/dhMkp9OERjbj83mFLAhouCfBLBm4uw0zk=;
        b=JSEJ/xv3DYWxszd1N9nfSsoc4ojL7BQqbZDajhSNyBWv63FTw1en4YuqSYqpS8i7il
         DnVP0ncGnxXp59U00ZfmeWR4N58x7CRlkYC4/ESEBs8frN2BRREVT04guF8mi74MEeej
         L76Hcmw6NKVBkO5VTJ0KDySBakWltrXEeNhShxwL2l8JOTXgNKdsRl6WkA+m3sy77bAV
         +5NVJ/FxvGEsV3aW9w9eTByU2AJgoHo5fuuu/xCx1OTjQiPpVLC6e3SxQcXmKoQ4A15i
         qLkyfcsuXq7gfdUawM2ngC6GIBQNX2Oz24EQOtBNN0Xw2iQMLcVYUiD+QVi7yBKFqI4r
         +k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680164119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gVVj6zu55/dhMkp9OERjbj83mFLAhouCfBLBm4uw0zk=;
        b=JzATEsBExwvHg2ug+jdJzprF3lLeg9nQdEFT8nTdOlrVM1X5FwRtrF/nJ3obGTvxO/
         f0dRQ0DPXHQxEivOr9+swXqxT8NqTuBAy77HVZg2JfuTu3JWkD+Gmbo5dcjJVNl+LjR6
         99aCtJGAmDy62MCzVuE0KkgAt8c1bhUckmIlLPN5yqRjfEArnHlj+1Zs9/vQ8N9Qicyw
         CfJbteb/CeFQiP4BHcF1t+YrRTwzleRE+iYqpQWcaLxI1bnhCNM16JDfa3QAOklIJ5xJ
         yhXUxGDuE+hWIzl+HBCNwed6LtPcaZFY8kV+IIyPqRQ4i/wMRO35GOI4ssV4mGXU7R/K
         /nWw==
X-Gm-Message-State: AAQBX9dxZC3N+SAe+RZdmesP3wXtsOyuc1wW6H1NWINyXbfpHk3Xqhc4
        t090XRQJoaqXFJuTKbfCwHOGs1P9NJtn7rR1I7H+0rDLghQ=
X-Google-Smtp-Source: AKy350a2dI+xI917kCT4O7oKs5Qclqt58w+QQbPImwlWbSClDibBIEvNhSDkVYFwaW4i+RYtpKicmhpSda61wl0Vn5g=
X-Received: by 2002:a05:6902:1083:b0:b69:ca6f:452c with SMTP id
 v3-20020a056902108300b00b69ca6f452cmr14955445ybu.0.1680164119243; Thu, 30 Mar
 2023 01:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230328173932.3614601-1-felipe.contreras@gmail.com> <20230328173932.3614601-6-felipe.contreras@gmail.com>
In-Reply-To: <20230328173932.3614601-6-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Thu, 30 Mar 2023 02:15:08 -0600
Message-ID: <CAMP44s3m=gYhtH+h-Gsy9F+YNPsA5MXB5wuvLDEO+svA=FhATA@mail.gmail.com>
Subject: Re: [PATCH 5/6] test: hack for zsh
To:     git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 28, 2023 at 11:39=E2=80=AFAM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> See: https://www.zsh.org/mla/workers/2023/msg00336.html

In case anyone is interested this has just been fixed:

https://github.com/zsh-users/zsh/commit/12e5db145b098a62ff11b88eea26f473ea2=
ecdcf

--=20
Felipe Contreras
