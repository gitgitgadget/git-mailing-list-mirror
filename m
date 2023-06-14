Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E517EB64D8
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 19:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjFNTu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 15:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjFNTuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 15:50:25 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C741B2
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:50:24 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b3dd3ca7adso26200885ad.3
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 12:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686772224; x=1689364224;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MpSq0arnfXgF3TiOwBuzwqrBXiA3cWPBKD98WH3ltKY=;
        b=EpvazG3+0Q47iaUkdAIEFc0OHzhWsl2OAdS2An+eU1iNnEv7WAQgSzaPAYta3p1HeT
         SjamEKzbKKUfSzWtfIJ0L5PX1DjrF7212dcMId1PDjf199QissgNsl8XFrYwTc+XnF7H
         /mICX9ionTphCOXx8Cuk4OwOpHglPizTIqjOjpLL+PH0nqrCfOyRbrXWu4T0ELhV4YpF
         me1T2f5f7VCa/lWBMwiF04syrU21liu/yNUaYqiuemIL4Se3NYrlxsMXsIp5ieKc+GdP
         0wkSb3tM5PYe3x/eUJOxi0BsJ6OjZA6pgeROYKlCIUZosBJUmyjhWy7R65Nf4cpoXdaB
         Rw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686772224; x=1689364224;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MpSq0arnfXgF3TiOwBuzwqrBXiA3cWPBKD98WH3ltKY=;
        b=elpGKMDDCmTzu/VvfpNPfLosy7aFdRoZB70zg0E4ppTcuN+AbxBu6r36NM/Xu9ly48
         DONbEKw5W4gay7Wys7eHRfvf0MgG8hIXs7uhhGnySxjOXr0zf/jR9d+wegrSTTScDuP2
         Hw4FnwwJYvpFQiaJFhoXcqXybSxog0PNTupuHB9jyzPwa4R6HOqF5w9yGGWR/XTR2w8f
         bdT1NK4V70F98LLf1FPNzM5bvIOBJSk2/us3E7mGUzDk06wkczFiqY85DB/d9l0u+o5M
         EyNs9yc4kvZ6MzFUQo3wzDET77iX1mjpWahNjOa+K6uJcPXCYHcxJ75DprZ8D7JiUBHw
         d6Iw==
X-Gm-Message-State: AC+VfDxmiNRksWChOYR2xMsS6gMCHJPWOoBxj5NX7WOYqYPZHyQX9mic
        tNYaIIJED5X1okOJI+a31sSIb6KRCznYIw==
X-Google-Smtp-Source: ACHHUZ7dJN42CO9B31rXTZZvT6EFbZfVbFKtC2kw8teBM9JjH71D4Si1bVOFepgAHZpqmOvbYAlRYw==
X-Received: by 2002:a17:902:ec8b:b0:1b3:f72e:138d with SMTP id x11-20020a170902ec8b00b001b3f72e138dmr4462261plg.27.1686772224057;
        Wed, 14 Jun 2023 12:50:24 -0700 (PDT)
Received: from five231003 ([49.37.158.45])
        by smtp.gmail.com with ESMTPSA id g9-20020a170902c38900b001b51630d0absm14768plg.91.2023.06.14.12.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 12:50:23 -0700 (PDT)
Date:   Thu, 15 Jun 2023 01:20:12 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [GSoC] Blog
Message-ID: <ZIoZ9NhqsvNeVJ-W@five231003>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZIdrQybUsjEcxMrb@five231003>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,
Week 3 post is here

	Week 3: https://five-sh.github.io/2023/06/14/week3

Feel free to suggest any changes or comment on or off list.

Thanks
