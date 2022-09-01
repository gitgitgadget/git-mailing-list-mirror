Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F287CECAAD4
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiIAAbC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbiIAAaX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:23 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254A8AB411
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:20 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id b5so20260907wrr.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=EcdrArJbkoIin3rbgtMSYGVs6oL8Z+0m0NcLO+turgs=;
        b=JIMzJVDick4DYet5ExWjkq/+t+6fFjFtWdZjpTqyd4ccXo/dt9AUkO6jshA55D2Xaa
         WZxQ7a/0gXALgfMSNx2qeZthP/G9zKnKQGs0oTsdNT197IZiE06IoNORPsYSDMnsq1xc
         CuYckHnirYlndC6swQV39NSvuOTP3F8FeS31adtmi/U9ALpRx56oJhQg00qZNjjchg+3
         oQF/IABv0ntMj0mw0gVrM3810LPRhTiB3BBel+nNvAPR5onupldehgrWQlJvZ7DS2e9x
         UPl0PPnVpJPZexsmydUgD9Pz46VsseF3yd1D8nfTMQotO1Odb4sW4AFAcrj4epooE8Ql
         lwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=EcdrArJbkoIin3rbgtMSYGVs6oL8Z+0m0NcLO+turgs=;
        b=ONkZT+KWVK6Y/ydRwVste4OrN5T4LyHPD7xJKLyA7F3JMRREhGx6c0iHJ4rhvW8624
         NHbkXTzSoFNTT4T+Doj/vVIbAfURbXQwQunQcO4ijTH8XsDW0uwfl2MSxnlzXHFsGKN7
         tb2qRPHppcyWMuDhDd/i7+26nClF6krQrmbwTwYHX3Ozd97vQNoKHA0IMvedIRpdhz6H
         OMisGKVSlsVOVofj3ay0TB26lJo+GPyw/gBiFTvq7Mxdvc8u3Mo8kwOleN3EKb/cfMzo
         O/GVlFFHxkUMMbWnVH4BDT3NMBgSWpWPWuBjP19ta72swkVUX6rV9O8ljggjuaGYkBia
         E05g==
X-Gm-Message-State: ACgBeo3onEXbRYzFf/uuRnkebTvsk2kOHR6yfBSbQKmEPUwWryF24k4Q
        hk635Df+PFl8MVOqb8rxdXjqVFUp9KQ=
X-Google-Smtp-Source: AA6agR7d+hs1rjTBuo0ng26M2s4vjf4MJ+0MxAGfMX5aAYb4Lj2HKAXTXrXqg8S7mARNkFyZIostJw==
X-Received: by 2002:a5d:5047:0:b0:226:eb0a:d2d5 with SMTP id h7-20020a5d5047000000b00226eb0ad2d5mr3195035wrt.558.1661992219294;
        Wed, 31 Aug 2022 17:30:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l11-20020adff48b000000b0021e6277bc50sm15668521wro.36.2022.08.31.17.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:18 -0700 (PDT)
Message-Id: <f5dbcbf78db127d738c11a1aca416201298426cf.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:56 +0000
Subject: [PATCH 18/18] t: retire unused chainlint.sed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Retire chainlint.sed since it has been replaced by a more accurate and
functional &&-chain "linter", thus is no longer used.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed | 399 ------------------------------------------------
 1 file changed, 399 deletions(-)
 delete mode 100644 t/chainlint.sed

