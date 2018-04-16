Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF8ED1F424
	for <e@80x24.org>; Mon, 16 Apr 2018 09:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbeDPJjS (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 05:39:18 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58483 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753922AbeDPJjR (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Apr 2018 05:39:17 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 1488E20B5F;
        Mon, 16 Apr 2018 05:39:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 16 Apr 2018 05:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=S7t5Nu
        wV3D1qYOVyaVjHL9/W8+X318YEq/oiXw+I1Po=; b=bIuAZ7XZoMib1ZP1AuNqGV
        Jok5r77RTLONNRemzNpzlVS4RjLlpYvHPwPyW+/M1+uD9Cg9VpLEpRVIC3MAA81/
        o10UyI8yrmsvhJly4WTy3/AzUCHAut919L71qhjeevGT3ifZh/esye/q/yuueHez
        W4qNR9p/1Cu/X8WZZq/fi5kU50Yvmb2d/DZ3EqkmUE82c+Dhl8ox5lenn+K1BpAw
        m8pwL23tvjrnjFBBULOEdIZ/ioyn7AcIgMfve67l9NfgpTXpEtewKt/YHguXvyOe
        QQBs6IHgplfL3pUkeECKLyXnY3eZfG3GzLT+kBH3X+p14BdRm/QIaGODQe5RyyLA
        ==
X-ME-Sender: <xms:RG_UWhvWqTVOSvRbGH0HrHqEkuqAIv1hBz7hxlwLEGEz469Sn9Bvdw>
Received: from bod.fritz.box (p5482623f.dip0.t-ipconnect.de [84.130.98.63])
        by mail.messagingengine.com (Postfix) with ESMTPA id A3F75E4925;
        Mon, 16 Apr 2018 05:39:16 -0400 (EDT)
Received: by bod.fritz.box (Postfix, from userid 1000)
        id 6085E7C05C7; Mon, 16 Apr 2018 11:39:15 +0200 (CEST)
From:   Michael Vogt <mvo@ubuntu.com>
To:     git@vger.kernel.org, sbeller@google.com, avarab@gmail.com
Subject: [PATCH v2] show: add --follow-symlinks option for <rev>:<path>
Date:   Mon, 16 Apr 2018 11:36:24 +0200
Message-Id: <20180416093625.15752-1-mvo@ubuntu.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <87fu3yg6od.fsf@evledraar.gmail.com>
References: <87fu3yg6od.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Updated version of the `git show --follow-symlink` patch. This version
includes the feedback from Ævar Arnfjörð Bjarmason and Stefan Beller:

- commit message updated
- test fixes merged from Ævar (thanks!)
- Documentation/git-show.txt clarified

It does not include a test for --follow-symlinks in the dirlink case
when a file is behind a dirlink symlink. This this currently fails with
a non-descriptive error message. I hope to find time to improve this
error message at some point and then a test for this will be added.

It also does not include a test for a repo with symlinks when running
on a system without SYMLINKS. I don't have access to such a system,
sorry.



