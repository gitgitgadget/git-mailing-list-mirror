Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF14820248
	for <e@80x24.org>; Sat, 23 Mar 2019 20:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCWUEX (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 16:04:23 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41]:41971 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCWUEX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 16:04:23 -0400
Received: by mail-ed1-f41.google.com with SMTP id a25so4394353edc.8
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5IQ84xCtXXrsNdIXXwVWGh5rSSVuJ2GqUzMtfnPRzGQ=;
        b=ZxBmz03ji6gikjUn4KzibJZIukuJSzT62oe/C6xul2S3AHdb324E6FelsAeLcnVX9p
         sGI1NrilN8pGfhcsqBkoHoQTJ+h55eaPjK+SbxxG/XT29OGBcT7yRUtszQB/NBLKCgyL
         r11GEhy9Pi68Ut1x7a0TrbQSfwsXhImZK5YI7e7/o9bciUaLJVcftQwY39cWU3cZa9z1
         UuJiwfc/4KD2qka7+FWU+ZMfx5VdOchqbrRF8OQBC5UL0IzLj3MdHDMDGSbX6C5Jtntl
         wCE/hj24RQATOEEAD9UczOSMDyOZaU3cGPQVazarYeCicheRt+QxFvq5dL6y0J6XReLs
         5hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5IQ84xCtXXrsNdIXXwVWGh5rSSVuJ2GqUzMtfnPRzGQ=;
        b=VTnoN1KX28vn2y1muH9/4UQEhPWkr+KYUlhKPsVBUmi/ec10nbbhBao0RpjlLBFw46
         8ucqdtKazB31OW4vzLoHwc2bW5K9eedxKIwrJmquzXLnNhQFkBD9/2pqaakMeYc3MSxg
         LoFnm/xryu8VrXKAH87G/sMFDgbTl55mrs4orBxeuRQS5jBXkOSXuIX1Xvr9NVFxU8Nz
         2kSnGCvkRqYwkklpWaS0nrnNkkudDMF1ZrOh/Vo5POHP+0ZElZ2CEVg4TVL1P++h27qY
         7WrvADdglm4t07i6tsG5I06H5l0AcsZqHdXl/W1oj9vxGQGxMW3vwPA0lmLlcpw8Ifc4
         zt+Q==
X-Gm-Message-State: APjAAAWWPjgaaSQB2DaJxwgL1wTTsr26OclLJ8XHqL1OaJMaLAUwRpy5
        e4t+abC3vgrDdf0FNaPfUs4ZkEUCX2z9+1olWFE=
X-Google-Smtp-Source: APXvYqwxH3+EtF9hLxoxR13HJENI3IaRbvOw0JccKXmufwb4g84b1nPYkTif7/AEIrc5ii2QzuCI99PeQL197bIIdw0=
X-Received: by 2002:a50:91ac:: with SMTP id g41mr10205079eda.188.1553371461535;
 Sat, 23 Mar 2019 13:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190322160615.27124-1-jkapil.cs@gmail.com>
In-Reply-To: <20190322160615.27124-1-jkapil.cs@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 23 Mar 2019 21:04:09 +0100
Message-ID: <CAP8UFD3K4ft7UVSFeaQzKVVGFPwcLcpTKB+sqFN9X9_j_A093w@mail.gmail.com>
Subject: Re: [GSoC][RFC/PATCH] userdiff: added support for diffing shell scripts
To:     Kapil Jain <jkapil.cs@gmail.com>
Cc:     git <git@vger.kernel.org>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 5:08 PM Kapil Jain <jkapil.cs@gmail.com> wrote:
>
> Signed-off-by: Kapil Jain <jkapil.cs@gmail.com>
> ---
>
> The test written does not pass, imo there's some problem with the regex part.
> please let me know about the fault.

To save some work by people who could help you, it might be a good
idea to show the output of the failing test, for example the output of
`./t4034-diff-words.sh -i -v` or `./t4034-diff-words.sh -i -v -x`.
