Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8949E1F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 09:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756790AbcH2JSH (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 05:18:07 -0400
Received: from forward19m.cmail.yandex.net ([5.255.216.150]:60192 "EHLO
        forward19m.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756740AbcH2JSG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 29 Aug 2016 05:18:06 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Aug 2016 05:18:06 EDT
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [5.45.198.17])
        by forward19m.cmail.yandex.net (Yandex) with ESMTP id 753D820FD8
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 12:11:02 +0300 (MSK)
Received: from web6j.yandex.ru (web6j.yandex.ru [5.45.198.47])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id hc9YWL2VIv-B2be7D3d;
        Mon, 29 Aug 2016 12:11:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1472461862;
        bh=8Z6CoqIfChQs/SFy9cwkY08uWTwAF3/1C1HnkCQH0Ac=;
        h=From:To:Subject:Message-Id:Date;
        b=IbnrchVZPOHGAbqW8pHAaw5zikwsBei/grpAZUoDI9YdjsxUIkKe9Ghre96x9xmcR
         JrkSuZQeJCEZ/unpLqwHwCaULIe456XeeHsGzbOkbnfs1D+EHNtaCh1LKSSySQhq3F
         AWc2xh7bkVNC65MBWe8s5SBrM/hfq0NZgOZPnl+U=
Authentication-Results: mxback3j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web6j.yandex.ru with HTTP;
        Mon, 29 Aug 2016 12:11:02 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.ua
To:     git <git@vger.kernel.org>
Subject: improve status message
MIME-Version: 1.0
Message-Id: <276561472461862@web6j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Mon, 29 Aug 2016 12:11:02 +0300
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

When we do git pull -v --rebase

We got this:
remote: Counting objects: 7, done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 7 (delta 5), reused 0 (delta 0)
Unpacking objects: 100% (7/7), done.
From ssh://slab/alexclear/ontico
   2b541e2..2c17d76  master     -> origin/master
Changes from 2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7 to 2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08:
 xxxxx | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)
First, rewinding head to replay your work on top of it...


That will be better if this
2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7 to 2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08
will be replaced by this
2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7..2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08

This will allow us to copy/paste this string into 'diff' command
git diff 2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7..2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08

In compare to first version it give error:
git diff 2b541e2bbd23ab5c375c4ce1e0fae5255470a5e7 to 2c17d767934f7f6784d2e0411c7a3a9bfc9c4d08
fatal: ambiguous argument 'to': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'

Thank you.
