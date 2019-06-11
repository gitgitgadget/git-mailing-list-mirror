Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 116611F462
	for <e@80x24.org>; Tue, 11 Jun 2019 12:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389321AbfFKM7l (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jun 2019 08:59:41 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39477 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389096AbfFKM7l (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Jun 2019 08:59:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C304C220B5
        for <git@vger.kernel.org>; Tue, 11 Jun 2019 08:59:37 -0400 (EDT)
Received: from imap36 ([10.202.2.86])
  by compute1.internal (MEProxy); Tue, 11 Jun 2019 08:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inspired.no; h=
        mime-version:message-id:date:from:to:subject:content-type
        :content-transfer-encoding; s=mesmtp; bh=HV0WhebSxiTYfvJrd9Yhcok
        3CW1fr019+L89yhvW8Ss=; b=VaGSVXwy7KmQnYFieJbuqXNYRYA6LNdo4bs3q2i
        zBjn0kzCQ65MdQl0ZvmQDHpKlVE89OTD2mbltEQOzgPKwbVx0y+ewJpFeQV4LTcE
        ooyBJUmpveptGVtUN2psc+4l0hQA+iaEEf+a04fx3ZJ+c3Z+Rx4ORY66aUijoK9L
        ac8k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=HV0Whe
        bSxiTYfvJrd9Yhcok3CW1fr019+L89yhvW8Ss=; b=aJRLHp9Wfief56lkK0am/p
        S0pKkF/DFcAZRc2i17bcKcgl8vjSRqbf/NCQ1i+OTHhR2XkMDyVbi3ZkgiCOKJ2y
        X/mub+ynctYKCUss71rp41qwvo5I7uRVgzUSilA720070cvE/DYNaIg5iUY8aock
        MXZIkL4/tMAOqxLWT5MGlernn5mngwl8NLQ6E0WX6N4/dyOK71H2kvSVxa0LabN5
        tSqcdoIs9+VO55UalMPFnjocbFAP4361W39qiffNkR5boHRo6zVhtYirLM1kTbS7
        0K3FjF6cZD1x5BqI04fMyYcVYbwwe4pIyuBSAawGXGJy6Zgh4kUD4fQGCqKSI17A
        ==
X-ME-Sender: <xms:uaX_XCSurM0VJ9ujMFekxbQaxmrJONVqfCrNoeS9EImUlcEV_KNZYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudehhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdfgshhpvghnucetnhhtohhnshgvnhdfuceovghsphgvnhes
    ihhnshhpihhrvggurdhnoheqnecurfgrrhgrmhepmhgrihhlfhhrohhmpegvshhpvghnse
    hinhhsphhirhgvugdrnhhonecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:uaX_XDrMLVR-mh3_khvfF4QZa2mGSv6WAOZqB2vifr0ZK8LADFg9cQ>
    <xmx:uaX_XLX3h5dLZh2cMWkDjgzoxYF1jNBnIkwi3LFaCF0D7iPOtw9ubg>
    <xmx:uaX_XB8AwFFd_I6WqEURbT7q8vWLsbakNlPeT415R7ZsAOmnHV8W_g>
    <xmx:uaX_XMgK8_sS8-7R6E_1Lrnli5S8Lsa1CwmAoRhFP-3f1hVKfvjHKg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id EC4D912200A1; Tue, 11 Jun 2019 08:59:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-663-gf46ad30-fmstable-20190607v1
Mime-Version: 1.0
Message-Id: <3bc58c33-4268-4e7c-bf1a-fe349b3cb037@www.fastmail.com>
Date:   Tue, 11 Jun 2019 14:58:29 +0200
From:   "Espen Antonsen" <espen@inspired.no>
To:     git@vger.kernel.org
Subject: Git status parse error after v.2.22.0 upgrade
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seeing an error after upgrading to git v2.22.0.

git status shows =E2=80=9Cerror: could not parse =E2=80=98*a commit mess=
age from 2012*=E2=80=99=E2=80=9D

Downgrading to v.2.21.0 does not yield this message for git status.

I can only replicate this in a private repo I have so far. Unable to sha=
re the repo but can debug if you need more info.
