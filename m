Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 262E41F461
	for <e@80x24.org>; Wed, 21 Aug 2019 00:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfHUAFW (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 20:05:22 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54143 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbfHUAFV (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 20 Aug 2019 20:05:21 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id DE7C221CDD
        for <git@vger.kernel.org>; Tue, 20 Aug 2019 20:05:20 -0400 (EDT)
Received: from imap1 ([10.202.2.51])
  by compute3.internal (MEProxy); Tue, 20 Aug 2019 20:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=filippo.io; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm1; bh=bWsZ+K5QQTvsONN+/UR6Z7NNxDFbrF8AVoBnY7IO/2E=; b=F47D055z
        s2fKRBfmeR8rkzUJh9Q0htLYPHulmeN9zCVmg7S3fsFvifGUQG0FdPWahYeUlDG5
        LADMIfzwZTFGvJCD83fJ6fsDtxfw4CEwZU35Qw7l0jCn5Q96dpIqScSBEpHsqx9l
        1ET/dUIhn8uZC7c+yOmSQy42OBCgykmYtA0qXJ1sHgR22r5149iRc5fXjZI7w6sE
        4sCGCdzVfQBeLKGQITHQYJIuohmblpec1J87wcBt46VHSSdGabgkKodP1QAxFOh/
        jmGXZTVvHJAdndn//8taHng4oOZgZJbABuyBPirm5AEHLk4/p4g9w/j7FAaR6Ks0
        euR35oAVhBMkcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=bWsZ+K5QQTvsONN+/UR6Z7NNxDFbr
        F8AVoBnY7IO/2E=; b=EDgim4Cal2KWkSWB71Jw+aGpuxLZKsVL1vV4MJ3q1HDWu
        y6G7q3Ie8Lzh/vXx3iIkbzfU5jgceO1zNUHhD5Y/h6gAG8kltjMvNy4SS81Oy/FD
        I7bGxDHWW6maUNOz00BHyeHQxt2GTkMZUvbuBtm0cduoh+2HRWv3mwahEDQHUt/3
        va/bdgka2RRQVLYr5o79MKyFfZqiVSIQFjy6nMZ+aEjEmg6JJJ3QS/POxvcF0V+v
        z2AFTJ/tjQfivSxT0NUDMOG+AKpQhp+bw4+x3lniIXTQwOzVybJykEh/MdVedhHF
        bY6MiOKwYjqRkwnuYJdq4noKEne5q68DeKO4X2W1A==
X-ME-Sender: <xms:wIpcXYW6u2aBw9cVhTOtofpHMGWIa1vcuCZeeYQLVA2LwYqJssKXiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegvddgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfhfhilhhiphhpohcugggrlhhsohhruggrfdcuoehfihhlihhp
    phhosehmlhdrfhhilhhiphhpohdrihhoqeenucffohhmrghinhepthifihhtthgvrhdrtg
    homhdpghhithhhuhgsrdgtohhmnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfihhlihhp
    phhosehmlhdrfhhilhhiphhpohdrihhonecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:wIpcXQ3eQlHvvjXEAJpak9556waOiUC6ST9mBAlPwMLQx4jSbwbn-w>
    <xmx:wIpcXXYmn2g6CsSmNCsYVyELdSdA9-60zl1u767rMLEDgOSho7hEYw>
    <xmx:wIpcXbptGGAYM71lradwm1KQoRO7x9CThqCEWqafp3Tf_r1eXTHbBw>
    <xmx:wIpcXde_lcmdo7GlE5-k1mogXxPLr1t6nsfC7leR60PIStO4X4wpGg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9C528C200A5; Tue, 20 Aug 2019 20:05:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.1.6-878-g972612b-fmstable-20190820v1
Mime-Version: 1.0
Message-Id: <4d995a0b-0ac4-45a0-9ead-1bc76bd720c7@www.fastmail.com>
Date:   Tue, 20 Aug 2019 20:05:20 -0400
From:   "Filippo Valsorda" <filippo@ml.filippo.io>
To:     git@vger.kernel.org
Subject: Bug: git push in a --mirror repository deletes all refs
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When used in a repository cloned with --mirror, git push with refs on
the command line deletes all unmentioned refs.

This was investigated by @saleemrash1d on Twitter. I'm reporting
their findings here and a reproduction below.

> seems to be a regression.
> TRANSPORT_PUSH_MIRROR is set by remote->mirror
> (https://github.com/git/git/blob/5fa0f5238b0/builtin/push.c#L410)
> AFTER the check for refspecs provided on the command-line
> (https://github.com/git/git/blob/5fa0f5238/builtin/push.c#L615).
> introduced by 800a4ab399e954b8970897076b327bf1cf18c0ac.

> it's mirroring only the refspecs you provided on the command-line to
> the server. i.e. all local refs that aren't stated on the command-line
> will still be deleted

> this unexpected behaviour is why --mirror isn't allowed to be used
> when refspecs are specified on the command-line. but the above commit
> moves the sanity check so it doesn't catch the implied --mirror when
> remote.<remote>.mirror is set (i.e. cloned with --mirror)

https://twitter.com/saleemrash1d/status/1163963105849876481

$ git clone --mirror git@github.com:FiloSottile/test.git
$ git ls-remote
From git@github.com:FiloSottile/test.git
2aa1cacf9b1a6b1227c7c13367ec38637ef3d9a3	HEAD
2aa1cacf9b1a6b1227c7c13367ec38637ef3d9a3	refs/heads/master
773069ef7f893e7fcb3271e6ba80eeafbfb98694	refs/heads/patch-1
2aa1cacf9b1a6b1227c7c13367ec38637ef3d9a3	refs/tags/v0.0.0
$ git show-ref
2aa1cacf9b1a6b1227c7c13367ec38637ef3d9a3 refs/heads/master
773069ef7f893e7fcb3271e6ba80eeafbfb98694 refs/heads/patch-1
2aa1cacf9b1a6b1227c7c13367ec38637ef3d9a3 refs/tags/v0.0.0
$ git push -d origin patch-1
To github.com:FiloSottile/test.git
 - [deleted]         patch-1
 - [deleted]         v0.0.0
 ! [remote rejected] master (refusing to delete the current branch: refs/heads/master)
error: failed to push some refs to 'git@github.com:FiloSottile/test.git'
$ git version
git version 2.22.0
