Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D081F462
	for <e@80x24.org>; Wed, 22 May 2019 18:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbfEVSt2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 14:49:28 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38942 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728674AbfEVSt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 14:49:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id y42so3675782qtk.6
        for <git@vger.kernel.org>; Wed, 22 May 2019 11:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H26zt440PhuMhj2ENv4mh/PUJM9kXTvWIvHA8LyQGGY=;
        b=Gr+YQstnef0ibu13HnhrxJgik+hCHdOxHV2mF4zs7gbu2NgrG7hql108G7X74PlWg9
         SQoU8OtpvBkRcQUPX16SIJeOu8EgSVqNkydJbGo5lOaKgbLGFHhSqGMYHH7gz1vv/z9v
         5N/f/+eEzKa7Ij6O4+aNztnlDJtZ4hwvN89IYE6UbSUQ7b3m0WiEixnJTPQTAhvxtwQR
         Z4Wx7x+VmayS2ovxBKAZEX3UUGTwnZ0gVRBxtFk4lv+aXiuq8suINrowtdVOjUFA+Ako
         3UwEcRHILZ0WAn5FvYIzEO4Wnw+easbcKfnQ2ZzesjSVWvpp5C5r2RMVTlq+lFk6Cg0W
         5k7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H26zt440PhuMhj2ENv4mh/PUJM9kXTvWIvHA8LyQGGY=;
        b=EmwL+rJoqRwHSO03zaxkb96YtxQUMOnOusreoMUAytFALCn6AjTsVZua/r4xNMqar/
         oLb76Io7WqigpVO4MHOXhaohmmKL2CQPf9e23rI0ssTUGJc0S+YG5BUpkdcCI6KL/X9F
         Ok/dzrjJ6EJ79zZmAqodRhFBXX4uoucvEArtANRm01wr3fvZYZydRRR9XdIc6flBMVdo
         3hXZYkqEnzTh6+VOsNJli7HvEwhC0fn9qoEYRGBrAb1xrl/K2Vid1xodOEwggULkTbdc
         ftYEfu/5i9nYj47tSKrttZzZ+S3gXxL/beLbA+yWwy0O8Yo875swig+4mUmHkCsfDNeu
         D/dQ==
X-Gm-Message-State: APjAAAUi51bYds1obNGCgWY9jVP2MV0YoXksLUgPiLJazasCevLXoK2B
        XVeM8c2skdeKJONubBxv4AwOIhU9rzCPEALCERMXdl1bhsI=
X-Google-Smtp-Source: APXvYqzlLJY6Z6ieaIWXQn/LoGmqFS9aXsNQk/cmgNCHxl+3N28puhIIHPuz8BXOyeTkrm44VuhKOXaWsZHTy6ZDzZ0=
X-Received: by 2002:ac8:22b9:: with SMTP id f54mr21349180qta.382.1558550966555;
 Wed, 22 May 2019 11:49:26 -0700 (PDT)
MIME-Version: 1.0
From:   Karl Ostmo <kostmo@gmail.com>
Date:   Wed, 22 May 2019 11:49:15 -0700
Message-ID: <CAECbv94KF9MhzZqa8BR-RL93mh0NuD3vA69pAT-sY5O74e_duQ@mail.gmail.com>
Subject: standalone library/tool to query commit-graph?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After producing the file ".git/objects/info/commit-graph" with the
command "git commit-graph write", is there a way to answer queries
like "git merge-base --is-ancestor" without having a .git directory?
E.g. is there a library that will operate on the "commit-graph" file
all by itself?

Thanks,
Karl
