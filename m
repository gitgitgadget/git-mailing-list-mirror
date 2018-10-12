Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF93D1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeJLUnr (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 16:43:47 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36033 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeJLUnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 16:43:46 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so11451156edt.3
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3kWZKQlaCzfD2Juje5LrURhtxHsQwQI3rc/NYDQNTM=;
        b=fVGkFYth6MmcB0D02Ai2aOSydRubK96cv4YcT/4IyrAFMfiWJTEYSKJdZvpDNZpuPi
         HoLTNFriFgGT4g2v5c3Nq1g2c1tRYjLocROB5rl2+RomsEwpwxSWmlNSHZGGVQDxhPC7
         QbjxtPgMyuc+XGeUlsQKa/c12Vfdyp0VsU3V8McYWbP9KC8GZkdpCzuwnd/dF4Av45yj
         TCbuqLOzrqdpL0T3Q4lX1ovPFDKnpAU7rHSu1mqiJpAcxc8jsfxJsubrTI8k2xBMT/jw
         SeaXVDn4QRea3fQe2rTWArFH+JBFhfnA079Q1MlQoKiQiKCmELT9kinRBFx67PB/KFUe
         XEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3kWZKQlaCzfD2Juje5LrURhtxHsQwQI3rc/NYDQNTM=;
        b=R1XuGTZpQYS2Z2R4sFXcCUSCRswpvLKD/iOVpyhQIlrLitSw2T/b7AqLlrHMCwlaJK
         JZGdx9FfggYtUYP97UNd6LZ0ukgcH0XkKwDWAzF1+aEzIkvLin+d3XBkDdSD2508HWIZ
         Vbwjd9+upIbZgCKgQB2P2x6VQr8Hkl0zNrz5uS6jTA0/b0SAk1z5k0yv9mxI9i90a2e0
         yY5h2kldZY+Ew/a4CRccxfF4XwAQlaElMiLPPlwCYgPmEVqHCLjI1eVpXkk7cHcRDnEF
         qbQ0iNYDlUYuqnERw5RdcAR7LVytzk+5WGjKSPFf564TCxLIDdZLuP/lYCrZGCSxVjUs
         z/QA==
X-Gm-Message-State: ABuFfoj+WeEEoSKXNADCZkN5XQKmHuaDR0h8xT0eeteo8GB55H4JOgGv
        gbRcYQ4AzlkpqE0jQ2GjQfM=
X-Google-Smtp-Source: ACcGV63fQc+Rl4lj4W5UeWtW+CrqPWEG91qNr0Mu4QPiO0tjTc50oiMXtR8Y9H5JZ3mQgaBsrC1ZKw==
X-Received: by 2002:a17:906:66cd:: with SMTP id k13-v6mr7194050ejp.152.1539349880607;
        Fri, 12 Oct 2018 06:11:20 -0700 (PDT)
Received: from localhost.localdomain (x4dbe4f29.dyn.telefonica.de. [77.190.79.41])
        by smtp.gmail.com with ESMTPSA id h3-v6sm644497ede.42.2018.10.12.06.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 12 Oct 2018 06:11:19 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] object_id.cocci: match only expressions of type 'struct object_id'
Date:   Fri, 12 Oct 2018 15:11:16 +0200
Message-Id: <20181012131116.23733-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.465.gaff195083f
In-Reply-To: <20181008215701.779099-15-sandals@crustytoothpaste.net>
References: <20181008215701.779099-15-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Most of our semantic patches in 'contrib/coccinelle/object_id.cocci'
turn calls of SHA1-specific functions into calls of their
corresponding object_id counterparts, e.g. sha1_to_hex() to
oid_to_hex().  These semantic patches look something like this:

  @@
  expression E1;
  @@
  - sha1_to_hex(E1.hash)
  + oid_to_hex(&E1)

and match the access to the 'hash' field in any data type, not only in
'struct object_id', and, consquently, can produce wrong
transformations.

Case in point is the recent hash function transition patch "rerere:
convert to use the_hash_algo" [1], which, among other things, renamed
'struct rerere_dir's 'sha1' field to 'hash', and then 'make
coccicheck' started to suggest the following wrong transformations for
'rerere.c' [2]:

  -    return sha1_to_hex(id->collection->hash);
  +    return oid_to_hex(id->collection);

and

  -    DIR *dir = opendir(git_path("rr-cache/%s", sha1_to_hex(rr_dir->hash)));
  +    DIR *dir = opendir(git_path("rr-cache/%s", oid_to_hex(rr_dir)));

Avoid such wrong transformations by tightening semantic patches in
'object_id.cocci' to match only type of or pointers to 'struct
object_id'.

[1] https://public-inbox.org/git/20181008215701.779099-15-sandals@crustytoothpaste.net/
[2] https://travis-ci.org/git/git/jobs/440463476#L580

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I think this patch should come before that patch mentioned in the commit
message, or perhaps even before the whole patch series.

 contrib/coccinelle/object_id.cocci | 117 ++++++++++++++++-------------
 1 file changed, 63 insertions(+), 54 deletions(-)

diff --git a/contrib/coccinelle/object_id.cocci b/contrib/coccinelle/object_id.cocci
index d8bdb48712..6a7cf3e02d 100644
--- a/contrib/coccinelle/object_id.cocci
+++ b/contrib/coccinelle/object_id.cocci
@@ -1,119 +1,127 @@
 @@
