Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F12C4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbiKIRBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 12:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbiKIRAz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 12:00:55 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333913CFB
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 08:58:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h9so26758224wrt.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 08:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Jzh+0MPxBQhnbGSanUWM0t/1IOrgMetYazY8mp6q3w=;
        b=E5ZyBEibEM100itBXkyUqVma7BiVhVPkLdq6zAWx2LONqj+n6U1BXbsIfkKYrbkwL6
         iIXKPlU9b/17Yey2u5C9C6DkTrbHlVa46X9wpe4wUShKPf+QwL1hVgLDpqxwO87Ep8Ps
         HdJUaN0aapEn5GcDfQ2IGeLQaS0hbtWBQulyn5jobTRgKQbN8oOo2f/jE+s1ZnWeQoxd
         Gcoe9iCwEQJJmfq50V3k4psSy1vQaI2VSMt7ZGexVwxODezjLdX9lxfa+oahuHQWpFTk
         +DaqHrcRvNF1kM7lok+lBbpjLCVPd8xDStDzjRAzETe+9ZfrdIqW8E8k5UkfsucHefkf
         EbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Jzh+0MPxBQhnbGSanUWM0t/1IOrgMetYazY8mp6q3w=;
        b=6/JDUX+3E3bo6QefaFBhraetk1oxD02YkmFchnb9G3sHDyCAHixBCw3r4OQ7MsWOt3
         xpQoX/r9KR7FgKNWKoToBdqfRnwa3sYs3Nq4EvBDrJ0sfJUjaiK9DiyvMZ0GW6Y4A3C1
         E/1iOPm/ffIc1d4ZJWdjmBURX97AgVinkOzFmUlmI4DaCv5VQA3JNDSM7flftXDoctcU
         RvMcrS22LAMDBtv/WS9l7E8tB+qTuQclDel8I/glaZ0T1PqJw2dia+3i6fUi4hddrUwM
         lMpIrS5ysXhk6zKy3oFMTmFR/+gFWH3fmkOBeDYdKDxLEiO7clITNjs1YXsqqa7n40yf
         Z/Jg==
X-Gm-Message-State: ACrzQf1qmsJ/YMTk94BOpX288mSAcFtpp5V2BCYOcGWHB2oUH/fX/0S0
        v1M45MMvrSNoI8pOGFLI3xvxUL6GX6M=
X-Google-Smtp-Source: AMsMyM5m1heuNwE9eaA9fnBReWuvhTagbKAqoBWboyUoMlF2n27099EghbfOnQrqFfW99N3XRpLqAA==
X-Received: by 2002:a5d:5004:0:b0:236:c92e:5b41 with SMTP id e4-20020a5d5004000000b00236c92e5b41mr36253612wrt.655.1668013122362;
        Wed, 09 Nov 2022 08:58:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c199100b003b4fdbb6319sm2307279wmq.21.2022.11.09.08.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 08:58:41 -0800 (PST)
Message-Id: <c8a316426be4cefb6382f524a89226c76d6d1d97.1668013114.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
References: <pull.1413.git.1668013114.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Nov 2022 16:58:33 +0000
Subject: [PATCH 2/3] chainlint: latch line numbers at which each token starts
 and ends
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

When chainlint detects problems in a test, it prints out the name of the
test script, the name of the problematic test, and a copy of the test
definition with "?!FOO?!" annotations inserted at the locations where
problems were detected. Taken together this information is sufficient
for the test author to identify the problematic code in the original
test definition. However, in a lengthy script or a lengthy test
definition, the author may still end up using the editor's search
feature to home in on the exact problem location.

To further assist the test author, an upcoming change will display line
numbers along with the annotated test definition, thus allowing the
author to jump directly to each problematic line. As preparation,
upgrade Lexer to latch the line numbers at which each token starts and
ends, and return that information with the token itself.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index fcf4d459249..01f261165b1 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -67,6 +67,7 @@ sub new {
 	bless {
 		parser => $parser,
 		buff => $s,
+		lineno => 1,
 		heretags => []
 	} => $class;
 }
