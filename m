Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F314D1F404
	for <e@80x24.org>; Thu, 25 Jan 2018 14:02:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751471AbeAYOCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 09:02:52 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37237 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeAYOCq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 09:02:46 -0500
Received: by mail-qt0-f194.google.com with SMTP id d54so19399358qtd.4
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 06:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+/l0ogAUjFqZiWA1PLEAjUUZh/24K9ZykzK2rxPQ3KQ=;
        b=BMXfmnzBiN53QyVeFlpVR4jF5n98q6iT2co2fDjD1qVo53z98vSxlzPMaUvxuETlFO
         0doSJrHVXk2szvZ8LT8/CC4OwxqrEMV1OQJipwEXoKFZWqz8h0/Wdnx40wP+t/Mwhi4o
         95apz1DihlP3U64AcN26RqiZ499Ax/ug5Di9Qlv1t4nl5EAIpMawyk4B0z4P38OCqb1p
         6hwsgpZM+v5igEO4OzZp0lEhzmxoteFADbIIv2E+xOsyWpgeEidw3OK2Dx082rd2jedi
         cJclBG2z2IkPW5RQFMvZCD4bTkqjoGEw2vG5/Z7DX6yk3BkXhbQ9HgL77eNYv9hgcYRe
         gzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+/l0ogAUjFqZiWA1PLEAjUUZh/24K9ZykzK2rxPQ3KQ=;
        b=j1Hit5w+4tWO7a7f4Z/SFPUNOhtCD/QoFfiFw6IL4RVCVM1BeyftS+R7ZqJlGXhfvh
         7UtgREKdPMqWciDgjKKuFBkoyKo1E6KvtSYRw5DtXbWR7fO6JOL+40qx4Bjilyia3f9+
         sr/8KzN/vQ7+vrpT2R0sl4aofu1KKqZVXwRe92huohIp/+eanjo+BvZQg31nd/ouWtYH
         bWC/XUtWioVlhgaVJNBHr48SZ5ETnBemXCku8VtoiDPhwKWxS7ECnMrwydHXYVi5NESH
         x2ZckmFaYdpYGka98CyNFSEr7ioC5Mww+HjhoLO7+v3NEVyOwsB8grtwpkIAQ2JFN9Oa
         OEGw==
X-Gm-Message-State: AKwxytcETYRERCW1Dkl5qz/ymZZ96GLLD02jEDqofA3fbz7UhOrhdzcN
        iafk7vsX7mK30IN3qM35djof3Nl6
X-Google-Smtp-Source: AH8x2269baibmrIIQa/5VB1feF26adtrLm8J/rqZxcGy6uBijqZcET5Ya8bzfFxp2EljMDaRu5YJ8g==
X-Received: by 10.55.25.146 with SMTP id 18mr13888281qkz.214.1516888965857;
        Thu, 25 Jan 2018 06:02:45 -0800 (PST)
Received: from stolee-linux.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:7308])
        by smtp.gmail.com with ESMTPSA id y123sm1850875qka.42.2018.01.25.06.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Jan 2018 06:02:45 -0800 (PST)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
Subject: [PATCH 04/14] packed-graph: add format document
Date:   Thu, 25 Jan 2018 09:02:21 -0500
Message-Id: <20180125140231.65604-5-dstolee@microsoft.com>
X-Mailer: git-send-email 2.16.0
In-Reply-To: <20180125140231.65604-1-dstolee@microsoft.com>
References: <20180125140231.65604-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add document specifying the binary format for packed graphs. This
format allows for:

* New versions.
* New hash functions and hash lengths.
* Optional extensions.

Basic header information is followed by a binary table of contents
into "chunks" that include:

* An ordered list of commit object IDs.
* A 256-entry fanout into that list of OIDs.
* A list of metadata for the commits.
* A list of "large edges" to enable octopus merges.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/graph-format.txt | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)
 create mode 100644 Documentation/technical/graph-format.txt

diff --git a/Documentation/technical/graph-format.txt b/Documentation/technical/graph-format.txt
new file mode 100644
index 0000000000..a15e1036d7
--- /dev/null
+++ b/Documentation/technical/graph-format.txt
@@ -0,0 +1,88 @@
+Git commit graph format
+=======================
+
+The Git commit graph stores a list of commit OIDs and some associated
+metadata, including:
+
+- The generation number of the commit. Commits with no parents have
+  generation number 1; commits with parents have generation number
+  one more than the maximum generation number of its parents. We
+  reserve zero as special, and can be used to mark a generation
+  number invalid or as "not computed".
+
+- The root tree OID.
+
+- The commit date.
+
+- The parents of the commit, stored using positional references within
+  the graph file.
+
+== graph-*.graph files have the following format:
+
+In order to allow extensions that add extra data to the graph, we organize
+the body into "chunks" and provide a binary lookup table at the beginning
+of the body. The header includes certain values, such as number of chunks,
+hash lengths and types.
+
+All 4-byte numbers are in network order.
+
+HEADER:
+
+	4-byte signature:
+	    The signature is: {'C', 'G', 'P', 'H'}
+
+	1-byte version number:
+	    Currently, the only valid version is 1.
+
+	1-byte Object Id Version (1 = SHA-1)
+
+	1-byte Object Id Length (H)
+
+	1-byte number (C) of "chunks"
+
+CHUNK LOOKUP:
+
+	(C + 1) * 12 bytes listing the table of contents for the chunks:
+	    First 4 bytes describe chunk id. Value 0 is a terminating label.
+	    Other 8 bytes provide offset in current file for chunk to start.
+	    (Chunks are ordered contiguously in the file, so you can infer
+		the length using the next chunk position if necessary.)
+
+	The remaining data in the body is described one chunk at a time, and
+	these chunks may be given in any order. Chunks are required unless
+	otherwise specified.
+
+CHUNK DATA:
+
+	OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
+	    The ith entry, F[i], stores the number of OIDs with first
+	    byte at most i. Thus F[255] stores the total
+	    number of commits (N).
+
+	OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
+	    The OIDs for all commits in the graph.
+
+	Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)
+	    * The first H bytes are for the OID of the root tree.
+	    * The next 8 bytes are for the int-ids of the first two parents of
+	      the ith commit. Stores value 0xffffffff if no parent in that position.
+	      If there are more than two parents, the second value has its most-
+	      significant bit on and the other bits store an offset into the Large
+	      Edge List chunk.
+	    * The next 8 bytes store the generation number of the commit and the
+	      commit time in seconds since EPOCH. The generation number uses the
+	      higher 30 bits of the first 4 bytes, while the commit time uses the
+	      32 bits of the second 4 bytes, along with the lowest 2 bits of the
+	      lowest byte, storing the 33rd and 34th bit of the commit time.
+
+	[Optional] Large Edge List (ID: {'E', 'D', 'G', 'E'})
+	    This list of 4-byte values store the second through nth parents for
+	    all octoput merges. The second parent value in the commit data is a
+	    negative number pointing into this list. Then iterate through this
+	    list starting at that position until reaching a value with the most-
+	    significant bit on. The other bits correspond to the int-id of the
+	    last parent.
+
+TRAILER:
+
+	H-byte HASH-checksum of all of the above.
-- 
2.16.0

