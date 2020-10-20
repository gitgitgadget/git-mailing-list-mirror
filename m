Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C342EC433E7
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294FE2173E
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 01:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sfconservancy.org header.i=@sfconservancy.org header.b="QVP04jji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389698AbgJTBGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 21:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgJTBGS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 21:06:18 -0400
Received: from pine.sfconservancy.org (pine.sfconservancy.org [IPv6:2001:4801:7822:103:be76:4eff:fe10:7c55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90753C0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 18:06:18 -0700 (PDT)
Received: from localhost (unknown [216.161.86.18])
        (Authenticated sender: bkuhn)
        by pine.sfconservancy.org (Postfix) with ESMTPSA id EEF54E384;
        Tue, 20 Oct 2020 01:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sfconservancy.org;
        s=pine; t=1603155977;
        bh=yEQhCobb3Of2OOd/NNfolSeuvSOk4TNM+3w4pVHG218=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QVP04jjicLtbOoH+KrcYF4z+P5IB3/+NJ26DR0GdfXpOy7xCg0ZNnin1RfDgYxxtS
         y40U1jwEV0N07nhIDhuScjs5zCOk5Zk71F8UavuMOlMyWoipZ878av4vtPo5wVNbUI
         DlEoSp27AeUe2LcEN/9GPZzeWr7kWr4TbkeIl1HaJ+ax/M4it1s/nmDtAp0201QB1L
         DyUp4KCWk5rvmP8vB7YohuN1komYPlWQRuV/tlUa9ZTmHp0WX/EhJquMzOZbHSg+xW
         EMs2K7SqfnAZ+BFC3KE9MJrkFSnWrZpZN/km/KYUsqQ4maTpAjJX1T8+OTmBwxxhSU
         YWR/+WuxFvRYQ==
From:   "Bradley M. Kuhn" <bkuhn@sfconservancy.org>
To:     git@vger.kernel.org
Subject: [PATCH v3 0/4] clarify meaning of --signoff & related doc improvements in describing Signed-off-by
Date:   Mon, 19 Oct 2020 18:03:51 -0700
Message-Id: <cover.1603155607.git.bkuhn@sfconservancy.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com>
References: <xmqqy2k1dfoh.fsf@gitster.c.googlers.com> <20201018233136.GA4204@nand.local> <20201018194912.2716372-1-gitster@pobox.com> <xmqqmu0it6ls.fsf@gitster.c.googlers.com> <cover.1603142543.git.bkuhn@sfconservancy.org> <37a4932d48c1d36c3c512e9f8c0bcac878de6b76.1603142543.git.bkuhn@sfconservancy.org> <20201019220214.GB49623@nand.local>
MIME-Version: 1.0
Organization: Software Freedom Conservancy, Inc.
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[ Note that there were competing v2's of this patch series, one from me and
  one from Junio.  Sorry about that; I had missed Junio's from Sunday. ]

I believe this patch series now addresses all the issues raised in the
discussion.

  * [1/4] is unchanged from Junio's v2 and is the preparatory cleanup.

  * [2/4] remains unchanged textually since I originally posted it and Pfeff
    signed off.

  * [3/4] is unchanged from Junio's v2 and is his clarification for what
     Git's --signoff means.
     
  * [4/4] is a rework of a patch from *my* v2.  It takes into account Junio's
    comments about preferring the word "trailer" and leaving off the ':'
    whenever possible when discussing Signed-off-by.

For reference:

        v1: https://lore.kernel.org/git/20201015215933.96425-1-bkuhn@sfconservancy.org/
Junio's v2: https://lore.kernel.org/git/20201018194912.2716372-1-gitster@pobox.com/
     my v2: https://lore.kernel.org/git/cover.1603142543.git.bkuhn@sfconservancy.org/

Bradley M. Kuhn (2):
  Documentation: clarify and expand description of --signoff
  Documentation: stylistically normalize references to Signed-off-by:

Junio C Hamano (2):
  doc: preparatory clean-up of description on the sign-off option
  SubmittingPatches: clarify DCO is our --signoff rule

 Documentation/MyFirstContribution.txt |  2 +-
 Documentation/SubmittingPatches       | 35 +++++++++++++++------------
 Documentation/config/format.txt       |  2 +-
 Documentation/git-am.txt              |  2 +-
 Documentation/git-cherry-pick.txt     |  2 +-
 Documentation/git-commit.txt          | 10 ++------
 Documentation/git-format-patch.txt    |  2 +-
 Documentation/git-rebase.txt          |  2 +-
 Documentation/git-revert.txt          |  2 +-
 Documentation/git-send-email.txt      |  4 +--
 Documentation/git-svn.txt             |  4 +--
 Documentation/githooks.txt            |  2 +-
 Documentation/merge-options.txt       | 11 +--------
 Documentation/signoff-option.txt      | 18 ++++++++++++++
 builtin/am.c                          |  2 +-
 builtin/commit.c                      |  2 +-
 builtin/log.c                         |  2 +-
 builtin/merge.c                       |  2 +-
 builtin/pull.c                        |  2 +-
 builtin/rebase.c                      |  2 +-
 builtin/revert.c                      |  2 +-
 commit.c                              |  2 +-
 22 files changed, 60 insertions(+), 54 deletions(-)
 create mode 100644 Documentation/signoff-option.txt

-- 
Bradley M. Kuhn - he/him
Policy Fellow & Hacker-in-Residence at Software Freedom Conservancy
========================================================================
Become a Conservancy Supporter today: https://sfconservancy.org/supporter

