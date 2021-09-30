Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE7AC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A38D61555
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 17:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351404AbhI3RRK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 13:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349393AbhI3RRK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 13:17:10 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E48CC06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:15:27 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id n71so8622632iod.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=M9vErtfkQQYJU+qC5J4tqapbBil4kuEJAVtjMAsLyiw=;
        b=RMIYRVyM4rr7Xb+y5AkepSyEH0b0Vd28PnZUPGQ35V9dMELthOGRJz+Ew3LzPBBP6E
         m1VTK3p9Qd7yw/1xKyk/KsMWBd1Sx7MzWrfyqDQ/XZA2lefIGrKIBfhLA3WDwP+XtlSD
         lpuSL7xywVdcVLmzOg0EFyuF2YjVhhTRJT7lCJDJ0UDwmGBCbR8oxh2dQduWcUxwrXHu
         ZwZZsjQOb92dDIVYVhNnWZcI6jSpo/VNGOq4c4CNjpqELxWqT06eg0p4JvMa7K1/vnmS
         CrNJSG5Vdfhl2tteX/kwjCzDODY+S8r5TmCR+26mGAgGLmgenzkoYI89zib8NIDNq/CW
         ifXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=M9vErtfkQQYJU+qC5J4tqapbBil4kuEJAVtjMAsLyiw=;
        b=jElcijiiXvRZwHmRibehiCtKzf90VratuBJO0VPIdQr8i5JUaGbOKmlnxfmlsO7KHG
         GURE2I/WtApCCKzFb9Rbb/8Oem5kWCF+3BJZ00JZ3xabDZNl1Zb4z3B0rfJvXlkaRvY7
         /xHgo2Cj3byPGrEzU37GaTEDQ75FkGzdQD2RS9EWBYlkZ+ITs3TjhVBE5LMGqbgnl87x
         JnUZYKCLWFsfZkjmhnZjUI3uj+Xn5agqIxakD749h2DmCXapXFaZJOlYKVsYQe16/6G0
         XTXOD0hTTQvELzzygHXFze3bNl5+SRbdBzkNqkfUo1uNTpOZ7OVd64UAnAc39stT2bFL
         kDKQ==
X-Gm-Message-State: AOAM531pYMs7MzfvCvj3O9RvKoS+V6Xl0R8HoNKCzpQu6piywHwV2+Cv
        DPGysVIE8hqf7168YNOak+t7lyTv5b3NT/LnczH6GcUeMaA=
X-Google-Smtp-Source: ABdhPJxbctzQ5qESOc7B6gtUDdFvlPDWGk/JemmKeyDqROX8Y3SmBkVDhtf0Gg4bjwd1QEkEpK8aZOcD86MDub+AnN8=
X-Received: by 2002:a5d:9493:: with SMTP id v19mr4644831ioj.34.1633022126688;
 Thu, 30 Sep 2021 10:15:26 -0700 (PDT)
MIME-Version: 1.0
From:   Brian Bartels <bartels.desmond@gmail.com>
Date:   Thu, 30 Sep 2021 10:15:00 -0700
Message-ID: <CAEWW4VdL0N9DmJ7jwGY0WNN6SR75v-RR2HU-uFn7qDkod8o7Sg@mail.gmail.com>
Subject: Should help.autocorrect be on by default?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This would save developers precious inner loop time. I looked at the
code and it already handles cases where the environment isn't
interactive. So this should be a pretty minor configuration change.

Let me know what you think,
Brian
