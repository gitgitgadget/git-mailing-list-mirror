Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1454F1F62D
	for <e@80x24.org>; Sun,  8 Jul 2018 18:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932823AbeGHSvW (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 14:51:22 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:48709 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932730AbeGHSvU (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 8 Jul 2018 14:51:20 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D59BF262;
        Sun,  8 Jul 2018 14:41:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sun, 08 Jul 2018 14:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=living180.net;
         h=cc:date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=vz0g7Zr1nWinzKuSRUJyEXHJ27huhQooqIoC4F1b4
        uM=; b=XpELipmyZ7RdyfgRfFjvtB2KlSOycWaDZcXM6AnstnQ92GAz4lt7GGsSR
        bAltCJ2/P6hjAd01yA2z/o+vpxk86VBctmxQwn1RVNy8D2M/+QqkSy2Dx19AsQGB
        0Wco8/W8Do0PUhht/nLI0/dBds7APOLyyFFSE5+GSewC5UhUkz+zi2WO8NpeC0nf
        cwZzKZMT6w4yJ5QrcjHRAZE7k76wZ2Ll30kZ768wKGiHGhLbgdpPDzL/e0+8kYxv
        F9ObJDAw3nCdUK0NT82OGVIzNzh6lZApvgyJ3gVXzn+1ieUqMyg8WIfyAwu/EXv0
        EZ2x+VojN/LAjOm0NO+W2b4FKEI8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=vz0g7Zr1nWinzKuSR
        UJyEXHJ27huhQooqIoC4F1b4uM=; b=bQeaG75RvSHjzjvCXujxEFM4uX6TFDwfs
        xH3RLwq9VAzNUx3p/gGEv2g/5smsGwYJlY3BskEfmT6B3yVoGQxfoT4giD1E8b81
        uFRu0RhX4ouxciL4szthgnVtmDbBT8dvEIrR8G0xyNB7iIhUOowedz9OC/xyAuQY
        /VgK00SsjZbmSoKy2YUpyAyw3fNJQ9jmCqpINyhClcJj4Y8Opvpz6v6AR5t0hBRn
        ES1XiMpIwlIKG9Ns60P4DhvtQQr+Jxp4D25QvJ3uoMweJ2ZutXeRed5DQHgjoTBS
        p0XAM61eAV+6aZO/OjY80r0bWe9KirWv+zYGoPucdD83H4meBSArA==
X-ME-Proxy: <xmx:6VpCW1jm6cdrSaxmnU98Ttl8f3OzXXtb2KW8MUnpehOzrta2rqQqbA>
    <xmx:6VpCW61Hxt9hRP1axd_RG4CgWwEmE_rRQP2Xn3JtD1P_GbzWy2GZ2A>
    <xmx:6VpCWzozliszjLef60Zy7INkuANcfTiKbcqHQj3mxNx3W8HsWTCkgw>
    <xmx:6VpCWwEY-3duoXxQsnezUkdZvXjHED81sts8kI3zrpWZnqDmPAsK6g>
    <xmx:6VpCW97_mrmr1y_pz1t0ropeYh_WcyJTOiyM1p0gFdGu7Gb6KOQ1_Q>
    <xmx:6VpCWzYpSh5_dFBKWeTrK21Cs_fjM631XWMHn88fjVo8ekOorD4ZWA>
X-ME-Sender: <xms:6VpCW-sb1oP3J7YNLZXSEohN9QDz9xIQ0te6qI6Yn8OnnGOQ5v3lnA>
Received: from localhost (unknown [46.185.196.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 217CF10268;
        Sun,  8 Jul 2018 14:41:43 -0400 (EDT)
From:   Daniel Harding <dharding@living180.net>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 0/2] Fix --rebase-merges with custom commentChar
Date:   Sun,  8 Jul 2018 21:41:08 +0300
Message-Id: <20180708184110.14792-1-dharding@living180.net>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have core.commentChar set in my .gitconfig, and when I tried to run
git rebase -i -r, I received an error message like the following:

error: invalid line 3: # Branch <name>

To fix this, I updated sequencer.c to use the configured commentChar
for the Branch <name> comments.  I also tweaked the tests in t3430 to
verify todo list generation with a custom commentChar.  I'm not sure
if I took the right approach with that, or if it would be better to
add additional tests for that case, so feel free to
tweak/replace/ignore the second commit as appropriate.

Thanks,

Daniel Harding


