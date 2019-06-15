Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C39C01F462
	for <e@80x24.org>; Sat, 15 Jun 2019 02:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbfFOCLF (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 22:11:05 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:34051 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbfFOCLF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Jun 2019 22:11:05 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 22:11:05 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E5AB11DA1
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 22:01:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 14 Jun 2019 22:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
        to:from:subject:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=fm3; bh=sTqmtga3EI2t7FXz8aqKfLd0tO
        WN4xHuLM4A6JJKeCM=; b=fiXSf7+3hfFksaczBsAHXuqYN6HaX+pNebRMTppfhE
        a07J4/NHTcNCPMWd4c3wazLXXRH68NjQQmXlCBubgiLUOUpD/hW+B/O5PW/mlLDY
        EMvaSUm3IlxP19LgJH4/ml5YP5Y2CiQWtQrAbICYm5csk/18iJjdg5XKqn7UxMHo
        NgkUwtaAHqMDeqkR0FD2CDfFUhij5jb960i2ozYKHFSn7PpgIqITjiDozG+U/TAY
        nPH+AXjBtIR2Bk2KBa12TlfD/sQQdwbz3UNhYoD01ciCmICdn/fckTYu+qP+Qkoy
        SYVxK1EOIf5ngfFIWj6F0hlr3MdbJkVRaUehoos3ybfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sTqmtg
        a3EI2t7FXz8aqKfLd0tOWN4xHuLM4A6JJKeCM=; b=JPJe1CCEfgaTcll0U3x2WW
        Doji7gj9sbGqj7DM1g0wX85/yKt7lNema1kTg+vPe7iTzPdJlLp8WMpDVLzcC/tB
        Rekg6CxUf3eVaY3Ry9qB7qN2G37i7RkAYzMc63EAJwuRbrW1CL4vGFAeWDEeyhSa
        sx+QXQD+HxzcnGpWEK+HGelRy4Mp2ULo3vwTuWjqhMHbGTgKqtBHdeE57o9/sTIw
        Mm5Q5Lo+B+bjHDaaMy0MYXXEkh3AgvIdak9zz99KaMN0xoYDCrVPzjJVssHfz4B0
        WhLTGElcDb/DXgcmOaIg4Tx7mZ/EL/NFx8+CXiACirLy+p7domHokID2VDIJXxUQ
        ==
X-ME-Sender: <xms:ZFEEXRGQ98hgS8-G5MSi02xv99bJo0FY4yw7YJ0DWo2SxwCjDMZpEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudeivddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefvhffukffffgggtgfgsehtjeertd
    dtfeejnecuhfhrohhmpefurghmuceurgiilhgvhicuoehsrghmsggriihlvgihsehfrghs
    thhmrghilhdrtghomheqnecukfhppeekiedriedrleehrddvfeegnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehsrghmsggriihlvgihsehfrghsthhmrghilhdrtghomhenucevlhhu
    shhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:ZFEEXWK6uy6DdZ1NPifq6omE1v5V0jmvaWgBEHHtOa8K7pUVBGPnrQ>
    <xmx:ZFEEXVvv7OquXFNEPeMAGAMO6zfPyUacDwRdTrrZASStvM6VxUTjAQ>
    <xmx:ZFEEXToE2t6s3ircnfEAyEeT4sxM5cylxBo96VTv9aTN5PFJuqxQSA>
    <xmx:ZFEEXTdfnu9hC6v6HMf4m4XPA4-LFgJk9ewgxLQPDVHNUKDGouMWQvrZYwE>
Received: from [192.168.0.32] (cpc88606-newt36-2-0-cust1001.19-3.cable.virginm.net [86.6.95.234])
        by mail.messagingengine.com (Postfix) with ESMTPA id 27ED5380084
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 22:01:08 -0400 (EDT)
To:     git@vger.kernel.org
From:   Sam Bazley <sambazley@fastmail.com>
Subject: rev-parse --is-bare-repository incorrect when work tree is set
Message-ID: <8ac7a1d8-9185-b527-67f4-d5e25cb3eaf5@fastmail.com>
Date:   Sat, 15 Jun 2019 02:59:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rev-parse --is-bare-repository incorrectly outputs "false" when testing
a bare repository with the work tree set.

To reproduce:

$ git init --bare testbare
$ git --git-dir=testbare rev-parse --is-bare-repository
true
$ git --git-dir=testbare --work-tree=something rev-parse \
--is-bare-repository
false
$ GIT_WORK_TREE=something git --git-dir=testbare rev-parse \
--is-bare-repository
false
