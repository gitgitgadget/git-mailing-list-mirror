Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21E91FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932178AbdBPPOa (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 10:14:30 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33040 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754622AbdBPPO3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 10:14:29 -0500
Received: by mail-pg0-f65.google.com with SMTP id 5so2230941pgj.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gU2oK2qcn0aDx9PZafk4Bj+yvlT4sHsNrxhf8sgfkyk=;
        b=kmH+7vDwv745lm9MD1Cf9MDlrO1L1HYSa6xC8jtaEMkhb3uaiRaRhtA/WWfGMslWw3
         AjvLA4r9kjNdnjplZ0btWmoVpX62dKz3MnMwIZiLfW4CtWJzI88FzEjgmYGXjn5vXVtY
         00h1tY2jh/kwi7KYXcbSmkor8TjBDauBhccCB4K1SUjbelvNc2Cl/tUNGwYchsU/P+Ev
         0erwz6pk6k38CC4Wxof7BRzVkwsOuq+maqC5BslZxkU9yPFV+pwrqtj/fuN/NrCKsXZD
         apDyVeitUQZufYcSa68tboHne43zhqoB1hU8Ba2qD/iRe5vu9yYAoCfZPeyT3tvcskK0
         77CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gU2oK2qcn0aDx9PZafk4Bj+yvlT4sHsNrxhf8sgfkyk=;
        b=qPFMJvfoqkDLejNpllNMv81HBrtkGKzbiGnFMz7XTWjgSkCcfhG9je1umZKRJ4IRpv
         5bPcvQLqY98tPAyizxLoLpcrZ6lsKcDJTutt/JdPM5vdhV6DoNs5tx+RvyWKCyPyH/Ks
         MnZ+vddnCTUEIL6OhtTx0fj5kVwtskYToSQFnnEXHfCXHMYpYFrA/hQc2C0kRgTl8vm6
         PU2nos4/4e6t9SWlP8sc10IWsPpLDvlb4gY9xQ/ML2K+vv1hJhwa06uMx1izd+zJcOWz
         sgUY6lBsnztvPJoR6wIOtltUGqlSqbLkLvuoecBKeLQtgkou1mQgnFLAEQ4/8m+n5chI
         0GBg==
X-Gm-Message-State: AMke39mtJNQU1ja57yKuQ4gQU1Ee1PpBvR+U79UzpkcMHMDHloZIpsuzLp/btcMxK1BdmQ==
X-Received: by 10.99.48.68 with SMTP id w65mr3481054pgw.107.1487258068949;
        Thu, 16 Feb 2017 07:14:28 -0800 (PST)
Received: from localhost ([139.59.1.28])
        by smtp.gmail.com with ESMTPSA id e25sm14427447pfk.3.2017.02.16.07.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 07:14:28 -0800 (PST)
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx,
        Siddharth Kannan <kannan.siddharth12@gmail.com>
Subject: [PATCH 0/4 v4] WIP: allow "-" as a shorthand for "previous branch"
Date:   Thu, 16 Feb 2017 15:14:10 +0000
Message-Id: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is as per our discussion[1]. The patches and commit messages are based on
Junio's patches that were posted as a reply to
<20170212184132.12375-1-gitster@pobox.com>.

As per Matthieu's comments, I have updated the tests, but there is still one
thing that is not working: log -@{yesterday} or log -@{2.days.ago}

For the other kinds of suffixes, such as -^ or -~ or -~N, the suffix
information is first extracted and then, the function get_sha1_1 is called with
name="-^" and len=1 (which is the reason for the changed condition inside Patch
4 of this series).

For -@{yesterday} kind of queries, the functions dwim_log,
interpret_branch_name and interpret_nth_prior_checkout are called.

1. A nice way to solve this would be to extend the replacement of "-" with
"@{-1}" one step further. Using strbuf, instead of replacing the whole string
with "@{-1}" we would simply replace "-" with "@{-1}" expanding the string
appropriately. This will ensure that all the code is inside the function
get_sha1_1. The code to do this is in the cover section of the 4th patch in this
series.

2. we could go down the dwim_log codepath, and find another suitable place to
make the same "-" -> "@{-1}" replacement. In the time that I spent till now, it
seems that the suffix information (i.e.  @{yesterday} or @{2.days.ago}) is
extracted _after_ the branch information has been extracted, so I suspect that
we will have to keep that part intact even in this solution.  (I am not too
sure about this. If this is the preferred solution, then I will dig deeper and
find the right place as I did for the first part of this patch)

Matthieu: Thanks a lot for your comments on the tests! test_commit has made the
tests a lot cleaner!

[1]: <xmqqh941ippo.fsf@gitster.mtv.corp.google.com>

Siddharth Kannan (4):
  revision.c: do not update argv with unknown option
  revision.c: swap if/else blocks
  revision.c: args starting with "-" might be a revision
  sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"

 revision.c               |  15 ++++---
 sha1_name.c              |   5 +++
 t/t4214-log-shorthand.sh | 106 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 120 insertions(+), 6 deletions(-)
 create mode 100755 t/t4214-log-shorthand.sh

-- 
2.1.4

