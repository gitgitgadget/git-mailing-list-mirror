Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A6EEE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 11:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjHVLst (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Aug 2023 07:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235341AbjHVLss (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Aug 2023 07:48:48 -0400
X-Greylist: delayed 941 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Aug 2023 04:48:22 PDT
Received: from silly.haxx.se (silly.haxx.se [IPv6:2a02:750:7:3305::2aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C98E4E
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 04:48:21 -0700 (PDT)
Received: by silly.haxx.se (Postfix, from userid 1001)
        id 7A3C164980; Tue, 22 Aug 2023 13:32:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by silly.haxx.se (Postfix) with ESMTP id 79804809F9
        for <git@vger.kernel.org>; Tue, 22 Aug 2023 13:32:09 +0200 (CEST)
Date:   Tue, 22 Aug 2023 13:32:09 +0200 (CEST)
From:   Daniel Stenberg <daniel@haxx.se>
To:     git@vger.kernel.org
Subject: FYI: git issues with libcurl 8.0/1 HTTPS push
Message-ID: <qq3252n1-o71-n1r7-281p-npqo6rs5o50@unkk.fr>
X-fromdanielhimself: yes
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello friends.

If you use git with libcurl 8.0.x or 8.1.x, there is a risk that you will 
experience a "curl 56 HTTP/2 stream N was reset" errors when pushing over 
HTTPS. (where N is an odd number, often 7)

This is an unfortunate bug in libcurl that has subsequently already been 
fixed. We recommend using libcurl 8.2.1 (or later).

You can work around this issue (that tends to be sticky) by forcing git to use 
HTTP/1.1 instead of HTTP/2 for the push and then restore back to the previous 
state again.

This bug was filed and has been discussed in this curl issue:

   https://github.com/curl/curl/issues/11353

I'm sorry for this incovenience.

-- 

  / daniel.haxx.se
