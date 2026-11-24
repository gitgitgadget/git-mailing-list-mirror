Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510200;
	b=40VaF+p5/LAud8nTCmBo/E6OSeq4TKaK98FQfFV98/FwNvzhz7Gw650+HE0AVBOAz4ae
	 +gh4NS9GQ41FXGpHfiJ8NKL1B9o0XujOhWtt1MXLajKKzeKpVwQ/R4EAB1NV9Y+J6v4ZC
	 kV3iiPNlYenx3z100Yt4HQJx+PYmyForH9Rmtf0/sItQ7bTe7CxJSaWCaqcu6UKo1+j1L
	 ajXNXnP7xhi0CpRsxFQFaFHgNFqe7U/k2UF7MIo7ob2qd5BVSWewAV8u2owIxzbXzJlHK
	 DhZWzVfFoUg6q5r6jx50tz5WZSkvfPhb3DbOSUPp89OzCewqs62zpmGcH3Vrtr4WrdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510200;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=k80cSzc06GaDjk6t4aMFRdskxL6X0OWtnip7aCk4GuU=;
	b=R/jHnVYPJvnDc1wZNdaGFl/xtgXAgFo4nozsaCnqTHNfl960ho3ycKl/NTdh1hZHDrB0
	 elZqDVTln1qyOH1PTeGE6ve2T2Zv2dNR6ZNTmRyL5lyn9NSZMejxqVIrVTVPUBjdSVhWZ
	 gbx5jIRojoHENuXSjsFd5SmdG0CUxFdrmhTm7LjwncRPthBTVZ/Q6NusBb9Gv9NIYzcaP
	 WiyS1yQjihcyc8R/Llv0lhNae2RYbNTxbtW44tll5TxoK/FD3e5IW0ulz8Noz70DeSc1n
	 CC1o9B3+aeKlH58qlu/bK1MSIN+lXMvrM23IBZZzBNCFIkiqxncV2ZXiBFdsGA91T5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dc0eT12+;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246E606A321
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 08:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F246E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dc0eT12+
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdb15cd8558so1879402a12.2
        for <git@vger.kernel.org>; Tue, 24 Nov 2026 00:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795510199; x=1796114999; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=k80cSzc06GaDjk6t4aMFRdskxL6X0OWtnip7aCk4GuU=;
        b=dc0eT12+3CJOEg6VDqk4iO1dvdU2BWUz2VYPzztNLDMOa7LV4HqP2Ej76UFLMTw2pq
         Y8huF/MOZcV+Jp9mcm9jo+YDbhxX4yw3+K2J31qhTGU4ZPcTCfovkJSdRFx+VIgD/rL3
         +S1N9kTABOv7F/C7j+cCZ75PV+2p+xuzudLBtyfrNOTOplr8bw4RXLctayqImyH+n+Ur
         RfhpCuRPZKziVEqhSngpfjagGECAij5HGJX7Kczc+mrom6uPnuWwHtNiz5BKa8M3Bu2W
         zsGpVHOtBhJnkyt9/e9HhF0MoRL8UVsziusakfSXgUrP64hlXIHSj1vWVwGtadWcg9nS
         fvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795510199; x=1796114999;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=k80cSzc06GaDjk6t4aMFRdskxL6X0OWtnip7aCk4GuU=;
        b=Wqkm7gqxFYxXd9raqX+pbrPlSsSQ6SdcwthfhpIfroKI1mDoJ3UXVYG3Pm1LkbatmH
         Piqtx/KS8imV5bgPvqp4l5q4jQj6Vs0Pjl67XM9fZkv7IvkOnUHjSmWt3NU+oBL1fFqK
         XfejbpyC6pEeJieJahuV3y7oM7HzV08WjkwaK4yMteLSIjo+9qQU1omIEwQnh4I4OX/h
         J44ToA1EGoLCZgJxRdrYT8BnwJ8MqBMKJphtwhB54osVYnKrxVnG5KJ2DOiYQt5Cdw8K
         ++Pr/rIwhHGfSjAYKFL0aViO/lShxPSRcv1zAR8KkeRVQQ7dWmUb/vaOC5bgHaE/nSNG
         GZxA==
