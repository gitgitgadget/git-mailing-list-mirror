Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B541FC35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 07:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 808512077C
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 07:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJqnWhsw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgAYHFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 02:05:18 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:44601 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgAYHFS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 02:05:18 -0500
Received: by mail-wr1-f43.google.com with SMTP id q10so4735738wrm.11
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 23:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=VH/1hcwCMXtt5L4lbiur3ZxlMwNC/BhvfwYyByjN+E0=;
        b=IJqnWhswCahNkkEiAIbucmibYTNzOslzH72PLgEYtWsiafNCfgCifiNk2ckJXzGQtV
         o2nSzLE/9YEru27lrzZTroJNg9DE1uioYZ7G3AG9X094ub/pC/VbkJ0zxLi64HtHBU6X
         kObfcjXwHSkXQObNaegtFsuZc7s9zSrGfh+Tm1FXuL08fhpw1F05viIcrbSfrdeBiHPL
         jBLEF4dfIQdlwvLJ+JjjQ9hk6sXUbv0Ug5y22wFRbbaXoLmmEfktfDDv5ZB6tZMARChp
         m0cOF7kRzgVW7ZTS0IVPvriSakkisC8yglBqZx3oxwCtmll4qnm1bTGpvvEw5CQ6TeGa
         PVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=VH/1hcwCMXtt5L4lbiur3ZxlMwNC/BhvfwYyByjN+E0=;
        b=aIvCNjyCalBPfq9BtGgeCIktXutHHFmUkknBn1+oHx+xV7uPb5usbT875pquLwZkZa
         rwZru+R5XxNwAhOdwcLWd5HwFpYGaGHoV5pXTzi/H1BwCYVujuymaEAdDc+zOiGsntrP
         KuQW9SXbsoLkUvTdNzGNSs93XI/ro0l9ziZHpHJbh0718kCeYkJ8i8Yi1OICE6D/X/gX
         W2YCtTLYBSVCcFgNTTJB5dYqOxVwzA/IFnp/4SqpomDadZm6pnc+FJNlPn3GtsNHAAhT
         O34AaaJRnaWy2vRCWnvzI/k/sMyT5YTqWGVvzKVB6vFmTWwPr1YSCPPdKHbZBrD6AFpR
         Gk0Q==
X-Gm-Message-State: APjAAAV7OTNCFChud+Vr743A3tSYok/cYIX6UKcnvux8ybg/svLjaz4s
        gg/qXWBegZmMZx94A1XzxtQSLY5WWStNk3/Ss3i0BwVFPmo=
X-Google-Smtp-Source: APXvYqyu+HjbvH733wwIXVJ7aK3/bTzgt0r8uLiru9ZlOPT51l+kCh+rPx+K5JahO/m8yvERV1mrIU8rZbzqJbljmLg=
X-Received: by 2002:adf:ffc5:: with SMTP id x5mr9046270wrs.92.1579935916407;
 Fri, 24 Jan 2020 23:05:16 -0800 (PST)
MIME-Version: 1.0
From:   "/#!/JoePea" <trusktr@gmail.com>
Date:   Fri, 24 Jan 2020 23:04:40 -0800
Message-ID: <CAKU1PAUroy0_wa-7kBQ7vYHJB8GCK=Dm6w=8tk39r8_FWRb5rA@mail.gmail.com>
Subject: How about a `git submodule rm` command?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I stumbled on this: https://gist.github.com/myusuf3/7f645819ded92bda6677

It describes how to delete a submodule. Still, even `git rm
<submodule>` leaves stuff behind.

How about a `git submodule rm` command (or similar) that *removes
everything* and stages it? It would be the complete opposite of `git
submodule add`.

#!/JoePea
