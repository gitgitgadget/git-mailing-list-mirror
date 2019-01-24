Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CC021F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbfAXVPj (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:15:39 -0500
Received: from mail-wr1-f45.google.com ([209.85.221.45]:35242 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAXVPi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:15:38 -0500
Received: by mail-wr1-f45.google.com with SMTP id 96so8088086wrb.2
        for <git@vger.kernel.org>; Thu, 24 Jan 2019 13:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LhomHyzdYbQ5Wdf7NAyjNQx4r8TvBrQAfodP/t7rntM=;
        b=Z6Z68Q4zaG/vl370LgBny8xiyOCywOGOwzl2puzJaMg+HPK1yr+AG+bXSTQQN7RSxK
         +bnZJcfyiK/RaaaHZIUgg2JVNN2xcJlGj5eHQKRlSL+DRAi0ZkIygCO9uU10sd+8K449
         hSWAT7vbVBw7Xp3DSqws57B3Sucuizc6pfHmO8/8XLO5dnuub1JUiTQXURBk21VmZsRZ
         4CynpAZ5vIoQg0I437rSMVTYQgEJ3YjZNUe3wv7bwfwQtGrKYqSpqYVZWTRkBDWI7ypS
         EJY0E7ZE721HVFmnqs5ypZpFz62igM3SU7n8lQZfd/rzmNxhvcZS3R32juCG2d1nkVLe
         4BUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LhomHyzdYbQ5Wdf7NAyjNQx4r8TvBrQAfodP/t7rntM=;
        b=bMGXCVvtfYteS7g8PhKIlGEUzBnKwxNU8TujhSCB6y3PkLjz/HLtHOvQYxr2NxfNbx
         XKhGln9tTyPJHf/aZSjZU4bcDrgVc2bUAj0pa8rbuev3A+sJKzrZ/nj1zLqtm++yBYB5
         BWMBBaFdD1p5RJx/oRxXjvBYotzA5h6WKiwG0UJekoDnk8gj0ULTPAV5D9UNs8+HJQWy
         D9VeAi7AYwSncqCcDCLVsUX36nQrtTmAUMnVABrBNDhmmR1jTUHg6VB63XR5reneGqKT
         yRRJzDDPfDnN+ReGQLeTVKeBXrMEv9WmrXn6pZ4qAZDobbvBhRUUa2pt8gt3CeUU42zc
         YT2g==
X-Gm-Message-State: AJcUukfqObmsHfLcBopZaGxVUEChoZk4UWYLu7N68pC2BdYifOcvCDK3
        JM55Ne04DFp66eNNhNaOmAE=
X-Google-Smtp-Source: ALg8bN6YVkdMCeybn9FWyv+v2ljKcE1MJ/fM7Za4qsEWVNGLepZ4Okro4de+ygghkMBS7+GCmsMLwg==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr8776515wrq.16.1548364536844;
        Thu, 24 Jan 2019 13:15:36 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x15sm139770612wrs.27.2019.01.24.13.15.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 13:15:36 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lucy Phipps <landfillbaby69@gmail.com>, git@vger.kernel.org
Subject: Re: Fwd: [PATCH] optimize PNGs with FileOptimizer 13.50.2431 (x86) and ZopfliPNG 1.0.2
References: <20190124180755.6124-1-landfillbaby@outlook.com>
        <CAGZ79kZAhL6jz9i1-v09y0b3KGCokANN6eZYgXgU1w9_ymFZFg@mail.gmail.com>
        <CAGOd_F8f=dURFE0H3qjMONy32nrSsXs5KHnogsosfwK92-KbYw@mail.gmail.com>
        <CAGOd_F8A7Tfgb8cD1qvi2WDKYXLp=Zf_Yopb38gFpRQoj0tcdg@mail.gmail.com>
        <20190124190458.GA29828@sigill.intra.peff.net>
Date:   Thu, 24 Jan 2019 13:15:35 -0800
In-Reply-To: <20190124190458.GA29828@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 24 Jan 2019 14:04:59 -0500")
Message-ID: <xmqqh8dxhi4o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jan 24, 2019 at 06:34:29PM +0000, Lucy Phipps wrote:
>
>> honestly i just like optimizing files. the test images still work but
>> one of them is half the size as before. i don't know if it needs to be
>> bigger. it doesn't make any actual difference
>
> I'm not sure if we actually see any benefit to optimizing them, though.
>
> Optimizing a file which is served to many clients makes sense. So these:
>
>> > >  gitweb/static/git-favicon.png | Bin 115 -> 106 bytes
>> > >  gitweb/static/git-logo.png    | Bin 207 -> 204 bytes
>
> should be optimized (and largely already are, from the byte counts).

67e56eca ("gitweb: Optimize git-favicon.png", 2009-08-10)
