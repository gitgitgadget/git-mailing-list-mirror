From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] git-hash-object.txt: document --literally option
Date: Mon,  4 May 2015 03:25:13 -0400
Message-ID: <1430724315-524-2-git-send-email-sunshine@sunshineco.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 09:25:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpAl3-0005Bm-KY
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 09:25:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182AbbEDHZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 03:25:38 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:37795 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752165AbbEDHZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 03:25:36 -0400
Received: by igblo3 with SMTP id lo3so75441843igb.0
        for <git@vger.kernel.org>; Mon, 04 May 2015 00:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lUNoKoasCtbh6JzQ95m3Zmg32kop7yC33yhUIfxuiW8=;
        b=bx2meNixYyT583A7W0RUvYzL4KRaf1QcQ22OLNMohIBO3j9kSe0FJdEY7r3SEYK1Fv
         5pohTIOMq+s0qwTALS563+Spd08k6d9DptV/b9TzsvbmtOP2aBg9r16tiD5zsCszlhBL
         L7lDT71ViCZrUo82+9IDT0XbI6F0/LFHA8SutI82n6n8+MbH3oQJUMr8NCY7fhhpy1jz
         kX7L7wc+wSitEfHlagYuPadYsPq80dlIsXeR3dJmflyRLhLc0NzlaH83GdgkIE568ixO
         +6WBM0M0r8NhMd1DSxDIq1tEld8z9+4SniT5GMVxI6DE42GMY9iKKtg11xPzVMTZDYsu
         MDwg==
X-Received: by 10.42.50.81 with SMTP id z17mr26074529icf.57.1430724335733;
        Mon, 04 May 2015 00:25:35 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id r4sm4707630igw.12.2015.05.04.00.25.34
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 May 2015 00:25:35 -0700 (PDT)
X-Mailer: git-send-email 2.4.0.319.g7a04823
In-Reply-To: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268307>

Document the git-hash-object --literally option added by 5ba9a93
(hash-object: add --literally option, 2014-09-11).

While here, also correct a minor typesetting oversight.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

I used Junio's commit message from 5ba9a93 as the basis of the
documentation for --literally and then expanded upon it.

 Documentation/git-hash-object.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 02c1f12..0c75f3b 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,7 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>...
+'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters] < <list-of-paths>
 
 DESCRIPTION
@@ -51,7 +51,13 @@ OPTIONS
 	Hash the contents as is, ignoring any input filter that would
 	have been chosen by the attributes mechanism, including the end-of-line
 	conversion. If the file is read from standard input then this
-	is always implied, unless the --path option is given.
+	is always implied, unless the `--path` option is given.
+
+--literally::
+	Allow `--stdin` to hash any garbage into a loose object which might not
+	otherwise pass standard object parsing or git-fsck checks. Useful for
+	stress-testing Git itself or reproducing characteristics of corrupt or
+	bogus objects encountered in the wild.
 
 GIT
 ---
-- 
2.4.0.319.g7a04823