diff --git a/t/chainlint.sed b/t/chainlint.sed
deleted file mode 100644
index dc4ce37cb51..00000000000
--- a/t/chainlint.sed
+++ /dev/null
@@ -1,399 +0,0 @@
-#------------------------------------------------------------------------------
-# Detect broken &&-chains in tests.
-#
-# At present, only &&-chains in subshells are examined by this linter;
-# top-level &&-chains are instead checked directly by the test framework. Like
-# the top-level &&-chain linter, the subshell linter (intentionally) does not
-# check &&-chains within {...} blocks.
-#
-# Checking for &&-chain breakage is done line-by-line by pure textual
-# inspection.
-#
-# Incomplete lines (those ending with "\") are stitched together with following
-# lines to simplify processing, particularly of "one-liner" statements.
-# Top-level here-docs are swallowed to avoid false positives within the
-# here-doc body, although the statement to which the here-doc is attached is
-# retained.
-#
-# Heuristics are used to detect end-of-subshell when the closing ")" is cuddled
-# with the final subshell statement on the same line:
-#
-#    (cd foo &&
-#        bar)
-#
-# in order to avoid misinterpreting the ")" in constructs such as "x=$(...)"
-# and "case $x in *)" as ending the subshell.
-#
-# Lines missing a final "&&" are flagged with "?!AMP?!", as are lines which
-# chain commands with ";" internally rather than "&&". A line may be flagged
-# for both violations.
-#
-# Detection of a missing &&-link in a multi-line subshell is complicated by the
-# fact that the last statement before the closing ")" must not end with "&&".
-# Since processing is line-by-line, it is not known whether a missing "&&" is
-# legitimate or not until the _next_ line is seen. To accommodate this, within
-# multi-line subshells, each line is stored in sed's "hold" area until after
-# the next line is seen and processed. If the next line is a stand-alone ")",
-# then a missing "&&" on the previous line is legitimate; otherwise a missing
-# "&&" is a break in the &&-chain.
-#
-#    (
-#         cd foo &&
-#         bar
-#    )
-#
-# In practical terms, when "bar" is encountered, it is flagged with "?!AMP?!",
-# but when the stand-alone ")" line is seen which closes the subshell, the
-# "?!AMP?!" violation is removed from the "bar" line (retrieved from the "hold"
-# area) since the final statement of a subshell must not end with "&&". The
-# final line of a subshell may still break the &&-chain by using ";" internally
-# to chain commands together rather than "&&", but an internal "?!AMP?!" is
-# never removed from a line even though a line-ending "?!AMP?!" might be.
-#
-# Care is taken to recognize the last _statement_ of a multi-line subshell, not
-# necessarily the last textual _line_ within the subshell, since &&-chaining
-# applies to statements, not to lines. Consequently, blank lines, comment
-# lines, and here-docs are swallowed (but not the command to which the here-doc
-# is attached), leaving the last statement in the "hold" area, not the last
-# line, thus simplifying &&-link checking.
-#
-# The final statement before "done" in for- and while-loops, and before "elif",
-# "else", and "fi" in if-then-else likewise must not end with "&&", thus
-# receives similar treatment.
-#
-# Swallowing here-docs with arbitrary tags requires a bit of finesse. When a
-# line such as "cat <<EOF" is seen, the here-doc tag is copied to the front of
-# the line enclosed in angle brackets as a sentinel, giving "<EOF>cat <<EOF".
-# As each subsequent line is read, it is appended to the target line and a
-# (whitespace-loose) back-reference match /^<(.*)>\n\1$/ is attempted to see if
-# the content inside "<...>" matches the entirety of the newly-read line. For
-# instance, if the next line read is "some data", when concatenated with the
-# target line, it becomes "<EOF>cat <<EOF\nsome data", and a match is attempted
-# to see if "EOF" matches "some data". Since it doesn't, the next line is
-# attempted. When a line consisting of only "EOF" (and possible whitespace) is
-# encountered, it is appended to the target line giving "<EOF>cat <<EOF\nEOF",
-# in which case the "EOF" inside "<...>" does match the text following the
-# newline, thus the closing here-doc tag has been found. The closing tag line
-# and the "<...>" prefix on the target line are then discarded, leaving just
-# the target line "cat <<EOF".
-#------------------------------------------------------------------------------
-
-# incomplete line -- slurp up next line
-:squash
-/\\$/ {
-	N
-	s/\\\n//
-	bsquash
-}
-
-# here-doc -- swallow it to avoid false hits within its body (but keep the
-# command to which it was attached)
-/<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/ {
-	/"[^"]*<<[^"]*"/bnotdoc
-	s/^\(.*<<-*[ 	]*\)[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\2>\1\2/
-	:hered
-	N
-	/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
-		s/\n.*$//
-		bhered
-	}
-	s/^<[^>]*>//
-	s/\n.*$//
-}
-:notdoc
-
-# one-liner "(...) &&"
-/^[ 	]*!*[ 	]*(..*)[ 	]*&&[ 	]*$/boneline
-
-# same as above but without trailing "&&"
-/^[ 	]*!*[ 	]*(..*)[ 	]*$/boneline
-
-# one-liner "(...) >x" (or "2>x" or "<x" or "|x" or "&"
-/^[ 	]*!*[ 	]*(..*)[ 	]*[0-9]*[<>|&]/boneline
-
-# multi-line "(...\n...)"
-/^[ 	]*(/bsubsh
-
-# innocuous line -- print it and advance to next line
-b
-
-# found one-liner "(...)" -- mark suspect if it uses ";" internally rather than
-# "&&" (but not ";" in a string)
-:oneline
-/;/{
-	/"[^"]*;[^"]*"/!s/;/; ?!AMP?!/
-}
-b
-
-:subsh
-# bare "(" line? -- stash for later printing
-/^[ 	]*([	]*$/ {
-	h
-	bnextln
-}
-# "(..." line -- "(" opening subshell cuddled with command; temporarily replace
-# "(" with sentinel "^" and process the line as if "(" had been seen solo on
-# the preceding line; this temporary replacement prevents several rules from
-# accidentally thinking "(" introduces a nested subshell; "^" is changed back
-# to "(" at output time
-x
-s/.*//
-x
-s/(/^/
-bslurp
-
-:nextln
-N
-s/.*\n//
-
-:slurp
-# incomplete line "...\"
-/\\$/bicmplte
-# multi-line quoted string "...\n..."?
-/"/bdqstr
-# multi-line quoted string '...\n...'? (but not contraction in string "it's")
-/'/{
-	/"[^'"]*'[^'"]*"/!bsqstr
-}
-:folded
-# here-doc -- swallow it (but not "<<" in a string)
-/<<-*[ 	]*[\\'"]*[A-Za-z0-9_]/{
-	/"[^"]*<<[^"]*"/!bheredoc
-}
-# comment or empty line -- discard since final non-comment, non-empty line
-# before closing ")", "done", "elsif", "else", or "fi" will need to be
-# re-visited to drop "suspect" marking since final line of those constructs
-# legitimately lacks "&&", so "suspect" mark must be removed
-/^[ 	]*#/bnextln
-/^[ 	]*$/bnextln
-# in-line comment -- strip it (but not "#" in a string, Bash ${#...} array
-# length, or Perforce "//depot/path#42" revision in filespec)
-/[ 	]#/{
-	/"[^"]*#[^"]*"/!s/[ 	]#.*$//
-}
-# one-liner "case ... esac"
-/^[ 	^]*case[ 	]*..*esac/bchkchn
-# multi-line "case ... esac"
-/^[ 	^]*case[ 	]..*[ 	]in/bcase
-# multi-line "for ... done" or "while ... done"
-/^[ 	^]*for[ 	]..*[ 	]in/bcont
-/^[ 	^]*while[ 	]/bcont
-/^[ 	]*do[ 	]/bcont
-/^[ 	]*do[ 	]*$/bcont
-/;[ 	]*do/bcont
-/^[ 	]*done[ 	]*&&[ 	]*$/bdone
-/^[ 	]*done[ 	]*$/bdone
-/^[ 	]*done[ 	]*[<>|]/bdone
-/^[ 	]*done[ 	]*)/bdone
-/||[ 	]*exit[ 	]/bcont
-/||[ 	]*exit[ 	]*$/bcont
-# multi-line "if...elsif...else...fi"
-/^[ 	^]*if[ 	]/bcont
-/^[ 	]*then[ 	]/bcont
-/^[ 	]*then[ 	]*$/bcont
-/;[ 	]*then/bcont
-/^[ 	]*elif[ 	]/belse
-/^[ 	]*elif[ 	]*$/belse
-/^[ 	]*else[ 	]/belse
-/^[ 	]*else[ 	]*$/belse
-/^[ 	]*fi[ 	]*&&[ 	]*$/bdone
-/^[ 	]*fi[ 	]*$/bdone
-/^[ 	]*fi[ 	]*[<>|]/bdone
-/^[ 	]*fi[ 	]*)/bdone
-# nested one-liner "(...) &&"
-/^[ 	^]*(.*)[ 	]*&&[ 	]*$/bchkchn
-# nested one-liner "(...)"
-/^[ 	^]*(.*)[ 	]*$/bchkchn
-# nested one-liner "(...) >x" (or "2>x" or "<x" or "|x")
-/^[ 	^]*(.*)[ 	]*[0-9]*[<>|]/bchkchn
-# nested multi-line "(...\n...)"
-/^[ 	^]*(/bnest
-# multi-line "{...\n...}"
-/^[ 	^]*{/bblock
-# closing ")" on own line -- exit subshell
-/^[ 	]*)/bclssolo
-# "$((...))" -- arithmetic expansion; not closing ")"
-/\$(([^)][^)]*))[^)]*$/bchkchn
-# "$(...)" -- command substitution; not closing ")"
-/\$([^)][^)]*)[^)]*$/bchkchn
-# multi-line "$(...\n...)" -- command substitution; treat as nested subshell
-/\$([^)]*$/bnest
-# "=(...)" -- Bash array assignment; not closing ")"
-/=(/bchkchn
-# closing "...) &&"
-/)[ 	]*&&[ 	]*$/bclose
-# closing "...)"
-/)[ 	]*$/bclose
-# closing "...) >x" (or "2>x" or "<x" or "|x")
-/)[ 	]*[<>|]/bclose
-:chkchn
-# mark suspect if line uses ";" internally rather than "&&" (but not ";" in a
-# string and not ";;" in one-liner "case...esac")
-/;/{
-	/;;/!{
-		/"[^"]*;[^"]*"/!s/;/; ?!AMP?!/
-	}
-}
-# line ends with pipe "...|" -- valid; not missing "&&"
-/|[ 	]*$/bcont
-# missing end-of-line "&&" -- mark suspect
-/&&[ 	]*$/!s/$/ ?!AMP?!/
-:cont
-# retrieve and print previous line
-x
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-n
-bslurp
-
-# found incomplete line "...\" -- slurp up next line
-:icmplte
-N
-s/\\\n//
-bslurp
-
-# check for multi-line double-quoted string "...\n..." -- fold to one line
-:dqstr
-# remove all quote pairs
-s/"\([^"]*\)"/@!\1@!/g
-# done if no dangling quote
-/"/!bdqdone
-# otherwise, slurp next line and try again
-N
-s/\n//
-bdqstr
-:dqdone
-s/@!/"/g
-bfolded
-
-# check for multi-line single-quoted string '...\n...' -- fold to one line
-:sqstr
-# remove all quote pairs
-s/'\([^']*\)'/@!\1@!/g
-# done if no dangling quote
-/'/!bsqdone
-# otherwise, slurp next line and try again
-N
-s/\n//
-bsqstr
-:sqdone
-s/@!/'/g
-bfolded
-
-# found here-doc -- swallow it to avoid false hits within its body (but keep
-# the command to which it was attached)
-:heredoc
-s/^\(.*\)<<\(-*[ 	]*\)[\\'"]*\([A-Za-z0-9_][A-Za-z0-9_]*\)['"]*/<\3>\1?!HERE?!\2\3/
-:hdocsub
-N
-/^<\([^>]*\)>.*\n[ 	]*\1[ 	]*$/!{
-	s/\n.*$//
-	bhdocsub
-}
-s/^<[^>]*>//
-s/\n.*$//
-bfolded
-
-# found "case ... in" -- pass through untouched
-:case
-x
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-n
-:cascom
-/^[ 	]*#/{
-	N
-	s/.*\n//
-	bcascom
-}
-/^[ 	]*esac/bslurp
-bcase
-
-# found "else" or "elif" -- drop "suspect" from final line before "else" since
-# that line legitimately lacks "&&"
-:else
-x
-s/\( ?!AMP?!\)* ?!AMP?!$//
-x
-bcont
-
-# found "done" closing for-loop or while-loop, or "fi" closing if-then -- drop
-# "suspect" from final contained line since that line legitimately lacks "&&"
-:done
-x
-s/\( ?!AMP?!\)* ?!AMP?!$//
-x
-# is 'done' or 'fi' cuddled with ")" to close subshell?
-/done.*)/bclose
-/fi.*)/bclose
-bchkchn
-
-# found nested multi-line "(...\n...)" -- pass through untouched
-:nest
-x
-:nstslrp
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-n
-:nstcom
-# comment -- not closing ")" if in comment
-/^[ 	]*#/{
-	N
-	s/.*\n//
-	bnstcom
-}
-# closing ")" on own line -- stop nested slurp
-/^[ 	]*)/bnstcl
-# "$((...))" -- arithmetic expansion; not closing ")"
-/\$(([^)][^)]*))[^)]*$/bnstcnt
-# "$(...)" -- command substitution; not closing ")"
-/\$([^)][^)]*)[^)]*$/bnstcnt
-# closing "...)" -- stop nested slurp
-/)/bnstcl
-:nstcnt
-x
-bnstslrp
-:nstcl
-# is it "))" which closes nested and parent subshells?
-/)[ 	]*)/bslurp
-bchkchn
-
-# found multi-line "{...\n...}" block -- pass through untouched
-:block
-x
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-n
-:blkcom
-/^[ 	]*#/{
-	N
-	s/.*\n//
-	bblkcom
-}
-# closing "}" -- stop block slurp
-/}/bchkchn
-bblock
-
-# found closing ")" on own line -- drop "suspect" from final line of subshell
-# since that line legitimately lacks "&&" and exit subshell loop
-:clssolo
-x
-s/\( ?!AMP?!\)* ?!AMP?!$//
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-p
-x
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-b
-
-# found closing "...)" -- exit subshell loop
-:close
-x
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-p
-x
-s/^\([ 	]*\)^/\1(/
-s/?!HERE?!/<</g
-b
-- 
gitgitgadget
