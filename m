Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,URIBL_BLACK,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715BA1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 14:53:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeKAX4k (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 19:56:40 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52334 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbeKAX4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 19:56:39 -0400
Received: by mail-it1-f196.google.com with SMTP id r5-v6so2452459ith.2
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2Y7f5ibIatWKHE4hU6sZtj9VwUMMilg39cq3mZHj3M=;
        b=hVN8SwFluR/Bp4wpRec3SI6px4VrBhdeoScS8F3+pMeGr2PE6Dn6UxJ531IaoRej0J
         +0VOiMORPJAjDrVQ8DAQ8QKRusv617BL+yPWsz0ESWCwgId1WSW/tWB6uJg+U+7w5K0I
         JDiFop3vhL4UoGTYFGqT5WveGuq+Ta69iHjlMxh330uUFV6n9CklFwawXgZEYJcqu52V
         pteZZJMWBy6YflN5Uiu548QvOlrnpdZfjeChZeK4n4TOBVdCJjx18lrkSgdVHfCbEqpg
         1RmMaum9BSN/5QIc3cgpm9YEdITpByXdH5a6F6wcdQ+C2UgrAJPAo6U1POCn92+wWczC
         Na3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2Y7f5ibIatWKHE4hU6sZtj9VwUMMilg39cq3mZHj3M=;
        b=LG6W5hqj3Oi4L12NrYg8FZPbLBJuMjOzKG+NpEkw1BNcdyM7mVBkMMvKe93in9aGAb
         KlVI5M5D15kslB1eXhKKvFAvP/viFw/81LHJUNbHHAQUmmkHQapAxKSrSW+ZTFXuDtgp
         qbO8upb4YnPZdMieahCAOARkstpQVtDTcRiVcCf08XcKc6led4X8rPbOQvyRi8OwC7bs
         0cyKe52059jCEbFboNprPCIuEs/PVuQTEirzCdKAPD8xTEZfT5sJoplNOCPt2QSmykCX
         ajLr46tTOxE4cXyRQjFKEaQHLTqni84cj0PnpRrOS+5cvl+wSgPOeMrFMo2Z2o974HlX
         olJQ==
X-Gm-Message-State: AGRZ1gKtS6PZsZCHvIMrAwSgponer0QnIxp2yCg91Ar4yzwdeUVs+E+z
        LKCkXZwXKFsXpzuUm6rSiY/ov1jHoFTA0/QIO8qiqGxx
X-Google-Smtp-Source: AJdET5elvDxYsiWc/b9IgfsLzR9UX6p9iy+Z+DEz4kwCaYOvZLJaCkLIgsSGnpjKv4lDTjw+yuugKASJRIjKCr4ADiM=
X-Received: by 2002:a24:6b4f:: with SMTP id v76-v6mr748434itc.0.1541084000949;
 Thu, 01 Nov 2018 07:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <20181101115546.13516-1-slawica92@hotmail.com> <20181101115834.19044-1-slawica92@hotmail.com>
In-Reply-To: <20181101115834.19044-1-slawica92@hotmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 1 Nov 2018 15:53:09 +0100
Message-ID: <CAP8UFD2qUotva_f+GmawHB3hr3W=rBy5V36yUWj7Majf2K61fQ@mail.gmail.com>
Subject: Re: [PATCH 1/3][Outreachy] t3903-stash: test without configured
 user.name and user.email
To:     slavicadj.ip2018@gmail.com
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Slavica <slawica92@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 1, 2018 at 2:31 PM Slavica Djukic
<slavicadj.ip2018@gmail.com> wrote:
>
> Add test to assert that stash fails if user.name and user.email

Nit: I am not sure that "assert" is the right word here.
test_expect_failure() is more for documenting an existing bug than for
really asserting a behavior (that users could rely upon). So I would
replace "assert" with "document" or maybe "document the bug".

> are not configured.
> In the final commit, test will be updated to expect success.

Other nit: maybe use "In a later commit" instead of "In the final
commit" as you, or someone else, may add another commit in this patch
series after the current final one.

> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>

Thanks!
