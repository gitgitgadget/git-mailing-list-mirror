Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B8661F404
	for <e@80x24.org>; Tue,  6 Mar 2018 15:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbeCFPyf (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 10:54:35 -0500
Received: from forward102o.mail.yandex.net ([37.140.190.182]:50372 "EHLO
        forward102o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750797AbeCFPye (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Mar 2018 10:54:34 -0500
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Mar 2018 10:54:34 EST
Received: from mxback5o.mail.yandex.net (mxback5o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1f])
        by forward102o.mail.yandex.net (Yandex) with ESMTP id 41A705A0599D
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 18:46:39 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback5o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id NJXgl3Y2Sh-kc2qTm8c;
        Tue, 06 Mar 2018 18:46:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1520351198;
        bh=odZB9tZp60VUIhq7UB58XWFKp0EzdLlchRgyJdhoKhQ=;
        h=From:To:Subject:Message-Id:Date;
        b=eOuUC/y5NAPol/BgGr6dWtDPuQTns29x+3nQkzAldm4aFPErQP1R3/ON0K4FfCicQ
         zqZhOTh5TpLLYSYEjVbGpyKvcb5rACXkoAqDGybas+EWgEpihgo5hRiY6UX0a+Pj10
         SWIToOQ+WPpSV1+2cdhX440Hd+Ynqjp6D1pFFkHw=
Authentication-Results: mxback5o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web40j.yandex.ru with HTTP;
        Tue, 06 Mar 2018 18:46:38 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     git <git@vger.kernel.org>
Subject: Improve `git log -L` functionality
MIME-Version: 1.0
Message-Id: <2051651520351198@web40j.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 06 Mar 2018 17:46:38 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.
 I want to `Trace the evolution of the line range`. 
And not committed change is sort of evolution and should be taken into account by -L option. 

Currently I MUST `stash save` change, 
look actual line number, 
trace evolution, 
`stash pop` to bring back current change. 

EXPECTED:
Allow to use those line numbers which I see in my editor
without excess `stash save/stash pop` commands

If file has not committed change then this change maybe shown by `-L` as commit NOT COMMITTED YET
If file staged 'commit STAGED'

More description what is comming on:
https://stackoverflow.com/q/49130112/4632019
