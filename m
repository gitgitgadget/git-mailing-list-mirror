Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A20C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 03:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62FA461445
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 03:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhDWDNr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Apr 2021 23:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhDWDNp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Apr 2021 23:13:45 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B71C061574
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 20:13:04 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id n138so75473625lfa.3
        for <git@vger.kernel.org>; Thu, 22 Apr 2021 20:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XigeIK1BQWfD2lV5dr1sVqst74WD3Cqrw2Z2bPMI0yk=;
        b=iHa1TRBzpQlR2GmOqHbw+XkjJDHKgfTYLTSkAymCux/q4hxD/6GJGtE6kj3IqlNpaV
         860VXNDBJWidoOeTMs16X0BUX428uCSGZbZ4d5PO/wfWEUfjYuVj2mq7BWS4x/ZYlscQ
         MYivNuyIIQqVBngjaS1pNw8IheVfnMfo0ZBsm6qrR1QyyynFKIAlWAnrmgTcJqaJaFxr
         LsVunO4PCyjscQwvOxknXhSdjt3Ikv7NjsZcnFqiWRjx+2rEctTUAHZUe52sc+OSbB2H
         IKDT4vPcVNM9Cb13J/WHA1nX5yN/rzV5En/NLca8sB4g44HO/pYcJF0VjM1GHeB2RRes
         VD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XigeIK1BQWfD2lV5dr1sVqst74WD3Cqrw2Z2bPMI0yk=;
        b=rwZrdEB1/LI+NU9A1NjuWsEVDvgZGZ7imxl8afms/auhVvC808CiDtsNnY0jdZLdCO
         dp2EvvxsWqIvnednyvp0Xar2wUK6H3n1LazoZUT7otvfbYMFLCLmBZoC1B9TRJzMf7Lp
         Yfv7ZA08Q4dmtc48VCUhMaEH63zvYiT9TQdgSBaBFpBOpX3u45lh7uT3kCqhB0lX0B7b
         RdoNMpQQKIk9nixb9idK/DSDd4vUjDiiQqe3aUNgCPF06YY7aasZG+NrtZcQSVHVHmca
         tgsu4qthFKmy+6O6fuWRlMS2vLyMz9GHhF96nQ3rpU0Xu4UNYE3UG42by5IIMl0OSKRb
         DXMQ==
X-Gm-Message-State: AOAM5318ATU+fT+5/QpEka2P6qwBFmY8HYQRJefzkZXvlR/g6Qie+tfK
        t3fG2VHSPeXTaD3yxmg7qbXPt4E3+9nH9otABgQ0QD9x
X-Google-Smtp-Source: ABdhPJzQ7smiyrR3Priz8A1hpl7IPHexcsZZBM9OLvmSMnJxEXUiiS6TEcl14+ris++082JFigzow3hb9TYUCjbwxd8=
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr1058731lfu.42.1619147582703;
 Thu, 22 Apr 2021 20:13:02 -0700 (PDT)
MIME-Version: 1.0
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 22 Apr 2021 21:12:51 -0600
Message-ID: <CAMMLpeSsczjaTyuKgeLs2zLew5gX6KxzzDJK9pnamyYJd6rhkg@mail.gmail.com>
Subject: Pull warning
To:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello again,

Where did we wind up concerning the "Pulling without specifying how to
reconcile divergent branches" warning? Last I checked, there was
consensus that Git shouldn't allow non-fast-forward pulls by default,
but there was disagreement over how to refactor the code to make that
happen. However, since the warning now only appears if the pull would
not be a fast-forward, it seems to me that we could simply change it
from a warning to an error after a few more releases and update the
tests. Does that sound reasonable, or do people still want to see more
architectural changes first?

-Alex
