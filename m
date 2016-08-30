Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2156A1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 14:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbcH3OHp (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 10:07:45 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35238 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752941AbcH3OHl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 10:07:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id h186so1241817pfg.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 07:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GuoXfDKiNnKxA7gZKJok09d0IYM7kkapz6V2UdLPmdY=;
        b=NefqWBn57Mjzd/SsH6tGRHV6Lcp5Ez+HnyLo4ElFYPFgT05aS/USysiPvlz0tfBFpt
         9CrfIKxwJ6cCHdydE/oRqOaIHZ/h1G6XT6PiT/yVkNOz4CypFo846fgblDJdLnnbphqw
         n7/ArmSLC7CiE5VFY8+ks8x46QCLEHXgAX154wkmtkhJUzjwAXkwI1m+RMttv8vv0rUU
         f145Q5s04zE7jjL0P7KkMgffUL7IpyyHSOfWIKf5BKuo+YFSZJY/Pl/JuFKNsqw3vbOk
         8HxKAugMZrlHttqUC1m2uywSEd7dYy/dPU4/T8xo4pjtnIeJONIUeVCEV7SziUqt7MAs
         /NQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GuoXfDKiNnKxA7gZKJok09d0IYM7kkapz6V2UdLPmdY=;
        b=kIO26dXvfjFaIa0J4ISiFAJiwZESv0xjgCjCfVXgWpFaJV62p2cOIAdTJcxQ/dMSmb
         M3mWPVKnvPgG1pUZ02zhx0XhxmqD5m84GeriJhveE8KMipOxYom2rfWSZ9sDmwpweIYS
         GHGYgSOFdEdOySUsxvmyWdB1/AS6MIwWeSSgNW00Z2xiyiMhsVyPahDPSBzHmGwqVvyp
         nlj2vCojfbR8hd/QFiaeKYXEe4hcYqLPZ7fb79hpssQYwpaZvg0hECKZa+QSy6TW8NRC
         uJQbfUbsrZyuai/FnLQ1Jwgz8qUbnLP05ydW6XTtpK3lZAXsjsiUFn6khmOvc2FFWsHR
         xtbg==
X-Gm-Message-State: AE9vXwOkYQGAwlbGEicGZu70VpwisDhF/UHpOuTQW2pLyNM9CVDdOilz5thTXLAv7LA7vg==
X-Received: by 10.98.58.73 with SMTP id h70mr6397987pfa.125.1472566060221;
        Tue, 30 Aug 2016 07:07:40 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id j2sm57711654paa.46.2016.08.30.07.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 07:07:38 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v4 3/3] diff-highlight: add support for --graph output
Date:   Tue, 30 Aug 2016 07:07:14 -0700
Message-Id: <20160830140714.19048-4-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830140714.19048-1-henderson.bj@gmail.com>
References: <xmqq4m638ded.fsf@gitster.mtv.corp.google.com>
 <20160830140714.19048-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/diff-highlight            | 19 +++++++++++++------
 contrib/diff-highlight/t/t9400-diff-highlight.sh |  2 +-
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/contrib/diff-highlight/diff-highlight b/contrib/diff-highlight/diff-highlight
index ffefc31..9280c88 100755
--- a/contrib/diff-highlight/diff-highlight
+++ b/contrib/diff-highlight/diff-highlight
@@ -21,6 +21,10 @@ my $RESET = "\x1b[m";
 my $COLOR = qr/\x1b\[[0-9;]*m/;
 my $BORING = qr/$COLOR|\s/;
 
+# The patch portion of git log -p --graph should only ever have preceding | and
+# not / or \ as merge history only shows up on the commit line.
+my $GRAPH = qr/$COLOR?\|$COLOR?\s+/;
+
 my @removed;
 my @added;
 my $in_hunk;
@@ -32,12 +36,12 @@ $SIG{PIPE} = 'DEFAULT';
 while (<>) {
 	if (!$in_hunk) {
 		print;
-		$in_hunk = /^$COLOR*\@/;
+		$in_hunk = /^$GRAPH*$COLOR*\@/;
 	}
-	elsif (/^$COLOR*-/) {
+	elsif (/^$GRAPH*$COLOR*-/) {
 		push @removed, $_;
 	}
-	elsif (/^$COLOR*\+/) {
+	elsif (/^$GRAPH*$COLOR*\+/) {
 		push @added, $_;
 	}
 	else {
@@ -46,7 +50,7 @@ while (<>) {
 		@added = ();
 
 		print;
-		$in_hunk = /^$COLOR*[\@ ]/;
+		$in_hunk = /^$GRAPH*$COLOR*[\@ ]/;
 	}
 
 	# Most of the time there is enough output to keep things streaming,
@@ -163,6 +167,9 @@ sub highlight_pair {
 	}
 }
 
+# we split either by $COLOR or by character. This has the side effect of
+# leaving in graph cruft. It works because the graph cruft does not contain "-"
+# or "+"
 sub split_line {
 	local $_ = shift;
 	return utf8::decode($_) ?
@@ -211,8 +218,8 @@ sub is_pair_interesting {
 	my $suffix_a = join('', @$a[($sa+1)..$#$a]);
 	my $suffix_b = join('', @$b[($sb+1)..$#$b]);
 
-	return $prefix_a !~ /^$COLOR*-$BORING*$/ ||
-	       $prefix_b !~ /^$COLOR*\+$BORING*$/ ||
+	return $prefix_a !~ /^$GRAPH*$COLOR*-$BORING*$/ ||
+	       $prefix_b !~ /^$GRAPH*$COLOR*\+$BORING*$/ ||
 	       $suffix_a !~ /^$BORING*$/ ||
 	       $suffix_b !~ /^$BORING*$/;
 }
diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 54e11fe..e42232d 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -209,7 +209,7 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
 
 # TODO add multi-byte test
 
-test_expect_failure 'diff-highlight works with the --graph option' '
+test_expect_success 'diff-highlight works with the --graph option' '
 	dh_test_setup_history &&
 
 	# topo-order so that the order of the commits is the same as with --graph
-- 
2.9.3

