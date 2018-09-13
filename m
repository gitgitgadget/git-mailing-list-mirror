Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB2DF1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 18:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeIMXMs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 19:12:48 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38562 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727413AbeIMXMs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 19:12:48 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so3029737pfh.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YTivjITYq03njvaAtBeoCHnerU1R8MA25eKurXDqlso=;
        b=lzV65XBp5SpoFBL5QAMgQcN2e3rhVT+upKS2QmmnAQE3jDYsBRzINYCMdqPI8/l8hm
         +/rFNpDAou9cgwGHq/9o+dpiOiGoiiXOs9V+yOp7lUre5HCD56ZxAuhf79v6JC6F7SWk
         aPkVaRlH2WQBwKVFwJOEi9zbo/xRozzjAY/XB+n/VZmZn1tBOCxHuUHZzVIpCFkVX/Vh
         H9uTb+MsFbkEbP69UVFyXUU6xaDDA3Adf2fBcEPqHpIfUgfZmq8vIkLa/aXq9YmnwSqm
         V3RLOtAvJypzc3rzv4XKDyGuUuL2nSlfME3mCfzG5r2RP3Cdh/kei2wMIitp4A0b7CTI
         z1GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YTivjITYq03njvaAtBeoCHnerU1R8MA25eKurXDqlso=;
        b=WjmVe2ORKVryS59msDs2j9gsBDJTyzqhAfenl8ktmsLnuNqqgMhkJ9U35DYrnMgCK9
         c+n2FDNbON+RviUphESESmiTI7mSS21yQs558ghiS293NeuMZn7iy7qMSXG2caRm6m9U
         Cbt/OFowkuAbdkmX/BIemUaVHSafIeMaUfP692X9K+Cip+pNSttq+xBx8DJMiySkHcHg
         HTaTPtAtiWv+bdzzuDZNhgRU2LH84VNBWTeotugdbk5TprIgxy7APVxJOZpAl1/8rdEc
         /rNcqzgdcrU9vwp7c+XldNhx6bAZfflL/db8gRwYNOq9KRRZHUiumacZihHg2Fl73clo
         fOow==
X-Gm-Message-State: APzg51BZTmcPswcmdBU3gqd5nCd/Q1gu0+k1cTUvhOJ9NftUk1WzqBVd
        rS+YgtHFcP9t2uBBvt80XMRTR56A
X-Google-Smtp-Source: ANB0VdYwuyQRhOsgHmBiigzEEdslApPDjAP8gl1Ue/MY9hoo4yn5iTrEcjnf7I65JA/8ReFPbS9YNg==
X-Received: by 2002:a63:1d47:: with SMTP id d7-v6mr8140161pgm.180.1536861733129;
        Thu, 13 Sep 2018 11:02:13 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id a90-v6sm11798184pfg.106.2018.09.13.11.02.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 11:02:12 -0700 (PDT)
Date:   Thu, 13 Sep 2018 11:02:12 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Sep 2018 18:01:59 GMT
Message-Id: <pull.34.v2.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.34.git.gitgitgadget@gmail.com>
References: <pull.34.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 00/11] Add 'git multi-pack-index verify' command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index file provides faster lookups in repos with many
packfiles by duplicating the information from multiple pack-indexes into a
single file. This series allows us to verify a multi-pack-index using 'git
multi-pack-index verify' and 'git fsck' (when core.multiPackIndex is true).

The pattern for the tests is similar to that found in t5318-commit-graph.sh.

During testing, I found a bug in how we check for the size of off_t (we are
not actually checking off_t, but instead uint32_t). See "multi-pack-index:
fix 32-bit vs 64-bit size check".

Thanks to Ævar [1], I added a commit that provides progress updates when
checking object offsets.

Based on ds/multi-pack-index

[1] 
https://public-inbox.org/git/20180904202729.13900-1-avarab@gmail.com/T/#u

