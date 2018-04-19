Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9B131F424
	for <e@80x24.org>; Thu, 19 Apr 2018 10:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752120AbeDSKJj (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 06:09:39 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:38841 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751449AbeDSKJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 06:09:38 -0400
Received: by mail-it0-f50.google.com with SMTP id 19-v6so5986813itw.3
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 03:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1pYM/cpdk97Kvj4178vHKXtUEC1xFK8M5gmAOcLsWIg=;
        b=qYSfM5HbHi6TVi+If6zXb24150ZIIjtP6cLk46uuRm4/Jq6ah/O8lOitxkMgmzm4kS
         TQExDib3Sg1Z+BETnp9i9ARFd+0UzSY6aIErN//7cQWLZ63wZc82IU4YRzIJOmtp/0uM
         oKTdvvvJ6tTHh/yXWSR4Vp/B1nboWYvBmeb/53Pbc5ClFcC1fAgvAr//zzxLi8RZxPCQ
         BkJ15V4870Rqt5vdn8cv3Bh0M9QsTdcfxB/KnqN3Kc6fyXTcQAJPiM8I1ZLi60LAXcoZ
         +mqPi3Qylt3uSHFz/cyD8t3fZNPYuE/4LNnEaAHY5NvCxWp9NneWx7okRwxz3OY6EbCM
         y4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1pYM/cpdk97Kvj4178vHKXtUEC1xFK8M5gmAOcLsWIg=;
        b=Fo5LUuGsqFUz+I1PkLN5FwO+rhdEFz8Std7O2T72aYh21Xw02nUtfYmIkDDyN6xghG
         DHW6NwAwkfvxu6XGYiaE4o1rdTcyBinq2l77mQClzuG6XPhhDprUsGl5gnNmwRTpp9bO
         M9o5JVoclqDUuO426sPhnNbUtAVoTQPRbE9mb6uznymBQqk8kIfYKgfB4nVy2m8LjJcv
         61Z+P0sK/nTRL3v7u8fpRm6J0Un+RpbRbhYTFvTL+50DGpxjOLKPigonwBbHoyB3vHaQ
         Nj4fCYRYa/seSOKFnT6A/hv8KAvIxx2SktylcsTOQvQJiA+pjYrIHf36QMomHw/KhI7r
         OV1g==
X-Gm-Message-State: ALQs6tAZp7JpSQ3sZXPZkwQi9zx7kmDGnKiccVRq+Bhpm8m+Hj9T5Mma
        d6oI/Ydk7WRHrpq71z9uAm2CDNphAFtFYTAv1RQ=
X-Google-Smtp-Source: AIpwx48B7ys/pgwGeeGLUL9xwjqYUYGxjiLZV/NB264Wf06zbepLeZP+Hd0CHPjPeZ4HQRBUI0Im31o+F7ZHi4LeK80=
X-Received: by 2002:a24:538a:: with SMTP id n132-v6mr5521110itb.129.1524132577865;
 Thu, 19 Apr 2018 03:09:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22db:0:0:0:0:0 with HTTP; Thu, 19 Apr 2018 03:09:36
 -0700 (PDT)
In-Reply-To: <cecb82973f80fdd2db940410db2a7c3b23107c4b.1524125760.git.johannes.schindelin@gmx.de>
References: <0f0942043678fe76f8d654306482ee26fac643f0.1523617836.git.johannes.schindelin@gmx.de>
 <cover.1524125760.git.johannes.schindelin@gmx.de> <cecb82973f80fdd2db940410db2a7c3b23107c4b.1524125760.git.johannes.schindelin@gmx.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 19 Apr 2018 12:09:36 +0200
Message-ID: <CAP8UFD3cH4JkKo97o4k+BW=sdaFviJR06R1V_JqS9FkwuP7ZKw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] replace: introduce --convert-graft-file
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 19, 2018 at 10:17 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:

> @@ -87,9 +88,13 @@ OPTIONS
>         content as <commit> except that its parents will be
>         [<parent>...] instead of <commit>'s parents. A replacement ref
>         is then created to replace <commit> with the newly created
> -       commit. See contrib/convert-grafts-to-replace-refs.sh for an
> -       example script based on this option that can convert grafts to
> -       replace refs.
> +       commit. Use `--convert-graft-file` to convert a
> +       `$GIT_DIR/info/grafts` file use replace refs instead.

s/file use replace refs/file to use replace refs/

> +--convert-graft-file::
> +       Creates graft commits for all entries in `$GIT_DIR/info/grafts`
> +       and deletes that file upon success. The purpose is to help users
> +       with transitioning off of the now-deprecated graft file.

I wonder if it would be better to rename the file to "old_grafts" or
something, and perhaps tell the user that we renamed it and it can now
be either deleted or moved somewhere else.

Thanks for working on this,
Christian.
