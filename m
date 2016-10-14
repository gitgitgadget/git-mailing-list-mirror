Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A43F209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932915AbcJNNUp (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:20:45 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:33901 "EHLO
        mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932911AbcJNNUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:20:42 -0400
Received: by mail-vk0-f41.google.com with SMTP id b186so113841014vkb.1
        for <git@vger.kernel.org>; Fri, 14 Oct 2016 06:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=SxrlJkWSqydcIfXlMQljh0iA5AmQr9RKveMZSr3ve+4=;
        b=xpqQc6xeA9Sj3kQ2GtHolxXrgC1re/vPRrU0yvrklO+qD0cuhmkKHWUaqNafVSayBJ
         122xI5Vqwm2BkiiyI2ddAGDGZ+6i8ZH9yc6ZsbUZCKap4xVj3etrJFGyjqfOo2dzjhay
         vgoZov5CEqyKOQKEek+PqrUoryaPVu2spE9Rgs6nA3glDtoWmwQDuJ1jIgstlfR+F/FP
         J/V85B4UeysCbF/YYgcZRbFoZPypApJMOTz/sa81blMzVJ4gYxqiEqMlpUalGi72QxYz
         HqOfjHahGt4kGqVYcCCG23wWrTvSw9PQhKkcXfxpSkNFF/BHbxOJMJo/btOwDbMgq+Mx
         U3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=SxrlJkWSqydcIfXlMQljh0iA5AmQr9RKveMZSr3ve+4=;
        b=QT5VrljlvnRIn6PYmxhH4q/+KQXkGWDEiy+ORUaKmQXezIfPIJpHpy6nxeVEA5BOla
         7KQpGyuwivJB/ZKcnjtCEXGbW3J1J5EwucKAPw17ff3qX8K21YGFScCfYzrG6NWvGdKQ
         At2vWevu/BjuMDS3ZVCdzX6hrRT+TaLqA0h1yk8JPSCbgYnp+H2U940k+b3EI5SCECzf
         sfrwR3QTKHYrFi6YxGGobCu3kbLjA8jEt/3G3MaTpdI9AEhDGY/hyT+dhTzfgGl7Ah9E
         +qb+rBsGVJyusDvrStht4gcV7qk4NBQjs8+R1kZrHra7HSvrcoyN7gFvva/ubYwkZ3R5
         IdPQ==
X-Gm-Message-State: AA6/9RkL8UcMJxq1G4q9Ikf6tOBqlp6r+3Nfvs1lV86iiYnmuLIpB33YNkg0PoKnQPrnSkU/IgRx3xZDOl6smw==
X-Received: by 10.31.140.147 with SMTP id o141mr7418684vkd.149.1476451241385;
 Fri, 14 Oct 2016 06:20:41 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.68.97 with HTTP; Fri, 14 Oct 2016 06:20:40 -0700 (PDT)
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Fri, 14 Oct 2016 08:20:40 -0500
X-Google-Sender-Auth: 1hF31ZRcyizK5AiKTapK0vHh284
Message-ID: <CAHd499AnuVximRgM0MKdq5JC-hwkrhox6bK_KA+XGrawoz2W+g@mail.gmail.com>
Subject: Can we make interactive add easier to use?
To:     Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Normally when I use interactive add, I just want to add files to the
index via simple numbers, instead of typing paths. So I'll do this as
quick as I can:

1. Type `git add -i`
2. Press `u` after prompt appears
3. Press numbers for the files I want to add, ENTER key
4. ENTER key again to go back to main add -i menu
5. Press `q` to exit interactive add
6. Type `git commit`

This feels very tedious. Is there a simplified workflow for this? I
remember using a "git index" unofficial extension to git that let you
do a `git status` that showed numbers next to each item (including
untracked files!) and you could do `git add 1, 2, 3-5`, etc.

Thoughts? Even though this feels like I'm complaining, honestly I am
just consulting the experts here to see if I'm missing out on some
usability features. Thanks in advance!!
