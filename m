Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B72C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 18:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbiF1Sa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiF1SaY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 14:30:24 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4940D21809
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 11:30:23 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id y14so21284097qvs.10
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 11:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=lso+PzTKUQ48N7QxUrz18Uh27btVl3Sr2zX+v4JCqtY=;
        b=36AiF5wYKOOyNdlOM+DERiDMjNFZI+gK6rdufBH1TKusb9+fi01ZNMCZwr/hh9GHnj
         IOH7c6CBQ8sBJeldoz2yxzbhF0UaAdeOM5JodHJHA/OPs0LtJYW0LHq5BgNKqajllr3C
         sBZTKEPN7otUE+kgRPDPE1l3Chw4u7XAybm12AGKnetTk1jdBtcPknPziihqgl5qtmeV
         /tR91LSur1lITAqjZqJR7j+QrF7jx59N1iJZRu6B6nSZhNIFa8E0PHNNJjxW+ydZzlTA
         stqCanysOexpnKwps+2+eUdsw9EmBHmHX+pC+xqyTpBoJgzy3GyCjnLlNdIk86VoOFze
         Zb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=lso+PzTKUQ48N7QxUrz18Uh27btVl3Sr2zX+v4JCqtY=;
        b=MkYAjkkZerap+FtgfX1ehKDJ95PSmc7ndAenqyeBbCEz4A0rdgE4SSRMOen6kCFtv9
         YMHAGKmUZDtb30+jSdBfN8tWhy/RJInYphtipR15+51bjrT6Md0acK5XHMXNJ4D6N9QC
         GJWPp5DecQtDCMrujy7w+wodcEUYVIAMG7780W8Ip0QltcVSj1L7gGZpyCMjjfqGbbh1
         Yul5wsnuINJiyrJS9jV5B6juHclkxZ6ZU6zWid0PKUvItqXymVRbvyYm+CHRxtWJ1R7r
         IBSI74OEaQOFW7Vsbz9nbmR0M3FIKH3bjq7VD9clsSI8rGbfbdUgjnaQt4PUauCNjx4j
         HT4g==
X-Gm-Message-State: AJIora/CtALpzyrnPugiBUM4CiGAnGEYI/ZqqODkS9jaZYomHMeLbeJH
        y3tGoyTCD5CiUKEroMgoXGEw9EFn59t21A==
X-Google-Smtp-Source: AGRyM1uPdtjF0ineHaKAdXe8rKLHrDRKqZ/h2rEoNWB2eFs1LLWnacCuo/++tnOdOF5iw6OlwRlNFQ==
X-Received: by 2002:ac8:594a:0:b0:305:344d:b3f2 with SMTP id 10-20020ac8594a000000b00305344db3f2mr14609494qtz.102.1656441022191;
        Tue, 28 Jun 2022 11:30:22 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h18-20020ac87772000000b002f905347586sm9456770qtu.14.2022.06.28.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:30:21 -0700 (PDT)
Date:   Tue, 28 Jun 2022 14:30:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, pclouds@gmail.com
Subject: [PATCH] pack-objects.h: remove outdated pahole results
Message-ID: <1379af2e9d271b501ef3942398e7f159a9c77973.1656440978.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The size and padding of `struct object_entry` is an important factor in
determining the memory usage of `pack-objects`. For this reason,
3b13a5f263 (pack-objects: reorder members to shrink struct object_entry,
2018-04-14) added a comment containing some information from pahole
indicating the size and padding of that struct.

Unfortunately, this comment hasn't been updated since 9ac3f0e5b3
(pack-objects: fix performance issues on packing large deltas,
2018-07-22), despite the size of this struct changing many times since
that commit.

To see just how often the size of object_entry changes, I skimmed the
first-parent history with this script:

    for sha in $(git rev-list --first-parent --reverse 9ac3f0e..)
    do
      echo -n "$sha "
      git checkout -q $sha
      make -s pack-objects.o 2>/dev/null
      pahole -C object_entry pack-objects.o | sed -n \
        -e 's/\/\* size: \([0-9]*\).*/size \1/p' \
        -e 's/\/\*.*padding: \([0-9]*\).*/padding \1/p' | xargs
    done | uniq -f1

In between each merge, the size of object_entry changes too often to
record every instance here. But the important merges (along with their
corresponding sizes and bit paddings) in chronological order are:

    ad635e82d6 (Merge branch 'nd/pack-objects-pack-struct', 2018-05-23) size 80 padding 4
    29d9e3e2c4 (Merge branch 'nd/pack-deltify-regression-fix', 2018-08-22) size 80 padding 9
    3ebdef2e1b (Merge branch 'jk/pack-delta-reuse-with-bitmap', 2018-09-17) size 80 padding 8
    33e4ae9c50 (Merge branch 'bc/sha-256', 2019-01-29) size 96 padding 8

(indicating that the current size of the struct is 96 bytes, with 8
padding bits).

Even though this comment was written in a good spirit, it is updated
infrequently enough that is serves to confuse rather than to encourage
contributors to update the appropriate values when the modify the
definition of object_entry.

For that reason, eliminate the confusion by removing the comment
altogether.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Noticed this while reverting an old topic out of GitHub's fork, and
realized that this comment was severely out-of-date.

 pack-objects.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index 393b9db546..579476687c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -116,16 +116,6 @@ struct object_entry {
 	unsigned dfs_state:OE_DFS_STATE_BITS;
 	unsigned depth:OE_DEPTH_BITS;
 	unsigned ext_base:1; /* delta_idx points outside packlist */
-
-	/*
-	 * pahole results on 64-bit linux (gcc and clang)
-	 *
-	 *   size: 80, bit_padding: 9 bits
-	 *
-	 * and on 32-bit (gcc)
-	 *
-	 *   size: 76, bit_padding: 9 bits
-	 */
 };

 struct packing_data {
--
2.37.0.1.g1379af2e9d
