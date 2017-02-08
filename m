Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35EF01FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 16:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932145AbdBHQPk (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 11:15:40 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:33418 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdBHQPX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 11:15:23 -0500
Received: by mail-io0-f177.google.com with SMTP id v96so119759314ioi.0
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Gw3jHnYImV13ev+rxtUvkoGkQD+EViz8jtr/GyBKcbc=;
        b=D4cnwH27TvFzkjVrarOB7779ReD1wtayuH1VMQ+D9LVbHr92T8RzDuh3tH0wdDCQWq
         6w8/CM6jsoCQ7i/lTMfZnI8Y2/gpb6phWvybqU0GVmUnqXVCttb9yZdZDU4ncGuyuLs9
         6vXMvpdLsRgrH0YtHwZtzt/d48yIHbS3LwkpWZyG1SE314ra/gzP0KKVduURs/+3iuqJ
         8xJLtN1P0hxCuEexvZ7jLcWkFSBxj89idMN7GpiYTNpJZbxPb13R4OmjshFlX6Da9jMd
         pFinxhE67hMu0MXsDx0ogQ3B/jKyz5vY7GL3dR3QJIYgfGdp2Ad8LvLngSHx6Wk2Zv1U
         8IZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Gw3jHnYImV13ev+rxtUvkoGkQD+EViz8jtr/GyBKcbc=;
        b=uXFvAbOtf7ONpwGAjHI9Xh/YS00G5CEtD+w122WLZR0vAJKsZS8NUekaL7U80xuzX5
         TsYuTPvbIlsrjuXuSTIBv41spnqGGFITDTirva/Dz4pAPv/dVH2vlAXtHzkkqeVM3k1y
         JAtZxhGRu4Nf9424DCvhiSui2P6+jPEAOtUHLN0JqkvzqgOm0NzlxCVQECXk5FuM4PJw
         y7aYuhH0OrVpki0HVLi4BbHfUBMnji7FFr0yaKaXbL0cIake7B5aPwOtm6o9EN34qWuq
         D1tnN9bbYEsRS9PtXatP9xVxereGd42+t1Tbd7/e9DUkIQ9oSSa2/XF/sgdTpiupkp56
         3ftg==
X-Gm-Message-State: AMke39lcFYjtXig6DACspGrmxZBc/gl0l9x0OlEV9sd2setTfepEqhbtGycziyCs5u8YSb69+YABvToJmzXqa4rM
X-Received: by 10.107.16.14 with SMTP id y14mr9220986ioi.164.1486570477736;
 Wed, 08 Feb 2017 08:14:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 8 Feb 2017 08:14:37 -0800 (PST)
In-Reply-To: <877f55r0mk.fsf@kyleam.com>
References: <87h94d8cwi.fsf@kyleam.com> <CACsJy8AZUBt76ZocS2JEr9FP_8Obv8L911AvZxE_sww3qXB7qw@mail.gmail.com>
 <87efzg7oq3.fsf@kyleam.com> <CACsJy8C=owNPpND4Ab7bFE24kpWBr5fQdob21DEDCckCXu0Mng@mail.gmail.com>
 <877f55r0mk.fsf@kyleam.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 8 Feb 2017 08:14:37 -0800
Message-ID: <CAGZ79kZm7y_gcG-DcjywXzNk9RhPLLkVhjrsLQHijb-DQhnOJw@mail.gmail.com>
Subject: Re: init --separate-git-dir does not set core.worktree
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> [*] https://github.com/magit/magit/issues/460#issuecomment-36035787.

I would agree with the thinking in that issue.
