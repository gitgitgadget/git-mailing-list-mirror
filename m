Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65F0020899
	for <e@80x24.org>; Wed, 23 Aug 2017 13:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbdHWNqd (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Aug 2017 09:46:33 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36474 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754001AbdHWNqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2017 09:46:31 -0400
Received: by mail-oi0-f54.google.com with SMTP id g131so1441169oic.3
        for <git@vger.kernel.org>; Wed, 23 Aug 2017 06:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=GXV7s8uP+9/xxuLQ36ZxnNrv84H7N+/KmEKVObAuxOg=;
        b=BeCoBlRIO/7badq+HU2cAMrJAzbVx+a4FtAVxb2zb+0MkS20RhqP+KYw8UkQWKM0l6
         qYziZAcqQOk3gk7DkenHljeevvbx7GaQe25QjtnGYWmVZBzZ/ujEcN6LWD6wbp/5EYYs
         ethA61fXFU8T1q390gMskiSjSOBV0T3MRFcgRhJYwdTPQH8+0HS/ZXRtbFfCWjJZXKUF
         EJ23xw8PVLeMzI2rkGB/jIHp26g28xMgqDs+XmtoCnRtGSngRKvZ34wzRksQ5ddXDxvz
         TLeyh/rNl1sZNXxLyPk73ffu7dYmBqv/0s6a4//AKNGvSUcsg9Qo0sr3wEaPmk2+oioy
         N4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=GXV7s8uP+9/xxuLQ36ZxnNrv84H7N+/KmEKVObAuxOg=;
        b=kYUWYT+RfBNzH7uwJiaL36ms7XU/waZLOrxxTKv0jWVV1ecWTRo/RvHTMKakNw7hGH
         Lf1dOcyEWWriHCZNiAD1sgbh2IZBixLHnA1mkBTjU+XIdsEcnO8cC2lfwl2p8afXZq1K
         9mJFMQw9u2kq0fkLni9y+iG4NVE2mkm73d+wToX7dm+VjPpexDM0hCXqEXf+6ri5WSBH
         kWLB3bVZkvtmEtPa87tfW/tXnDEYc7RGinG5k5d1FeQF/OFx5GNSPeMe9fgLA4KF+jwB
         A5Zv7E2U2ayzvs928PVs+cOc2c+crLzzunZsJlJ6EVVRG7rvYvYdAgSJIwdcg5NOdOlJ
         +V3A==
X-Gm-Message-State: AHYfb5ibezG6ctpbZSIepXEp529ebLadomBZ6MwMwKWQQT8MTRdvHGNG
        p9w9WEWC24SjeVyuro6q1fGdx31VBg==
X-Received: by 10.202.104.160 with SMTP id o32mr3556131oik.66.1503495991063;
 Wed, 23 Aug 2017 06:46:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.7.74 with HTTP; Wed, 23 Aug 2017 06:46:30 -0700 (PDT)
In-Reply-To: <CAOkDyE9phgZ4ToWTWa2GYgfVkDknCqWr+KEyqVoHg0RVrVVk9A@mail.gmail.com>
References: <CAOkDyE8KxFvM4CJhC4U=Jb95D6HQ-4qQBtKAgBMyHH15UOhvqg@mail.gmail.com>
 <CAM9Z-n=ypt_fyFcPjYD28NNoxnJ2ZSovd1TbERdA8RJY1Va=kA@mail.gmail.com> <CAOkDyE9phgZ4ToWTWa2GYgfVkDknCqWr+KEyqVoHg0RVrVVk9A@mail.gmail.com>
From:   Adam Spiers <git@adamspiers.org>
Date:   Wed, 23 Aug 2017 14:46:30 +0100
X-Google-Sender-Auth: _EtlOnCGvMLQqm_7tqkBzT7clBk
Message-ID: <CAOkDyE_VhGUzn=PmAVsbaTe1ZeBwBVGpF4Muz5MBckMAB6cf=g@mail.gmail.com>
Subject: Re: splitting off shell test framework
To:     Drew Northup <n1xim.email@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        "Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I got a helpful response to the following question almost 5 years ago:

On 12 November 2012 at 23:09, Adam Spiers <git@adamspiers.org> wrote:
> On Mon, Nov 12, 2012 at 6:18 PM, Drew Northup <n1xim.email@gmail.com> wrote:
>> On Mon, Nov 12, 2012 at 11:37 AM, Adam Spiers <git@adamspiers.org> wrote:
>>> As it turned out to be fairly easy, I was wondering if there would be
>>> any interest in doing this more formally, i.e. splitting off the
>>> framework so that it could be used and improved outside the scope of
>>> git development?  Of course this would pose the question how git would
>>> consume this new project without any risk of destabilisation.  I'm
>>> guessing that simply using a git submodule would solve the problem,
>>> but ICBW ...
>>>
>>> Just an idea.  Interesting, or terrible? :)
>>
>> Done at least once already:
>>
>> http://comments.gmane.org/gmane.comp.version-control.git/201591
>
> Nice!  So hopefully someone will submit patches to build a two-way bridge
> via git subtree.  Having them diverge would be sad.

but sadly since then gmane has shuffled off its mortal coil and I can't
remember / find what this URL referred to.  Please could someone
point me at a working link?

Many thanks!
Adam
