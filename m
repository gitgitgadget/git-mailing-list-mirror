Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B52C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 15:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjDAPxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDAPxs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 11:53:48 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEA11B7D5
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 08:53:47 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j13so23478293pjd.1
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680364427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pz5v5ucPKLSRyT92YABygffvMOngad4UQfZSgjtDIQQ=;
        b=E6ff5LYyk169ynOCiNybbNy4Xpz7vWLEB/XuQ7myd42ipTtKQSLDW6XpTHRzjBVU1K
         Ewc2c2cwzZQ3Q57yu02oboCEaGWf1V0Kp/eaJzEB7Yw07mg7uG6Ci6lBy/WP45WP3+DV
         tpqg8syznfUtmVEbp+RH0T2+kHyuLg7RgWu41TFRTFY80gXgw8Iq3HIAQAkUInQma/+K
         D/DItWG/3/2pIVlHjt5aY9/+rI8dX/YlLk56krAECWtD6/5K4Htb3nkZ7QHopTCXnpbq
         Lm4rmSdY1JbqY+rj0wJpp5LurnDXvVrK/xdWVxZfVFatPIyNXNkknQJ8fnY/esw2snMz
         ngbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680364427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pz5v5ucPKLSRyT92YABygffvMOngad4UQfZSgjtDIQQ=;
        b=psEZDhJ9NMrRqq6aSavAN0sy1ysVPVHxl0W8uZzsQvULKIWHmZ3zF74j5QjIKtrCBj
         xsZgpFJ9sxRLio6akoJEWJHT8Hsp7nbqZ7fG8woSXZXU4RJvRSYq5ToV5VoPPq4wHcOj
         Fh1G6zKDs3kuw/Gd7fDj9zCbmiQfokJmYmWp9dkCt+fE1Bg2MHUrbCrjYBe0YWwKKr/c
         YvbVAaHeNmHH4RRhXkKRxZYrRFmOpe207T1Vi7lCtV3lq6Or88yekhzq0Nx8hAYSknWd
         fPFZ4Ere2XB6X0C6Awdz89ifTRNSLpT3NYJxl2gyLykRA8S3amtijAfAb2+tXjH/juVK
         Hcgg==
X-Gm-Message-State: AO0yUKUh65IfZLLIKlA5CBjSWm4N0zZnobQXUe8xDSh2mFBkxEXKF9nT
        LJxZYf16sm6zXmFbsSifzXU=
X-Google-Smtp-Source: AK7set870AJr93ilLaE8dJShr1tgXRzLVWZGV5DBHi7H/1kfDh+kbZ22drhuuS1Xt8DAwqbnF2xEoA==
X-Received: by 2002:a05:6a20:c41f:b0:db:6237:e76 with SMTP id en31-20020a056a20c41f00b000db62370e76mr25521760pzb.15.1680364426751;
        Sat, 01 Apr 2023 08:53:46 -0700 (PDT)
Received: from localhost.localdomain (121.CH37014.cyberhome.ne.jp. [126.249.181.121])
        by smtp.gmail.com with ESMTPSA id e1-20020a6558c1000000b00513a9b29634sm3329058pgu.27.2023.04.01.08.53.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 01 Apr 2023 08:53:46 -0700 (PDT)
From:   ryicoh <ryicoh@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, ryicoh@gmail.com
Subject: Re: [PATCH] doc: add that '-' is the same as '@{-1}'
Date:   Sun,  2 Apr 2023 00:53:42 +0900
Message-Id: <20230401155342.21230-1-ryicoh@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <xmqqlejchpct.fsf@gitster.g>
References: <xmqqlejchpct.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Oswald, Junio and Phillip.

Thank you for your reviews. Let me reply to each comments.

> i'd recommend quoting the dash as you do in the summary (or adding some markup?), as otherwise it's way too easy to misread.

That's good. I'll fix it.

> It is certainly *not* synonymous in general and I
> doubt we want to make it to.

That's correct. Your examples helped me understand.

> A few commands (checkout, merge, rebase and switch spring to mind) accept '-' as a shorthand for '@{-1}' but I don't think it is universally accepted.

That's correct too.


> for now we should
> update its documentation to mention "- can also be used in place of
> @{-1}".

Finally, How should I update the documentation? How about following changes?

- You may also specify `-` which is synonymous to `@{-1}`.
+ Only some commands (checkout, switch, etc,), you may also specify `-` which is synonymous to `@{-1}`.

Other commands also seem to accept '-', such as `cherry-pick`.
It's not good idea to write all commands that accepted it.

Best Wishes