X-Gm-Message-State: APuU4Z9NJWgBeYDtH8Gz46eQ8EmyCICVlE8dirs0XSNAFDXcqiC+pDNI
	d8QNVd7/l97XFtD57QWDV62/o9M9h8MuPxTKhxT+RAw/DfEXJOpWyEaH2dzVCg==
X-Gm-Gg: AZFdTZfrVKJS22qNVPPV2h3FEx5y5gyWVl1+S6UTIea97V6/GHA7zGnFP/qQT9vXQE4
	IB++LgTDXofoJXvWAp43d29XRALsTbO78DoJJHxN3lrJMGUawel3F1jcq7iRQcZLwFfKNDxFGhe
	2mArBlXfuL5EEv7BUCBpkAcvTp6ZVe4TA5iwPd9f5F37wcGa7byGk5B2zvEypHTmJLp00L5MJwq
	ZFujyBFaba6ZYHljL3CzQce4oBK0Op7EQwfSkSsNpAULrG7m9gHPbS3W/wI7I8tuNP+clrda1tb
	buECQJH70ClOGGZSq3sLlnZ22zUKViTtXacaR7rjgSf07sqASkmSLAGijNa2DWj9ns1pvwhBqkb
	obO1ATJOMWiVqIyuT6rPupK32VQGhv1EODG4kFEFhlTlfKCQn8oARSIcD2jKNmPIAd0mzMY0ftt
	AzQPS49dOGYIDkCpVgFvDlkjSQBMf84Q1spR4RKowqgrhNJg/g+tAU36vhr8JOzS9vCs9bltFi+
	eYA1/Pkk5WtM1vKiazpt2bYSkycmjKldcdOSx92Jbie0oKK3E9gf7ZWcP1IDEhP8UAOddMnqoOG
	4tOqI1Pt0V3HSEc2DPgJBSd7vly3s1d0SQ==
X-Received: by 2002:a17:90b:1cc4:b0:3b3:af8e:ea98 with SMTP id 98e67ed59e1d1-3b41caeb09cmr11150108a91.37.1795510199218;
        Tue, 24 Nov 2026 00:49:59 -0800 (PST)
Received: from [127.0.0.1] ([52.159.247.168])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b48b41928esm11493574a91.9.2026.11.24.00.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 00:49:58 -0800 (PST)
Message-Id: <pull.2320.git.1795510197963.gitgitgadget@gmail.com>
From: "gremat via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Nov 2026 08:49:57 +0000
Subject: [PATCH] diff-highlight: support range-diff output
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    gremat <gremat@nextron-systems.com>

From: gremat <gremat@nextron-systems.com>

The output of "git range-diff" is a diff of diffs: each line carries
an outer marker (how the patch changed between versions) followed by
an inner marker (what the patch itself does), and the whole thing is
indented by four columns below a commit pair header such as

    1:  abc1234 ! 1:  def5678 subject

diff-highlight currently does not highlight anything in such output.
It neither strips the indentation nor recognizes the "@@" hunk header
that range-diff colors differently, and even when a removed/added
pair is found, is_pair_interesting() rejects it because the common
prefix contains the second marker.

Teach diff-highlight to:

  - recognize the range-diff commit pair header, and strip the
    four-column indentation of the following lines the same way we
    strip a --graph prefix;

  - accept color codes between "@@" and the following space when
    looking for a hunk header;

  - accept either the outer or the inner marker as the one forming a
    removed/added pair in is_pair_interesting();

  - pair up lines that share the same outer marker but form a
    removed/added pair in the inner diff (e.g. "+-old" and "++new",
    when a new version of a patch starts modifying a line), falling
    back to that when the outer hunk cannot be paired line by line.

Apart from the more lenient hunk header match, non-range-diff input is
not affected, as the new behavior is guarded
by the range-diff header having been seen.

Signed-off-by: gremat <gremat@nextron-systems.com>
---
    diff-highlight: support range-diff output

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2320%2Fgremat%2Ffeat%2Fdiff-highlight-support-range-diff-output-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2320/gremat/feat/diff-highlight-support-range-diff-output-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2320

 contrib/diff-highlight/DiffHighlight.pm       | 77 ++++++++++++++++---
 .../diff-highlight/t/t9400-diff-highlight.sh  | 63 +++++++++++++++
 2 files changed, 129 insertions(+), 11 deletions(-)

