Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7051F404
	for <e@80x24.org>; Mon, 13 Aug 2018 21:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeHNAOx (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 20:14:53 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:51331 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729947AbeHNAOx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 20:14:53 -0400
Received: by mail-it0-f73.google.com with SMTP id q5-v6so10846151ith.1
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 14:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jQRsa1jyZlhTgz83euIlmYYc6McUeyY7lmSuRkMTAss=;
        b=IDt99OY321l4S3RA2iP3GkTD/z78JhX6DV6lNwtUZF/c7CdQqbCAlNtzPllN2vOOW9
         4gVrzDC0B68ukwi/CXkDCv9Un22MSW/WeAt7jong/5BMapc8osiRKNCDsCaPayDkQeAi
         UkgHVao5l2DEUBBaAUMLOr5tekIpwhSzr4uehPkNuNT8ScFxCarCl1VtjdDsUepEXzVa
         xCh5QPOl+0PmybnHhTZlucloiWAtvnrVq3kxWQKHn4ZGd5JSs9a8k6qF1ZHg7r3cR93m
         3ksPQQgDZawq91edN7Y6kEv31dTP/QCPMqHhuoxdtpxSVXfk48KndGl3ZFyEyDxTD22A
         61kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jQRsa1jyZlhTgz83euIlmYYc6McUeyY7lmSuRkMTAss=;
        b=JQoCinh+Hlj1RGajegzPdckmaYCPNHEA65yfZQ/sACgxp0kUfmrJqu3qL8JcODwyZN
         ZOhZw0cs60tWVJusK61UhLnbNiGfWyryeY0FNKX+5Pk2k+5Ntof0184KJNVRiVFUKMpz
         oj5r2pajgk+ogf6H9EbBUCG4Pwzcg2mSwmaBcs5m+K47Cf4wl2JqP9IOf0vz7cSQfFyI
         wiVr1k00lEfiKoEwxqWWRpU1s9z8thCQm0S56seYuwBGWBcVbjQYJONrECRJRgGWn/zE
         U42S9LMdcETRdC/sXUgMoah73MdKDQufNb/2KbaZ5hMJ6Sv34+p1JEveGbgFfgFtOI8r
         WK2Q==
X-Gm-Message-State: AOUpUlFEjjOWno8JOBZjpm7pJ9SliuUJXo5+yx4Mrhcs/3Rxx4Fk2Hlh
        3b2u/LkVBgHge6G8g6g5NFXnxrlZsbjjm3YI1JJ5Y8tXPXQ/kQhDK6G5LeIWG5056SpmpiH13o2
        dfL0Bo+exz+iTC5wMAY8KlqRkULbsaDy/0EGmfuIFCXyMl/LDAuVyvhePvI0faN0GgrdTt6pGVY
        J2
X-Google-Smtp-Source: AA+uWPxSVWqm+SDy04fWDgMmow9bKJyoVpS61YYh3NhBQWKZW+KF/PxXRNSxvSaC4Hok3y8/l6e/50YlpH3xVIFncEXD
X-Received: by 2002:a24:6883:: with SMTP id v125-v6mr7184390itb.20.1534195852432;
 Mon, 13 Aug 2018 14:30:52 -0700 (PDT)
Date:   Mon, 13 Aug 2018 14:30:48 -0700
Message-Id: <20180813213048.45555-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH] Documentation: partial clone-related arguments
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 88e2f9ed8e ("introduce fetch-object: fetch one promisor object",
2017-12-05) introduced new command-line arguments without documenting
them. Add documentation for these arguments.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
This is a follow-up to [1] in which Junio noticed some arguments lacking
documentation, and I said that I would make a patch documenting these.

[1] https://public-inbox.org/git/CAGf8dg+5ywyQVfuPfbRrKFdAatst25307ctQvkWqCDKHka7z4g@mail.gmail.com/
---
 Documentation/git-fetch-pack.txt |  8 ++++++++
 Documentation/git-index-pack.txt | 11 +++++++++++
 2 files changed, 19 insertions(+)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index c97588479..a9dce8fee 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -108,6 +108,14 @@ be in a separate packet, and the list must end with a flush packet.
 	Output "connectivity-ok" if the received pack is
 	self-contained and connected.
 
+--from-promisor::
+	For internal use only. Ensure that any packs generated have
+	associated .promisor files.
+
+--no-dependents::
+	For internal use only. Indicate that any objects referenced by
+	the objects given as arguments do not need to be fetched.
+
 -v::
 	Run verbosely.
 
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index d5b7560bf..a20eeff8e 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -66,6 +66,17 @@ OPTIONS
 	message can later be searched for within all .keep files to
 	locate any which have outlived their usefulness.
 
+--promisor::
+	For internal use only. Create an empty .promisor file for the
+	associated pack file. In Git repositories that are partial
+	clones, the presence of this file indicates that this pack comes
+	from the promisor remote of the repository.
+
+--promisor=<msg>::
+	For internal use only. Create a .promisor file containing the
+	given message. Note that this message may not be preserved when
+	the associated pack is repacked.
+
 --index-version=<version>[,<offset>]::
 	This is intended to be used by the test suite only. It allows
 	to force the version for the generated pack index, and to force
-- 
2.18.0.597.ga71716f1ad-goog

