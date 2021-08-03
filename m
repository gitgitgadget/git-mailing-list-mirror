Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8AFC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 14:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6A1E60F58
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 14:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236643AbhHCOje (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbhHCOjd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Aug 2021 10:39:33 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2381DC061757
        for <git@vger.kernel.org>; Tue,  3 Aug 2021 07:39:22 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso8959636otq.6
        for <git@vger.kernel.org>; Tue, 03 Aug 2021 07:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOBTBOsJA6t3AaGYQXbDoW+3odLisxjDAwO+dPrNK9s=;
        b=TB6f6AOBwWXvn6f5NpyFmPEUefW7MfYcinizy8GvIlEbG3ojS7MskKflabmy74oj6T
         0BalmRoEU+2ej4eXdlb+5vWoLYAGMGGWphXDS5V67X9meEMlqSNp35iA1M148lHSl048
         9AF3utwEt0kenmAb+OmXgbPa2QBbdujt5wbcX7T7MjW3z/LAedViHazcG28zgn14QKtF
         z8u/tLOm/vEM3+YXSawEz2JePztT0OBCL244ZYKbZwu1ww3YxFWWo5cj3Hj2d1XvGGIz
         BfcLQYmJWuDdgsf9O+DkQc6MS93qZ87xl7QdldcsH6PmrVtoTQoikGCMD7DV2jNvBM5F
         pUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOBTBOsJA6t3AaGYQXbDoW+3odLisxjDAwO+dPrNK9s=;
        b=OaQ8EdzuKed4ZPpi0PlkyaEpUuauFeJnv9JhhQvOgjLZghSPncCQeiJygyo7DX08xZ
         +wkwvlVjriVEk/4gPbL75eswEoIVBZwwnI+oDKOxlRiTjYe79+5XeoT6OYKnab4H18Ud
         WqJMiQWnQ21SFcfqNlBVL1Fe3lEi4s1zWUVRPbZhL/ZKXbWnGIs+u0wDS8iBFgwHnHfF
         6SQglWWOxqiyJg6tWyt+psot5ONZGY7fI9b8H17aMMoU2U6REdgSHLeeZphxqDGeJ4mK
         YKtozwzxrVFo9ZOfMlZvIjXLXUpQPEFPIYz4m9L5NpkcXgswvmamxh47iA+pfc/U/P4S
         FP2Q==
X-Gm-Message-State: AOAM533NQyGNC6eWMFuQsEiOLyHhbnc29+pFeHQuntMPlidoyT8W84ks
        cyswJtWGgqWY4VMcjPyDPxs7UGqpX/Np2qITDWw=
X-Google-Smtp-Source: ABdhPJxetpastF3ly04TL4LQQOJCta2SdMJT5btTcZ3rjbz+Vzao92SVLZN/JassiO0pT0PP6yzDOwWtS06jxx/Hhhw=
X-Received: by 2002:a05:6830:78c:: with SMTP id w12mr15240775ots.162.1628001561446;
 Tue, 03 Aug 2021 07:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com> <35490397590ae4d39ba98c7eb206bfadc22ddf35.1627776462.git.gitgitgadget@gmail.com>
In-Reply-To: <35490397590ae4d39ba98c7eb206bfadc22ddf35.1627776462.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 3 Aug 2021 08:39:10 -0600
Message-ID: <CABPp-BGmnOUy3d2Ey5Pxr+3x-icBDkd7ZHWG52OymJKGuOw7ZQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Update docs for change of default merge backend
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 31, 2021 at 6:07 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> Make multiple documentation updates to bring things up to date as we
> change the default merge backend...

Some of these changes are specific to the change in default backend,
but many of them are probably useful updates prior to such a switch.
I'm going to break those out into several small patches and submit
them separately so they can be included in Git v2.33.0 if wanted.
I'll then take the remaining changes and resubmit them after 2.33.0
along with the switch of default.
