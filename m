Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F68C2BA16
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 06:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E562051A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 06:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RtViX8FU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgDGGCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:02:50 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:44109 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgDGGCt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 02:02:49 -0400
Received: by mail-il1-f179.google.com with SMTP id j69so2014757ila.11
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 23:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Z2WU3vplC0KSHI20pKtV4oscmYJZcQwpK/ePoq+cpnM=;
        b=RtViX8FUOudLaHpogdntvnn4LpGq3N0/Np5U5f6g80JTBszCCIuDIxhJOSotwN/xUY
         imulkIXXf03lnRda/hgQbA2hQUuMkU8q7szTi4g0py4qk5kGnl7bezCPuoxArCRQJM8U
         FLqFywlPnYb00kzx4BfSX03SH4TEmRL67LQK+n73RQcCe4dXcTxFi5/8xi6pLjheWcqa
         J5Wd2eDMoUnD0ACpOD1c9TZfZ5xNg7uDJETx44KK+xtCWhW7Ow4egJIXs6+2GoosUs0M
         U9FLmTSWKMqofhknwnmgV3m0afSk41/GIPmf/xCSq6m/qS1KKkjp7Wvn/vZ1XyN67phP
         fWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Z2WU3vplC0KSHI20pKtV4oscmYJZcQwpK/ePoq+cpnM=;
        b=SC2NEsEdvhupMd2MhgMfRBU6sWPZBKGn/adMHHjiqBMvJ+F8PJvuCMMvKJhGMgwyhR
         A5FW2AvgSbS+tnPBrnEf6WLmn+1njXx8H5IMCDj8lMJ8bd37kw5yZrr1lqiSUloK8Yd2
         thcXQc30Wp+ePsOeidZfTvRZv4PErdOniFjjDzQ2hL0SaM/ZVnASLahwRbDf+dfB1MeE
         A/kgGN/qSXHfH+Ied6PuApIL6boYuJ/ROPw8SnooAxlfI5HYkKyR/M++lVN9cTm1+P9Q
         u4hbgUU07yPKAJjl2OSTJ+eWzvlgqQFKa/XfV6tbgw299A8Dp/cPY1JvKYhp9xn/F36B
         5s+Q==
X-Gm-Message-State: AGi0Pub5ohetvrQ6YsRxq2eYfRkI2zoERfTijF53oWMGeQVZjsm+VOHu
        /S9EsDjnBQ6CHFMILRqaH3IP9lbVcgq890XSjBVImvh9Bdg=
X-Google-Smtp-Source: APiQypKAwa3f9ZsGYhj58Ym6r8JbVKSW087DjxWF0tF32dTGuTrlUsfnRwwEOQhBskEuX2EJz3VZw6rYZLa6V3BPUYA=
X-Received: by 2002:a92:90c:: with SMTP id y12mr776383ilg.212.1586239368879;
 Mon, 06 Apr 2020 23:02:48 -0700 (PDT)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Tue, 7 Apr 2020 02:02:38 -0400
Message-ID: <CAH8yC8nzc6My_DyTJ1vyZ4zvsOiSegM01p1xsS_bABc70=SPCg@mail.gmail.com>
Subject: git cp command?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a large source file and I want to split it into two pieces. I
want to preserve the history so someone can start at either of the
copies and work back to the original file.

I see folks talking about a "git copy" at
https://stackoverflow.com/a/44036771, but I am not really following
what is happening with moves and merges and the other extra commands.

Can someone please provide the commands to copy the file using Git.

Thanks in advance.
