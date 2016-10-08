Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B23207EC
	for <e@80x24.org>; Sat,  8 Oct 2016 11:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935127AbcJHL0Q (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Oct 2016 07:26:16 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34661 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935070AbcJHLZw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2016 07:25:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id b201so6642439wmb.1
        for <git@vger.kernel.org>; Sat, 08 Oct 2016 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhmYdBfsyzdPElgyDiCUzB/BRkiWg+oJdiwRZ5/90XI=;
        b=JK/d2FaAxv8dF+4/tYoKdIbPvCjB/fCHCLE1tW/5YY3QGC941SL0dq3C0qyTxDxDGL
         UnVCYyVF7n/zL+tdMPaXSnGU8PfCXh0lFOGwbK+mSGyx1ovhuq+bN0c0GEZenrFZLY4W
         d4uWCzAEmfQAwoy9//lhJi6z0Z6KGq1kSsCBarZWfkBRvoRDlzUF56BYMv9Aa0upL19W
         ZPmR0VQ1W+DkWS2I7YlVUzismdlmsSEqHhrvOIAqjKgemwv0+eEqR4PWaF3Byz0aqH1G
         LzPVr99Rj3Mt3g1GfWrSZzlmj7AuMpxWWad8MbsoTE32ASeN3pKxJG0y03XKbc6Iw/YO
         ABlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhmYdBfsyzdPElgyDiCUzB/BRkiWg+oJdiwRZ5/90XI=;
        b=g3rAYMTl1qurjENBgexOdx5cRfA4p3tuQSr4Zmh5CSskNzvaj2Ccl6baey+DWCcuCl
         L/+726sPiZ24XPdW0InCyeDkZ9NItptD/ulk1afzBO4XG8qar7r8iE6aurP4U40J00gE
         NHh9gc5qZVitdzLuOVmAWGgLjhFZmraykfO/uSBaw1ldqW+vJdNVCRnl0Rx5WpI9IxxU
         az/xWl2zW896bjY/X4I2ulU1u6xwlx2oYVP0F6ea4h1qQFLTVhSbg0HO/o/SaBBN8Ghr
         r44RlF5o7mrS0VcWMfYdgsVdkg4WXkq20oj1RJ4gAbReDuFFbuyn14G7TnuxxYBuu1Oo
         /tmA==
X-Gm-Message-State: AA6/9RmpH1c3xHbpIXthpUNoSwm5yAicA8HfVhZU/8DSXDJl1Q3M7J7ue8aVVzS3tKJRkw==
X-Received: by 10.194.30.137 with SMTP id s9mr20818176wjh.77.1475925950446;
        Sat, 08 Oct 2016 04:25:50 -0700 (PDT)
Received: from slxBook4.fritz.box (p5DDB73B1.dip0.t-ipconnect.de. [93.219.115.177])
        by smtp.gmail.com with ESMTPSA id a1sm24599623wju.41.2016.10.08.04.25.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Oct 2016 04:25:49 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 14/14] contrib/long-running-filter: add long running filter example
Date:   Sat,  8 Oct 2016 13:25:30 +0200
Message-Id: <20161008112530.15506-15-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161008112530.15506-1-larsxschneider@gmail.com>
References: <20161008112530.15506-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Add a simple pass-thru filter as example implementation for the Git
filter protocol version 2. See Documentation/gitattributes.txt, section
"Filter Protocol" for more info.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 Documentation/gitattributes.txt        |   4 +-
 contrib/long-running-filter/example.pl | 127 +++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100755 contrib/long-running-filter/example.pl

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 5868f00..a182ef2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -514,7 +514,9 @@ the next "key=value" list containing a command. Git will close
 the command pipe on exit. The filter is expected to detect EOF
 and exit gracefully on its own.
 
-If you develop your own long running filter
+A long running filter demo implementation can be found in
+`contrib/long-running-filter/example.pl` located in the Git
+core repository. If you develop your own long running filter
 process then the `GIT_TRACE_PACKET` environment variables can be
 very helpful for debugging (see linkgit:git[1]).
 
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
new file mode 100755
index 0000000..f4102d2
--- /dev/null
+++ b/contrib/long-running-filter/example.pl
@@ -0,0 +1,127 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git filter protocol version 2
+# See Documentation/gitattributes.txt, section "Filter Protocol"
+#
+# Please note, this pass-thru filter is a minimal skeleton. No proper
+# error handling was implemented.
+#
+
+use strict;
+use warnings;
+
+my $MAX_PACKET_CONTENT_SIZE = 65516;
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+
+		# EOF - Git stopped talking to us!
+		exit();
+	}
+	elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	}
+	elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	}
+	else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.";
+	}
+	return ( $res, $buf );
+}
+
+sub packet_bin_write {
+	my $buf = shift;
+	print STDOUT sprintf( "%04x", length($buf) + 4 );
+	print STDOUT $buf;
+	STDOUT->flush();
+}
+
+sub packet_txt_write {
+	packet_bin_write( $_[0] . "\n" );
+}
+
+sub packet_flush {
+	print STDOUT sprintf( "%04x", 0 );
+	STDOUT->flush();
+}
+
+( packet_txt_read() eq ( 0, "git-filter-client" ) ) || die "bad initialize";
+( packet_txt_read() eq ( 0, "version=2" ) )         || die "bad version";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad version end";
+
+packet_txt_write("git-filter-server");
+packet_txt_write("version=2");
+
+( packet_txt_read() eq ( 0, "clean=true" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )            || die "bad capability end";
+
+packet_txt_write("clean=true");
+packet_txt_write("smudge=true");
+packet_flush();
+
+while (1) {
+	my ($command)  = packet_txt_read() =~ /^command=([^=]+)$/;
+	my ($pathname) = packet_txt_read() =~ /^pathname=([^=]+)$/;
+
+	packet_bin_read();
+
+	my $input = "";
+	{
+		binmode(STDIN);
+		my $buffer;
+		my $done = 0;
+		while ( !$done ) {
+			( $done, $buffer ) = packet_bin_read();
+			$input .= $buffer;
+		}
+	}
+
+	my $output;
+	if ( $command eq "clean" ) {
+		### Perform clean here ###
+		$output = $input;
+	}
+	elsif ( $command eq "smudge" ) {
+		### Perform smudge here ###
+		$output = $input;
+	}
+	else {
+		die "bad command '$command'";
+	}
+
+	packet_txt_write("status=success");
+	packet_flush();
+	while ( length($output) > 0 ) {
+		my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+		packet_bin_write($packet);
+		if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+			$output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+		}
+		else {
+			$output = "";
+		}
+	}
+	packet_flush();    # flush content!
+	packet_flush();    # empty list, keep "status=success" unchanged!
+
+}
-- 
2.10.0