Derrick Stolee (11):
  multi-pack-index: add 'verify' verb
  multi-pack-index: verify bad header
  multi-pack-index: verify corrupt chunk lookup table
  multi-pack-index: verify packname order
  multi-pack-index: verify missing pack
  multi-pack-index: verify oid fanout order
  multi-pack-index: verify oid lookup order
  multi-pack-index: fix 32-bit vs 64-bit size check
  multi-pack-index: verify object offsets
  multi-pack-index: report progress during 'verify'
  fsck: verify multi-pack-index

 Documentation/git-multi-pack-index.txt |  10 ++
 builtin/fsck.c                         |  18 ++++
 builtin/multi-pack-index.c             |   4 +-
 midx.c                                 | 113 ++++++++++++++++----
 midx.h                                 |   1 +
 t/t5319-multi-pack-index.sh            | 136 ++++++++++++++++++++++++-
 6 files changed, 262 insertions(+), 20 deletions(-)


base-commit: 6a22d521260f86dff8fe6f23ab329cebb62ba4f0
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-34%2Fderrickstolee%2Fmidx%2Fverify-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-34/derrickstolee/midx/verify-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/34

Range-diff vs v1:

  1:  8dc38afe2b !  1:  d8ffd84d67 multi-pack-index: add 'verify' verb
     @@ -47,7 +47,7 @@
       
       static char const * const builtin_multi_pack_index_usage[] = {
      -	N_("git multi-pack-index [--object-dir=<dir>] write"),
     -+	N_("git multi-pack-index [--object-dir=<dir>] [write|verify]"),
     ++	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
       	NULL
       };
       
  2:  787e1fb616 !  2:  9590895830 multi-pack-index: verify bad header
     @@ -61,10 +61,10 @@
       
      +# usage: corrupt_midx_and_verify <pos> <data> <objdir> <string>
      +corrupt_midx_and_verify() {
     -+	POS=$1
     -+	DATA="${2:-\0}"
     -+	OBJDIR=$3
     -+	GREPSTR="$4"
     ++	POS=$1 &&
     ++	DATA="${2:-\0}" &&
     ++	OBJDIR=$3 &&
     ++	GREPSTR="$4" &&
      +	FILE=$OBJDIR/pack/multi-pack-index &&
      +	chmod a+w $FILE &&
      +	test_when_finished mv midx-backup $FILE &&
  3:  b385aa2abf =  3:  2448173844 multi-pack-index: verify corrupt chunk lookup table
  4:  37ee24c82b =  4:  947241bfdc multi-pack-index: verify packname order
  5:  b747da415c =  5:  4058867380 multi-pack-index: verify missing pack
  6:  58e5c09468 =  6:  ea1c522702 multi-pack-index: verify oid fanout order
  7:  b21772d054 =  7:  511791de91 multi-pack-index: verify oid lookup order
  8:  b08d3f0055 =  8:  210649bf83 multi-pack-index: fix 32-bit vs 64-bit size check
  9:  e1498aea45 !  9:  ef20193d59 multi-pack-index: verify object offsets
     @@ -21,7 +21,8 @@
       
       	if (pack_int_id >= m->num_packs)
      -		BUG("bad pack-int-id");
     -+		die(_("bad pack-int-id"));
     ++		die(_("bad pack-int-id: %u (%u total packs"),
     ++		    pack_int_id, m->num_packs);
       
       	if (m->packs[pack_int_id])
       		return 0;
 10:  acf8cfd632 = 10:  29ebc17161 multi-pack-index: report progress during 'verify'
 11:  09d16aff20 ! 11:  406c88b456 fsck: verify multi-pack-index
     @@ -40,14 +40,14 @@
      --- a/t/t5319-multi-pack-index.sh
      +++ b/t/t5319-multi-pack-index.sh
      @@
     - 	DATA="${2:-\0}"
     - 	OBJDIR=$3
     - 	GREPSTR="$4"
     -+	COMMAND="$5"
     + 	DATA="${2:-\0}" &&
     + 	OBJDIR=$3 &&
     + 	GREPSTR="$4" &&
     ++	COMMAND="$5" &&
      +	if test -z "$COMMAND"
      +	then
      +		COMMAND="git multi-pack-index verify --object-dir=$OBJDIR"
     -+	fi
     ++	fi &&
       	FILE=$OBJDIR/pack/multi-pack-index &&
       	chmod a+w $FILE &&
       	test_when_finished mv midx-backup $FILE &&

-- 
gitgitgadget
