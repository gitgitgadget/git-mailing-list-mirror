Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97559C63703
	for <git@archiver.kernel.org>; Thu,  8 Dec 2022 14:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiLHOaB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Dec 2022 09:30:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLHO37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2022 09:29:59 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2160212E
        for <git@vger.kernel.org>; Thu,  8 Dec 2022 06:29:58 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id m18so4476852eji.5
        for <git@vger.kernel.org>; Thu, 08 Dec 2022 06:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks.biz; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=68nP5MH2l875uIt1yICx7RejsGLCy49bFHWv79Z222M=;
        b=DhUIXrXBAPhOSGkgxVloqhmqXRCavp+39vbfpXN7i27gyhScNG22SoHXma561Hws+e
         8ypQiPcCDyfOg4/jfEES9CTBDpC/iwHiQrtAmbAKs7BHhqt63n4G8WtAhrD69akrCPMy
         KxfEMZc/loG06LEN5biUKILpEBM/ok6OBuaNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68nP5MH2l875uIt1yICx7RejsGLCy49bFHWv79Z222M=;
        b=2SRZ9QO+ziX3I0l2HwL9yPdTen6wj+6BaceuEutqG4OyZA9YNhrfVlSNJYmQNGKf1b
         ANFjjhAeD+A4Uf8tvS/zM/oZTNZx0RctrZvdal1K2xmexlu8G+BGUST5DQwHTtF8KgDP
         KUM3csHkQoJFgXPYxyvvPlvqigVl673IbcM14P+Yis8wufyiTUIHo+rDrSh/HgqI2or9
         DMtUPacOMJcHUHgIVoXf2g5mB6oMEq7NZSDA56wZG52j6rzrND27HE4BFajifcrg3cvh
         53cK5CQKk+/5NFJ1leor+7cAiaU6dIFrE/C0NPqbCHQfw0EpWGTWXR+E6tLqVzL16VOS
         wjxA==
X-Gm-Message-State: ANoB5pkSxNEFyLZHAwJCBlxNgRVFxgP9gDcWEa9iykUBX83XXRGs2Di4
        M5cq6pDKiYsDuZ/Ci1dsna383a40kUx9Xjpe9ojdy3QFVsxjzybgBEk=
X-Google-Smtp-Source: AA0mqf6dyYVLT5+PN6mSdH+63+ryZFmThXr+uU77CjgNg0KXGn6gOgH+jfczxgjADS82b5JJ8P+Wpe/ZtPoyAGvbKY4=
X-Received: by 2002:a17:907:591:b0:7c0:a997:2298 with SMTP id
 vw17-20020a170907059100b007c0a9972298mr27254602ejb.430.1670509796511; Thu, 08
 Dec 2022 06:29:56 -0800 (PST)
MIME-Version: 1.0
References: <CAPMMpoiN=Rj_z9VEJZ4EFhb8gBeqb6H7JhTUBbn-b-t-jHRVnA@mail.gmail.com>
 <4dcad1f5-9ebd-d15a-b663-a3513ae1bcb8@github.com> <091329e0-9af3-b853-0ed3-edd10d2a2b72@jeffhostetler.com>
In-Reply-To: <091329e0-9af3-b853-0ed3-edd10d2a2b72@jeffhostetler.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 8 Dec 2022 15:29:44 +0100
Message-ID: <CAPMMpojW1mHmZ7_P=JpDZr2JjNxn-Rt_CP5VjtnMVJ6ZDFk36g@mail.gmail.com>
Subject: Re: Auto packing the repository - foreground or background in Windows?
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you all. I will try to carry forward a patch with this change
and a hint about the recommended maintenance approach for longer runs.

On Tue, Dec 6, 2022 at 11:41 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>
>
> On 12/6/22 1:03 PM, Derrick Stolee wrote:
> > On 12/1/2022 7:25 AM, Tao Klerks wrote:
> >> But my *question* is: Does anyone know where I could/should look to
> >> understand why the GC was happening in the foreground, even though the
> >> message says it will run in the background?
> >
> > On Windows, Git's foreground process cannot complete without also
> > killing the background process. I'm not sure on the concrete details,
> > but the lack of a background "git gc --auto" here is deliberate for
> > that platform.
>
> Here the GC code uses `daemonize()`.  On Posix this is a wrapper around
> `fork()` where the parent exits and the child continues the computation
> (without stdin/out).
>
> However, `daemonize()` just returns an ENOSYS on Windows, since Windows
> doesn't have `fork()`.  The net result is that the foreground process
> falls thru and does the actual work.
>
>
> [...]
> > Instead, the modern recommendation for repositories where "git gc --auto"
> > would be slow is to run "git maintenance start" which will schedule
> > background maintenance jobs with the Windows scheduler. Those processes
> > are built to do updates that are non-invasive to concurrent foreground
> > processes. It also sets config to avoid "git gc --auto" commands at the
> > end of foreground Git processes.
> >
> > See [1] for more details.
> >
> > [1] https://git-scm.com/docs/git-maintenance
>
> It is possible to do the GC in the background on Windows (using other
> techniques), but I don't think it is worth the bother now that we have
> `git maintenance` to handle it.
>
> And yes, AEvar's suggested fix for printing the correct error message
> looks helpful.
>
>
> Jeff
