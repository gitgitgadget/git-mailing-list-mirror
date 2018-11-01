Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA7E1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 10:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeKATbp (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 15:31:45 -0400
Received: from smtpoutz25.laposte.net ([194.117.213.100]:45595 "EHLO
        smtp.laposte.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727453AbeKATbp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 15:31:45 -0400
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 444BD106B32
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 11:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=laposte.net; s=mail0;
        t=1541068161; bh=0Xe5YmgkjU9qtAPpovPz3W9zhDxrUIy1tcguD53ZHXs=;
        h=Subject:From:To:Date;
        b=H5eQavz5bOO5nMz13NqPq/13JQCuiEhi4p2AZZWpLxBAz6AhYj+yX4YhO/sN2Zl/H
         fHRuVYCpjMxDhu3Nklzvkn+yXxwakbRkw7ntzkchM3OJGUIdudHeWqZYhBJoG3zYDh
         ayW32+xRNWdiGnWjj1opwl4Ayo3isDd8Ex6JlLh7r8SqdZQuLGkhQFlOIVL4TfF2h3
         iHwcmhfsHaKKCQNz08C9sEqI5RK7J5jOwPdhNRp9Fj2WBna4ywP4JsQF+MGD6dbg6n
         5mj6vu2qZB22o/XelSH6VYrKuYidvzgSWFh9UmoKiVjvtPnJ1NGkqXveyJ23tgfg1k
         0arLqKRYMn5mg==
Received: from smtp.laposte.net (localhost [127.0.0.1])
        by lpn-prd-vrout013 (Postfix) with ESMTP id 39821106B2A
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 11:29:21 +0100 (CET)
Received: from lpn-prd-vrin002 (lpn-prd-vrin002.laposte [10.128.63.3])
        by lpn-prd-vrout013 (Postfix) with ESMTP id D0A95106B1B
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 11:29:20 +0100 (CET)
Received: from lpn-prd-vrin002 (localhost [127.0.0.1])
        by lpn-prd-vrin002 (Postfix) with ESMTP id C0FC85E82E5
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 11:29:20 +0100 (CET)
Received: from arekh.ddns.net (unknown [82.64.49.105])
        by lpn-prd-vrin002 (Postfix) with ESMTPA id AC3FA5E82AF
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 11:29:20 +0100 (CET)
Received: from cerebro.okg (box.okg [192.168.0.1])
        by arekh.ddns.net (Postfix) with ESMTPSA id 8FB0B2200EF
        for <git@vger.kernel.org>; Thu,  1 Nov 2018 11:29:20 +0100 (CET)
Message-ID: <b639c19a881476be2d4dbdd731cd305384b287a9.camel@laposte.net>
Subject: [RFE] Please add a standard ref object to releases
From:   Nicolas Mailhot <nicolas.mailhot@laposte.net>
To:     git@vger.kernel.org
Date:   Thu, 01 Nov 2018 11:29:20 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.31.1 (3.31.1-2.fc30) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-VR-FullState: 0
X-VR-Score: 0
X-VR-Cause-1: gggruggvucftvghtrhhoucdtuddrgedtkedrieehgdduhecutefuodetggdotefrodftvfcurfhrohhf
X-VR-Cause-2: ihhlvgemucfntefrqffuvffgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepkffuhffvffgt
X-VR-Cause-3: fggggfesthejredttderjeenucfhrhhomheppfhitgholhgrshcuofgrihhlhhhothcuoehnihgtohhl
X-VR-Cause-4: rghsrdhmrghilhhhohhtsehlrghpohhsthgvrdhnvghtqeenucfkphepkedvrdeigedrgeelrddutdeh
X-VR-Cause-5: necurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhinhgvthepkedvrdeigedrgeelrddutdehpdhh
X-VR-Cause-6: vghloheprghrvghkhhdruggunhhsrdhnvghtpdhmrghilhhfrhhomhepnhhitgholhgrshdrmhgrihhl
X-VR-Cause-7: hhhotheslhgrphhoshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
X-VR-Cause-8: rhhgnecuvehluhhsthgvrhfuihiivgeptd
X-VR-AvState: No
X-VR-State: 0
X-VR-State: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git makes no provision for versioned release references.

However, software projects need versioned releases. Software project
integrators need versionned releases. Security auditors need versioned
release. Software project users need versioned releases.

Versioned releases are not the same thing as free-form tags. They have
semantics to allow deducing upgrade paths (usually, a form of semver).
They imply some form of API stability promise. They imply release
documentation completion. They're not just a random point in the project
history like tags are.

This is why most git hosting sites provide a way to select versioned
releases, even if it's not a native git concept. And this way is clearly
separate and distinct from git tag selection.

Unfortunately, since git makes no provision for versioned release
references, git hosting sites have to shove release refs into tag refs.
And it's a huge mess.

Some put release ids in tags as-is, others add a v prefix, others a
version_ prefix, it's all hoster-specific, it's all inconsistent. It
ends up being inconsistent within projects, as they migrate from a
hoster to another, are mirrored from one hoster to another. It depends
on the habits of the person cutting a release, and the release manager
of a project can change over time. It ends up being inconsistent in
release archives, as the version munging can percolate in the archive
name and structure, or not, for mysterious heuristic reasons that change
over time.

As a result, when assembling a project that uses other git repositories,
you spend more time checking repository by repository and version by
version how the version ref was mangled in a tag ref for this specific
(repo,version,date) tuple, than doing actual software dev and QA work.

Please add a specific release reference to git, so software projects
that do versioned releases can use this ref object directly, without
needing to invent custom version rewriting rules to shove them in tags
while marking they are not just tags but release references.

Regards,


-- 
Nicolas Mailhot

