Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1461F404
	for <e@80x24.org>; Fri, 24 Aug 2018 15:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbeHXSzl (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 14:55:41 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46234 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbeHXSzl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 14:55:41 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so7767661wrc.13
        for <git@vger.kernel.org>; Fri, 24 Aug 2018 08:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eF4Y6yP13d8ZfGBL5/gGFwpyLrHDLByx1MZu3iWLRgo=;
        b=aAgEf7uPSLA3jtAXmQINO99CZpy0b7e9FLZnBOXs7SeVvS20iSAyEOc2v10ZggYzxu
         AR7u/WcWGfUNqMIGfp2iBFh5EbutK1UK2vZ4rduxiPyNm/fKfpYH4hD+1EF4kjwuSZ8d
         LG3BocwoUIdfP6/32SBSzDLR4HRCA1nMXevTYhrznOgQIzrdjeOgArqDAHrghJKnOU8F
         3qMLEZe6zbWrMoJ5uRyn4lXF/IqKBCzBd8QVUfeJI4TYgbbyt8tsZEZqLqdgOjU6enT6
         YN4Bx6B5CCY/pBHqYRsTjamKsBLjWT9uZULktH/GWZj2sFGDe41uOp/NZJraQ4qPpVR+
         vBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eF4Y6yP13d8ZfGBL5/gGFwpyLrHDLByx1MZu3iWLRgo=;
        b=kqhi21IDHBbtN9BVY40Ft/GkSJwRxtl4RzoKfwbNbLMaPHF48JI1aMakcj0sPXM+r6
         2q2ITJ8lisf3OT3dm+R59WXcf+S9RbIouTvUlrHNuSh5uLBueNJgk/5CTHW6uBJQOqUM
         dhsg1u66ZFG2PaiqI6XYtoUaeDyOCC7OQ6m9QXNh8VTE7z6E+nTTzY84921I2C5CwMPZ
         RXaOMiWC/DIUc+2EBTnwrzanM+LdNEiVWVyqeQeLIJS/74fnWs7n3NFFnqggdczd5ij/
         sVCADxDE9/ZbrASfoevoNG8oVWfpdqx/R32+zvUMdxU05kjjb4a3LWHUyTiZ+qAWFHw5
         zdfg==
X-Gm-Message-State: APzg51A07oQ4QZDdP9nhATT5qUuNGrfXeskOtOUTA0YAhD9MVWW7bpCK
        OcqIjQSvZnGvw2uV6A9Qb+uHWJdR/y4=
X-Google-Smtp-Source: ANB0VdbG0SgvsALMARycJiHAvIrr51H67I1wlOP4bbMmASfGs8El63iUjE4LeHHXGSUI8gcNZcAj1w==
X-Received: by 2002:a5d:470d:: with SMTP id y13-v6mr1529834wrq.229.1535124034322;
        Fri, 24 Aug 2018 08:20:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id z16-v6sm6689485wrq.78.2018.08.24.08.20.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Aug 2018 08:20:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Benoit Lecocq <benoit@openbsd.org>, kn@openbsd.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 4/6] tests: use shorter here-docs in chainlint.sed for AIX sed
Date:   Fri, 24 Aug 2018 15:20:14 +0000
Message-Id: <20180824152016.20286-5-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
References: <CAPig+cS4yeHNbc1Anq1DtLPEEGLpGeGEV74JHZrYft2wRmZAPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the portability of chainlint by using shorter here-docs. On
AIX sed will complain about:

    sed: 0602-417 The label :hereslurp is greater than eight
    characters

This, in combination with the previous fix to this file makes
GIT_TEST_CHAIN_LINT=1 (which is the default) working again on AIX
without issues, and the "gmake check-chainlint" test also passes.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/chainlint.sed | 56 ++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/t/chainlint.sed b/t/chainlint.sed
index dcb4b333ed..c80d2fad7a 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -97,11 +97,11 @@
 /<<[ 	]*[-\\']*[A-Za-z0-9_]/ {
 	s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
 	s/[ 	]*<<//
-	:hereslurp
+	:hered
 	N
 	/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
 		s/\n.*$//
-		bhereslurp
+		bhered
 	}
 	s/^<[^>]*>//
 	s/\n.*$//
@@ -149,7 +149,7 @@ s/.*\n//
 
 :slurp
 # incomplete line "...\"
-/\\$/bincomplete
+/\\$/bicmplte
 # multi-line quoted string "...\n..."?
 /"/bdqstring
 # multi-line quoted string '...\n...'? (but not contraction in string "it's")
@@ -171,7 +171,7 @@ s/.*\n//
 	/"[^"]*#[^"]*"/!s/[ 	]#.*$//
 }
 # one-liner "case ... esac"
-/^[ 	]*case[ 	]*..*esac/bcheckchain
+/^[ 	]*case[ 	]*..*esac/bchkchn
 # multi-line "case ... esac"
 /^[ 	]*case[ 	]..*[ 	]in/bcase
 # multi-line "for ... done" or "while ... done"
