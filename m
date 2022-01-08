Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749E2C433F5
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 02:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbiAHC6j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 21:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbiAHC6j (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 21:58:39 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF589C061574
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 18:58:38 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h2so22174180lfv.9
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 18:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UdIukAHd8SOlOHsGrK7MeofyGkFMaQeV7DoMyrpTVQM=;
        b=aFtoCkrDMaxC5XsJl1aAKrENVYcJU4TsGqXss5sEF84ZM5BWrJ1EjS5UW68Bw7cCJc
         /hDY/nFZ8Mmb6jMVjA+4XwYU/+kUxdccSjaWkWQoLXjZvpqfmc4gRsmJA4+J7usi5l/v
         4oFn4+3xAHx8249lfcIpYtfQRVhsCoefZ6Duzpm+zTjCmeiZq5dzetHAMxCBxK76HVNJ
         bEYfPxPIazQsnP60jhtzWVxG71Rt+bh7eW/jKFgJY5rocuN1JdyNV2cT1ksV6yIg1idv
         0KbBWAmQlTHJMfa9tU/kJqzh/CnmHxG6yxW3QrQKEcC6qQkWklhEysFbv0YFRqpAmEn9
         dJ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UdIukAHd8SOlOHsGrK7MeofyGkFMaQeV7DoMyrpTVQM=;
        b=hQ+A3YGXhaUh9Ye0D90N9Gt3w6QxM3XPdLAz206GBW0xqVlgMjNXEYrFYJPTBsh0r+
         OIV3ok/kl79McxEvKc1yyOxHEPQ3Z0RKQWjkZLR0yJbXecXp0uCXaxkf8WQMtis+9Zcu
         oLif6OZlTwAsSlZBbEua4e3vv5UURr/TvhowBdeUnPfmyQ+VpX4WhrcFn0+tyx3sE2b8
         k3RDlkPgR9iV4Z2zDk0xRkXM/8CzCYSIEbJsWl+gjLznWq8csengwz+nj/CnSSyKgGCY
         HvDvDxCxbJCsp7tUEs9YXHK9MyOAAclfrfkNrIXsOZEo3xmBCoqvO0F9oVrnaieGWHcu
         jpSA==
X-Gm-Message-State: AOAM532l4OIu+y+cMrGn4sQy27OMeA18kTfJh0qfsFnrG/DQazTatQQV
        3900PpTE58r55plOWGXsO0QZo5+/cm3qydmcr6U=
X-Google-Smtp-Source: ABdhPJz64EuSrVjxDinqp1eiDLtkpdl6g7LCxUEYahI4aipWBHX8EJKQRhohSifqybx/ZVwM0oi8thiwv3p/TZIobRk=
X-Received: by 2002:a05:6512:39cf:: with SMTP id k15mr56279722lfu.664.1641610717114;
 Fri, 07 Jan 2022 18:58:37 -0800 (PST)
MIME-Version: 1.0
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
 <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com> <patch-v6-08.10-af22a4cb134-20211228T132637Z-avarab@gmail.com>
In-Reply-To: <patch-v6-08.10-af22a4cb134-20211228T132637Z-avarab@gmail.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 8 Jan 2022 10:58:25 +0800
Message-ID: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com>
Subject: Re: [PATCH v6 08/10] cat-file: correct and improve usage information
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 28, 2021 at 9:28 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> +               OPT_CMDMODE(0, "filters", &opt,
> +                           N_("run filters on object's content"), 'w'),
> +               OPT_STRING(0, "path", &force_path, N_("blob|tree"),
> +                          N_("use a <path> for (--textconv | --filters )=
; Not with 'batch'")),

Found unnecessary space between "--filters" and ")" in the new entries
of "po/git.pot", see:

 * https://github.com/git-l10n/git-po/blob/pot/next/2022-01-05.diff#L200
 * https://github.com/git-l10n/git-po/blob/pot/next/2022-01-05.diff#L319

They were introduced in the following commits:

 * 57d6a1cf96 (cat-file: correct and improve usage information, 2021-12-28)
 * 5a40417876 (cat-file: move "usage" variable to cmd_cat_file(), 2021-12-2=
8)

--
Jiang Xin
