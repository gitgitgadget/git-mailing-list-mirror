Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22045C43334
	for <git@archiver.kernel.org>; Sun, 24 Jul 2022 06:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiGXGMi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Jul 2022 02:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiGXGMh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Jul 2022 02:12:37 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B70413D42
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 23:12:36 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id z3so7793619plb.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 23:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=EpRHYGJHafoWv4/vFISdFoe52JGtobAX66joTm6Z1QI=;
        b=Fl13AjdGgP3Bx7bw8yPQ7Bme9qJLEr2SRRiBb6kerZkC/jB7ONc7yx6gxNtQt5zcaa
         BxOuYhTIq7LXUy4KfpzUywO0Mc3g2mxnW0xYQ2PwucSGdcxEd+ob3fCnE9+IvvuXtl2b
         5J8juPzHHEJMDJp+gaj6sX6W8tqTc77yYfuHl97lIJfRtADhowBUkRG1yQ0qZwk4nHjC
         YX2a4YvDWjxMmsNodTCamO6O08sNwBL9BMRUzTMzx5KSggXaTb83FfmiPQWSMfLIDENj
         rrGe7NwmfG46W2323HNl3fENs40ZP+Q096E/B7dRU5UMU9sWhf7DRHRa8Qmq2Xbn9jYz
         4kZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=EpRHYGJHafoWv4/vFISdFoe52JGtobAX66joTm6Z1QI=;
        b=aSn/NYpaYJpjVwcNO4xKOwMnipe6oEbv7mTjqoqf2ZMEsuYyygPKLmV5s2f3l3Owzf
         mSffWYRDVDQ+9llQCHoW18lQ8Y4Qb+c63ObnsqUM2gssrd9AplfXVPIlgEo4oCcuylZ7
         0SOZUmDArDCaaKx9DIsGn+ibXBKCwnlv6eHq3KU5JJeWGH4rMUEEV6GDiufQl0MsFkIa
         QpwcCu4uruB3LxF64j+yuYxF1sa/570JvV5+eZwnTCecWulctPp/NIVWEljfY/BkwHfO
         tT9YSKMs3FV34T2o5i4xAGJO0qijIoJ2lOlkqEIZRn4qhROBzpw6ylvzAgVo2YFAuak9
         LFjA==
X-Gm-Message-State: AJIora+F3ksiLQ+2mqGiWHz7Z2AQjKOTbz96woWlRJZyiKOE5yYSMSke
        /dgHmYFc1MCZfiai6O5Y14qefEZVBWc=
X-Google-Smtp-Source: AGRyM1saiStp1j19P7/O7iSr7QC+n7TD4S7KKTInZ1ySpb8UU4+0aMjlIknIULozb/RIiNgY7MetBw==
X-Received: by 2002:a17:903:2282:b0:16c:500f:b78e with SMTP id b2-20020a170903228200b0016c500fb78emr6896396plh.49.1658643155477;
        Sat, 23 Jul 2022 23:12:35 -0700 (PDT)
Received: from jrouhaud (2001-b011-1006-9ae2-bcf5-781b-e790-9433.dynamic-ip6.hinet.net. [2001:b011:1006:9ae2:bcf5:781b:e790:9433])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902780200b0016a091eb88esm6542076pll.126.2022.07.23.23.12.33
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 23:12:34 -0700 (PDT)
Date:   Sun, 24 Jul 2022 14:12:31 +0800
From:   Julien Rouhaud <rjuju123@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH] gitweb: improve title shortening heuristics
Message-ID: <20220724061231.jddhqns7bqx5c2xm@jrouhaud>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ztoz5ogpnirm5wmh"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ztoz5ogpnirm5wmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

First of all, this is my first time on this ML so apologies in advance if I
missed anything in the patch submission guidelines.

We got some report recently that the commit short title on the postgres gitweb
instance was sometimes being mangled (1).  After a bit of digging, it appears
to be due to some long time heuristics to remove some uninteresting parts of a
commit message (see 198066916a8 from August 2005).  In our case, it removed any
occurrence of "master." in the commit message even if the message contains
"postmaster.c" rather than a cname (or something that looks like it), leading
to the commit message:

Remove postmaster.c's reset_shared() wrapper function.

being displayed as:

Remove postc's reset_shared() wrapper function.

It's probably some corner case for which there's barely any complaint, so it
doesn't look worthwhile to spend too much effort on it.  It also seems
impossible to make the current approach entirely bullet proof, but if we simply
make sure that the prefix is preceded by at least one whitespace and isn't
followed by another one we could avoid almost all of the incorrect matches (and
all of them as far as postgres is concerned).  Would that be an acceptable
compromise?  If yes, I'm attaching a patch that does that (and also adds git://
and https:// to the list of trimmed protocols while at it).

Otherwise, would it be acceptable to disable the whole block (the "remove
leading stuff of merges to make the interesting part visible") with some new
configuration option?

Cheers,
Julien.

[1] https://www.postgresql.org/message-id/flat/4025723.1658013974%40sss.pgh.pa.us

--ztoz5ogpnirm5wmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="v1-0001-gitweb-improve-title_short-shortening-heuristics.patch"

From ed46dcd2796b9af6ba3f73d46a3141a88964ed11 Mon Sep 17 00:00:00 2001
From: Julien Rouhaud <julien.rouhaud@free.fr>
Date: Sun, 24 Jul 2022 13:17:19 +0800
Subject: [PATCH v1] gitweb: improve title_short shortening heuristics

In order to shorten the title, some common domain prefixes can be detected and
removed.  However, the current regex matches those prefix anywhere in the
title which makes it likely to remove it where it's not intended.

To make that case less likely, make sure that the prefix is preceded by at
least one whitespace and isn't followed by another whitespace.

While at it, also add  git:// and https:// to the list of detected and trimmed
protocols.

Signed-off-by: Julien Rouhaud <julien.rouhaud@free.fr>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1835487ab2..18dd0b93fb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3565,10 +3565,10 @@ sub parse_commit_text {
 				$title =~ s/^Automatic //;
 				$title =~ s/^merge (of|with) /Merge ... /i;
 				if (length($title) > 50) {
-					$title =~ s/(http|rsync):\/\///;
+					$title =~ s/(git|http|https|rsync):\/\///;
 				}
 				if (length($title) > 50) {
-					$title =~ s/(master|www|rsync)\.//;
+					$title =~ s/\s+(master|www|rsync)\.([^\s])/ \2/;
 				}
 				if (length($title) > 50) {
 					$title =~ s/kernel.org:?//;
-- 
2.37.0


--ztoz5ogpnirm5wmh--
