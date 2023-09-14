Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C24EEAA7A
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 22:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjINWdd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 18:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjINWdc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 18:33:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004692100
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:33:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b52554914so20146447b3.0
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 15:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694730807; x=1695335607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQrYRHCEFM5XRYa0ZEIHQ8Rp0MX/YkWEuHUYHD3hmK4=;
        b=uAdgZHvz93uRhcA5UVkoPpokp5NdZnepifTO0eLYseSUrIJmXX79eNT0NCqHXpeAeq
         QugjtYY44Zor96AaFoowS4rQSUoezm+wdz4pGD54ssZ9Yp8Z9XHyOmM66yzXMzAtTU3p
         6rewLZo28ZlljzFNfhBbB+FYylfh0j9UHYHbrNLC48UIHxNEXIcmWnEgHqtxIaCpkvWu
         tcVWygtI9Qc1+Iz13BvKEaAR7Q3ih1/8mlYAqBs+UcYkn/wnfWsaoSZPJ5HqxXAtLCEf
         P3cXdF773bNFR2fP53WQiX6/umXZQKy206IPqN28pvQ8tEKHPza0SskLFBXrhhQhEYnS
         bDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730807; x=1695335607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQrYRHCEFM5XRYa0ZEIHQ8Rp0MX/YkWEuHUYHD3hmK4=;
        b=QNDLurrcCfwr8/qsvw8puJDkSlLs0Q/b15yIHjzqu69mMT91HEG8WJlB2TVGjL+xM/
         dHZCQQK0yszQPudW5I/vw548K4qbjupgBhfdtLI2qZyxZ2SotUMSKxNq5ff5rXeA0TTB
         gKKmAShmxNjW4yvpo+CZZMItXn0fb9WmoRea1sDnoNZRMr+lHdoXsrhntEPPXgd1C3Su
         uJmcV36wTSgWGUhn2+rZKAg/BxZAGH1D0bbN2Ub6IOMEw6f07cohUkw/p7I5rAPw/wlO
         vSAOCmCF3kyXrRv8dPj/bebGGQat67j+6jxviIbMCLqJc45PMAwCa7G9Wy2Y+0gdAw79
         l7iw==
X-Gm-Message-State: AOJu0Yw1VJpm8zIAvqv23VnBJUG14Mdd7x+xZTVnfTAcSiE5MHHNde7r
        /zRMPKtaiNdON4xaTas+UlViNtvkFYU=
X-Google-Smtp-Source: AGHT+IFktJ4B1hqAx2JPSaLdTe31281JhcwusLEuKNWKQsYOhcOVLHmV+T/DtkeQUKafeXrB4HpkL690IlQ=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:ad0d:0:b0:59b:e97e:f7d7 with SMTP id
 l13-20020a81ad0d000000b0059be97ef7d7mr1390ywh.1.1694730807232; Thu, 14 Sep
 2023 15:33:27 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:33:25 -0700
In-Reply-To: <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1585.git.1694274592854.gitgitgadget@gmail.com> <pull.1585.v2.git.1694538135853.gitgitgadget@gmail.com>
Message-ID: <owlymsxojsga.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v2] completion: improve doc for complex aliases
From:   Linus Arver <linusa@google.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Steffen Prohaska <prohaska@zib.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> The completion code can be told to use a particular completion for
> aliases that shell out by using ': git <cmd> ;' as the first command of
> the alias. This only works if <cmd> and the semicolon are separated by a
> space, since if the space is missing __git_aliased_command returns (for
> example) 'checkout;' instead of just 'checkout', and then
> __git_complete_command fails to find a completion for 'checkout;'.
>
> The examples have that space but it's not clear if it's just for
> style or if it's mandatory. Explicitly mention it.
>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     completion: improve doc for complex aliases
>     
>     Changes since v1:
>     
>      * fixed the typo pointed out by Eric
>      * added an explanation of why the space is mandatory, as suggested by
>        Linus
>

Thanks for the investigation. The commit message reads much better now.

This LGTM, but I think Junio's review comments [1] are worth
considering. I'll respond there also.

[1] https://lore.kernel.org/git/xmqqo7i6khxv.fsf@gitster.g/#t 
