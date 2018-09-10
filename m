Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC88B1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 19:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbeIKAYZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 20:24:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51967 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbeIKAYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 20:24:25 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so22706683wma.1
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5L9K2lxiFNVE7ley0aCJ+iqrt7jucaV8gPb5WDeVyuY=;
        b=TdIvFMKS+fywqdvc4DIHwrX4O5je8UlNE7zd2OT2DjZuIiZkrjN7rDZDWlx57HcnVf
         mn79CIW2LC3lkmadayzO9X14SJmfyaX87J3/jkPq0oH96BteCGmOn9zyMqCeBCp9J7ss
         vwBrzuSWX5jsyGLNjxhJx+sN2BkS08N6PXaTNjLdmq0MVTFPNXrEZsrSzHll/2oxDeLj
         uYALJm6fLvipI8F5AUSvUvjJxfK1Xc5+GZk/fd8MjXhFIY6kKxVFoT5llS6A8hRvh4It
         G6xlJOOy9q4FSK63KV0LEN01+g38PCzxmrs4WjGuXWqRZ9X2AvqulzRYmqEHJFz7ks0Q
         dy5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5L9K2lxiFNVE7ley0aCJ+iqrt7jucaV8gPb5WDeVyuY=;
        b=uf8mVv00e1rW3YUIx278GIiE5214wj1asiOvUP9ku2NDVP+JYZ7UrWN74xCXKKTE04
         4DMHyl6yctdOmEyRIstNcUfaR9Lr6l/k6U4sF0oZDJhN7I8u6KKTlkAbmqYVgRycL+ko
         WjVre16H3PV9EgsvGkHpEuAvpPSh5/erKaWjLwsOycwoVcN770WL03Hm3xPnvPAY2529
         f+NS6mAuy33qM10r+LrLmBAn0HVC+2GygXid+zMHVVtfPpi/GLau09uljvQyvtuV8mWk
         ELS+vMlu3JIOQMwCrioN+HvqB4d1d3/fqVdcSOUdTre4JjWuFT9Vw3MJrACGnhE5SBRv
         6VzA==
X-Gm-Message-State: APzg51D228cQMfbbzOsgVgcO0/Yl4z9mHxT7JZL8sXV0O9N7l5xOPF0O
        CTkyRaaaRIYPql64KhZ+z9A=
X-Google-Smtp-Source: ANB0VdZKXEfkJcYT8zIRkIP4HzOVBmg3jc4Ka5fDOpyggYtvBt3NnO+VC4rxO+3+cI5RBBAulAb3Ug==
X-Received: by 2002:a1c:8145:: with SMTP id c66-v6mr1631647wmd.139.1536607727978;
        Mon, 10 Sep 2018 12:28:47 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y17-v6sm19645964wrh.49.2018.09.10.12.28.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:28:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 14/23] patch-ids.c: remove implicit dependency on the_index
References: <20180903180932.32260-1-pclouds@gmail.com>
        <20180909085418.31531-1-pclouds@gmail.com>
        <20180909085418.31531-15-pclouds@gmail.com>
        <CAGZ79kYS2bTFowEYwH6t9sBAAZ=ikMn7eAut8O0-6NdG=eq3dw@mail.gmail.com>
Date:   Mon, 10 Sep 2018 12:28:46 -0700
In-Reply-To: <CAGZ79kYS2bTFowEYwH6t9sBAAZ=ikMn7eAut8O0-6NdG=eq3dw@mail.gmail.com>
        (Stefan Beller's message of "Mon, 10 Sep 2018 11:49:56 -0700")
Message-ID: <xmqqsh2hrw29.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Sun, Sep 9, 2018 at 1:54 AM Nguyễn Thái Ngọc Duy <pclouds@gmail.com> wrote:
>>
>> ---
>
> Junio would have to forge your Sign off here?
> (I just realize this holds true for the whole series,
> but it occurred to me in this patch, as I was looking at
> the diff_setup[_done] part on the previous round.

That is fine; as I said elsewhere, I am treating patches, other than
regression fixes, sent to the list during prerelease freeze as mere
"test data" for the 2.19-pre version of Git, and I may end up
keeping the result of testing "git am" on them as topic branches,
but there is no promise I'd do so.  Reading patches on the list and
commenting on them can be done without sign-offs; you can treat them
as an early draft that is not meant for the final application.

I may come back to leftover patches in the list archive after the
release is made, but honestly I'd prefer to see them sent afresh
after the final for the next round, taking input from the review
comments as necessary.

