Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58E9B1FF32
	for <e@80x24.org>; Fri, 13 Oct 2017 10:26:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753430AbdJMK0t (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 06:26:49 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:50565 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753413AbdJMK0s (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 06:26:48 -0400
Received: by mail-it0-f49.google.com with SMTP id 72so10708389itl.5
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 03:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lbeGkVf3SDU3sMzbgVV8pMeO98+EOFn0oJKpWKCkP4Q=;
        b=lpotqNpyrojZYNDtFs+Aw3msBrnKmQ0BwYV4tJzZ6yii2KThwePUWcxVD5FLtwRjg+
         xha4O6CjXH5etXcC++AHl0djNmxOeyCMROJvQi7upMiQpWrAChU9cfuOdqM1NrB6eklg
         BxzCW1xTnFPU/HWZkEG09Df5Hxh+NiGSYgqUzA8S59advIuTIybsUosudWKvbMT5Y4N5
         fQoYdSMdf6bdC0Ck2VsVemcXfqlegPhvYS+c4KFa69E/r5J9P4c1wA83wonKWf48Edb9
         QuxwZj1fWLkP3yh396UyzculAShYAsT1ypmdzSUegYsK5RempWFRu0roUfnPAWu3xIMW
         ulhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lbeGkVf3SDU3sMzbgVV8pMeO98+EOFn0oJKpWKCkP4Q=;
        b=Oyxi7he4uDl5wNGS9m2yRI5wlaZkgxlUwy0T6KxPZqjOqjVpucuRaK2QX76y9Qlp4w
         8krgGwQEIaE17yOzn1wwWnh7Ywc6qz6Ft3kgz93OotEkcJmHwVAoDYnS8L8dG/4Lqwez
         pO7ofTh5BqaSsIVHocOqZ2GrSTU4HlzBVaICcjLp+U9Wzdq8FvjiynBxImMGidq9aUV9
         4khb2GbKQVUUWS6Ymk2s65YkLmDCgaQ2k1wgFN2ECNqImrIvXTtZC2BFjoSb48Rx1php
         GDmg2EywR/lWkTxe8C2/L6Ximrl/2chVYX+r+GmxhTVfjFLl4iztSpoqOdzEDRXe6guB
         UWTA==
X-Gm-Message-State: AMCzsaVINqGngXTfCgkiDOTVgdjybz0EdGKnAFC/IKx41ZRbn3iJzkjd
        PK40ZDIXvDN/oFvCnSqff9Zaqn9MgLx8ktCGGc8=
X-Google-Smtp-Source: ABhQp+SoO9U+6UEOeECSGYNUapsiJMgXRAK7bjhp2a5al0Wi2SlaZAGnaY/UHPIXx36wNez7q3FjgMMgZSdIOCcm+JY=
X-Received: by 10.36.36.19 with SMTP id f19mr1518740ita.96.1507890407420; Fri,
 13 Oct 2017 03:26:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.7.10 with HTTP; Fri, 13 Oct 2017 03:26:46 -0700 (PDT)
In-Reply-To: <20171013100603.5eed26sjjigph2il@glandium.org>
References: <515b1400-4053-70b0-18e2-1f61ebc3b2d7@yandex.ru> <20171013100603.5eed26sjjigph2il@glandium.org>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 13 Oct 2017 12:26:46 +0200
Message-ID: <CAP8UFD1KuBdUCo=x_q4__s1kW15CWMH1jJkKzXqmf3=T3jcrng@mail.gmail.com>
Subject: Re: git-clone causes out of memory
To:     Mike Hommey <mh@glandium.org>
Cc:     Constantine <hi-angel@yandex.ru>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 12:06 PM, Mike Hommey <mh@glandium.org> wrote:
> On Fri, Oct 13, 2017 at 12:51:58PM +0300, Constantine wrote:
>> There's a gitbomb on github. It is undoubtedly creative and funny, but since
>> this is a bug in git, I thought it'd be nice to report. The command:
>>
>>       $ git clone https://github.com/x0rz/ShadowBrokersFiles
>
> What fills memory is actually the checkout part of the command. git
> clone -n doesn't fail.
>
> Credit should go where it's due: https://kate.io/blog/git-bomb/
> (with the bonus that it comes with explanations)

Yeah, there is a thread on Hacker News about this too:

https://news.ycombinator.com/item?id=15457076

The original repo on GitHub is:

https://github.com/Katee/git-bomb.git

After cloning it with -n, there is the following "funny" situation:

$ time git rev-list HEAD
7af99c9e7d4768fa681f4fe4ff61259794cf719b
18ed56cbc5012117e24a603e7c072cf65d36d469
45546f17e5801791d4bc5968b91253a2f4b0db72

real    0m0.004s
user    0m0.000s
sys     0m0.004s
$ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/d0/d0/f0

real    0m0.004s
user    0m0.000s
sys     0m0.000s
$ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/d0/d0

real    0m0.004s
user    0m0.000s
sys     0m0.000s
$ time git rev-list HEAD -- d0/d0/d0/d0/d0/d0/d0/d0/
45546f17e5801791d4bc5968b91253a2f4b0db72

real    0m0.005s
user    0m0.008s
sys     0m0.000s
$ time git rev-list HEAD -- d0/d0/d0/d0/d0/
45546f17e5801791d4bc5968b91253a2f4b0db72

real    0m0.203s
user    0m0.112s
sys     0m0.088s
$ time git rev-list HEAD -- d0/d0/d0/d0/
45546f17e5801791d4bc5968b91253a2f4b0db72

real    0m1.305s
user    0m0.720s
sys     0m0.580s
$ time git rev-list HEAD -- d0/d0/d0/
45546f17e5801791d4bc5968b91253a2f4b0db72

real    0m12.135s
user    0m6.700s
sys     0m5.412s

So `git rev-list` becomes exponentially more expensive when you run it
on a shorter directory path, though it is fast if you run it without a
path.
