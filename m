Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB11FC4167B
	for <git@archiver.kernel.org>; Sun, 18 Dec 2022 03:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiLRDQ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 22:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiLRDQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 22:16:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894719FEF
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 19:16:22 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so9095385lfa.9
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 19:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PA4gaR1OCOnWpwOQgvlxBB4+9aJzuo8GKoMMeV8pyaE=;
        b=SgzVubVmr2O+ACeEvLPCKJb5XbkxWl/ItCCVldJ7J/qsBRVBV212tsUYo1XUkXN68K
         E7aTl5Xs9xLJjl9rASVH1UdXgSRRKwOXWb0cbbsETZbwA/FcmJVpRsMhETbvgZcVWTyL
         Ik1qvVoGWJ12jGcW2I/VFgIu+NfF6zxdCQ3EM9BbPp5QU+X7U6tlYSPyCenSfSC+5gY6
         f+mHd04u0G9OafYtEBzH5NyCieNHdjF34DvKqv5GSuYn7s/+SpXCwvLjijAnKppfNR2l
         OaFnboABbSZVxI4fqKOaDNLdNeX/Wrtfo2vTgB4+FksXwGDyJe1kPwAnAaMteUkq+PlV
         Dp+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PA4gaR1OCOnWpwOQgvlxBB4+9aJzuo8GKoMMeV8pyaE=;
        b=iamRRQehX35S2vW1PA2EQtqAeCOYj8tKH7c4Rc7uy8DiqSd/eFM2VQu4PE3osReUoG
         0T7mhz08OLy6qeodSBaFYXkwHuU6sU8VvOLxpV8UmtwpmZ8AjZXl1Bsa+/fyKViCPylF
         B1o+nDRi5ARguxzkyv8+sPk9K24ZmTeAo5FkF0koSsyl8U/8ThzfzUmbggbrHXPh1Sdz
         kONzMo1e3ns+X/EErGfX1Ps9K5phF3Cu03QcGWNjCVRLwR63CBZYr5+9mcZ4Ompa1N8r
         ANWGWxquEr0u3p5l8hPiA09mxd110vCL6V/SMLyXg5mdG550tPBIlyZyK8//ZgBzh1Wt
         SJTw==
X-Gm-Message-State: ANoB5pkd90JRKyBJ+QeQF3cid7afI7+O84f/GnB6DwzSAA6gRz9Kh3WB
        ZvZTMcCPJNni91vK0AXH3bJknTpjfFbaBVWeJOJ1J6OFG8Q=
X-Google-Smtp-Source: AA0mqf44GLIxCr8Xc2awtHG/9Qrp9RNQx5OL+bXcHAg0eCERMP0Q+oeirpxIMsEj9T/6V5Y9nxm6H/CN4Pob5GuUjiI=
X-Received: by 2002:a05:6512:298c:b0:4a4:4f35:45dc with SMTP id
 du12-20020a056512298c00b004a44f3545dcmr26617456lfb.424.1671333380765; Sat, 17
 Dec 2022 19:16:20 -0800 (PST)
MIME-Version: 1.0
References: <CAPnZJGABhczzs-6Pri2SAOkujJXT1+JDH9FiwdDns6=miZmvFQ@mail.gmail.com>
 <878rj6rnuo.fsf@igel.home>
In-Reply-To: <878rj6rnuo.fsf@igel.home>
From:   Askar Safin <safinaskar@gmail.com>
Date:   Sun, 18 Dec 2022 06:15:44 +0300
Message-ID: <CAPnZJGAMRY02s6UvMg7B6f=NSAgK0PJQAoftwnhXk-ufD2YknQ@mail.gmail.com>
Subject: Re: https://github.com/rust-lang/rust is not bisectable
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At some point that "bootstrap" word appeared, then at some point it
disappeared again. I'm trying to find a point where it has
disappeared. Consider this script:

==begin
#!/bin/bash

set -e
set -x

git bisect reset
git bisect start
git bisect good 7175c499ecc32cb3ff713be0bbac9fd12990a34e
git bisect bad 49c2279ef658d8732597c4da93897d84838f3df5

while :; do
  if grep -q bootstrap compiler/rustc_target/src/abi/mod.rs; then
    git bisect good
  else
    git bisect bad
  fi
  sleep 1
done
==end

Here is the output: https://paste.debian.net/1264444/ . As you can
see, we always choose "else git bisect bad". And we reach... initial
commit!

Well, technically speaking, this is correct: initial commit is
actually the first commit, where word "bootstrap" is not present in
compiler/rustc_target/src/abi/mod.rs . But this is not what I want! I
want to find commit, which is the first one, which doesn't have
"bootstrap" in compiler/rustc_target/src/abi/mod.rs, AND which is
descendant of good commit ( 7175c499ecc32cb3ff713be0bbac9fd12990a34e
).

Also, after failing with "git bisect", I did MANUAL BISECT!!!!!! I did
this: I run command "gitk --ancestry-path $GOOD..$BAD". Then I clicked
to some commit located nearly in the middle of history, then I copied
its ID. Then I switched to this commit and checked whether it is good.
Then I again run command "gitk --ancestry-path $GOOD..$BAD", this time
with a smaller interval. I did this several times and eventually I was
able to find the faulty commit! (Well, the result was not good enough:
this manual bisecting gave me some merge commit, so I still don't see
the actual commit. But it is still better than "git bisect": "git
bisect" simply gave me the initial commit.)

So, as you can see, manual bisecting (somewhat) works and "git bisect"
doesn't. This means that something is wrong with "git bisect". (Maybe
there is a way to make "git bisect" behave similar to that "gitk"
experiment above?)

Let me say this in other words: I want git-bisect to mark all commits,
which are not descendants of good, as good. (Here I assume bad is
descendant of good.)

-- 
Askar Safin
