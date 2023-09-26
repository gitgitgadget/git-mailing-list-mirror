Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3370DE7F14B
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 01:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjI0BOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 21:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbjI0BMm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 21:12:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40431C240
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 15:23:30 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53317e29b00so8506a12.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695767009; x=1696371809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYuks7UXHGsFH+oS6vzdtMsNwGdIqEGNKmwalM/TCsQ=;
        b=Y6WHxztTevjOWE/CdBV1Dx35T3ML8/vE/LdxsShvL1IgHMyyksPoY0R7ROqLWMyVJF
         0ecG+lnRLNxvmTW2aJ7C7D3MuA8MmGYFGesi+CorFYnTjEt36T1Wbf6x2lilP+ki57Ei
         3o1jndU4SuuSLUtwVCu9ojuma+i/rR1sTnULP2nDFbVpQE6IBfn/AM/rsrOZ7wD8eKHV
         Zhx2R96D59g0ec0xkF1DO4qxcnfWdcKPVEiGjXkVnigR75IiEzsK2jF13vQxxopGcVbh
         CB3rrrQ4CEAD8KQU7bgIgiETalq07mp5/6vzNckruKUpY9UZ3waAAxYNWGJJ2R+tBfLT
         QvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695767009; x=1696371809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYuks7UXHGsFH+oS6vzdtMsNwGdIqEGNKmwalM/TCsQ=;
        b=E4JxjPiLoz0orv5JregO7YciBWAGT7Jft0S5QM5Ka5FCn1KlzFrECFrmkmNEpcmIgO
         at+IQIUsUe20RkwvPXZCaY+bYgQr0MYCP6JzRgCBetD44ExdcK3Ucc05qOiafj4Fv9uT
         iJEDA8T91nmAZkJw1ogBUz2GUpMVzfIkdF5j/INXfMTiKQuHze2XqxOCatLGw9KH6x58
         12098UEGDRzBcct9z9zl1jF9CQyta1ve1odzWit8T8GBvXbCPTr0zZtKOnmLyJk257ja
         j6TNYJmmyg82XZrqAT3WQx8Op+233lofLMsxxUKzoUtLkUbctC9SKEfnUReyspzGu7ae
         7aHg==
X-Gm-Message-State: AOJu0YwuIjuO8U5/1o0jsW9PBkLzf5T/Ic85Hj/dvdr81MQ4IQ0zAFtM
        WCsZy9JnAMAgXT1o4NrxHJhsc41ubyoySo95H6d8zg==
X-Google-Smtp-Source: AGHT+IEaqDBtL5vUEiMN4jRCxLoHmtJu9losNudqCA3vhQ12Es+IDsbjyYt9W67GVi/6C45qLbnzH2fkxXighUy80dk=
X-Received: by 2002:a50:c308:0:b0:522:4741:d992 with SMTP id
 a8-20020a50c308000000b005224741d992mr225304edb.4.1695767008865; Tue, 26 Sep
 2023 15:23:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
In-Reply-To: <CAP8UFD1bsez-eMis5yH7Esds+LkhMnj0qTUMFPL1tRuDv2fiPw@mail.gmail.com>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Tue, 26 Sep 2023 15:23:17 -0700
Message-ID: <CAJoAoZmC-Ku80aSp5xkxfirJitoi_ai6ryK3cJ7Jkx_2fUjENw@mail.gmail.com>
Subject: Re: Projects for the next Outreachy round
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Shuqi Liang <cheskaqiqi@gmail.com>,
        Victoria Dye <vdye@github.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 26, 2023 at 7:48=E2=80=AFAM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi everyone, especially Shuqi and Kousik,
>
> September 29 is the deadline for proposing Outreachy projects. As we
> have at least one mentor for now (me), we should propose at least one
> project though.
>
> All ideas for projects are welcome, don't hesitate to suggest one!

It is probably premature for this cycle. But once we have unit testing
framework[1] in, I expect that moving tests from t/helper/test-foo.c +
a sh test to invoke test-foo over to using the unit testing framework
could be a tidy project for GSOC/Outreachy. Especially if we can have
an example migration to refer to, which Siddharth from Google is
working on in his 20% time just now :)

1: https://lore.kernel.org/git/cover.1692297001.git.steadmon@google.com/
