Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93F41F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeKIT6M (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 14:58:12 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35516 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIT6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 14:58:12 -0500
Received: by mail-wr1-f67.google.com with SMTP id z16-v6so1299430wrv.2
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 02:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Slh2A2RYreSOzwNJWm+OI+0unvvcwKzVHjQ1+CWi44I=;
        b=gWUH3mNTUDP8FvSq11/xky2iRqgil1KFp4FOJvv0FqEA4IXPo/Keg8Ry6O17cG2ULh
         NOQ2DGpewc3TU3zm7bh19zNDQfqHHaRKfdCJIuJ3x2Zzm4BpAYzO5JAdy1z4llixU0P7
         LX0iaSJMmx2Clm+o0w431qAheNFlAhHKd1Nzat4KYmDUsI8m0LIn1jT3ZBXTwPfqVhoI
         V8yxQ2NyfuQ+zAXWvUPQnbFu9tHVDBTBCpxogVByKiMJiieGbZypZIhfY/vj60AvEaej
         e/ay5Z1xFsqui+CZ9/JystjSBKgfNbI/xNTBzpmC9/END5ktgSzktXEr9qxz+l7mCH5Q
         9xfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Slh2A2RYreSOzwNJWm+OI+0unvvcwKzVHjQ1+CWi44I=;
        b=XHkW0cnEhR7kPBmIVhwsAKJW+kLVuCtVmFv9q+ySRDP1PRyRVGgSJTvj11aDRWI+Pw
         YYYwpP/umKP9CqjV2AuUVx3DBIpHIXiKzqX5IMFzWW0xTKld+gLgxsyigrPpYDihYw01
         xNe3aJ3gwkAYDeu4vVqLF+1UoUSwRZgvmYoI+0TOJKYorUGVPmzW6OuEVHd8gueeUAWk
         9+IkM0a6bhkmdqm53OUvWLtEhD2WmKsOh36jLYX7W3FN3K8es/EauCBvZIDo21xQETT5
         CbnQsQ8bpcaEhZWeBlXUgFJlOgbbMHGEJo3uRQrE/CPJpBxU9rMVGWupZ1yk5cxs6n5O
         zK3A==
X-Gm-Message-State: AGRZ1gKKPEnpKP987Y1sPZprwG9PUfi5o+YaDtWUn34I2Hl4+pWXIwRQ
        NRI+ky5le7B/yaBEwkhLT4Ivh1hUBrY=
X-Google-Smtp-Source: AJdET5eoUJUQXRnLpSM664+5uV6a+7Yd2WfkaeSl+Adc1+em9VFtjWvYVZ3FelUWoFFJb3amYd27Aw==
X-Received: by 2002:adf:eecd:: with SMTP id a13-v6mr7773622wrp.242.1541758694329;
        Fri, 09 Nov 2018 02:18:14 -0800 (PST)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h4-v6sm5662020wrt.76.2018.11.09.02.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 02:18:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephen & Linda Smith <ischis2@cox.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/3] range-diff fixes
Date:   Fri,  9 Nov 2018 10:18:00 +0000
Message-Id: <20181109101803.3038-1-avarab@gmail.com>
X-Mailer: git-send-email 2.19.1.1182.g4ecb1133ce
In-Reply-To: <20181107122202.1813-3-avarab@gmail.com>
References: <20181107122202.1813-3-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Addresses feedback on v3, especially Eric's suggestion to split out
the behavior change (which I was not aware of) into a 3/3. Diff with
v3:

1:  23295d7806 ! 1:  5399e57513 range-diff doc: add a section about output stability
    @@ -29,11 +29,11 @@
     +be machine-readable.
     +
     +This is particularly true when passing in diff options. Currently some
    -+options like `--stat` can as an emergent effect produce output that's
    -+quite useless in the context of `range-diff`. Future versions of
    -+`range-diff` may learn to interpret such options in a manner specifc
    -+to `range-diff` (e.g. for `--stat` summarizing how the diffstat
    -+changed).
    ++options like `--stat` can, as an emergent effect, produce output
    ++that's quite useless in the context of `range-diff`. Future versions
    ++of `range-diff` may learn to interpret such options in a manner
    ++specific to `range-diff` (e.g. for `--stat` producing human-readable
    ++output which summarizes how the diffstat changed).
      
      CONFIGURATION
      -------------
