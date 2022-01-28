Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4E9C433F5
	for <git@archiver.kernel.org>; Fri, 28 Jan 2022 09:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347568AbiA1JTb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jan 2022 04:19:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243305AbiA1JT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jan 2022 04:19:27 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E6EC061747
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 01:19:26 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p5so16496975ybd.13
        for <git@vger.kernel.org>; Fri, 28 Jan 2022 01:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Dsjj9SRl86bdNhAqGdKYXsiSlcFyBkSTlfCHUt91HBM=;
        b=nj3ta6zM7nSjf+ce2El6tYng4OsZEuhQ/Eui7pE3yB7l40m5ig9nLCUZ6tproUknM2
         NcZ8zeSTzqvKqWXpslIDEK2hEN56Nx3t3lIZSK68uljDkLMooYUBnQN8mypQEWIxS13l
         5dU85eg3AWzBaywW9nbBQ4GPtjuxFdVM+jdRJ4W1/xWMHfwhD9gkQUJfWPEtsQeDaGKs
         jkriUJtSgpXVazSPG2k1NhR8k+Axbqe5jsn6dxI7E6m/dP2k5fxfMVLh1hXuZkbSyf+5
         JHJTvJLmgd+Z9EBaVaWbfwOM0vQIg8UWlws8ooPyR2QNiB9xQmvr6IiQBAr6oTEDbkew
         mC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Dsjj9SRl86bdNhAqGdKYXsiSlcFyBkSTlfCHUt91HBM=;
        b=r0/IGadRa1dWw0IZkn9m2qPU2mQL0j+af2PNEiNGytPbyW0/xDPgZNlUvHJKhIAclx
         4XmcCiop0HRlEXgzBoPDfWnw4t1/Mf948KysYXQlv6sFPEn2pHPwhcjKRv/cGEjedak8
         xX6cugxZDL0hpOabiBQ8ljO3fgiSWYpAJR2gtTao2PvO6nw99LIq/L8ZfNE69MQCNbeK
         Jky8CenGazxyXSsUodSHluKtsm4PkSPrBeaEkXHtesRbwkvK0KNY/h1gN2sk8ry9jf2v
         ralfU3VTUw3SAgXA1axiltfgqTj0rBHKI0Sv8tOjttCEtjuhuVx4PtvLXrn4r+lpeHTR
         x21g==
X-Gm-Message-State: AOAM532eU4TAzkegA0XnXOEzjz0WpKChx5D3DEGZDDjR/D8ajNPYB2Hf
        Jfc8cVLyllIVtwAmpP23vVGViWIHTsIzF2lo/d/1S3uo
X-Google-Smtp-Source: ABdhPJy4JFUIn8tS7Bil1eI85kwNv1gtMgZCK+NFf8mOJ68LR+SbkGyFkU92FQMPYXEYfP60PLfI9MziVnAcYAz6rDU=
X-Received: by 2002:a25:d6ca:: with SMTP id n193mr10832749ybg.45.1643361565900;
 Fri, 28 Jan 2022 01:19:25 -0800 (PST)
MIME-Version: 1.0
References: <CAGqZTUuLNoZR7L9r1unR75S4Gte83DGSV2QUnGG2PqQOPBigAg@mail.gmail.com>
In-Reply-To: <CAGqZTUuLNoZR7L9r1unR75S4Gte83DGSV2QUnGG2PqQOPBigAg@mail.gmail.com>
From:   clime <clime7@gmail.com>
Date:   Fri, 28 Jan 2022 10:19:15 +0100
Message-ID: <CAGqZTUue90yqwK5w8RsH3iG7uMYCXb1kFWZhKOMXXkN=Wjc+oQ@mail.gmail.com>
Subject: Re: spurious git stash create failures
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Can it be that `git stash create` operation uses threads in some
fashion and there is a race condition?

Thank you
clime
