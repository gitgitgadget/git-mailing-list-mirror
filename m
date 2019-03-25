Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1375E20248
	for <e@80x24.org>; Mon, 25 Mar 2019 23:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfCYXW1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 19:22:27 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:40498 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfCYXW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 19:22:27 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1h8Yv9-0008Ny-RZ
        for git@vger.kernel.org; Tue, 26 Mar 2019 08:22:23 +0900
Date:   Tue, 26 Mar 2019 08:22:23 +0900
From:   Mike Hommey <mh@glandium.org>
To:     git@vger.kernel.org
Subject: Auto-gc in the background can take a long time to be put in the
 background
Message-ID: <20190325232223.r72qtffyzn5qzoxc@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Recently, I've noticed that whenever the auto-gc message shows up about
being spawned in the background, it still takes a while for git to
return to the shell.

I've finally looked at what it was stuck on, and it's 
`git reflog expire --all` taking more than 30s. I guess the question is
whether there's a reason this shouldn't run in the background? Another
is whether there's something that makes this slower than it should be.

Mike
