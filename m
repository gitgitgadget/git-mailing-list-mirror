Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4A8C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 15:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbiDPPSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 11:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbiDPPSU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 11:18:20 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Apr 2022 08:15:48 PDT
Received: from mail.eskimo.com (mail.eskimo.com [204.122.16.222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C439B859
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 08:15:48 -0700 (PDT)
Received: from eskimo.com (debian.eskimo.com [204.122.16.15])
        by mail.eskimo.com (Postfix) with SMTP id ADDB8504C19;
        Sat, 16 Apr 2022 08:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eskimo.com;
        s=default; t=1650121633;
        bh=qwg35VDR7N0448zAIg6TGaNWSBXTJA1Cs4gstMYHzS0=;
        h=From:Date:To:Subject:From;
        b=Ie6TMQFPnSPcWbGYQpFf1PgnDh/cDcCzlBDKINpU0kEr5QpWkUNHozb0zVcdDpFS5
         ZKP12LyDlkFhbLWVpM2Lcr8mtzIsqqXbWNHz8JZjXAjla1573hmLuW5eQcz6HSNa7v
         RWDmcgdigmvi1YCFntBGK3ka+hgb0G/kZK3/O32g0fdzKKm+so03Yp/TXdKJALAHdB
         33ovWzjpbDOqdYiy4fYsaxCzEvXZE8wXm+1xTdJtUhtJYnO7qUb/MFu4i8Q7cx1ANs
         vMG13lcVADG1tq6x6A8cPsul9xR8H3P/kM2KuGVOBIz0gDNN6e+bH7r3h4yi0Lg6PZ
         ld2cxqvx+8ckw==
Received: (nullmailer pid 1637077 invoked by uid 10926);
        Sat, 16 Apr 2022 15:07:13 -0000
From:   scs@eskimo.com (Steve Summit)
Date:   Sat, 16 Apr 2022 11:07:09 -0400
Message-ID: <2022Apr16.1107.scs.0007@quinine2.home>
To:     git@vger.kernel.org
Subject: suggestion for git glossary: "ort"
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2022Apr16.1107.scs.0006"
X-Virus-Scanned: clamav-milter 0.103.5 at mail.eskimo.com
X-Virus-Status: Clean
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--2022Apr16.1107.scs.0006
Content-Type: text/plain; charset=US-ASCII
Content-ID: <2022Apr16.1107.scs.0009@quinine2.home>

I kept seeing references to "ort" in the git source code, and I
had no idea what it meant.  Grepping around in the Documentation
tree eventually revealed: it's a new merge strategy!  Suggested
glossary patch attached; feel free to improve.

--2022Apr16.1107.scs.0006
Content-Type: text/plain; charset=US-ASCII; name="glossary-content.txt.patch"
Content-Transfer-Encoding: Quoted-Printable
Content-Disposition: attachment; filename="glossary-content.txt.patch"
Content-ID: <2022Apr16.1107.scs.0011@quinine2.home>

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary=
-content.txt
index aa2f41f..cb0726f 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -287,6 +287,13 @@ This commit is referred to as a "merge commit", or =
sometimes just a
 	origin/name-of-upstream-branch, which you can see using
 	`git branch -r`.
=20
+[[def_ort]]ort::
+	The default merge strategy when pulling or merging one branch.
+	An acronym for "Ostensibly Recursive's Twin", due to the fact
+	that it was written as a replacement for the previous default
+	algorithm, `recursive`.  See linkgit:git-merge[1], section
+	"Merge Strategies".
+
 [[def_overlay]]overlay::
 	Only update and add files to the working directory, but don't
 	delete them, similar to how 'cp -R' would update the contents

--2022Apr16.1107.scs.0006--