diff --git a/contrib/diff-highlight/DiffHighlight.pm b/contrib/diff-highlight/DiffHighlight.pm
index abe457882e..0e45d0fbf2 100644
--- a/contrib/diff-highlight/DiffHighlight.pm
+++ b/contrib/diff-highlight/DiffHighlight.pm
@@ -21,8 +21,10 @@ my $BORING = qr/$COLOR|\s/;
 
 my @removed;
 my @added;
+my @context;
 my $in_hunk;
 my $graph_indent = 0;
+my $range_diff;
 
 our $line_cb = sub { print @_ };
 our $flush_cb = sub { local $| = 1 };
@@ -72,10 +74,20 @@ sub handle_line {
 		# queued.
 		flush();
 		$graph_indent = visible_width($graph_prefix);
+		$range_diff = 0;
+
+	# match a range-diff commit pair header like "1:  abc1234 ! 1:  def5678";
+	# the diff-of-diffs that follows is indented by 4 columns, which we
+	# strip just like a graph prefix
+	} elsif (/^$COLOR*\s*(?:-+|\d+):\s+(?:-+|[0-9a-f]+)$BORING*[<>=!]$BORING*(?:-+|\d+):/) {
+		flush();
+		$graph_indent = 4;
+		$range_diff = 1;
 
 	} elsif ($graph_indent) {
 		if (length($_) < $graph_indent) {
 			$graph_indent = 0;
+			$range_diff = 0;
 		} else {
 			$_ = visible_substr($_, $graph_indent);
 		}
@@ -83,14 +95,22 @@ sub handle_line {
 
 	if (!$in_hunk) {
 		$line_cb->($orig);
-		$in_hunk = /^$COLOR*\@\@ /;
+		$in_hunk = /^$COLOR*\@\@$COLOR* /;
 	}
 	elsif (/^$COLOR*-/) {
+		flush() if @context;
 		push @removed, $orig;
 	}
 	elsif (/^$COLOR*\+/) {
+		flush() if @context;
 		push @added, $orig;
 	}
+	# in range-diff output, an unchanged line of the inner diff may still be
+	# part of an inner removed/added pair
+	elsif ($range_diff && /^$COLOR* $COLOR*[-+]/) {
+		flush() if @removed || @added;
+		push @context, $orig;
+	}
 	else {
 		flush();
 		$line_cb->($orig);
@@ -114,8 +134,34 @@ sub flush {
 	# Flush any queued hunk (this can happen when there is no trailing
 	# context in the final diff of the input).
 	show_hunk(\@removed, \@added);
+	show_inner(\@context);
 	@removed = ();
 	@added = ();
+	@context = ();
+}
+
+# In range-diff output, lines with the same outer marker can still form a
+# removed/added pair in the inner diff, e.g. "+-old" and "++new". Pair those
+# up among the given lines, which all share one outer marker.
+sub show_inner {
+	my (@rm, @add);
+	for my $line (@{$_[0]}) {
+		local $_ = visible_substr($line, $graph_indent);
+		if (/^$COLOR*[-+ ]$COLOR*-/) {
+			if (@add) {
+				show_hunk(\@rm, \@add, 1);
+				@rm = @add = ();
+			}
+			push @rm, $line;
+		} elsif (/^$COLOR*[-+ ]$COLOR*\+/) {
+			push @add, $line;
+		} else {
+			show_hunk(\@rm, \@add, 1);
+			@rm = @add = ();
+			$line_cb->($line);
+		}
+	}
+	show_hunk(\@rm, \@add, 1);
 }
 
 sub highlight_stdin {
@@ -149,20 +195,23 @@ sub color_config {
 }
 
 sub show_hunk {
-	my ($a, $b) = @_;
+	my ($a, $b, $inner) = @_;
 
 	# If one side is empty, then there is nothing to compare or highlight.
-	if (!@$a || !@$b) {
-		$line_cb->(@$a, @$b);
-		return;
-	}
-
+	#
 	# If we have mismatched numbers of lines on each side, we could try to
 	# be clever and match up similar lines. But for now we are simple and
 	# stupid, and only handle multi-line hunks that remove and add the same
 	# number of lines.
-	if (@$a != @$b) {
-		$line_cb->(@$a, @$b);
+	#
+	# For range-diff, fall back to pairing lines within the inner diff.
+	if (!@$a || !@$b || @$a != @$b) {
+		if ($range_diff && !$inner) {
+			show_inner($a);
+			show_inner($b);
+		} else {
+			$line_cb->(@$a, @$b);
+		}
 		return;
 	}
 
@@ -319,8 +368,14 @@ sub is_pair_interesting {
 	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
 	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
 
-	return visible_substr($prefix_a, $graph_indent) !~ /^$COLOR*-$BORING*$/ ||
-	       visible_substr($prefix_b, $graph_indent) !~ /^$COLOR*\+$BORING*$/ ||
+	# range-diff lines carry two markers (outer and inner); either may be
+	# the one that makes this a removed/added pair
+	my ($rm, $add) = $range_diff ?
+		(qr/-$COLOR*[-+ ]|[-+ ]$COLOR*-/, qr/\+$COLOR*[-+ ]|[-+ ]$COLOR*\+/) :
+		(qr/-/, qr/\+/);
+
+	return visible_substr($prefix_a, $graph_indent) !~ /^$COLOR*(?:$rm)$BORING*$/ ||
+	       visible_substr($prefix_b, $graph_indent) !~ /^$COLOR*(?:$add)$BORING*$/ ||
 	       $suffix_a !~ /^$BORING*$/ ||
 	       $suffix_b !~ /^$BORING*$/;
 }
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index b38fe2196a..ada90a5666 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -378,4 +378,67 @@ test_expect_success 'configure normal/highlight colors' '
 	EOF
 '
 
+dh_range_diff_setup () {
+	git checkout --orphan rd-base &&
+	git rm -rf --cached . >/dev/null &&
+	test_write_lines 1 2 3 4 5 6 >file &&
+	git add file &&
+	git commit -m base &&
+
+	git checkout -b rd-v1 &&
+	test_write_lines 1 "2 x" 3 4 5 6 >file &&
+	git commit -a -m change &&
+
+	git checkout -b rd-v2 rd-base &&
+	test_write_lines 1 "2 x" 3 "4 old" 5 6 >file &&
+	git commit -a -m change &&
+
+	git checkout -b rd-v3 rd-base &&
+	test_write_lines 1 "2 x" 3 "4 new" 5 6 >file &&
+	git commit -a -m change
+}
+
+test_expect_success 'diff-highlight highlights range-diff pair across versions' '
+	dh_range_diff_setup &&
+	git range-diff --creation-factor=999 rd-base rd-v2 rd-v3 |
+		"$DIFF_HIGHLIGHT" >actual.raw &&
+	sed -n "/^ *@@ file/,\$p" actual.raw | test_decode_color >actual &&
+	cat >expect <<-\EOF &&
+	    @@ file
+	     +2 x
+	      3
+	     -4
+	    -+4 <REVERSE>old<NOREVERSE>
+	    ++4 <REVERSE>new<NOREVERSE>
+	      5
+	      6
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-highlight highlights range-diff pair within one version' '
+	git range-diff --creation-factor=999 rd-base rd-v1 rd-v2 |
+		"$DIFF_HIGHLIGHT" >actual.raw &&
+	sed -n "/^ *@@ file/,\$p" actual.raw | test_decode_color >actual &&
+	cat >expect <<-\EOF &&
+	    @@ file
+	     -2<REVERSE><NOREVERSE>
+	     +2<REVERSE> x<NOREVERSE>
+	      3
+	    - 4
+	    +-4<REVERSE><NOREVERSE>
+	    ++4<REVERSE> old<NOREVERSE>
+	      5
+	    + 6
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'diff-highlight highlights colored range-diff' '
+	git range-diff --color --creation-factor=999 rd-base rd-v2 rd-v3 |
+		"$DIFF_HIGHLIGHT" | test_decode_color >actual &&
+	grep "+4 <REVERSE>old<NOREVERSE>" actual &&
+	grep "+4 <REVERSE>new<NOREVERSE>" actual
+'
+
 test_done

base-commit: e1ec09b23c8e0deb21a0b95ac5996422277395d4
-- 
gitgitgadget
