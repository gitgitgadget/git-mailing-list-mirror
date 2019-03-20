Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B18620248
	for <e@80x24.org>; Wed, 20 Mar 2019 01:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfCTBuZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Mar 2019 21:50:25 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45718 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbfCTBuY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Mar 2019 21:50:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id s15so891279wra.12
        for <git@vger.kernel.org>; Tue, 19 Mar 2019 18:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2HAdZ29MYxfd/Y23VHYN3qi5NriwvcjeyS1HuFgrt/Q=;
        b=IL12P7vOdYN8qwcWVjFqlLlnOXanGOvUrMQPpwyPUXW6HCbZQGi/w4pGmADspxK1m2
         oyYhLjVwACCyf0aRijXV2FfjbZyvEvL9NxVsPiVM/6o3jDVroJIzH1zI0988hPM98qR2
         gIXe8SLDQv8fcrtFWTQT7BAOfLetIzc/kDgVyzN2XJUCEHdQSiNmz1W3pFw/v21MfXXS
         UieU3bhU3AXxJ2IpWZ7JUiQdvsdwOTqHwNTI4pa0VWjmL80GAG1Er0W4tUbeW4gsDV3h
         LqVeI5oKCOT+3z0hUA2RqQMbscvtSk75YN7tqx6ory5KRh9KyNnUBpd9bI5R0IJ4YFuv
         Alig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2HAdZ29MYxfd/Y23VHYN3qi5NriwvcjeyS1HuFgrt/Q=;
        b=PROw0MlUDeL/FFCuXxQKj2Eu1b91azqqzycwaC+/G1NvMjRqkI7eVjg7c8tq7JCGq8
         8EkEHKa8Kr5+kfGIUZcXLWhWR055rmwMB5Kf2QE15m6rOiPp1unKxBk4yWa/t+ifUJnA
         YW511aqXr2tUnRpMwezIu6Z89nhNWnrpStNLnEBtJmVbXK/XUxC60XgTI1E413qNpZvh
         7QD7ruQLa/yxd6r+aPSt7WeDpFI9Yh7W1/osSZU6e1nTsrgwDJhKFtN69y0M/nUUmIqw
         PbAe2WP2fwhwIPLSyuPiZ+100tLB0dUzjCcRI8QahfwQGBsjw1b8n8q7OvsLKeVtPk7g
         90YQ==
X-Gm-Message-State: APjAAAX25GjPh3fLCMihX8nbEyc3ouR150jWh7LA0SpGxkf5Uke9UqI0
        jvlVCZih4yq3m05GKYZvy3g=
X-Google-Smtp-Source: APXvYqy8H728xodVd9D1zzubazy8oFuHQpLzj6d8DR6DgWEDOZEImw5tTI5znkrZoju+MsNM6hIdbA==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr20676330wrp.39.1553046622891;
        Tue, 19 Mar 2019 18:50:22 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w8sm719547wmc.0.2019.03.19.18.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 18:50:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] checkout.txt: note about losing staged changes with --merge
References: <78628256-79dc-3036-c57b-a96797ceb120@gmail.com>
        <20190319093910.20229-1-pclouds@gmail.com>
        <xmqqimwexujm.fsf@gitster-ct.c.googlers.com>
        <CACsJy8BLxWea0ZrHkSU6+nE7dr5YvFNVH1tLhaqPRadi+2Hhwg@mail.gmail.com>
        <xmqqk1guwdeu.fsf@gitster-ct.c.googlers.com>
        <CACsJy8AUH4nOkt6H=yu=eRktK4me9kEkjqsC3zyNZDwUKXqCPg@mail.gmail.com>
Date:   Wed, 20 Mar 2019 10:50:21 +0900
In-Reply-To: <CACsJy8AUH4nOkt6H=yu=eRktK4me9kEkjqsC3zyNZDwUKXqCPg@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 20 Mar 2019 08:22:22 +0700")
Message-ID: <xmqqftriwbz6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Kinda. But "--force --merge" makes no sense. --force discards all
> local changes by definition, which means you can't have conflicts and
> will not need --merge. I think this is the reason why we die() out
> when both are specified. So we need something like
> --discard-staged-changes-only...

At that point, I would have to say that we do not need anything.
The use case is already covered with "git reset && git checkout -m",
isn't it?

Thanks.

