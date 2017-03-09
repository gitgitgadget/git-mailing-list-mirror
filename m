Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CAB520135
	for <e@80x24.org>; Thu,  9 Mar 2017 00:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbdCIAJn (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 19:09:43 -0500
Received: from forward11j.cmail.yandex.net ([5.255.227.175]:41033 "EHLO
        forward11j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753913AbdCIAHw (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 19:07:52 -0500
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [77.88.29.86])
        by forward11j.cmail.yandex.net (Yandex) with ESMTP id 021A221042;
        Thu,  9 Mar 2017 03:04:05 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtp3p.mail.yandex.net (Yandex) with ESMTP id AE5F41320062;
        Thu,  9 Mar 2017 03:04:02 +0300 (MSK)
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id w4bRePZkSb-41TWfD43;
        Thu, 09 Mar 2017 03:04:01 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtolstov.org; s=mail; t=1489017841;
        bh=yr9RL7rEtgw47vOqMpqlUSTAKmEU9u3GCtUyfAfjOcE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=kz7Wz69f+/cNgB+x8ZnLPGGQ/xMF66TfdFDtMZHaznoGITvz6WPr1syqL5T8324YF
         Zp2ZbFR6ejKeDSZENxHQFdeoHFtUiD1q5Ody4MQL4m+TnxAX+HOzeXDtmKBERGc7L1
         AJXdVRw0DcpAEXGexJ3wnHyPI4pyzyTgPmVvnCkk=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@vtolstov.org
X-Yandex-ForeignMX:  US
X-Yandex-Suid-Status: 1 0,1 0,1 1130000030716801,1 0
From:   Valery Tolstov <me@vtolstov.org>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, me@vtolstov.org, gitster@pobox.com
Subject: [PATCH v2 0/2] Remove duplicate code from module_clone()
Date:   Thu,  9 Mar 2017 03:03:50 +0300
Message-Id: <20170309000352.18330-1-me@vtolstov.org>
X-Mailer: git-send-email 2.12.0.192.gbdb9d28a5
In-Reply-To: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
References: <CAGZ79kbnpUtrKdjQdQ-r6rRuVvnawooLFk1bO8jOSgxNkx2Dbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Then the next step (as outlined by Documentation/SubmittingPatches)
> is to figure out how to best present this to the mailing list; I think the best
> way is to send out a patch series consisting of both of these 2 patches,
> the "connect_work_tree_and_git_dir: safely create leading directories,"
> first and then your deduplication patch.

Combined two patches

Stefan Beller (1):
  connect_work_tree_and_git_dir: safely create leading directories

Valery Tolstov (1):
  submodule--helper.c: remove duplicate code

 builtin/submodule--helper.c | 20 ++------------------
 dir.c                       | 32 +++++++++++++++++++++-----------
 submodule.c                 | 11 ++---------
 3 files changed, 25 insertions(+), 38 deletions(-)

-- 
2.12.0.192.gbdb9d28a5

