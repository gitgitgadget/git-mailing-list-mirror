Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D732C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176082253D
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 18:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P6OQsTzK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgCJSlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 14:41:17 -0400
Received: from mail-pj1-f47.google.com ([209.85.216.47]:39786 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgCJSlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 14:41:16 -0400
Received: by mail-pj1-f47.google.com with SMTP id d8so806105pje.4
        for <git@vger.kernel.org>; Tue, 10 Mar 2020 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=tGjwsnl7GC0dSI7OCyuf2IwGhW1Jl2oRpBUDLEHFjDM=;
        b=P6OQsTzK+zIBpdsIYBhimmDW/QwhwcLluO9g1HLCp9z3NIyLvS1EfzNcy4BNB4Scn0
         VjnPttf1XEiFIdxgWSdJqyBHIgBRQyh5Nmp3hPVlrnvwjQ4MMtBWr5avuGHPISq4Bdkp
         /zcy4PBHcEiCHLMo43hF8XKEtGxjBjNSkD7+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=tGjwsnl7GC0dSI7OCyuf2IwGhW1Jl2oRpBUDLEHFjDM=;
        b=oa1d1kngdfSTXlqYb0Os1DeMecaOwb7vrAcJDIJbOblEBW1Jy51QgcF2igzhRz7P+f
         F/Y7pyEYkaN1XhMFws/VSqEqxzk19jq3iKkY2Tjq7EcxmpVF4kIPLu0m4NsexflvMgXG
         Y9pgluY1Z3h1wr4ITdf6fAVLwN0s9R29pXu9GD76sWbTGsZ/DCN3fq6DYbuF/axl3SbK
         qSJ9IK8bQaZkUcTKnEwS2e7vlp0LRDVjHOS78IYLpQPn+HNt+N1yPcGPY12MnFYKhHkZ
         Ad6CNJjGjNGXBqdq7c3F7w/5TH5s+kFFEt4DXMTVFS8n3cCPM/n+lrccIzlc3Dk79kSC
         mhyA==
X-Gm-Message-State: ANhLgQ3WWQqJcwlLQdmdAJ9uPkXxIoBC8lUGkQ+KCPygKwpxXOsFs4o7
        xO79FPjB3klbNy2Z68bZkcWbSBJiJw1iVW6Qn/vjrbITbNgw/ws788T2mUDdDYBkmtLih4djC8G
        h7E/K8T3BpGYWYNSEofeuqWQ58D0si5P1dfKXS+XU+Fp3utVDsr5s36wqVwDTchGn
X-Google-Smtp-Source: ADFU+vsXbF+/5CXbT7dzqDmJ5kiSqnPoBsQouTSrHpmcoToRcAqmgqBmuwesl5NdL8580uoL9IumWg==
X-Received: by 2002:a17:902:8a8f:: with SMTP id p15mr17924169plo.45.1583865674970;
        Tue, 10 Mar 2020 11:41:14 -0700 (PDT)
Received: from cork ([64.84.68.252])
        by smtp.gmail.com with ESMTPSA id f8sm48192976pfn.2.2020.03.10.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 11:41:14 -0700 (PDT)
Date:   Tue, 10 Mar 2020 11:41:11 -0700
From:   =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
To:     git@vger.kernel.org
Subject: new file mode 160000
Message-ID: <20200310184111.GD1443@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Something weird happened to us and I have no idea how to reproduce it.
A developer managed to create a git commit with the following content:

diff --git a/foo b/foo
new file mode 160000
index 000000000000..b7e7816c1266
--- /dev/null
+++ b/foo
@@ -0,0 +1 @@
+one line of content

File name and content obfuscated, the rest is verbatim from the git
commit.

Now, file mode 160000 doesn't make sense to me.  It doesn't correspond
to any known file type and I cannot explain how this commit was created
in the first place.  But whatever the mechanism, the git client should
have refused it.

Next, the commit was pushed to our git server, which happily accepted
it.  Again, I would argue that the git server should have refused the
push.

Finally, others including myself pulled and checked out a branch with
this commit.  On checkout, an empty directory is being created and
caused various mayhem.  I get:
	error: 'foo' does not have a commit checked out
	fatal: updating files failed

Not sure what the correct solution would be here.  An empty directory is
a bad idea, but I cannot think of any "correct" way to handle things
once the bad commit is in the tree.

In case it matters, my client is: git version 2.25.0

Jörn

--
So, one might well ask, if Congress and the White House, Republicans
and Democrats, liberals and conservatives, all now agree on reform,
how meaningful can the reform be?
-- David Cole
