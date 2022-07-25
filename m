Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4C2C433EF
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiGYVwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 17:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiGYVwg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 17:52:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574EBAC
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:52:35 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g24so9296656qtu.2
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fdbpYtosdG46ty5bV4lcNU+xfUD1Y2vE+AjPNceoUHQ=;
        b=q6Yw2dicLPKLOdi5UtZ+Q5kd7ZSWQV3ODI+xU/5sWxpCqmift5+0/VtvZNwG1HGI+L
         +ovyGUUtAMApdeT9HhHimGONi4MZNBptUg6L2R2WIX9HP8vkvO+4dfk2CfXso5cwgcgh
         dtZ+Cd3IXxNzOXs752KcObHhlmrqt2Ytf8rK0xjG35V7paOWxU6zqAF4l1e1I3h48a1S
         K4dvAyrofd0Pt81RNvtuI45la6CvQH2eRe5KsPoZjJawD/+IPalTCmn/Ozmqg8I4cNrx
         tkK4o9SZg4T9fheSDD7xpvqBWBWTFALO7ob2OD4HgTEuHWhiuhzUNpadaRiczGXBmbJC
         DkNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fdbpYtosdG46ty5bV4lcNU+xfUD1Y2vE+AjPNceoUHQ=;
        b=knfdp6LHSlYfoFtgP3RePaJokBEr4IB66Z0XgsV6l+GuvnRL2ck/AaF6NfHOJIJ790
         l5XRkNRxIZpb7G+QqO5iR8JAg8SIV4ktkrQ/82pHPyP6Lcblq0KZ45Q79RnsSr+DQqLf
         lu5mqjli0yj9YkwQXcCmB+GNjq0AHj44hdJo9HmNK8z3RmzvEmeN6rgfm2PlIWysVYXY
         Dyl9lHQzMJyqx3isFwewzcZxBmk0WtOvtkcW+lnAP+hfUAqqt8D0FXd3YIQPN0U7UokD
         XO6GvrUgkD9tJ9XPosDaaWshMuZV/0g6u+308GHkwDdOmlSK7ogemWW6/ObgOqCTWlwd
         7PLA==
X-Gm-Message-State: AJIora9orD3hGshPcW/Avoew4a8kMktzUiTXU3pfi47131+PPl5Y8xeQ
        7DJG2mVB4Qy3XnErbWLCwqwkHw==
X-Google-Smtp-Source: AGRyM1tQ0VLPuia3t0HhioZiD7/7jWTHBbTeGjQwLX04WDeR3F0ljKH0zte6ZTanvD/baJGmLfXz/A==
X-Received: by 2002:ac8:5905:0:b0:31e:e346:e080 with SMTP id 5-20020ac85905000000b0031ee346e080mr11882560qty.569.1658785954455;
        Mon, 25 Jul 2022 14:52:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o62-20020a374141000000b006b56a4400f6sm9743546qka.16.2022.07.25.14.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:52:34 -0700 (PDT)
Date:   Mon, 25 Jul 2022 17:52:33 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     git@vger.kernel.org, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC] Abhradeep's GSoC blogs (25 Jul, 2022 IST)
Message-ID: <Yt8QoUPnZQTB2OQQ@nand.local>
References: <20220725152326.60497-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220725152326.60497-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Abhradeep,

On Mon, Jul 25, 2022 at 08:53:26PM +0530, Abhradeep Chakraborty wrote:
> Title - GSoC Week 6: using CRoaring library
> Blog link - https://medium.com/@abhra303/gsoc-week-6-using-croaring-library-be309cfa89f5
>
> Summary -
>
> I missed the week 5 blog update. So this blog covers both
> week 5 and week 6 work updates. I submitted my latest version
> Of `lookup-table-extension` patch series. There are some issues
> with CRoaring e.g. it do not store in network byte order (which I
> confirmed in Roaringbitmap's google group[1]). So, I need to make
> some changes to fix it. I have already finished implementing
> `roaring_portable_network_serialize` and `..._deserialize`. My
> next step is to use its functions in Git's codebase. I will
> submit the patch series soon.

Thanks for another delightful blog post. Like I mentioned off-list, I am
really impressed with your progress, and in your ability to reach out
across multiple projects in order to make substantial licensing changes.

I'm looking forward to hearing how things go with the CRoaring folks,
and to helping out where I can. I think that the final implementation of
Roaring bitmaps into Git's reachability bitmaps will be higher quality
because we're able to rely on existing libraries.

Thanks again for all of your hard work. I have your lookup table series
on my list to review right after this, and I think that that should be
getting close to being ready.

Well done!

Thanks,
Taylor
