Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EA820705
	for <e@80x24.org>; Thu,  8 Sep 2016 16:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755826AbcIHQ2r (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 12:28:47 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:37668 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754699AbcIHQ2q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 12:28:46 -0400
Received: by mail-it0-f53.google.com with SMTP id e124so90079508ith.0
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6YtIRbavwG2cIlpZShun/3xNsfCYDkLNiepGd+Vz5qU=;
        b=D+q8mC17RBm/LO62BzAj7dteRJGujk9qHRBIYW0gfInbLq5svxWJ+vL6XRKtLYrU7c
         k1s9TsM+bY4O6L9QoriG63k9u/FETWnUSvMw4CvGtMAcgWAWIQhQyqJjjnsjzLJ1k5jg
         6TDRXfYEFYfyLFFsXvxrRO+RqLAkM4ByQM1t0IJByEVGoiXxqdXSRzCbxMGLkV1ZTh7o
         bIy90ng7T+n/ARFgoHRv+IZ7RK99tdom/rwoSVibhMuj9u7411c+psGdTPESTlJzJF+q
         7Gyr0+N7HyW0sCltb12I8gmQqva93JvOb8N5plNCPaC9o3Kf5i4IyMdCKpC9ol7iBcuU
         4hfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6YtIRbavwG2cIlpZShun/3xNsfCYDkLNiepGd+Vz5qU=;
        b=N6MyOt/1qF9O9ok8LmHdQmWO4M95dwblLHkkMqHo6swBkPZXJEZlvsBkUJ4QKPe7z6
         X3g19R70nko509ZO8O7CEL/3TPPZrhbdkv2TViP0hP/V9OiG+YldaC20PLMQWq4KPyti
         ID9SHWQ4AQsTwOUq/xH3N131O+kmQSpwtLJYWjarrpt09GVRb5AhXccaquUOgEOV01AA
         IqAT3CVTJVnS1mbTgus0T4RG4VQ9KyUHnejzyl77fc2OcPpJAxm7ljqnrXCdOE3T4Tzb
         oOQ2NGGAePcJO+UXlSW4pQuhHLDGW/GWLpZ/s4rw9zH8Nj8bwp3VACNVsnW9xaGlOS3g
         Wtrw==
X-Gm-Message-State: AE9vXwNPD7cwO2BeDHGAHRWZQL+2wMhjDYNxMHJWCJoGlyqcW1bFflk7I27OVM4nkWe3/1SR++HH0Gap+eHW7T35
X-Received: by 10.36.123.199 with SMTP id q190mr17295212itc.46.1473352111780;
 Thu, 08 Sep 2016 09:28:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 8 Sep 2016 09:28:31 -0700 (PDT)
In-Reply-To: <20160908014555.GD25016@google.com>
References: <cover.1472836026.git.jonathantanmy@google.com>
 <cover.1473291819.git.jonathantanmy@google.com> <4b09bb7a5b7f4eb5fc31df3d98ce7ffc042eb367.1473291819.git.jonathantanmy@google.com>
 <20160908013431.GC25016@google.com> <20160908014555.GD25016@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 8 Sep 2016 09:28:31 -0700
Message-ID: <CAGZ79kYx_vb4_x0Bw=DUpWmb2DWO2KbfU8uCganN-0dT5CUGog@mail.gmail.com>
Subject: Re: [PATCH] connect: tighten check for unexpected early hang up (Re:
 [PATCH v3 2/2] connect: advertized capability is not a ref)
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Shawn Pearce <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Heiko Voigt <hvoigt@hvoigt.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 7, 2016 at 6:45 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (+cc: Heiko)
> Jonathan Nieder wrote:
>
>> 'die_initial_contact' uses got_at_least_one_head to determine whether
>> it was on the first line but code paths added later that use
>> 'continue' don't populate it properly (see b06dcd7d, 40c155ff, and
>> 1a7141ff).  We could do
>>
>>       int first_line = 1;
>>
>>       for (;; first_line = 0) {
>>               ...
>>       }
>>
>> and use !first_line instead of got_at_least_one_head (removing
>> got_at_least_one_head in the process since it has no other purpose).
>
> I got the history wrong.  It looks like this was always confused
> by the 'continue' cases.  Unless I'm missing something subtle ---
> thoughts?

I was a bit confused by the line

    for (;; first_line = 0) {

at first, but the explanation of 'continue's make sense for this pattern.
However I'd rather prefer if we'd have

    int first_line = 1;
    for(;;) {
        ... // stuff with no continue here
        if (len < 0)
            die_initial_contact(!first_line);
        first_line = 0;
        ... // here we may have some continues, but that doesn't matter
        // w.r.t. first_line
    }
