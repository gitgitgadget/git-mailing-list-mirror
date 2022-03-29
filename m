Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0896C433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 17:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbiC2RQo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236314AbiC2RQm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 13:16:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6785BD37
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:14:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p15so31443837lfk.8
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 10:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRdhPj1GW4CtV0bqLZVKkXI3Nih3WmzzykttfY1Wt2Y=;
        b=VBYEstyp2HTw6Ueo3F76pIqTLdwrq062Eo+kV6hysfQc7adJ2drkxd6bb2aKtdzkX5
         1mIoUUZYEoIUfKijWVvXvDFFCaDx5RZRkdQDjstceEdcwirQA5TLc6dBC2gdW0C5M+ol
         L9dw9z5B6K0cZ9JOwi1ZZLsma2oH0vsGU2MrphoSE7iV+31/g+7gP1soSLgGxMAfrTFF
         IpmP6PeD4WLM3MebeAmIR6xPT5CYBDKu+jsriaKZjj/psR8Rj2IXpmf45J/QqX3dG5Vl
         Rx0H45D6d/f5mIgaKxu48TO8R12+qP0ZaTr3i+vEgwojVlKc91ulUXN9GinZ7wSl1wkN
         P1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRdhPj1GW4CtV0bqLZVKkXI3Nih3WmzzykttfY1Wt2Y=;
        b=kTTwqe+ZElEDmt3NfEQIkgKbv3F9jZ76oposqHn8d+yVlyKyKmvvop8kXhsrNVVqU0
         YSjxNP8HurfuFEHIqNaXrihqDfezh8e8OwpXxJzdEMs9JZbeLUDOx30lAU7Ku10itSkX
         7AbzSFDzTDc0S4BEJgLFh174Zatz3PyRT3q6Wtdw26inEP3fnI7s+fDYWktjSSUnuRj7
         brQt/WDatmKR+BJaZCn/2zbhpqc0yPD3taOw6j+g9krxQ64E/OGqtG9dO2nIkF+Ru/zs
         rDBVAXuyqBwIoxnGgOl8cB4mzKRaohoAYqnAR19j5qvFbmIO1aGdwERG1aoB7lLS+zkX
         6Vzw==
X-Gm-Message-State: AOAM532HAB3cPgW2mGHRnAlhTXM6X2QCIw5UE4+5GYiXG6d6Q6hqhjwU
        Aq/b4B0GkE2Wu37/mEh1YoNm9UXEMmNNctMcA/M=
X-Google-Smtp-Source: ABdhPJz98T5q4iqwnKJ6XLz5KLJEdtR03PghRs/TcTNHjSjADq/bGHoT8LKjEGZ5/AZyW3RX2NdmBjl4LoxhaTXeA+c=
X-Received: by 2002:ac2:5dfa:0:b0:44a:15d4:9e60 with SMTP id
 z26-20020ac25dfa000000b0044a15d49e60mr3749873lfq.241.1648574097651; Tue, 29
 Mar 2022 10:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1134.v3.git.1648097906.gitgitgadget@gmail.com>
 <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com> <ee7ecf4cabeff14cc64c979aa77fbb2597a9f986.1648514553.git.gitgitgadget@gmail.com>
In-Reply-To: <ee7ecf4cabeff14cc64c979aa77fbb2597a9f986.1648514553.git.gitgitgadget@gmail.com>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Tue, 29 Mar 2022 10:14:45 -0700
Message-ID: <CANQDOdfjRcTB4=mq869NZrNAk+gapR5i8XHFnBhfH1eONzP0BA@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] t/perf: add iteration setup mechanism to perf-lib
To:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 28, 2022 at 5:42 PM Neeraj Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
>  test_wrapper_ () {
> -       test_wrapper_func_=$1; shift
> +       local test_wrapper_func_=$1; shift
> +       local test_title_=$1; shift

local with assignment seems to be a bash-ism.  I'll fix this.
