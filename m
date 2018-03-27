Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26CE71F404
	for <e@80x24.org>; Tue, 27 Mar 2018 23:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752234AbeC0XxY (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 19:53:24 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:32812 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeC0XxX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 19:53:23 -0400
Received: by mail-yb0-f194.google.com with SMTP id b4-v6so215677ybi.0
        for <git@vger.kernel.org>; Tue, 27 Mar 2018 16:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=eXrH0xJmOxs+a3+0W7Yfi1mnkeBp5i2s2hz0T2w3gpo=;
        b=Bn++JVfftAGL3e78VAKozAcn7OSj7Smrdm/4sJG+BOcWKpxGEfkUjMDQ67k+U+uwGw
         GfhV68t7Xy4yn3aGxUKJXFpvIsBd1e4ZNUfRHElOvaYc35PBXwtXNZZ3CIN5uUk5oQQ0
         TGeE7rPq4ZVhNTiEkC1NLyhhJGF76b33LQrOeRwXFKe+qGq/deyNtcgLY0DFClQGs4ot
         HNBfMHPtFxQvkpqzYAf47VEQYYaj2NSUsMKy7frdVTH+nWXVwBQZbyp7bZh2iQu9jvzL
         zWaDok6+eGbRSn8bZFA6CwsrXdpA1EkE9UEhitHVJ3g5Y01wwPeEW2aPUZqag32q++ya
         11kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=eXrH0xJmOxs+a3+0W7Yfi1mnkeBp5i2s2hz0T2w3gpo=;
        b=GiaXJo5mPTTk0B+DiI4VOjwsqqdVVTntWuazll+R76h6GPBWdx8n96mPrVGahjoLJK
         EOhca67GACP6SRoZkykEUUWXVhDagzpF7eYz2UJiVZKYENx3o5wEAH9VAneASxFNN/tm
         LJf3CMVx/xcSr931mLHE5GYudO11h3sgdvHaRl4YGkRFOudT4DELjbbMxlkDYFD0g+tO
         hD5QaC4236AtgTrwlzx5di7ih1E9gvXokmjqGYEBOzGiIjyC0wdUG95vT58Jw6lmK6T7
         edPIgUgsXRdMFpKeJvd0i80M46polk/8JFKO9Pvt6fzE+rO+EGK1ZfZJR5yWvxXYkfSO
         H+Bg==
X-Gm-Message-State: AElRT7EFPAdUwAyMgzwV21A+ln0FlLAHPOgGzpnALjywYOhW3m8WCtKS
        2A7pfr8q2xlaQZe3JQJ7Ifxx/0ht29dlA/ecU/Tz4w==
X-Google-Smtp-Source: AIpwx49dnwaZkeETIgg6BkDfZtppLNzGYrgE7YP0b8WI8OPc1o+ynpEfoRHdZdhsV90VSX0Gr+G+7rInvH43TH0YynU=
X-Received: by 2002:a25:5605:: with SMTP id k5-v6mr940480ybb.292.1522194802541;
 Tue, 27 Mar 2018 16:53:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf81:0:0:0:0:0 with HTTP; Tue, 27 Mar 2018 16:53:22
 -0700 (PDT)
In-Reply-To: <20180327160443.5034f7db908c08fe3c301ab9@google.com>
References: <20180327213918.77851-1-sbeller@google.com> <20180327213918.77851-4-sbeller@google.com>
 <20180327160443.5034f7db908c08fe3c301ab9@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Mar 2018 16:53:22 -0700
Message-ID: <CAGZ79kbisNdO_9A_sH0w+FU5q6mhtgynd6BuY8UoWaC-X6twbg@mail.gmail.com>
Subject: Re: [PATCH 3/5] submodule-config: add repository argument to
 submodule_from_{name, path}
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, seanwbehan@riseup.net,
        Brandon Williams <bmwill@google.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 27, 2018 at 4:04 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> On Tue, 27 Mar 2018 14:39:16 -0700
> Stefan Beller <sbeller@google.com> wrote:
>
>> -extern const struct submodule *submodule_from_name(
>> +extern const struct submodule *submodule_from_name(struct repository *r,
>>               const struct object_id *commit_or_tree, const char *name);
>> -extern const struct submodule *submodule_from_path(
>> +extern const struct submodule *submodule_from_path(struct repository *r,
>>               const struct object_id *commit_or_tree, const char *path);
>
> There is a recent change to CodingGuidelines that states to not include
> "extern" in 89a9f2c862 ("CodingGuidelines: mention "static" and
> "extern"", 2018-02-08), so consider removing "extern" since you're
> already changing this file.

Gah!

I have that fixed locally; it will be included in the next version

>
> Other than that,
>
> Reviewed-by: Jonathan Tan <jonathantanmy@google.com>

Thanks!
