Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB3921F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390212AbeIUWQt (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:16:49 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33715 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389804AbeIUWQt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:16:49 -0400
Received: by mail-io1-f68.google.com with SMTP id r196-v6so12859899iod.0
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsrQsqyEsyFdH3E3m2eEd4Ka9JtfeuyDIKKt6jgByq0=;
        b=Ex1hBwgTe1gnbiCzsByih8NsHyruT5+L4x08b3M0u6ceKoeZqSqDubAwUMc0W9GEOK
         x28M/CosNhcHy3bVLlFTDZehRRoVU0onnCBqo/4bfgWPejrDRg3fCBO9miJ2eAa5INC0
         mHvUY1uMU9ZLVqQCCvl9EGZQzZYiCwKcgbMp++NfT4u/0m6dxaW96f30gnheSix9uG5F
         SW4K8D+UAGL21YB8LqWmPoMrGtDrfwuDisKOkjN+EqLeYDP+9J6WjTjXBGxWQwBpbWGJ
         QEKAPQs3bv394st30WVADF2F9iMKbKNMjgM/9BiYws1enWZdG9CRDIsuq9bvUuQsEMmy
         fbtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsrQsqyEsyFdH3E3m2eEd4Ka9JtfeuyDIKKt6jgByq0=;
        b=qOQoysw8aeMCPvv1BAoUHoH97GN2SliDtOTA+1ZX3GK//TnYQQSvfpIUwz/b4WS8DG
         7t87RmtJEg9+kSpcwBzj7I1mAg8GKB80oZ//RumaVYcNqcMtpfGOwBGP+RRarTbGGYwf
         jD/W9XnXlDnrAA6tP1U8Cl4LfXoVMFU1GVYqiLtBZORcfb50pZYA/Gl91ZDRzyIM3M05
         P7KrKn8TyV/TRkgBL/S7zkPfA0ULsWWZ59aKuXnwIp5TunZW2EeUmyTORooRiEpV+Eq4
         eHSLnJJgGZzKmngoxfaMWQjzQ1/vshE+mRyYVkBh7sud6TqIJBR+BLSinOl1Y68xNf/G
         iMnw==
X-Gm-Message-State: APzg51BrT7bIRmvTA8MDm5v7rEVKALrW81Qs4dpgzpwS69WUpW4Kkpqm
        rGLl/8NSzWTbQTRRTY813rnpDm8qHWqX4mpmCxU=
X-Google-Smtp-Source: ANB0VdZsLbAyUykj61IHxnUTuVY/FfgX/cY6rl3WLBQaX40x4Bpt2vCBqkK9lqfj0ATuvU7WRf4LDWqOZjpVRiB6ISo=
X-Received: by 2002:a5e:d803:: with SMTP id l3-v6mr34827176iok.236.1537547231240;
 Fri, 21 Sep 2018 09:27:11 -0700 (PDT)
MIME-Version: 1.0
References: <c46ca4a9-6822-436c-8e84-95b977527912@ramsayjones.plus.com> <xmqqworex1h7.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqworex1h7.fsf@gitster-ct.c.googlers.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Sep 2018 18:26:45 +0200
Message-ID: <CACsJy8DJ_PEJN_C_LJY4NNM6y1DbSy9vmgPOQTp3cPp0Ft+xEg@mail.gmail.com>
Subject: Re: [PATCH] userdiff.h: add missing declaration (hdr-check)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 21, 2018 at 6:24 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Ramsay Jones <ramsay@ramsayjones.plus.com> writes:
>
> > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > ---
> >
> > Hi Junio,
> >
> > ... and this is the patch I needed for the current 'pu' branch.
>
> Which in turn means that this is to fix 5b338d60 ("userdiff.c:
> remove implicit dependency on the_index", 2018-09-15) and should be
> rolled into nd/the_index topic.

I guess I should send v6 then?
-- 
Duy
