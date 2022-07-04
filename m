Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C7C43334
	for <git@archiver.kernel.org>; Mon,  4 Jul 2022 08:46:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiGDIqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Jul 2022 04:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbiGDIqZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jul 2022 04:46:25 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE0BC1C
        for <git@vger.kernel.org>; Mon,  4 Jul 2022 01:46:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t17-20020a1c7711000000b003a0434b0af7so5225494wmi.0
        for <git@vger.kernel.org>; Mon, 04 Jul 2022 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tuzgIEkmu5CcuDnt05w4QEo8w5u0tq3gF7F/WJurB4o=;
        b=WsDSMBsVxX9c1llfDvX5oZipkP67WSUlwzJFfZMvSMOl8TXaO+E0yyaQD+fKnVOcp+
         zSQAwXV2Kk6lOKw3oK9GVN/00D5/ueHjs21jSsCmdZYSmfgwDdFISDmhvOWZXCb0LjTr
         Zuh5l24m5kppHRkDeLSl1bXyeBibGt11a/JA3HGuFMgTmD4T5Gt/9eqMA59VgOowOFu4
         D4gT/tP0zMWce5TM2TBc/5YsqC9H3NF+h7VGjuVR+nM/srrunAO4Aw/NQSLB9fISIPs4
         jdVj9N4cAqBSCAyXjLVgAJeROylFewF/qR8tLjybEwxkkA9wTg5ECcV4k5DtSCBXmF5j
         pcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tuzgIEkmu5CcuDnt05w4QEo8w5u0tq3gF7F/WJurB4o=;
        b=C4SxUd1ZKTzy7iuVA0ud9GpE453nPCE7lkCbVpG+S8YjJL4fAa63piYDo26rAEFgPM
         TqdsySJg0QXUfzBoFPX/bFODlM6smKbr79t4TQzlduBKYuehQn+yU9OHvAlDBCCMPZ4I
         ii5sCyphIgeL8q4Cw+7P2ZuRO/jL+JdC2A59ZLQiei4iMPHnJkyZ1EUSM8MFmXYa4PmG
         dLDGutQM7JnPt3hf7SS//2mLdq6S4QhIRqiZ9KeYKaSPpB40gPUukX9gqYhLzCVQeVN3
         PB0wwT+QBcK7nqlYr6pVPFQTNRvSxrBzeXsii86FvraiQDQPEs+B5hQIK7eptII0HztC
         FUSg==
X-Gm-Message-State: AJIora9T6BccD7pQw/YfXkhERZp0wlCrC6kR9UBhVKJ3yUR4Qs8lUJO4
        VpOlTp5Y5g5BUwyowAqQ8yrP/tLKaGE=
X-Google-Smtp-Source: AGRyM1u17ixXX6A8xemS0cQ5z2MQjtk/+vdqBFMPa6TsnA69HvQmG6owZCquGUy6/om9C8psWo2WzA==
X-Received: by 2002:a1c:7903:0:b0:3a0:3936:b71f with SMTP id l3-20020a1c7903000000b003a03936b71fmr32898450wme.168.1656924381082;
        Mon, 04 Jul 2022 01:46:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b003a04e900552sm17849262wmq.1.2022.07.04.01.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 01:46:19 -0700 (PDT)
Message-Id: <f72bf11e6efb4690ae808c0b56c3991c2b1ef266.1656924376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
        <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Jul 2022 08:46:11 +0000
Subject: [PATCH v3 1/6] Documentation/technical: describe bitmap lookup table
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

When reading bitmap file, Git loads each and every bitmap one by one
even if all the bitmaps are not required. A "bitmap lookup table"
extension to the bitmap format can reduce the overhead of loading
bitmaps which stores a list of bitmapped commit id pos (in the midx
or pack, along with their offset and xor offset. This way git can
load only the necessary bitmaps without loading the previous bitmaps.

Older versions of Git ignore the lookup table extension and don't
throw any kind of warning or error while parsing the bitmap file.

Add some information for the new "bitmap lookup table" extension in the
bitmap-format documentation.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-Authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..c30dc177643 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -67,6 +67,17 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			pack/MIDX. The format and meaning of the name-hash is
 			described below.
 
+			** {empty}
+			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
+			If present, the end of the bitmap file contains a table
+			containing a list of `N` <commit_pos, offset, xor_row>
+			triplets. The format and meaning of the table is described
+			below.
++
+NOTE: Unlike the xor_offset used to compress an individual bitmap,
+`xor_row` stores an *absolute* index into the lookup table, not a location
+relative to the current entry.
+
 		4-byte entry count (network byte order)
 
 			The total count of entries (bitmapped commits) in this bitmap index.
@@ -205,3 +216,31 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
 If implementations want to choose a different hashing scheme, they are
 free to do so, but MUST allocate a new header flag (because comparing
 hashes made under two different schemes would be pointless).
+
+Commit lookup table
+-------------------
+
+If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
+bytes (preceding the name-hash cache and trailing hash) of the `.bitmap`
+file contains a lookup table specifying the information needed to get
+the desired bitmap from the entries without parsing previous unnecessary
+bitmaps.
+
+For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
+contains a list of `nr_entries` <commit_pos, offset, xor_row> triplets
+(sorted in the ascending order of `commit_pos`). The content of i'th
+triplet is -
+
+	* {empty}
+	commit_pos (4 byte integer, network byte order): ::
+	It stores the object position of a commit (in the midx or pack
+	index).
+
+	* {empty}
+	offset (8 byte integer, network byte order): ::
+	The offset from which that commit's bitmap can be read.
+
+	* {empty}
+	xor_row (4 byte integer, network byte order): ::
+	The position of the triplet whose bitmap is used to compress
+	this one, or `0xffffffff` if no such bitmap exists.
-- 
gitgitgadget

