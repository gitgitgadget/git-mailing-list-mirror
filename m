Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C96C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 14:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CCD5613A7
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 14:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343961AbhI2OUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245242AbhI2OUg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 10:20:36 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75DCC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 07:18:55 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id v195so5252517ybb.0
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 07:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGih5qkCl9BvUPiWf4Yx9ae7/Y3T1v95JN67eyU7sfo=;
        b=THlBVrN7djicePOIWboCvF1YNqHQ/vXaooUi0BV1tUXEvEgjNZANUVs/4ueXTq+kvS
         WPWSTt+83yOaY2NYU7UYP1S7RgzN1MrJiRuj9KoM8WqHgM+Yw/kPcuURt3RaZeafVawl
         LIZKQeyXjCdayGuMlBwMNOvf30QP5V1AiEIimMXOdXt4XUiRNi2x7q/RO6gIGi7t8JhE
         /TXe+uFCtwdrnHuD36n8bZ5n92iRMEkJ69hR6VR0eehe2MCb6brC6mndnSYRwqGhT7Y4
         EqmyaFaRT/ST2lC7Kx6zYga6vosxMtuu7i5SskCr5dsAGZ0WRoqw+yJDsQ5YfCshxSTh
         RmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGih5qkCl9BvUPiWf4Yx9ae7/Y3T1v95JN67eyU7sfo=;
        b=YVUx8nmTnpMBASrGLb5HiUvZ+HX2WUdVJzlUtW7spW+DmhJO3UCRV9FB9aVzPMoioq
         2jy/jn45Eq7H8f+DiepdO7uq2tRWDEEPW82QXLJTHRGoPUyOrBkQxsrS0rfoa1bXjFkm
         hq761zEHrGkudv5dZ9YxDWxyXfKf/YBRo8DpmEW0sak/N80DFUjsaNQappnmiy3Vdb2a
         60orKhFdc7ZgbPqLJaa3ce/qdmDsnS60svG03KTWK28/j7IrZwxG7b84BroGcMRYk4Yp
         LMc0LzJ/f76DOEWlciyKxMA4COtFR8+dGajcFLbMZ8j3loQlbRW3PB6VVJ9uXvkh1jXc
         Ii0A==
X-Gm-Message-State: AOAM531lNcuNj5AOQecoWpDXHMVVH20Ad73yyrMka8n2o74vp4vMJS5N
        vD7kIHZW4/f7PEWaoqKZ+XYAZBT5Vklopdgqt5wYm6MKW8c=
X-Google-Smtp-Source: ABdhPJyLG+YJDluem2lx0E63NXjxkH2jOK4SGmw49EzZwgo5PZkBXhzCm5wzoRod1ngUifllpVRVAH7fflsy9IPg7HQ=
X-Received: by 2002:a5b:2d2:: with SMTP id h18mr83352ybp.526.1632925134833;
 Wed, 29 Sep 2021 07:18:54 -0700 (PDT)
MIME-Version: 1.0
References: <YTGLLQCvlnT17jo8@nand.local> <YUYPgF6tRQ5ERYWL@nand.local> <YUpN4zrZmyxoTb4l@nand.local>
In-Reply-To: <YUpN4zrZmyxoTb4l@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 29 Sep 2021 16:18:43 +0200
Message-ID: <CAP8UFD0snuPE0L+L2LxEgCAQXaP_j9LwxwJP_ZounOtg4kRv_g@mail.gmail.com>
Subject: Re: Git in Outreachy?
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor and all,

On Tue, Sep 21, 2021 at 11:26 PM Taylor Blau <me@ttaylorr.com> wrote:

> > The project deadline of September 23rd is fast approaching, and we do
> > not have any proposed projects or signed-up mentors.
>
> It looks like the deadline was extended to September 29th at 4pm UTC. So
> we have a little less than an extra week. The below link is still the
> right place to submit proposals:
>
>     https://www.outreachy.org/communities/cfp/git/

So the deadline for mentors to submit projects has been extended again
to Wednesday, October 6 at 4pm UTC.

We still have only one project ("Unify ref-filter formats with other
pretty formats", that ZheNing and me are willing to co-mentor)
submitted though.

I plan to submit another project that I will be willing to (co-)mentor
before the deadline.

It's confirmed that GitLab will sponsor one intern.

Best,
Christian.
