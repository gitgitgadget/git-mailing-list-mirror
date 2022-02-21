Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A94EC433FE
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 01:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbiBUBtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 20:49:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245488AbiBUBtC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 20:49:02 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEB5517D0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 17:48:40 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id 195so4097337iou.0
        for <git@vger.kernel.org>; Sun, 20 Feb 2022 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8tFUzsk8mmPNKNubl9j8beFhsQGNtrHpOHhOwthNdpY=;
        b=YHESTKcIzNqVJrjiTS+9GIQ4936lGZCA9SAOjqbW6W0mLLaTvrJHcfuwOSLjO1q3TQ
         45PrDb9XECHzpOX+XlTrY5OBx3geFkeDRc/EATnqlpemEJurKRCAGwquJNIexcN7QPDv
         MPAuebME7xyYZbE1odIeDIA0bysBF/S7PaDIz6Dy2yzewMYwRrvSD3dXtBEUFDB1G7zp
         qUseee+u5JuaK4FEC/wMRpkhIimDc6IZG3fp2dnbGcj5W7XRO/aOdbMlfT58hNTiHUd+
         s2+CjblN5MAAN6qCH8lay9NnYXpbFcDXWbKs24K3IWeuUkvwZXx1hE/lePMHY4B4ZPa+
         3+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8tFUzsk8mmPNKNubl9j8beFhsQGNtrHpOHhOwthNdpY=;
        b=i3kJhE6nR7M8VuaXrsxV+ap5fQBLVEnegcMefj7SRwMRjzaZ8AnkRtFoLP7gRwYTIk
         or6elE3lkH5QrkSRWTi46Fj4aepMMy75d305PB/rJnWX6JBFVXGLMlozZ2L03g8dUfLw
         z11f5pMxpTjwvJqNfJaKU+MEM0KEusHlS2nQ73zxyKc+AZI2uFh65fhlfDgRfjuu0tA5
         8bFnNO2zVq5oT0KZGKcXci2AZfZbC1RU9/q+1svHfEQsjlOt8e6mJFnA6Fu4dErjUg9B
         L1Pw3PZVIM6pd61m8JeXaYr/TIStUQO/ygod8DEW220+f89eP8KntQ3uqTMgUoxwqE9V
         cZ+Q==
X-Gm-Message-State: AOAM532DIJbX7426HFNK3JziNTHvVx00sU72n0ePHmnvjhoDLvoaKU0o
        KLsUDCxGC0BKh734sVBS+Uyre3rw8dk4//si
X-Google-Smtp-Source: ABdhPJyQMpAxq/kpt9P6PeZWurx3Sd3kVbRKqK5C2IVeTgsgGhxw3XUWQksC8oL+OKpDBJ8k9p88Sw==
X-Received: by 2002:a02:83cb:0:b0:30e:e389:a146 with SMTP id j11-20020a0283cb000000b0030ee389a146mr12902176jah.201.1645408119426;
        Sun, 20 Feb 2022 17:48:39 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x19sm8949888iov.33.2022.02.20.17.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 17:48:39 -0800 (PST)
Date:   Sun, 20 Feb 2022 20:48:38 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSOC] Student Introduction - Reachability bitmap Improvements
Message-ID: <YhLvdjghyC+WQI6e@nand.local>
References: <CAC316V7M8bziK207tuFbctAqDdz+GC8OGaxM+B0earJtqDvBSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC316V7M8bziK207tuFbctAqDdz+GC8OGaxM+B0earJtqDvBSg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Shubham,

On Sun, Feb 20, 2022 at 10:39:13PM +0530, Shubham Mishra wrote:
> Hi,
> I am Interested in Project - "Reachability bitmap Improvements".

Great! I am excited that you are interested.

> I am going through the blog [1] and I love the technique we are using
> to fasten the queries. I have still not decided which one idea to pick
> out of many mentioned under "Reachability bitmap Improvements" but I
> think I will figure that out soon.

Let me know if you have any questions about the projects listed there,
and I'd be happy to add some more details. Alternatively, if none of
them pique your interest, that is OK, too, and we can brainstorm other
potential projects.

> Can someone please tell me if a micro-project - "avoid pipes in git
> related commands in test scripts" mentioned [2] is still available to
> take?

Oh, yes. Here is a command you can run to find some of them:

    $ git grep "git[^|]*|\($\|[^|]\)" -- t

There are some false-positives, but that should give you a good starting
point to look for potential spots to touch up.

BTW, re-reading [2], I wanted to clarify that "The git command should be
on the left side of a pipe" is describing what we should remove, not
add.

I'm looking forward to your patches!

> [1] https://github.blog/2015-09-22-counting-objects
> [2] https://git.github.io/SoC-2022-Microprojects/

Thanks,
Taylor
