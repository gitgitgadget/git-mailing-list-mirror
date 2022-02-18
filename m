Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB79C433EF
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 18:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiBRS6X (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 13:58:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiBRS6X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 13:58:23 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE0534655
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:58:06 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id fh9so16559722qvb.1
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 10:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ITt4wCaJ45MbATVasL4OCqilWLQMOfeZ6brwUGT+ZqE=;
        b=pQZV+n0q57F2xiGJc9flsCD0N9Ip7Cm9yFbSeiPfY/fe1Z+0SCRNdk+VrPFzeAqCWV
         yBs8hP1N2dUGw6L4JcHrmDr7BYGd7qrmrgWOYzvRp8I+xi2zPjcmKBWNd7BpsDCwbDh5
         bw9cN/lRoxD9FFKtOslOEICWLHtd0nTQcGxQDC6QJFphRlFxpHxzv90gu2ASaUchSj0b
         41pLpXvabsmfoE6S2EZci9sPFx3kG6cbf7neUAsck3cU5WzKU9vlL89UdALOKP2c7I3z
         v0H2i7C4XlNIt1UrhoUE/tdDhFZ7x3eXNo2mPyTiqr/jj6uqnLlogSvKmlEuDRsNDi9L
         aMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ITt4wCaJ45MbATVasL4OCqilWLQMOfeZ6brwUGT+ZqE=;
        b=JUDU6sBmdv9ZX2CMtMI30BwmYL6kQrhKhLp/4dYeAdklH3AuWADmceCGQ5le8uUGBV
         f9PbVbNk0ujFCh5G4Zkpe8ITsDU1JcFvl5aUecCHPZzuOTN2ca1twVHet4kH5dckwDzV
         f3goNNh9o3nVGDv7pXPgnavezh646FtJU7N8hBp/+GyGPbnhXT8CpZ7AX0Av+OkNnWqr
         MRq90bd9tXYaCWRU8ut9gie+vcSngwV5OO1nYp91pQgYiULiZQlmVIwsVevNNt3Si+xl
         GVu5odJhWD4LMJEEANqJhD9C9GHdV2BZvBfiv2kJuP9lN8FeAXNmoHU6JIxon/rLobmS
         K7jQ==
X-Gm-Message-State: AOAM530hFQbmQOitA0+qax6IrQLTWYtbHlPR8Mnh45+KRqv39WK9xVxX
        o0vfz6FkPwMknqWTmNcF2MAwng==
X-Google-Smtp-Source: ABdhPJwjdaKu38XWV2sUcoKSD4cLDHhOXPEiSc98XNIPBLcpPocUo7duYVOBPb/Eis+kcrVo/8Ckpg==
X-Received: by 2002:a05:6214:21ad:b0:42d:3631:4e8b with SMTP id t13-20020a05621421ad00b0042d36314e8bmr6819427qvc.123.1645210685270;
        Fri, 18 Feb 2022 10:58:05 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i20sm3912743qtr.38.2022.02.18.10.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 10:58:04 -0800 (PST)
Date:   Fri, 18 Feb 2022 13:58:03 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Git at SFC <git@sfconservancy.org>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [ANNOUNCE] New Git PLC Member
Message-ID: <Yg/sO63nhhtAXWvn@nand.local>
References: <CAP8UFD2XxP9r3PJ4GQjxUbV=E1ASDq1NDgB-h+S=v-bZQ7DYwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2XxP9r3PJ4GQjxUbV=E1ASDq1NDgB-h+S=v-bZQ7DYwQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 18, 2022 at 07:34:12PM +0100, Christian Couder wrote:
> We are happy to announce that Taylor Blau is now on the committee.
> Welcome to him!

Thanks, Christian, and the rest of the PLC for this opportunity. I look
forward to serving on the PLC alongside you, Ævar, and Junio.

On a practical note, it feels like we are somewhat overdue for a "Git +
SFC status update", the last one being back from 2018 in [1]. I'll see
if I can gather some more up-to-date information from Conservancy and
send out an updated status report, hopefully soon.

Thanks,
Taylor

[1]: https://lore.kernel.org/git/20180306231609.GA1632@sigill.intra.peff.net/
