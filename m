Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60E2120248
	for <e@80x24.org>; Fri, 22 Mar 2019 09:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbfCVJdR (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 05:33:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41129 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbfCVJdP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 05:33:15 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so1524524wrs.8
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbz+ZQhaxAq9zBs8Z0B/DXRydlbJbw7ibhZnEiAJdjw=;
        b=MKa+uy+Dq6KWv3LMadx2aZjkzJWbBM2lAXd7Feey1uOvL689lpyrjpAyqnD964EzOx
         uZ64Ol9VTDhBMGDfUzP+05a0akoBuefgG/nFWjXcPe73M55bqJrESDNINDrwc8kuHOmn
         BFbTKP+8tJjcw/eURvcrD39Ga4Dt1Cofwu1UgeNkgx4q2IIaqOvM0mmJb9dmQiiIKNky
         8rdhVCpV7DndUdm+YMpSXfmz0Zo01n2r9Rfom2Ch2w5Wv7geBd8W3/upT1DG2fNdyJUq
         6+skLJYpcZ/6g2BqN/ag+0lywqXc8j3baoZ0amaYOYx/2cs31xMEFLhzaLzGvQAvFbsx
         1Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbz+ZQhaxAq9zBs8Z0B/DXRydlbJbw7ibhZnEiAJdjw=;
        b=ZSvWOgvDZCx9ybOVW/xTKLU0fRs8/J0uGpVW6P1MifMsG3vLdJmtGKm1U37+dbnFAr
         1g0+a7VCJHVPf2yz+dJBeh55+dX48rD/ScesxazgTbXgT+B7ZFGteJfeiRDNwaVRksdu
         uJQ6J7doIejsZoYa3oLks8Jn5cwy2dzC+qjAuz4ggvNZOFudXtUOC4yeUY+otGvECs0A
         ystmI0QdyUiT717FflTS0K2hUTs8wH8kBlz5S2Jbrk73NQHSvM1PawJiN2sJA48V7lll
         XvjdNiuJzitgl4Z1FK1OKGQd+HrGgj/DhWuzuZ5yH1gZOp0pCFaTqlk58Ueq9uoKf4dv
         Q2Cg==
X-Gm-Message-State: APjAAAVlvAbe1LLVLjg+z7VWi53EHVouF+bgPJ65D7+HDu6L8RcetEyv
        D3pP+AMMcDPSQUJQGvfuG74RNkBk4Cw=
X-Google-Smtp-Source: APXvYqzNZr/9MT2Jz7BeuZXSX6rEzFp+SFN17/I9yfDXoFqeVZQNWfW8qsaoUO6O2Z2apRvmTAqVgg==
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr5678427wrq.189.1553247192596;
        Fri, 22 Mar 2019 02:33:12 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y197sm3521447wmd.34.2019.03.22.02.33.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 22 Mar 2019 02:33:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 10/11] gc docs: clarify that "gc" doesn't throw away referenced objects
Date:   Fri, 22 Mar 2019 10:32:41 +0100
Message-Id: <20190322093242.5508-11-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190321205054.17109-1-avarab@gmail.com>
References: <20190321205054.17109-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend the "NOTES" section to fix up wording that's been with us since
3ffb58be0a ("doc/git-gc: add a note about what is collected",
2008-04-23).

I can't remember when/where anymore (I think Freenode #Git), but at
some point I was having a conversation with someone who was convinced
that "gc" would prune things only referenced by e.g. refs/pull/*, and
pointed to this section as proof.

It turned out that they'd read the "branches and tags" wording here
and thought just refs/{heads,tags}/* and refs/remotes/* etc. would be
kept, which is what we enumerate explicitly.

So let's say "other refs", even though just above we say "objects that
are referenced anywhere in your repository".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-gc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 165f05e999..49aec5435b 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -119,8 +119,8 @@ anywhere in your repository. In
 particular, it will keep not only objects referenced by your current set
 of branches and tags, but also objects referenced by the index,
 remote-tracking branches, refs saved by 'git filter-branch' in
-refs/original/, or reflogs (which may reference commits in branches
-that were later amended or rewound).
+refs/original/, reflogs (which may reference commits in branches
+that were later amended or rewound), and anything else in the refs/* namespace.
 If you are expecting some objects to be deleted and they aren't, check
 all of those locations and decide whether it makes sense in your case to
 remove those references.
-- 
2.21.0.360.g471c308f928

