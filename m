Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5524FC433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 12:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348619AbiDTMOr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 08:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243765AbiDTMOr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 08:14:47 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9976B366B5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 05:12:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id n18so1600791plg.5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 05:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=njHo+vssW7ArC6fGMLx8jgUahak1PSjhRvroMHfjszo=;
        b=OHdKm0tcFVU02axYKG0+OZHa5y/SoCj4MLyKuXPC58gsZvo7PAjV/ozKye3s7Nh2nn
         hMDcmBbY61vd4qjZDi7CMLcXCJwRQDZA2hk1ASrpUTatUk+lH1Wkl3sbPXz1UFZvavgB
         NsoBWUHsxc+pDQL7eEpZKh1bTKZEz/Xj6LxR75IfelUmizrMPA/XJ6Zp59p7266bQJNp
         VrX38UxT59C6rZHCPuAUcZK5usfnxzhvp4rx28sAikAd8YnStRjIZKaEPHFvIRAvwjof
         9Iz0HNrTS0ZF/d1LER8taDGRR2r1KiPMUrOp5tDZMgN1BCxpFDA0OhxuLmlEFq/YJ80A
         FRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=njHo+vssW7ArC6fGMLx8jgUahak1PSjhRvroMHfjszo=;
        b=Dcco+nDbLTI+UyqnFj0hu83Pn8yf1XRZCiXS+aXmNNS7wU/NqL/zXVsVgnqZ8vnRh1
         m5Sh7+IsofsPpXsvBsgZkg+9LtZOiOpeQToK4iBrmpGNI5OSFjP+FLl9PXUIugQZBpnV
         1kGpCq8RRTlM8XH79CtkugtEU6p3gGjrm2dph8Ftzt3fUdNa+8ylwks/9ri66xD1ygAr
         63HeAUo8rUTToEu1CFWUdcCW16zEfn3a+eKw9qTcawho4cxJ5c6tFbUCgMtv93O73Ap0
         zYAHdEc8yOFQF0b7x4PdCcI+mUMEFg0iOZvFc3hWaIuEdKhPLC3E/mZeQoUhXLI5xGRx
         PTCQ==
X-Gm-Message-State: AOAM533eS4xfH7w8wSxyPZYr403JimMlrf63wfYUvryFgD4xECRgDQmD
        dZdwWpKuZKyXV6eOBwNONpzp8Db4XD22VA==
X-Google-Smtp-Source: ABdhPJy3KyHldOWQOxkED4tgp50fNKNh6B/zbyD92OENPPxV/771oHeja4FC7w4osWvFo37rFDcncA==
X-Received: by 2002:a17:902:a710:b0:156:5650:f94a with SMTP id w16-20020a170902a71000b001565650f94amr19817971plq.86.1650456720115;
        Wed, 20 Apr 2022 05:12:00 -0700 (PDT)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id j7-20020a056a00130700b004b9f7cd94a4sm21207060pfu.56.2022.04.20.05.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 05:11:59 -0700 (PDT)
Message-ID: <f5be273c-d958-be53-5f2b-d9ab52f5e96b@gmail.com>
Date:   Wed, 20 Apr 2022 17:41:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: [GSoC][RFC][Proposal] Unify ref filters in pretty.{c,h}
References: <7f2e9c1b-1d01-00af-810f-c81dd38c12ad@gmail.com>
 <bff6bdc8-83ef-7fa4-3554-edc0b7af1dfe@gmail.com>
 <CA+CkUQ9iujvFoGOqYHab-V9QKtnCvK+Zs1J7mzJDwQzH2-AOsQ@mail.gmail.com>
 <CAP8UFD0EXeZW=e2d34m5JSXpaedCs-QPc-jkuOcjxuDFFUAf+A@mail.gmail.com>
In-Reply-To: <CAP8UFD0EXeZW=e2d34m5JSXpaedCs-QPc-jkuOcjxuDFFUAf+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/19/22 7:37 PM, Christian Couder <christian.couder@gmail.com> wrote:
> On Mon, Apr 18, 2022 at 9:42 PM Hariom verma <hariom18599@gmail.com> wrote:
> >
> > On Mon, Apr 18, 2022 at 11:13 PM Kaartic Sivaraam
> > <kaartic.sivaraam@gmail.com> wrote:
> >>
> >> +Cc: Christian, Hariom
> >>
> >
> > Thanks Kaartic.
> 
> Yeah, thanks Kaartic!
> 
> > I didn’t get the time to read all of it. Maybe Christian can add some
> > more pointers.
> 
> Thanks Jaydeep for this proposal, and thanks Hariom for taking a look!
> 
> I had a small vacation from Thursday evening to this morning, and now
> I think it's a bit late to comment on this just before the deadline.
> So I think it should be submitted as is. I will try to give it a look
> after the deadline.



Sorry for the late reply. Yeah, I couldn't make changes to the proposal I submitted
in the GSoC website. Nevertheless, I would still like fix some known breakages in 
t/t42[0-9].sh related to git-diff. Currently, I am working on a project for a college
hackathon which would be over by 21st April. So I will begin working on fixing the tests
from 22nd tentatively.

Thanks,
Jaydeep. 