2:  b21bd273f5 ! 2:  e56975df6c range-diff: fix regression in passing along diff options
    @@ -4,8 +4,10 @@
     
         In 73a834e9e2 ("range-diff: relieve callers of low-level configuration
         burden", 2018-07-22) we broke passing down options like --no-patch,
    -    --stat etc. Fix that regression, and add a test for some of these
    -    options being passed down.
    +    --stat etc.
    +
    +    Fix that regression, and add a test asserting the pre-73a834e9e2
    +    behavior for some of these diff options.
     
         As noted in a change leading up to this ("range-diff doc: add a
         section about output stability", 2018-11-07) the output is not meant
    @@ -14,7 +16,9 @@
     
         See
         https://public-inbox.org/git/nycvar.QRO.7.76.6.1811071202480.39@tvgsbejvaqbjf.bet/
    -    for a further explanation of the regression.
    +    for a further explanation of the regression. The fix here is not the
    +    same as in Johannes's on-list patch, for reasons that'll be explained
    +    in a follow-up commit.
     
         The quoting of "EOF" here mirrors that of an earlier test. Perhaps
         that should be fixed, but let's leave that up to a later cleanup
    @@ -30,8 +34,7 @@
      
      		memcpy(&opts, diffopt, sizeof(opts));
     -		opts.output_format = DIFF_FORMAT_PATCH;
    -+		if (!opts.output_format)
    -+			opts.output_format = DIFF_FORMAT_PATCH;
    ++		opts.output_format |= DIFF_FORMAT_PATCH;
      		opts.flags.suppress_diff_headers = 1;
      		opts.flags.dual_color_diffed_diffs = dual_color;
      		opts.output_prefix = output_prefix_cb;
    @@ -55,20 +58,43 @@
     +'
     +
     +test_expect_success 'changed commit with --stat diff option' '
    ++	four_spaces="    " &&
     +	git range-diff --no-color --stat topic...changed >actual &&
     +	cat >expected <<-EOF &&
     +	1:  4de457d = 1:  a4b3333 s/5/A/
     +	     a => b | 0
     +	     1 file changed, 0 insertions(+), 0 deletions(-)
    ++	$four_spaces
     +	2:  fccce22 = 2:  f51d370 s/4/A/
     +	     a => b | 0
     +	     1 file changed, 0 insertions(+), 0 deletions(-)
    ++	$four_spaces
     +	3:  147e64e ! 3:  0559556 s/11/B/
     +	     a => b | 0
     +	     1 file changed, 0 insertions(+), 0 deletions(-)
    ++	$four_spaces
    ++	    @@ -10,7 +10,7 @@
    ++	      9
    ++	      10
    ++	     -11
    ++	    -+B
    ++	    ++BB
    ++	      12
    ++	      13
    ++	      14
     +	4:  a63e992 ! 4:  d966c5c s/12/B/
     +	     a => b | 0
     +	     1 file changed, 0 insertions(+), 0 deletions(-)
    ++	$four_spaces
    ++	    @@ -8,7 +8,7 @@
    ++	     @@
    ++	      9
    ++	      10
    ++	    - B
    ++	    + BB
    ++	     -12
    ++	     +B
    ++	      13
     +	EOF
     +	test_cmp expected actual
     +'
-:  ---------- > 3:  edfef733c7 range-diff: make diff option behavior (e.g. --stat) consistent

Ævar Arnfjörð Bjarmason (3):
  range-diff doc: add a section about output stability
  range-diff: fix regression in passing along diff options
  range-diff: make diff option behavior (e.g. --stat) consistent

 Documentation/git-range-diff.txt | 17 +++++++++++++++++
 range-diff.c                     |  3 ++-
 t/t3206-range-diff.sh            | 31 +++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 1 deletion(-)

-- 
2.19.1.1182.g4ecb1133ce

