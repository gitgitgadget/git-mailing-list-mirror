Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85F82098B
	for <e@80x24.org>; Sun, 16 Oct 2016 23:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757221AbcJPXV4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Oct 2016 19:21:56 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36393 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756775AbcJPXVz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2016 19:21:55 -0400
Received: by mail-pf0-f194.google.com with SMTP id r16so11508851pfg.3
        for <git@vger.kernel.org>; Sun, 16 Oct 2016 16:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7o+ahvOSMb19lmoNuzHjACqbUpyVxBax/PWWmU0nMdg=;
        b=LDDPafmWQ/M5vjots4lByDkIjnVWO79/PP2AMJ7pJgjRrntui915KQlQ2FCKr02IUJ
         jdMopB8cnLHQq+CTQBgwvPHm30rxW3cAsoQdaXz5lTxG41OExi825ZJr8q1RchDprGSL
         twqrgcaLG6ckGm/XadXB5EDVfUFifA6oJyrTSux2IqYxx7kPbR4MLCS7HKKQgn0ssi7p
         dLJcCqDnvFi8GQl4CPTVmlw7GaO5npOcKopagMdlFZznfP7GgDyB3i8aw+EBfs9ZGhj8
         Yi63bcsmRmNqMcfWWImHxO7jxFp/1vECRwb7T8CWdXlvHIqqMHgrPBEMvPhg0fmjtdv3
         w6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7o+ahvOSMb19lmoNuzHjACqbUpyVxBax/PWWmU0nMdg=;
        b=jm1rlHwxKgIMq4jN3Hviksq5pwaso/br3uBTir6rFjdZYiLk7sqwZh586ueRcXM3H4
         QRTm9NkmMkFAt2GcDI5knJvX9vhCWYryaSOmRpvOaa0Nq28MSOQJ4r+hakjUXUZgJ24J
         uidb3T09Beu/+eSln74ecBaV2R/SduPGdYGj7gEzc6mTRrV2xkC3MmCNYybYsqTZFNaf
         wvfP4+ERxqienbdOlYApaLVmvnjahi5aALuKqGp7yN75rHUZRDCwqyBPz/l7p/6w1EH3
         giqymRvLxmnEmMo0JyP4LWtuKoo8aL9oIRsTPHnZFEPIXlcJ+mth8eguODyZ6LiqzeJx
         Sozw==
X-Gm-Message-State: AA6/9Rkw31aZVwvsmdRXLZBKEYWkEU2sv70T/Xqx8xT7QiU8Nev/t856C3rhLeGJEI6rgA==
X-Received: by 10.99.156.10 with SMTP id f10mr28093020pge.123.1476660113539;
        Sun, 16 Oct 2016 16:21:53 -0700 (PDT)
Received: from rem3n8pj12.ads.autodesk.com (adsk-nat-ip4.autodesk.com. [132.188.71.4])
        by smtp.gmail.com with ESMTPSA id cp2sm10325691pad.3.2016.10.16.16.21.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 16 Oct 2016 16:21:50 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, jnareb@gmail.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, tboegi@web.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v11 14/14] contrib/long-running-filter: add long running filter example
Date:   Sun, 16 Oct 2016 16:20:38 -0700
Message-Id: <20161016232038.84951-15-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20161016232038.84951-1-larsxschneider@gmail.com>
References: <20161016232038.84951-1-larsxschneider@gmail.com>
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
 contrib/long-running-filter/example.pl | 128 +++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100755 contrib/long-running-filter/example.pl

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 3f4d1ed..976243a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -516,7 +516,9 @@ the command pipe on exit. The filter is expected to detect EOF
 and exit gracefully on its own. Git will wait until the filter
 process has stopped.
 
-If you develop your own long running filter
+A long running filter demo implementation can be found in
+`contrib/long-running-filter/example.pl` located in the Git
+core repository. If you develop your own long running filter
 process then the `GIT_TRACE_PACKET` environment variables can be
 very helpful for debugging (see linkgit:git[1]).
 
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
new file mode 100755
index 0000000..3945705
--- /dev/null
+++ b/contrib/long-running-filter/example.pl
@@ -0,0 +1,128 @@
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
+packet_flush();
+
+( packet_txt_read() eq ( 0, "capability=clean" ) )  || die "bad capability";
+( packet_txt_read() eq ( 0, "capability=smudge" ) ) || die "bad capability";
+( packet_bin_read() eq ( 1, "" ) )                  || die "bad capability end";
+
+packet_txt_write("capability=clean");
+packet_txt_write("capability=smudge");
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

