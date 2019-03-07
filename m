Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A64820248
	for <e@80x24.org>; Thu,  7 Mar 2019 05:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbfCGFgQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 00:36:16 -0500
Received: from mail-it1-f180.google.com ([209.85.166.180]:35775 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfCGFgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 00:36:16 -0500
Received: by mail-it1-f180.google.com with SMTP id 188so13998327itb.0
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 21:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=Z0AxZchYt4sqMIYGwPepJvLDugdOMr08GV8xgYbfy1k=;
        b=vYEOhLIc8Cebbx8PTW5IFKJ33etP1ZVYn/Lx1E6eMBnf6flhIYVbTQwp8rc2hlg+4q
         HCeAgGagJHa0tHNgQBB8JgAEHaLJyKZEL/Npnnk6CuW00UTCTKA3wybNSPnEcWhSygCg
         Cz17LVou/hC7ME+lKZBtIRjLqIdOenkzoj8R/3Na5kktmAVnkAbGG1yxwz9x2K11rbrp
         q1z7SAO240NmDq9QvFpZ/BV/9Ajkgm35viM5DBZxUpexdfIqGmd5yhXPOBNbld1st2PD
         /rsgdYWemOASWIEksxuiXs7YKpRQA7yNPvsMj/VyE8RBRY3E3hB3tKdmoTqH+tDbdJKq
         pizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=Z0AxZchYt4sqMIYGwPepJvLDugdOMr08GV8xgYbfy1k=;
        b=JPheW8ppU+Nq+wgnv9GfBOPoevBj6GfFJfpjWMFPKH+3mKYYUDdOzY5eYDg9UE0274
         K16p6BaG7mXbbP0CQKyhUY5GIH4xnNCMrFvBQ0YeKZgl6qrHcl4a07RCTjwEEDjPo++F
         oS1mIgIOKT/U5z25+jq5xPKN95VuJxS3q+n1kZRZhLaJk7+MfLpbDPW3wrpYEeBsCc/Q
         RZwM7OVCIrl2giTL9mHoPhu8q5hQ+ZcRgS+RfyMBlUobPl0YxImBP/rtoyXH9onpEDn/
         bcvunY6jCJQzYPrf82CPktm1TjRobhkSukgIyrUFYB5MWpYJV0Dce1gNapVQ9l3S/liJ
         yP0w==
X-Gm-Message-State: APjAAAWRXE0jSV7KFrS+4Eo1rKsVlcCu+DJYms5Doi/HQSx4sNxm4NlB
        NjQ/kaZHQATFCOc45VmZfoHTEOMHpg7ImJ5lQb8T17an
X-Google-Smtp-Source: APXvYqzJMUGUri03O9Hg190mmbV4TyXs/JiBQK/UDBEqctyBR4DDUvWHveyNG+vEp+9byXa1EoCgvDyDSoPiJnY3/D4=
X-Received: by 2002:a24:7cc4:: with SMTP id a187mr4483520itd.171.1551936975135;
 Wed, 06 Mar 2019 21:36:15 -0800 (PST)
MIME-Version: 1.0
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 7 Mar 2019 00:35:58 -0500
Message-ID: <CAH8yC8nP+bDQZXHbn+GdVsEEMRYzC45pViYOcB2_FpbYK4nmqQ@mail.gmail.com>
Subject: How to see raw output from 'make test'?
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

I built Git 2.2.0 from sources. I added CFLAGS="-DNDEBUG -g2 -O1
-fsantize=undefined'. Then, a 'make test V=1'. The tests don't produce
output. For example:

*** t0021-conversion.sh ***
ok 1 - setup
ok 2 - check
ok 3 - expanded_in_repo
ok 4 - filter shell-escaped filenames
ok 5 - required filter should filter data
ok 6 - required filter smudge failure
ok 7 - required filter clean failure
ok 8 - filtering large input to small output should use little memory
ok 9 - filter that does not read is fine

Yet when I grep for 'runtime error' I am getting some hits for
undefined behavior:

git-2.21.0$ grep -IR 'runtime error'
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:392:2: runtime
error: load of misaligned address 0x000002d7d1d5 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:397:2: runtime
error: load of misaligned address 0x000002d7d1d5 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:402:2: runtime
error: load of misaligned address 0x000002d7d1d5 for type 'const
uint32_t', which requires 4 byte alignment
t/trash directory.t0021-conversion/err:sha1dc/sha1.c:407:2: runtime
error: load of misaligned address 0x000002d7d1d5 for type 'const
uint32_t', which requires 4 byte alignment
...

How do I get the full output from 'make test'?

Thanks in advance.
