Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7721320179
	for <e@80x24.org>; Mon,  4 Jul 2016 18:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753420AbcGDSri (ORCPT <rfc822;e@80x24.org>);
	Mon, 4 Jul 2016 14:47:38 -0400
Received: from mx-out-2.rwth-aachen.de ([134.130.5.187]:54293 "EHLO
	mx-out-2.rwth-aachen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713AbcGDSrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jul 2016 14:47:37 -0400
X-Greylist: delayed 595 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Jul 2016 14:47:37 EDT
X-IronPort-AV: E=Sophos;i="5.26,575,1459807200"; 
   d="scan'208";a="447612328"
Received: from rwthex-s2-a.rwth-ad.de ([134.130.26.154])
  by mx-2.rz.rwth-aachen.de with ESMTP; 04 Jul 2016 20:37:40 +0200
Received: from [172.16.42.191] (89.0.248.191) by rwthex-s2-a.rwth-ad.de
 (2002:8682:1a9a::8682:1a9a) with Microsoft SMTP Server (TLS) id 15.0.1178.4;
 Mon, 4 Jul 2016 20:37:54 +0200
From:	Bernhard Kirchen <bernhard.kirchen@rwth-aachen.de>
To:	<git@vger.kernel.org>
Date:	Mon, 4 Jul 2016 20:37:39 +0200
Message-ID: <155b7339538.2774.8c011de0e6d4f677db1e190e9d3169b9@rwth-aachen.de>
In-Reply-To: <OFEE90CED0.0832E3D4-ONC1257FE9.0053D856-C1257FE6.00660366@lancom.de>
References: <OFEE90CED0.0832E3D4-ONC1257FE9.0053D856-C1257FE6.00660366@lancom.de>
User-Agent: AquaMail/1.6.2.5 (build: 27000205)
Subject: --dir-diff not working with partial path limiter
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rwthex-w1-b.rwth-ad.de (2002:8682:1a9d::8682:1a9d) To
 rwthex-s2-a.rwth-ad.de (2002:8682:1a9a::8682:1a9a)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hello!

Today I started using --dir-diff and noticed a problem when specifying a
non-full path limiter. My diff tool is setup to be meld (*1).

OK while working directory is repo root; also OK while working directory is
repo subfolder "actual":
git difftool --dir-diff HEAD~1 HEAD -- actual/existing/path
=> meld opens with proper dir-diff.

NOT OK while working directory is repo subfolder "actual":
git difftool --dir-diff HEAD~1 HEAD -- existing/path
=> nothing happens, as if using "non/such/path" as the path limiter.

Because "git diff HEAD~1 HEAD -- existing/path" while the working directory
is the repo subfolder "actual" works, I epxected the difftool to work
similarly. Is this a bug?

Best,
Bernhard

(*1)
[diff]
tool = mydiffmeld
[difftool "mydiffmeld"]
cmd = meld --auto-compare --diff $LOCAL $REMOTE
[difftool]
prompt = false


