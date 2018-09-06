Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52DE21F404
	for <e@80x24.org>; Thu,  6 Sep 2018 09:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeIFO0b (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 10:26:31 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:43628 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeIFO0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 10:26:31 -0400
Received: by mail-io0-f180.google.com with SMTP id y10-v6so8332929ioa.10
        for <git@vger.kernel.org>; Thu, 06 Sep 2018 02:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OelwO6Vz/jHLIDQlshez5APYp7tsJ6fSLdyTzSwSXAA=;
        b=AUpZBWxF+4OJ5TuUHTAOULQMEBPcYcEd7Y+Ee+UdFZ61oSPOiD149L+Argq2WMeupx
         RNN72FWYuR6mJtp80y2yhQd6tgeXvk+xLW9a4WqUbr0ASRoZxzexhKTa6emAAuvGG6VE
         mzDDYd2I9U7Dd0KMQPjRVFgLlKzDN9fEjX+NM3Q6BcyBDcFRLETH2NxpywJOTbi+gXN5
         SZsj76KVdMpSaE7pN/6kX8kZj9NY3H8wM0T95DlpqsKvwiNdj1heX6ezweCxmMI+AnCc
         1xSoooiPVQdwiyFz5f/YKKx8lhrPczEzxBtTBE4UjCBUEdH22/LNHRkSYnFOfnv+Gvrk
         BzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OelwO6Vz/jHLIDQlshez5APYp7tsJ6fSLdyTzSwSXAA=;
        b=d5v0Z2RlhMl8ZiskgtYhbh+/k1EQr5GyKbfYyS5LTriKhUp5iCBTOlU4+Xu8G1KrQ3
         5uKN9fMEloruBkSEs9xuTPfg8tx5fWds1+a66/yMy2/aQ36MVpHmrxmjZCSfA3A0M5pH
         qy2zRdDHGNC9rbA8xAiFCWX6hLdGMhJcP8WGv0k5+M9eAje67rJ/WatIfgr0BHOBsL3a
         BLpniRytZnXbA0vy5pFvQzHPMh/pIWBJH1XfKX4+qUlbM48AmY48Ehr+x5OYuZlrA8yw
         nkGSUGz4SBeyT6AQnFb91j0yl1mVEWb02OeTPg5Js43JpOxZ7SrCdn7wXVu9iwiHKLiR
         wbYw==
X-Gm-Message-State: APzg51DJ/GqfcCh/SRa/kXnbv1ibmJi2n9HL2VFbF2s235xFg8VmUv3S
        dkfbkes2kJbLUlTVN/a1gJ4USYL8cDMGrxIjPWM=
X-Google-Smtp-Source: ANB0VdaDsGt/lOeUyQ8+Uq0RmRS/KhW9O+J8nAQjYSM5A7x2ZtcspwN4vsadbhBe2OZ2YntMc8rLdNLEC8AcQhIlVWA=
X-Received: by 2002:a6b:500e:: with SMTP id e14-v6mr1166263iob.5.1536227510734;
 Thu, 06 Sep 2018 02:51:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22a7:0:0:0:0:0 with HTTP; Thu, 6 Sep 2018 02:51:49 -0700 (PDT)
In-Reply-To: <20180906012143.GA7477@sigill.intra.peff.net>
References: <20180828151419.GA17467@sigill.intra.peff.net> <CAP8UFD0SYECLk--7JsZkxBdQeJPuG1Ut5GMLsCJHqM+jG7C0jQ@mail.gmail.com>
 <20180901084321.GC25852@sigill.intra.peff.net> <CAP8UFD0qk3SkBhuEiG+-qhTjXry1SH0SmoFjSNmPr6WZrLfijw@mail.gmail.com>
 <20180906012143.GA7477@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 6 Sep 2018 11:51:49 +0200
Message-ID: <CAP8UFD1nbv6=6JLnOCkmCcZjNOcDfOm4oH7pxHsYcddUYUxBPw@mail.gmail.com>
Subject: Re: Git in Outreachy Dec-Mar?
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 6, 2018 at 3:21 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 03, 2018 at 06:36:19AM +0200, Christian Couder wrote:
>
>> So here is a landing page for the next Outreachy round:
>>
>> https://git.github.io/Outreachy-17/
>>
>> about the microprojects I am not sure which page I should create or improve.
>
> Thanks. I signed us up as a community (making me the "coordinator" in
> their terminology). I think the procedure is a little different this
> year, and we actually propose projects to mentor through their system.

Yeah, I think the https://git.github.io/Outreachy-17/ is not actually necessary.

> So anybody interested in mentoring should go here:
>
>   https://www.outreachy.org/communities/cfp/git/
>
> (and you'll need to create a login if you don't have one from last
> year). You should be able to click through "Submit a Project Proposal",
> after which the fields are pretty self-explanatory.

I did that for the "Improve `git bisect`" project. As the
"coordinator", you will need to approve that project.

I think the person who submits a project becomes some kind of primary
mentor for the project. So Dscho, if you want to be such a mentor for
one or both of the other projects on the Outreachy-17 page, please
submit the project(s) otherwise please tell me and I will submit them.
You are free of course to change things in these projects when you
submit them or to submit other completely different projects.
