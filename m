Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC54BC433ED
	for <git@archiver.kernel.org>; Tue,  4 May 2021 18:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88941610A1
	for <git@archiver.kernel.org>; Tue,  4 May 2021 18:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhEDScd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 14:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbhEDScb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 14:32:31 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B51C061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 11:31:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id zg3so14680492ejb.8
        for <git@vger.kernel.org>; Tue, 04 May 2021 11:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=o2QqSxBQGAgOIrKJjcg/MbbE6llpuKTb1CWo1xXafbw=;
        b=kYhf78AQupMBAen+ilmk9MebPmY4tMsDCsgbYwOzy1Sqvf00EZGsg6iab6n2pRFouP
         U6oQS4KJmun6DNkH3MmU7KORrIlfKCBcxolDo55ONw0iWR4/gY6D+sUubaL9cUrK0oZK
         l4t2dVV1KC0jLHFeFvuRqK9q7DcHDR+zjrcO+aMm08PGE0OA+wXXsJCDzC1g5IFvfxmv
         3Y0mvpwuBykdFnVt9xzrlZjRcW0jYBYZyAU8rBNmmBbMd31UzmNLHXC+k+LC2M9/xue9
         eTDG8QBve8IluZNSC2lX48g+lwiNJcz6O6FC7MhjJuSvMH1wFtOHKjUmOQvFKDMN7RV0
         K4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=o2QqSxBQGAgOIrKJjcg/MbbE6llpuKTb1CWo1xXafbw=;
        b=uk/8biJOUwewcn0mdOeTPYaYSud39iFxmAUiKqMiiUqz6fUhUilSoOAHTSC9Wi5aEP
         K+gIF7MGyZ6ub+m9W5snCfaXWkYWrHpkgAsL1v19rzJYSJTWazOxbeeFtlOP3i1wPmVF
         7PUcbqNZ5RM1vM+yQ0Hl5KK5kQ+PCsCL3RpEz+Hfz5krpmd+qJjM1sILMzekIgvyHYVY
         Hd/7Ob6tpEc2jmSV2YA1vl5MxRp3Jz81l7idGLnLcpCaMa6ZJt2FP891oZaHoxQsObYx
         wJ08q/uRHmwVZ8DFrY2myWJZ+VC893dW9hveEvcj9+W0eLFWrp7p1LfDAhsR6rL7bcys
         yzZA==
X-Gm-Message-State: AOAM530fbgRpUzxbxGnBeyNCXRNJp+XbrKGnACMYmdPRGWc+TAm47q1w
        9+uVA7hARXPf1By5N6mZcKHDX0knPTrOXvFOAkGJk4oPVCLUsw==
X-Google-Smtp-Source: ABdhPJzMaK8AFqNGKiQfqo9MwJURIv2yx+jLl93lR1PqdyzWk7Akh15rVtDm2aydOPEeG7STGqHXew5m7I95vz+0ADo=
X-Received: by 2002:a17:906:8285:: with SMTP id h5mr23096120ejx.456.1620153093699;
 Tue, 04 May 2021 11:31:33 -0700 (PDT)
MIME-Version: 1.0
From:   Cristiana Man <man.cristiana1@gmail.com>
Date:   Tue, 4 May 2021 20:31:22 +0200
Message-ID: <CAL2wJUAk50O-iSH9PEewYHwE9tV-TZZerqd1Eh9OTQfWBkmCgA@mail.gmail.com>
Subject: Git commit allow empty docs unclear
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

The documentation for Git commit --allow-empty option
(https://git-scm.com/docs/git-commit#Documentation/git-commit.txt---allow-empty)
contains the acronym SCM which is confusing to me.
Do you mean Software Configuration Management, Source Control
Management or Source Code Management?
Clarifications are appreciated!
--

Kind regards,
Cristiana Man
