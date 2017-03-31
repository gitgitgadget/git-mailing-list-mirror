Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE3961FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933287AbdCaRHN (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:07:13 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36460 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933217AbdCaRHM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:07:12 -0400
Received: by mail-pg0-f52.google.com with SMTP id g2so75700667pge.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2017 10:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EAcaIZNq9EleHpIztPmSx0HAYAYmEcIrBn7AsFW0f2s=;
        b=ey60OGfpV+12Yw7Pgd5HRfG1PytcOo/IVLfVLh4y4DLKEzwG6iOIi1wh34vCVWrqlZ
         bupCftA6B6wYlz7FKt843EG+cymlbx8u8gCnbltCCSaTYZasRIBV9fJ/KhSzT8XZ3fpd
         P7y+piida2HWRw9l5lePdnFsojr/f2LFc3lvHtQYFmDiI1gTQi/wmr4mWqJG+5yFhYJW
         gK8ZsTAPbZY6dpG2iX2uvxT/UlqhCRg8skUEmOojxpP1c5wp0zyCb25RCFp5QZxM+Oc5
         9kVRkDBDPLnGENj3g57MReKk2TSONRRjvruQAsXkGI4i433MoO7D4zT0ToBKUW8zrmmG
         EJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EAcaIZNq9EleHpIztPmSx0HAYAYmEcIrBn7AsFW0f2s=;
        b=EEJk+oJmtgAGm8cY6RLPP3spfr9v0yton4tDm0GZnCOt5FUX4SNmDnGq7ERhKUux8i
         tEFypxPtV0YKNQpfx8HBmvVS2jHN//ZOCvtYJaG9jnXtGinyJPyij7wxuSx1KSNNXNIh
         K2TZ5534SBlBxtGuvY0rRwbqVaORuTu6h9p2I5l6oyK+EWemfcB/fyt4gSF/QMc9ecdG
         ZmRC/spU996FJxk1dIfXNPczFDS/e/ZnRuykD8pXEzGezZCm9kaABlmOQToshnNCl2OI
         B2wLhyNKhNmMxMrxNIIasTwtgQoe66ztndAiKjXywZsQEP23C95GWY4YaNTu0EzR2Kef
         ItPA==
X-Gm-Message-State: AFeK/H0nmQ2Ei1ibmXz/7FuTOQRmK4Xyb4W/W2EB/VNYyL19avJHLzLOf6PQcfYbyVFMv8CLLJiCYuY8aMvAl6RJ
X-Received: by 10.84.232.131 with SMTP id i3mr4565026plk.172.1490980030578;
 Fri, 31 Mar 2017 10:07:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Fri, 31 Mar 2017 10:07:09 -0700 (PDT)
In-Reply-To: <CAPd5SoV1F7MMDSRGzrd-7soty=61vnumQ02UtBJs2fwEyv+V3Q@mail.gmail.com>
References: <CAPd5SoV1F7MMDSRGzrd-7soty=61vnumQ02UtBJs2fwEyv+V3Q@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 31 Mar 2017 10:07:09 -0700
Message-ID: <CAGZ79kapamr4=C_JQ4Ud2bF6NoXn8qeQR1fYScWB4+-EzEckmQ@mail.gmail.com>
Subject: Re: git diff --submodule=diff fails with submodules in a submodule
To:     David Parrish <daveparrish@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc Jacob, who implemented --submodule=diff

On Fri, Mar 31, 2017 at 8:40 AM, David Parrish <daveparrish@gmail.com> wrote:
> When I try to run `git diff --submodule=diff` in a submodule which has
> it's own submodules that have changes I get the error: fatal: bad
> object

Thanks for the bug report!

> Let me know if you need an example reproduce the issue.

I could reproduce it when playing around locally with a submodule in
submodules. I think sub-submodule needs to have its HEAD moved from
the recorded commit.

Thanks,
Stefan
