Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F4FC1F597
	for <e@80x24.org>; Tue, 31 Jul 2018 00:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732130AbeGaCJT (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 22:09:19 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:38646 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732009AbeGaCJT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 22:09:19 -0400
Received: by mail-vk0-f73.google.com with SMTP id d134-v6so6093981vkf.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 17:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=+CrBXrhP/tmsO4SvWi3YbZdNfqzUjmZLR+8Otarw8+s=;
        b=U7yWIEW26rfwbRyEJQuvvxFZ4/rIbjqYdSl3P3ZhdovlQMhFnyxo6z9XKcq+gV7Ymf
         EsVg23lM0bsK9wISoN32KShsVFpKYrLQlx2AOV+quhNoMmUR3PXU1j7JiXVre0WAW/TL
         U6mkxQkFKjjNWsSay2672oebhPCv9eydRY8gyt5c4TDZ+ABYT5NC7FTl/5m+x92JodQP
         L5I7QCAb//Gim2H2RfnGQa4SJowRiA1qNmveVSFMJU4Icsf/dLNrcdXxk1gVoCOjInxy
         InYNy4gChPkpEW+fLDLab7YiT3M4YABR+Cn6n7CVeoA8ZPG12GuykfPu2VCTrW7Vscpj
         MeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=+CrBXrhP/tmsO4SvWi3YbZdNfqzUjmZLR+8Otarw8+s=;
        b=ifaYPODpojwqJolfIxODwVlisWCsIQ103jANivEzyKq5nyk4DEZsFXPNatz53OAFqh
         a6BV/4yfilncBGcUfL3Jv5Z+XmRT/wXUQIkmnkFt5PS9uVfCTxjOWNuOE621hDowiU/Y
         qX2A5+cBC5W4+cKCJUQb8FB9vQBgHHK4zLRom+d6lqSWGLTGfGGV13ckJnFuK76ZuJxb
         wpJAjCjymUetba0Gv7AWtbq8AGHAn3XIPvX7OH/ULMziNxDMCyGG9qEKKnRyhrvwa/Zy
         zdjWEz4RFGnD0xO8oi0wJwCNapOWFiHST2KeUpTUyXm6Hs0Q4X+LWVCuncxQkdvVD0K7
         sAyw==
X-Gm-Message-State: AOUpUlG5NSzU1FWwOJ2pAJHb99T6YdAmJO79MHkKO9IdO3oKscRYWks0
        3Z70v4JxOFPOpTZH6pBQIDdnTExddoi/
X-Google-Smtp-Source: AAOMgpfiK1hgzSbjCJe6LZfCEJmHC9ywQK/4PGdWXbOQIfb5+7v61iI4VkHn4N2Ya3I6T9lEtLHGSy3E+Rpi
MIME-Version: 1.0
X-Received: by 2002:a1f:bd07:: with SMTP id n7-v6mr9547686vkf.11.1532997106774;
 Mon, 30 Jul 2018 17:31:46 -0700 (PDT)
Date:   Mon, 30 Jul 2018 17:31:33 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180731003141.105192-1-sbeller@google.com>
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.132.g195c49a2227
Subject: [PATCHv2 0/8] Add color test for range-diff, simplify diff.c
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

addressed all of Erics feedback:
* reworded commit messages
* dropped q_to_tab and use cat instead
* use -\EOF isntead of -EOF

Thanks,
Stefan

Stefan Beller (8):
  test_decode_color: understand FAINT and ITALIC
  t3206: add color test for range-diff --dual-color
  diff.c: simplify caller of emit_line_0
  diff.c: reorder arguments for emit_line_ws_markup
  diff.c: add set_sign to emit_line_0
  diff: use emit_line_0 once per line
  diff.c: compute reverse locally in emit_line_0
  diff.c: rewrite emit_line_0 more understandably

 diff.c                  | 94 +++++++++++++++++++++++------------------
 t/t3206-range-diff.sh   | 39 +++++++++++++++++
 t/test-lib-functions.sh |  2 +
 3 files changed, 93 insertions(+), 42 deletions(-)

./git-range-diff ws_cleanup-ontop-range-diff-2@{2.hours.ago}...HEAD >>0000-cover-letter.patch
[dropped changes to range-diff itself]
13:  a02ea020ae7 ! 13:  16f71b43f48 t3206: add color test for range-diff --dual-color
    @@ -2,9 +2,7 @@
     
         t3206: add color test for range-diff --dual-color
     
    -    The 'expect'ed outcome is taken by running the 'range-diff |decode';
    -    it is not meant as guidance, rather as a documentation of the current
    -    situation.
    +    The 'expect'ed outcome has been taken by running the 'range-diff | decode'.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
     
    @@ -15,8 +13,8 @@
      	test_cmp expected actual
      '
      
    -+test_expect_success 'simple coloring' '
    -+	q_to_tab >expect <<-EOF &&
    ++test_expect_success 'dual-coloring' '
    ++	cat >expect <<-\EOF &&
     +	<YELLOW>1:  a4b3333 = 1:  f686024 s/5/A/<RESET>
     +	<RED>2:  f51d370 <RESET><YELLOW>!<RESET><GREEN> 2:  4ab067d<RESET><YELLOW> s/4/A/<RESET>
     +	    <REVERSE><CYAN>@@ -2,6 +2,8 @@<RESET>
14:  c8734075229 = 14:  abd1ec80608 diff.c: simplify caller of emit_line_0
15:  ba98acffcda = 15:  bc29037f4f0 diff.c: reorder arguments for emit_line_ws_markup
16:  5a576baeb49 ! 16:  8f6ee340f1e diff.c: add set_sign to emit_line_0
    @@ -5,9 +5,10 @@
         For now just change the signature, we'll reason about the actual
         change in a follow up patch.
     
    -    Pass set_sign (which is output before the sign) and set that is setting
    -    the color after the sign. Hence, promote any 'set's to set_sign as
    -    we want to have color before the sign for now.
    +    Pass 'set_sign' (which is output before the sign) and 'set' which
    +    controls the color after the first character. Hence, promote any
    +    'set's to 'set_sign' as we want to have color before the sign
    +    for now.
     
         Signed-off-by: Stefan Beller <sbeller@google.com>
     
17:  4e2d5a4c7f3 = 17:  0ab5920a9ab diff: use emit_line_0 once per line
18:  460713e1c3c = 18:  2d05ebdd280 diff.c: compute reverse locally in emit_line_0
19:  e442d722b7f ! 19:  001e6042d81 diff.c: rewrite emit_line_0 more understandably
    @@ -7,9 +7,9 @@
         and set_sign, but let's defer that to a later patch.
     
         'first' used be output always no matter if it was 0, but that got lost
    -    got lost at e8c285c4f9c (diff: add an internal option to dual-color
    -    diffs of diffs, 2018-07-21), as there we broadened the meaning of 'first'
    -    to also signal an early return.
    +    at "diff: add an internal option to dual-color diffs of diffs",
    +    2018-07-21), as there we broadened the meaning of 'first' to also
    +    signal an early return.
     
         The change in 'emit_line' makes sure that 'first' is never content, but
         always under our control, a sign or special character in the beginning
