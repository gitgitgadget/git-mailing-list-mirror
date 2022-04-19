Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9FAC433EF
	for <git@archiver.kernel.org>; Tue, 19 Apr 2022 13:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343682AbiDSNTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Apr 2022 09:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238617AbiDSNTt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Apr 2022 09:19:49 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BA9344DA
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 06:17:05 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p10so29295666lfa.12
        for <git@vger.kernel.org>; Tue, 19 Apr 2022 06:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=okSaa8suKBjW3s6VFxWW4a5XvPeapr4dK+YR/J7JifY=;
        b=cevLj0WYXU2Kz8pGmAN6a+l3NGlUAhNJgMOvGx74VCZ7ata+zOgdizh3AGiv2U7fAq
         XSfiq+Af3Bs95Roansd+IJxKfwrKRCPqtFszX3JkIjw0dqDt6WlSshu+f1SN+wwzJd9z
         U6sSokrFEWX+0ZeigGBZQVQmYUNtfbDbA5ScmDqH+DB1nxL2Z2EUF3uG8e3PjOwYr2LF
         DDzBmbfWk/ffWbfeGKuy+cwVr2DPUwsSj70ScbcXAUPg6xwIxDrRIIvQBQsgj9lAhcQW
         3ToPAoM0a9t9DzLV3+2KI/0gpiCG+u6dV+TJBGeqBZ/EQTcgx8XDqDPQH+Bjo7ZlOacd
         h23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=okSaa8suKBjW3s6VFxWW4a5XvPeapr4dK+YR/J7JifY=;
        b=q7lVjKBK0736EmR44fZylD9DSG9xGdBAnugRXPOUGIimDDlw5yr18U3RKML+BXZwd6
         y49chznNZJ59GcXytcVHQkwqc2ijIjM22bZC+AUgemfQ6l8ZYk4lkabmogrsdic2UEjn
         iPDC4fOiNLPSf9MmR1oAv8Pd8+singtdxZ/+o+MR87m2vmD298kuixJOTTJwUUR8BBVo
         OvLp9Nuxp9hDS2Ya7ZFlzgipuh/I8Yz06DEtwOY2qzcunFczWb8qGWPZj0M8HONP55Jk
         YQEdEchZEu4GfJmWuYZjzjK+iUbxZW8NL1tW6NFyE+t6tXFHfWxX7APE//gwePWviT6Q
         45DQ==
X-Gm-Message-State: AOAM5321k/IQXjRU8YX+ZTr0zYpnriBxVn0EUd3AMhE0il7524ngItxz
        zMxfayD4iOKir3nmX9aauhO1D6bt//YywbMJ7RMzbOmUHL/6SA==
X-Google-Smtp-Source: ABdhPJzyhmudz3n3Op5jAHkdD7lImGI2V2UMj+uSitxLRiAWXEivfxfdsSCx5uC285QTfswc5fFuiYE53AzmZvPs3sQ=
X-Received: by 2002:a05:6512:114f:b0:471:b097:4a29 with SMTP id
 m15-20020a056512114f00b00471b0974a29mr1009798lfg.93.1650374223806; Tue, 19
 Apr 2022 06:17:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAO2gv81zCGbxNN_7a2j7sJZ_fbHiFXf4YxagddWLBWw7-ki5zw@mail.gmail.com>
 <660025e5-637d-8e93-e7ba-65a3ad474bad@gmail.com> <E6525E16-10E8-4C08-A596-6C16AD31F62A@gmail.com>
In-Reply-To: <E6525E16-10E8-4C08-A596-6C16AD31F62A@gmail.com>
From:   Jayati Shrivastava <gaurijove@gmail.com>
Date:   Tue, 19 Apr 2022 18:46:52 +0530
Message-ID: <CANsrJQcq-nWPaCyM3qR1d_u4U8wERdKbxFKMVK6Db9uWtyoFfQ@mail.gmail.com>
Subject: Re: [GSoC] Contributor candidate introduction
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Plato Kiorpelidis <kioplato@gmail.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Labnan Khalid Masum <khalid.masum.92@gmail.com>,
        Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to time constraints I shall be unable to participate in GSOC this
year, but I'll continue
to contribute to Git and invest time in understanding its codebase and
hopefully apply
next year as a GSOC applicant.

Thanks and Regards,
Jayati


On Mon, Apr 18, 2022 at 11:54 PM Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
>
> Adding other potential contributors to notify them too.
>
> See mail with details below.
>
>
>
> On 18 April 2022 11:24:34 pm IST, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> >Hello all,
> >
> >Just a heads up that the proposal deadline (19Apr2022 18:00 UTC) is
> >approaching shortly. I noticed that Abhradeep has submitted his proposal
> >so far. Others, do make sure you submit your proposals in the GSoC
> >website before the deadline. Only then can we consider your proposals
> >for GSoC [ref].
> >
> >Thanks.
> >
> >[ref]:
> >https://developers.google.com/open-source/gsoc/faq#should_i_send_proposals_directly_to_the_mentoring_organizations
> >
> >
>
> --
> Sivaraam
>
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