@@ -200,32 +200,32 @@ s/.*\n//
 /^[ 	]*fi[ 	]*[<>|]/bdone
 /^[ 	]*fi[ 	]*)/bdone
 # nested one-liner "(...) &&"
-/^[ 	]*(.*)[ 	]*&&[ 	]*$/bcheckchain
+/^[ 	]*(.*)[ 	]*&&[ 	]*$/bchkchn
 # nested one-liner "(...)"
-/^[ 	]*(.*)[ 	]*$/bcheckchain
+/^[ 	]*(.*)[ 	]*$/bchkchn
 # nested one-liner "(...) >x" (or "2>x" or "<x" or "|x")
-/^[ 	]*(.*)[ 	]*[0-9]*[<>|]/bcheckchain
+/^[ 	]*(.*)[ 	]*[0-9]*[<>|]/bchkchn
 # nested multi-line "(...\n...)"
 /^[ 	]*(/bnest
 # multi-line "{...\n...}"
 /^[ 	]*{/bblock
 # closing ")" on own line -- exit subshell
-/^[ 	]*)/bclosesolo
+/^[ 	]*)/bclssolo
 # "$((...))" -- arithmetic expansion; not closing ")"
-/\$(([^)][^)]*))[^)]*$/bcheckchain
+/\$(([^)][^)]*))[^)]*$/bchkchn
 # "$(...)" -- command substitution; not closing ")"
-/\$([^)][^)]*)[^)]*$/bcheckchain
+/\$([^)][^)]*)[^)]*$/bchkchn
 # multi-line "$(...\n...)" -- command substitution; treat as nested subshell
 /\$([^)]*$/bnest
 # "=(...)" -- Bash array assignment; not closing ")"
-/=(/bcheckchain
+/=(/bchkchn
 # closing "...) &&"
 /)[ 	]*&&[ 	]*$/bclose
 # closing "...)"
 /)[ 	]*$/bclose
 # closing "...) >x" (or "2>x" or "<x" or "|x")
 /)[ 	]*[<>|]/bclose
-:checkchain
+:chkchn
 # mark suspect if line uses ";" internally rather than "&&" (but not ";" in a
 # string and not ";;" in one-liner "case...esac")
 /;/{
@@ -244,7 +244,7 @@ n
 bslurp
 
 # found incomplete line "...\" -- slurp up next line
-:incomplete
+:icmplte
 N
 s/\\\n//
 bslurp
@@ -282,11 +282,11 @@ bfolded
 :heredoc
 s/^\(.*\)<<[ 	]*[-\\']*\([A-Za-z0-9_][A-Za-z0-9_]*\)'*/<\2>\1<</
 s/[ 	]*<<//
-:hereslurpsub
+:heredsub
 N
 /^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
 	s/\n.*$//
-	bhereslurpsub
+	bheredsub
 }
 s/^<[^>]*>//
 s/\n.*$//
@@ -316,43 +316,43 @@ x
 # is 'done' or 'fi' cuddled with ")" to close subshell?
 /done.*)/bclose
 /fi.*)/bclose
-bcheckchain
+bchkchn
 
 # found nested multi-line "(...\n...)" -- pass through untouched
 :nest
 x
-:nestslurp
+:nstslurp
 n
 # closing ")" on own line -- stop nested slurp
-/^[ 	]*)/bnestclose
+/^[ 	]*)/bnstclose
 # comment -- not closing ")" if in comment
-/^[ 	]*#/bnestcontinue
+/^[ 	]*#/bnstcnt
 # "$((...))" -- arithmetic expansion; not closing ")"
-/\$(([^)][^)]*))[^)]*$/bnestcontinue
+/\$(([^)][^)]*))[^)]*$/bnstcnt
 # "$(...)" -- command substitution; not closing ")"
-/\$([^)][^)]*)[^)]*$/bnestcontinue
+/\$([^)][^)]*)[^)]*$/bnstcnt
 # closing "...)" -- stop nested slurp
-/)/bnestclose
-:nestcontinue
+/)/bnstclose
+:nstcnt
 x
-bnestslurp
-:nestclose
+bnstslurp
+:nstclose
 s/^/>>/
 # is it "))" which closes nested and parent subshells?
 /)[ 	]*)/bslurp
-bcheckchain
+bchkchn
 
 # found multi-line "{...\n...}" block -- pass through untouched
 :block
 x
 n
 # closing "}" -- stop block slurp
-/}/bcheckchain
+/}/bchkchn
 bblock
 
 # found closing ")" on own line -- drop "suspect" from final line of subshell
 # since that line legitimately lacks "&&" and exit subshell loop
-:closesolo
+:clssolo
 x
 s/?!AMP?!//
 p
-- 
2.18.0.865.gffc8e1a3cd6

