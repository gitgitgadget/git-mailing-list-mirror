Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C190DEE4993
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 15:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237175AbjHVPfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 11:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjHVPfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 11:35:09 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF84113
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 08:35:08 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-317f1c480eeso4170452f8f.2
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 08:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718506; x=1693323306;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWQlc4S4/EY/zS6vB1+bATfrju9WXkD8hsi67vyKcb8=;
        b=N+qPg5NnIPSNFgMvHwWZTzwj1rhvivRS+e/4KSovavWaLwl5gSVbUTZ0t+D+TVCuGE
         ltLSShgRkNdfH7hPSbRlk3eJ2Nedp9kKM2A47Z3k4fPGLhKKX+Q3/h4FS9fIZAwdlvzJ
         mYSivkPyQBqDh072VaXY2L/jzWQ+nqD/l+AUmYU/+LEpRsZTVeklmtVaVjvfNrHoRjZ/
         oG/tMBEobUeqa4yYQiSbo9epF4cWGiDvI7tlWLrvOkJ4PtuecNSmISPJHwqrfNWvSZWX
         iKAvOvX+M+WA4U4fWyrZCo/1EzfJbUmBJJ3FVfEhYKKzB1GNIIjIb/c5gXmfeab1NPxC
         Wyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718506; x=1693323306;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NWQlc4S4/EY/zS6vB1+bATfrju9WXkD8hsi67vyKcb8=;
        b=bKO+DtQVKb9DdsN4tO0ZRZ5OlGILLb6rrI6Bh3pm07vy7yhrAg0jO3CFkTwC+IUg8R
         8CI8r9TFudypSLCtgDFM6tIeRXLTdd94uepdhTa9pAEA1y9oO1wYGQR83z8MvRm1OtXo
         KPzJX/GqUSm+Cp332m/gWSu/VUGAWc/tGfaxv+6wzfGLCcLTHDa0Ge3ogNpGyBcyFOGf
         7a7R57u1H97XlW7dQ+goupqQgZxGzmFalxcBxqr3akEtRVjJswxaC/lTOoHk5iTRbuEU
         cv6ZmPAHYnLQxxdoZjmeLM/zon4QdifvgaWeOZf6zoENqeYesDXwOsl3FE3oH7OMrimX
         nSpA==
X-Gm-Message-State: AOJu0Yw/2y0AUuNVfWz4qQHhHVI7A0y4RBkWd1isejos2jz1qiE59fed
        R/tbaZhQhCAshzBZ922X4nABZlphnyw+Vgj282RAkVZ09Z07Ww==
X-Google-Smtp-Source: AGHT+IFQw6UqwUTvcL0T5LkJFcVO2/FPcv8khFnjZXVcBU2NylddT6+gsqhy+FzzUahsxjMZ+cXS+rs2yHoPTknkJSk=
X-Received: by 2002:a5d:4c4a:0:b0:319:7aa5:b880 with SMTP id
 n10-20020a5d4c4a000000b003197aa5b880mr7206051wrt.48.1692718506034; Tue, 22
 Aug 2023 08:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230711135214.17445-1-cheskaqiqi@gmail.com>
In-Reply-To: <20230711135214.17445-1-cheskaqiqi@gmail.com>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 22 Aug 2023 23:34:53 +0800
Message-ID: <CAMO4yUEwOCNtk2L9ooXHTMC-ysVG0xgHB5UWW_pb7gwzDpy4Dg@mail.gmail.com>
Subject: Re: [GSoC] Blog:More Sparse Index Integrations
To:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Week 9-12 post and GSOC final report is here:

Week 9-10:https://cheskaqiqi.github.io/2023/08/20/Week9-10/

Week 11-12:https://cheskaqiqi.github.io/2023/08/21/Week11-12/

Final report: https://cheskaqiqi.github.io/2023/08/22/Final/

Thanks
Shuqi

On Tue, Jul 11, 2023 at 9:52=E2=80=AFPM Shuqi Liang <cheskaqiqi@gmail.com> =
wrote:
>
> Hi,
> Week 5-8 post is here
>
>         Week 5-6: https://cheskaqiqi.github.io/2023/06/25/Week5-6/
>
>   Week 7-8: https://cheskaqiqi.github.io/2023/07/05/Week7-8/
>
> Thanks
> Shuqi
>
