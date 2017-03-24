Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82EAA1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935988AbdCXSlk (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:40 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34088 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935541AbdCXSlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id u132so2304913wmg.1
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovNHPNDIpXqVOzkBZH7SQ16oRbH/Dt/uvKWqUpfssfE=;
        b=U6jJ+CuypFONj2kNDRkub1kOjH0fZMAj9gKcHlG3CiTOiZOHBBpYl0iHynz4+cIWT/
         culIEjIJDkKzNvLdY8YA7/DwI/w2CBLkxNy02e9jpoyei2iZIBVltJvSYfZxyzfQZGqu
         /X9J2JY/Guk8k1xl20warqgdfzmmQKnZZkWynfeyQSK//iTnuPjYjKU7Zn/ivcfTBaUb
         XlDvRp8vyiO8+/MeF//Pq01K2FP7KDjNFMoiJLXa2a36rcUmzt/rBulbBEK7wUbN2cW6
         WUlUWXulPFdpP9zNTmjbM14sPz+XEX9qsdOtqoEhFE7SD2AAFf7XKJUTHlwinTuDmgK/
         3gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovNHPNDIpXqVOzkBZH7SQ16oRbH/Dt/uvKWqUpfssfE=;
        b=h1w51y+xmCzzKPJV0LClRzVXn3psPl86BRRGd0asi4Fj4Y8nrysH1nihpyIopk8GF9
         xvIKoQO0oBzNzbamo9sh/eMFzc0/jDJm/VhvPrgaXVOvjNkbrNRX4P1P3ZVkO5tZDzz3
         P8vJ6FL5+8z8GWnzKmuCuiXBjiU4bLwsAqThrwgHKEXeFV0fA0JTa45PlDWh4sqCA6fE
         XrVshTpPld5L+SvvkEZMMCZI8uO8pvImknjhsG2zBEKKhVLPWp7pFKFO64xW3wB7MbB1
         EbHTgbm729w/gwmY0dCygRykjuuVf7SjEwY0WmfIBCLnJ1Yl7OkQlDGvafsSPwlOBLJ0
         jA9g==
X-Gm-Message-State: AFeK/H0+ObaBXqS/KuhkBDj0Rr+2bhvYmoIMyDr2fRDdsv3gd88i6muBvmVmGtkZRFAgCA==
X-Received: by 10.28.7.13 with SMTP id 13mr4454392wmh.16.1490380873965;
        Fri, 24 Mar 2017 11:41:13 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/16] tag doc: move the description of --[no-]merged earlier
Date:   Fri, 24 Mar 2017 18:40:44 +0000
Message-Id: <20170324184059.5374-2-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the documentation for the --merged & --no-merged options earlier
in the documentation, to sit along the other switches, and right next
to the similar --contains and --points-at switches.

It makes more sense to group the options together, not have some
options after the like of <tagname>, <object>, <format> etc.

This was originally put there when the --merged & --no-merged options
were introduced in 5242860f54 ("tag.c: implement '--merged' and
'--no-merged' options", 2015-09-10). It's not apparent from that
commit that the documentation is being placed apart from other
options, rather than along with them, so this was likely missed in the
initial review.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-tag.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 525737a5d8..33f18ea5fb 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -124,6 +124,11 @@ This option is only applicable when listing tags without annotation lines.
 	Only list tags which contain the specified commit (HEAD if not
 	specified).
 
+--[no-]merged [<commit>]::
+	Only list tags whose tips are reachable, or not reachable
+	if `--no-merged` is used, from the specified commit (`HEAD`
+	if not specified).
+
 --points-at <object>::
 	Only list tags of the given object.
 
@@ -173,11 +178,6 @@ This option is only applicable when listing tags without annotation lines.
 	that of linkgit:git-for-each-ref[1].  When unspecified,
 	defaults to `%(refname:strip=2)`.
 
---[no-]merged [<commit>]::
-	Only list tags whose tips are reachable, or not reachable
-	if `--no-merged` is used, from the specified commit (`HEAD`
-	if not specified).
-
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-- 
2.11.0