@@ -97,7 +98,9 @@ sub scan_op {
 sub scan_sqstring {
 	my $self = shift @_;
 	${$self->{buff}} =~ /\G([^']*'|.*\z)/sgc;
-	return "'" . $1;
+	my $s = $1;
+	$self->{lineno} += () = $s =~ /\n/sg;
+	return "'" . $s;
 }
 
 sub scan_dqstring {
@@ -115,7 +118,7 @@ sub scan_dqstring {
 		if ($c eq '\\') {
 			$s .= '\\', last unless $$b =~ /\G(.)/sgc;
 			$c = $1;
-			next if $c eq "\n"; # line splice
+			$self->{lineno}++, next if $c eq "\n"; # line splice
 			# backslash escapes only $, `, ", \ in dq-string
 			$s .= '\\' unless $c =~ /^[\$`"\\]$/;
 			$s .= $c;
@@ -123,6 +126,7 @@ sub scan_dqstring {
 		}
 		die("internal error scanning dq-string '$c'\n");
 	}
+	$self->{lineno} += () = $s =~ /\n/sg;
 	return $s;
 }
 
@@ -137,6 +141,7 @@ sub scan_balanced {
 		$depth--;
 		last if $depth == 0;
 	}
+	$self->{lineno} += () = $s =~ /\n/sg;
 	return $s;
 }
 
@@ -165,6 +170,8 @@ sub swallow_heredocs {
 	while (my $tag = shift @$tags) {
 		my $indent = $tag =~ s/^\t// ? '\\s*' : '';
 		$$b =~ /(?:\G|\n)$indent\Q$tag\E(?:\n|\z)/gc;
+		my $body = $&;
+		$self->{lineno} += () = $body =~ /\n/sg;
 	}
 }
 
@@ -172,11 +179,12 @@ sub scan_token {
 	my $self = shift @_;
 	my $b = $self->{buff};
 	my $token = '';
-	my $start;
+	my ($start, $startln);
 RESTART:
+	$startln = $self->{lineno};
 	$$b =~ /\G[ \t]+/gc; # skip whitespace (but not newline)
 	$start = pos($$b) || 0;
-	return ["\n", $start, pos($$b)] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
+	$self->{lineno}++, return ["\n", $start, pos($$b), $startln, $startln] if $$b =~ /\G#[^\n]*(?:\n|\z)/gc; # comment
 	while (1) {
 		# slurp up non-special characters
 		$token .= $1 if $$b =~ /\G([^\\;&|<>(){}'"\$\s]+)/gc;
@@ -188,20 +196,20 @@ RESTART:
 		$token .= $self->scan_sqstring(), next if $c eq "'";
 		$token .= $self->scan_dqstring(), next if $c eq '"';
 		$token .= $c . $self->scan_dollar(), next if $c eq '$';
-		$self->swallow_heredocs(), $token = $c, last if $c eq "\n";
+		$self->{lineno}++, $self->swallow_heredocs(), $token = $c, last if $c eq "\n";
 		$token = $self->scan_op($c), last if $c =~ /^[;&|<>]$/;
 		$token = $c, last if $c =~ /^[(){}]$/;
 		if ($c eq '\\') {
 			$token .= '\\', last unless $$b =~ /\G(.)/sgc;
 			$c = $1;
-			next if $c eq "\n" && length($token); # line splice
-			goto RESTART if $c eq "\n"; # line splice
+			$self->{lineno}++, next if $c eq "\n" && length($token); # line splice
+			$self->{lineno}++, goto RESTART if $c eq "\n"; # line splice
 			$token .= '\\' . $c;
 			next;
 		}
 		die("internal error scanning character '$c'\n");
 	}
-	return length($token) ? [$token, $start, pos($$b)] : undef;
+	return length($token) ? [$token, $start, pos($$b), $startln, $self->{lineno}] : undef;
 }
 
 # ShellParser parses POSIX shell scripts (with minor extensions for Bash). It
-- 
gitgitgadget