-expression E1;
+struct object_id OID;
 @@
-- is_null_sha1(E1.hash)
-+ is_null_oid(&E1)
+- is_null_sha1(OID.hash)
++ is_null_oid(&OID)
 
 @@
-expression E1;
+struct object_id *OIDPTR;
 @@
-- is_null_sha1(E1->hash)
-+ is_null_oid(E1)
+- is_null_sha1(OIDPTR->hash)
++ is_null_oid(OIDPTR)
 
 @@
-expression E1;
+struct object_id OID;
 @@
-- sha1_to_hex(E1.hash)
-+ oid_to_hex(&E1)
+- sha1_to_hex(OID.hash)
++ oid_to_hex(&OID)
 
 @@
 identifier f != oid_to_hex;
-expression E1;
+struct object_id *OIDPTR;
 @@
   f(...) {<...
-- sha1_to_hex(E1->hash)
-+ oid_to_hex(E1)
+- sha1_to_hex(OIDPTR->hash)
++ oid_to_hex(OIDPTR)
   ...>}
 
 @@
-expression E1, E2;
+expression E;
+struct object_id OID;
 @@
-- sha1_to_hex_r(E1, E2.hash)
-+ oid_to_hex_r(E1, &E2)
+- sha1_to_hex_r(E, OID.hash)
++ oid_to_hex_r(E, &OID)
 
 @@
 identifier f != oid_to_hex_r;
-expression E1, E2;
+expression E;
+struct object_id *OIDPTR;
 @@
    f(...) {<...
-- sha1_to_hex_r(E1, E2->hash)
-+ oid_to_hex_r(E1, E2)
+- sha1_to_hex_r(E, OIDPTR->hash)
++ oid_to_hex_r(E, OIDPTR)
   ...>}
 
 @@
-expression E1;
+struct object_id OID;
 @@
-- hashclr(E1.hash)
-+ oidclr(&E1)
+- hashclr(OID.hash)
++ oidclr(&OID)
 
 @@
 identifier f != oidclr;
-expression E1;
+struct object_id *OIDPTR;
 @@
   f(...) {<...
-- hashclr(E1->hash)
-+ oidclr(E1)
+- hashclr(OIDPTR->hash)
++ oidclr(OIDPTR)
   ...>}
 
 @@
-expression E1, E2;
+struct object_id OID1, OID2;
 @@
-- hashcmp(E1.hash, E2.hash)
-+ oidcmp(&E1, &E2)
+- hashcmp(OID1.hash, OID2.hash)
++ oidcmp(&OID1, &OID2)
 
 @@
 identifier f != oidcmp;
-expression E1, E2;
+struct object_id *OIDPTR1, OIDPTR2;
 @@
   f(...) {<...
-- hashcmp(E1->hash, E2->hash)
-+ oidcmp(E1, E2)
+- hashcmp(OIDPTR1->hash, OIDPTR2->hash)
++ oidcmp(OIDPTR1, OIDPTR2)
   ...>}
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcmp(E1->hash, E2.hash)
-+ oidcmp(E1, &E2)
+- hashcmp(OIDPTR->hash, OID.hash)
++ oidcmp(OIDPTR, &OID)
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcmp(E1.hash, E2->hash)
-+ oidcmp(&E1, E2)
+- hashcmp(OID.hash, OIDPTR->hash)
++ oidcmp(&OID, OIDPTR)
 
 @@
-expression E1, E2;
+struct object_id OID1, OID2;
 @@
-- hashcpy(E1.hash, E2.hash)
-+ oidcpy(&E1, &E2)
+- hashcpy(OID1.hash, OID2.hash)
++ oidcpy(&OID1, &OID2)
 
 @@
 identifier f != oidcpy;
-expression E1, E2;
+struct object_id *OIDPTR1;
+struct object_id *OIDPTR2;
 @@
   f(...) {<...
-- hashcpy(E1->hash, E2->hash)
-+ oidcpy(E1, E2)
+- hashcpy(OIDPTR1->hash, OIDPTR2->hash)
++ oidcpy(OIDPTR1, OIDPTR2)
   ...>}
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcpy(E1->hash, E2.hash)
-+ oidcpy(E1, &E2)
+- hashcpy(OIDPTR->hash, OID.hash)
++ oidcpy(OIDPTR, &OID)
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR;
+struct object_id OID;
 @@
-- hashcpy(E1.hash, E2->hash)
-+ oidcpy(&E1, E2)
+- hashcpy(OID.hash, OIDPTR->hash)
++ oidcpy(&OID, OIDPTR)
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR1;
+struct object_id *OIDPTR2;
 @@
-- oidcmp(E1, E2) == 0
-+ oideq(E1, E2)
+- oidcmp(OIDPTR1, OIDPTR2) == 0
++ oideq(OIDPTR1, OIDPTR2)
 
 @@
 identifier f != hasheq;
@@ -125,10 +133,11 @@ expression E1, E2;
   ...>}
 
 @@
-expression E1, E2;
+struct object_id *OIDPTR1;
+struct object_id *OIDPTR2;
 @@
-- oidcmp(E1, E2) != 0
-+ !oideq(E1, E2)
+- oidcmp(OIDPTR1, OIDPTR2) != 0
++ !oideq(OIDPTR1, OIDPTR2)
 
 @@
 identifier f != hasheq;
-- 
2.19.1.465.gaff195083f

