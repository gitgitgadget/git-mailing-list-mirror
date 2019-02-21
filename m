Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0548B1F453
	for <e@80x24.org>; Thu, 21 Feb 2019 10:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbfBUKrk (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 05:47:40 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:39617 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfBUKrk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Feb 2019 05:47:40 -0500
Received: by mail-qt1-f177.google.com with SMTP id o6so30906216qtk.6
        for <git@vger.kernel.org>; Thu, 21 Feb 2019 02:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zafF0pAEBq5IMyIr49cWjT5K3CX/8DuBqCA0SfklMcM=;
        b=HU//Qnt3RP57f1U9TcSSNDq+mqVuQV4uB50CfHhCPQJ/kZUxn4lUyIwAiDoRr6YxQQ
         U8nYkCKziuWY06eq4W9SPKpZWOOrdyyjwABeedZ1hmKrFh4zEEQQqXD5J84zFBShcr16
         5RZMwCWc76fY78+xOvGrUN+m0JdsFxeTR4TYVFLtb2jWqbthCWK2qZKYomuj0chs6GNH
         Nw5v4lNNmjdK1lKgHq/xat4hj+UAhOx+BAtQztyKTDAAyn5iPQKrDWifrhCIT8/050dw
         Xw6P5DVmL625czIxPKFzKbYiaRiWXd5u1Qlv0E3dHpGHBBUbEg1LXVJOeY82IQo2hsl0
         MnvA==
X-Gm-Message-State: AHQUAuZGU7ejNxZXYgFiSu4bUFEaSHzObTOV1hlRN5IjOxpjHv9jv4cF
        DnfHzzyZXf4KD8G2YK+1MO2dtj/iNrgloy9VQgJwOEanhOfLUQ==
X-Google-Smtp-Source: AHgI3IZQZi2NwWq4v1MZGxV0Wf6cvFkuS4SmZqStuov+ZgHsqL1wp46I28bj7IUBGXY3IqBnBNzkuZDaZm9hPkqyHnw=
X-Received: by 2002:ac8:36b6:: with SMTP id a51mr14095425qtc.208.1550746059699;
 Thu, 21 Feb 2019 02:47:39 -0800 (PST)
MIME-Version: 1.0
From:   Bartosz Baranowski <bbaranow@redhat.com>
Date:   Thu, 21 Feb 2019 11:47:29 +0100
Message-ID: <CAEpy5fTnyPjH0sVyjnGHi1qxo+_dpaerxwaD7MmNPbmLx6qyJA@mail.gmail.com>
Subject: git bisect - good vs bad output is different.
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending how you end bisecting, result/report is either one liner or
dumps commit information:


$ git bisect bad
77c044d8d66f9f9bebdb805853409e920e537d59 is the first bad commit
commit 77c044d8d66f9f9bebdb805853409e920e537d59
Author: XXXX
Date:   Tue Jan 22 09:24:02 2019 -0500

   ISSUE-11626 Bad fish in the sea of comment

:040000 040000 ef2280aa5f7e0c23f8750c43a0bf05c0a9639fe3
f63bea979784cade7dffd653d939f665ff6a53b7 M      clustering
:040000 040000 6f4667c819106f6e9ddbb902253862212a2558f5
4d8c4dc85872c0665eb77957a6fd69c49c173188 M      triton
:040000 040000 0400075b3d5f7cb9e68683b25b8ede93fb1b293b
35ba4c831c4834f9ce612e394621dde382bc72f1 M      web-common

vs


git bisect good
3a9388eef42efc87c78ce22158d55e69a278b4eb is the first bad commit

git --version
git version 2.14.1
