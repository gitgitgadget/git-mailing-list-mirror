Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6419C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 11:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B748207FF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHRLv4 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 18 Aug 2020 07:51:56 -0400
Received: from co02.mbox.net ([165.212.64.32]:49106 "EHLO co02.mbox.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgHRLvz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 07:51:55 -0400
X-Greylist: delayed 331 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Aug 2020 07:51:55 EDT
Received: from co02.mbox.net (localhost [127.0.0.1])
        by co02.mbox.net (Postfix) with ESMTP id 4BW8JJ4JDczKSM2
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 11:46:24 +0000 (UTC)
X-USANET-Received: from co02.mbox.net [127.0.0.1] by co02.mbox.net via mtad (C8.MAIN.4.17E) 
        with ESMTP id 154yHRLUV8832M02; Tue, 18 Aug 2020 11:46:21 -0000
X-USANET-Routed: 3 gwsout-vs Q:cmvirus
X-USANET-Routed: 3 gwsout-vs Q:cmvirus
X-USANET-GWS2-Tenant: usa.net
X-USANET-GWS2-Tagid: UNKN
Received: from ca32.cms.usa.net [165.212.11.132] by co02.mbox.net via smtad (C8.MAIN.4.26V) 
        with ESMTP id XID161yHRLUV4262X02; Tue, 18 Aug 2020 11:46:21 -0000
X-USANET-Source: 165.212.11.132  OUT  ianworthington@usa.net ca32.cms.usa.net CLR
X-USANET-MsgId: XID161yHRLUV4262X02
Received: from web13.cms.usa.net [165.212.8.213] by ca32.cms.usa.net
        (ESMTP/ianworthington@usa.net) via mtad (C8.MAIN.4.26U) 
        with ESMTP id 201yHRLUV5424M32; Tue, 18 Aug 2020 11:46:21 -0000
X-USANET-Auth: 165.212.8.213   AUTO ianworthington@usa.net web13.cms.usa.net CLR
Received: from 171.33.234.191 [171.33.234.191] by web13.cms.usa.net 
        (USANET web-mailer C8.MAIN.4.29K); Tue, 18 Aug 2020 11:46:21 -0000
Date:   Tue, 18 Aug 2020 12:46:21 +0100
From:   "Ian S. Worthington" <ianworthington@usa.net>
To:     <git@vger.kernel.org>
Subject: Problems with FTP PUSH
X-Mailer: USANET web-mailer (C8.MAIN.4.29K)
Mime-Version: 1.0
Message-ID: <196yHRLtV8416Set.1597751181@web13.cms.usa.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Z-USANET-MsgId: XID201yHRLUV5424X32
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi guys -- 

I have a server without https and so I'm trying to establish if I can host a
repository there using ftp.  The manuals suggest that I can, but when I try: 

>git push -v ftp://user:pw@host//u/path/repos/test/.git/ 
Pushing to ftp://user:pw@host//u/path/repos/test/.git/ 
fatal: unable to access 'ftp://host//u/path/repos/test/.git/': RETR response:
550 

Looking at it with wireshark, I can see the SIZE and the RETR of
.../test/.git/info/refs reports the file does not exist, which is correct and,
as far as I can see, normal(?), but that the RETR failure terminates the push:


<image deleted> 

Have I made an error in the setup of my repos, or some other foolish mistake?



Best wishes, 

i 
... 

Ian S Worthington 

