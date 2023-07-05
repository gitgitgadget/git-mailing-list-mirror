Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F09EB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 07:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjGEHQu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 03:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjGEHQp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 03:16:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C4197
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 00:16:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b700e85950so1845571fa.3
        for <git@vger.kernel.org>; Wed, 05 Jul 2023 00:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688541403; x=1691133403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26STypWzA6VseLpHPuNIXg0VHrXXxrSHm1clmm9XBvU=;
        b=NC4frBBSTXtvij8iyfsViny5aNAZyuUAguR08iLXD+BmZqFgRr1m60zscLNAWZXNox
         bl76FDAeZVswcF2KbPVB8vX07YZqhj2+OTqJMDT1tXJfPWEFCHn17oZiNbio9JKFKAx6
         tebE1C22rKgAt2gmGWiXN60umxBn/opXdz/U+c/+7uTaAdDsxpsvC4w2bL5cc3LAdQuA
         1L35A4RwEXh505KG4/CA5l9YpFuDShzAif9sQITO/5wwTENDANOEBYrGH7qY03wDY/18
         yfXBxofNnSVpzTXx80OZeCsUjPlopAzXeYQ5+VKuZT9HAL7qEy2jE//06hLvVLcPCKZK
         5TPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688541403; x=1691133403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26STypWzA6VseLpHPuNIXg0VHrXXxrSHm1clmm9XBvU=;
        b=jXuq2RT2Zu+H1TB7DC3lPlawJYK05zr+6QGn78+B3PQ3B5qywFYAc2CyEpFDKigyAz
         PXCVu6SyK2fgxrOOt4cuWm4qxa698n5Hl7KzX68RGATpFn1j1d29rM/arOsG5yMrj2op
         cOoxVDQFOqxqXPGxM8ClpDYMnVD+ILIlQvcXEU1f+OMZnfMKqwVXM7Ny8beFBy/z91Zk
         vmOTkLqnhJRW5AwXLVU5CL+RgIcZ0q7XcmGkCFRRpissRyQoxqfFf7n4MD0q1tMrBxUD
         lwl6f93s1SaYkDdZmPoN4sdGRDnHiwCOe3XM9J0TbRY+brj5v8/poCf9g4++/n/qsm9X
         QEvA==
X-Gm-Message-State: ABy/qLY7rBpMSA0Ql/+AWwiJE7TMtak5l1OLB6qYqluxMcf/vY84jSqi
        MB7mwIgbvL6JVDLfIjsgH5e+MK3AZqwazPyUNjdwUz0I
X-Google-Smtp-Source: APBJJlEezJqi65SxxZnftWGzseLeRnvJOqQYVK1X1caMPqV8pzNgKpI5HgfQbGnjhoF8ua+jKmz7m+0cJHg+cFJSsKc=
X-Received: by 2002:a2e:8541:0:b0:2b6:a76b:c39e with SMTP id
 u1-20020a2e8541000000b002b6a76bc39emr10347800ljj.35.1688541402642; Wed, 05
 Jul 2023 00:16:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230702151457.3227-1-vinayakdev.sci@gmail.com> <xmqqilay3mzg.fsf@gitster.g>
In-Reply-To: <xmqqilay3mzg.fsf@gitster.g>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Wed, 5 Jul 2023 12:46:31 +0530
Message-ID: <CADE8Napg5ps9NywJS_P6wGnGVVCv9eqvEZXKVbZ-wWGZbjzHOQ@mail.gmail.com>
Subject: Re: [PATCH] docs: add necessary headers to Documentation/MFOW.txt
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 5 Jul 2023 at 11:42, Junio C Hamano <gitster@pobox.com> wrote:
> That is OK.  So the other one turned out to be a work-in-progress,
> and this is the final version, right?

Yes, I included all the files that did not have any mentions in the tutorial.
This should work perfectly fine. But the repository to which the tutorial points
still contains stale code. It might require a re-write, so I will cc Emily too.

> Thanks for working on this.  Will queue.

Thanks a lot!

Have a good day!
Vinayak
