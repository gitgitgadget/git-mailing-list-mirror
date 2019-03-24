Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F10320248
	for <e@80x24.org>; Sat, 23 Mar 2019 23:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfCWXBE (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 19:01:04 -0400
Received: from gateway.webhosting.coop ([216.55.137.74]:33078 "EHLO
        gateway.webhosting.coop" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfCWXBE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 19:01:04 -0400
X-Greylist: delayed 2743 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Mar 2019 19:01:04 EDT
Received: from [199.241.219.43] (port=52012 helo=jaguar.webhosting.coop)
        by gateway.webhosting.coop with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <klaatu@member.fsf.org>)
        id 1h7ov9-00025F-0a
        for git@vger.kernel.org; Sat, 23 Mar 2019 17:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mixedsignals.ml; s=default; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U5ke5SGeL1Ju3H7ytN0HRtNgWeWZotgWeVXzuDt2qDs=; b=ZaPRHry0zmj/M4Ln/RnV/ozpkN
        y0dDdqTZW8yj+0e2UkwVbL3N9akD90AYm77FgiGA94L9rnpdMyLL2bSkj1JMVP3aYQpq+O8yHN+6r
        txAOk15tmr2OgjcmjjJj8XmtKz5TPfDG6EKyuM4EcOdZ+59RQlVRVeWCXY3gOWHFkcHfcxwgSDHJP
        3e3mHKb3fNAtex4V6ovhf9G/Qm99shRQ8iuuz16k2JbjXF/eomTypScoGyCs5chK66qxf619ackZ0
        icBV+JygdjQFHww2OoSMBeothJmuYDNpfDFeK4r0mJVj066JGN4mtQBmKYZ+BiuMl3z2djefyjLqY
        36Op1Kng==;
Received: from [121.99.198.120] (port=34268 helo=beast.localnet)
        by jaguar.webhosting.coop with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <klaatu@member.fsf.org>)
        id 1h7ovB-0005qt-4N
        for git@vger.kernel.org; Sat, 23 Mar 2019 17:15:21 -0500
From:   Klaatu <klaatu@member.fsf.org>
To:     git@vger.kernel.org
Subject: Git excludes fails to avoid git submodule warning
Date:   Sun, 24 Mar 2019 11:15:29 -0700
Message-ID: <5352115.zUM9HkL6VV@beast>
Organization: Slackermedia
User-Agent: KMail/4.14.10 (Linux/4.4.157; KDE/4.14.32; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - jaguar.webhosting.coop
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - member.fsf.org
X-Get-Message-Sender-Via: jaguar.webhosting.coop: authenticated_id: klaatu@mixedsignals.ml
X-Authenticated-Sender: jaguar.webhosting.coop: klaatu@mixedsignals.ml
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gateway.webhosting.coop
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - member.fsf.org
X-Get-Message-Sender-Via: gateway.webhosting.coop: acl_c_recent_authed_mail_ips_text_entry: klaatu@member.fsf.org|member.fsf.org
X-Authenticated-Sender: gateway.webhosting.coop: klaatu@member.fsf.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Working with Git 2.21.0 on Linux:

The git-add(1) man page says:

"The optional configuration variable core.excludesFile indicates a path to a 
file containing patterns of file names to exclude from git-add"

But if I do this:

$ echo "docs/themes/*/.git >> .gitexcludes
$ git config core.excludeFiles .gitexcludes
$ git add docs
 warning: adding embedded git repository: docs/themes/foo

It seems to me that this goes against what the git-add(1) man page says.

A workaround I found on stackoverflow is to add any file within the target 
directory:

$ git add docs/themes/foo/README

And then add everything:

$ git add docs

In which case the contents of .gitexcludes is honoured. But that seems like a 
hack.

Am I experiencing the intended result of Git's exclude function? If so, I'll 
happily submit a patch to the man page to clarify this behaviour. If not, I 
guess I'm submitting a bug report here.

Thanks for all the amazing work.

Cheers.

 
