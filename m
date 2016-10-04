Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 046F920987
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbcJDNAN (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 09:00:13 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35738 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754084AbcJDNAH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 09:00:07 -0400
Received: by mail-wm0-f68.google.com with SMTP id f193so14973274wmg.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AhmYdBfsyzdPElgyDiCUzB/BRkiWg+oJdiwRZ5/90XI=;
        b=lTSFEDozEWlsjstdPhUi4gw6V2rX0k1ZPWsOZetGnyHN7XDZZnb1bqxrZFmsC7a6Tc
         5wnNWfOxnPiz8v6r6X+MawjzUn79E/KlrhIR+5P4F2fWFE0phyNTxCkk5M6E3Iw6zve6
         p2tFurAaUUdPEegp65VFdnSGP8C5b7FsZHWT9eNmuQgMPvrobaYCU80KPYeM94lZNKsz
         VnRqxiJD79gPtdX3rr3q0mBWrnIjTZhToTepLT26Zm8yV/swRKj95S/M9Qk4tp5/cWR6
         RIi+16elsrVa+8p/92dcddcIPcM6WxL7xZeERlzbKxqHjbGzIx1L5wIooveFlZGntCCV
         /RLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AhmYdBfsyzdPElgyDiCUzB/BRkiWg+oJdiwRZ5/90XI=;
        b=diUijgt7T5aIQxYBhIl/vTm80Zug+bz0G4lz+JyUIIi/I4EE6nRKJesG2sE+IB+d+g
         Ut/hBQHHsmRmrnjc7aS4jmDhtEHnlKlXo9ky0nnbMmhJttnIT7l1udv0d3hRb3Bt1aRy
         o3GeChgAzTojc1I1pWrLm4ByprRp2qxuQnojZ2ejWMOSNnLNqWEXGldYQQQ5uWzVGKwI
         rIA+/ziBE7L+ZpK+8S+59aycvNvKQqZVuuiT7eKjvUjZ1/M5knnStVUnyRhwC7xqBElg
         Hu+FJaQmofCkPYJnS3D2n0rwpR5HVUfhNvElpLa/5//sjex0qVYaZA16588rbeWcEvHU
         Ec9g==
X-Gm-Message-State: AA6/9RmClMwMQs++pf6zMDxCCC3q9iMcwsfph3FLUkIOTjB3SUj/G6NukTHQgNY9Vi2l/w==
X-Received: by 10.194.146.195 with SMTP id te3mr3419662wjb.51.1475586005456;
        Tue, 04 Oct 2016 06:00:05 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.06.00.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 06:00:04 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 14/14] contrib/long-running-filter: add long running filter example
Date:   Tue,  4 Oct 2016 14:59:47 +0200
Message-Id: <20161004125947.67104-15-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161004125947.67104-1-larsxschneider@gmail.com>
References: <20161004125947.67104-1-larsxschneider@gmail.com>
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

