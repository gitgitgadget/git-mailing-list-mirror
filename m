Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96EB5202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 12:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbdJSMav (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 08:30:51 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:43105 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdJSMao (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 08:30:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id m72so15974504wmc.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=muAtZZZv63d9m0UZO4y+iSO+G+widSXwv6uoSiTqAmE=;
        b=hVSKf2aWcrxza0POVWVpN3GGQ1f39d3Xa6zOY+2WR6UAMSOriV860N6dmt0hFBE3YE
         R6epf/KjNU8/eWHVjhiywIayGIpIVf533M6Xp7kIf+QGMLsONEQZ0MHyOGj6QvRYVNWc
         41UODgLHT8U0EwOtdQAqEV89rejZs9PysfF57GTLSkyLEVooBdgKmGAI5fmEYLJxjVAH
         eptagV4utRzDWmkaZ+YV7k8sNvVCMQqBhg3KFG5+qfIC4rop8DR5RD73WpqlnXMr8I0y
         NQshn1xu70Opg0jbgultTNdIpVr7j+Gf0ho0JUfy2a/UkYN+UXY5WuM+WeH7w+q9sxh4
         TSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=muAtZZZv63d9m0UZO4y+iSO+G+widSXwv6uoSiTqAmE=;
        b=M4VxTthl6hSsvWeXyO/HYO5z18W+weiNQLbBbsEKsFiSZ+T+n+J4BMdMsQI14E9UjG
         ZXLo+DnZ/a3d1Nuxy1CcWDSsCkaczYhRG7c6Qt7C0PbHaGfCr6UF2/RZypX8xT+KF7R4
         Z9jVXO/hOqbTbDC2bQLowGtUEDRwcZwwSLIV/SBICLEkEPi+mypJsihPUZ78ti83pG4T
         HYZe3hFSXjm++sywklYTFrbFh8cvDTJWG0I8xfM41K6bRHTwv7788O9HmhE5FgVy90B0
         1JbULNdRXWju3BbEsOelqFTOKiyv//nyBwQtdi/jlLEE2U0gQim0CW/xByYE9FrXHGge
         3ong==
X-Gm-Message-State: AMCzsaWroXbrOmbUbrhtx8R2LPDAurV7NaPbz/C9BeKZt1K0Csk+0CKg
        maSnZIqPGVbrpJdjD0zELP1Z7w==
X-Google-Smtp-Source: ABhQp+SS7gRLGcPmxDb/qfsRRJFCnVr8/caC1adGUnWb/FfqLO646TcoVHGjGgE6tfiDIt+SCvB1aQ==
X-Received: by 10.28.209.132 with SMTP id i126mr1475090wmg.65.1508416243184;
        Thu, 19 Oct 2017 05:30:43 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id 25sm12820879wrv.8.2017.10.19.05.30.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Oct 2017 05:30:42 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 6/6] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
Date:   Thu, 19 Oct 2017 14:30:30 +0200
Message-Id: <20171019123030.17338-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.rc1.106.g7e97f58a41
In-Reply-To: <20171019123030.17338-1-chriscool@tuxfamily.org>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And while at it let's simplify t0021/rot13-filter.pl by
using Git/Packet.pm.

This will make it possible to reuse packet related
functions in other test scripts.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 perl/Git/Packet.pm      | 118 ++++++++++++++++++++++++++++++++++++++++++++++++
 t/t0021/rot13-filter.pl |  94 ++------------------------------------
 2 files changed, 121 insertions(+), 91 deletions(-)
 create mode 100644 perl/Git/Packet.pm

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
new file mode 100644
index 0000000000..b1e67477a0
--- /dev/null
+++ b/perl/Git/Packet.pm
@@ -0,0 +1,118 @@
+package Git::Packet;
+use 5.008;
+use strict;
+use warnings;
+BEGIN {
+	require Exporter;
+	if ($] < 5.008003) {
+		*import = \&Exporter::import;
+	} else {
+		# Exporter 5.57 which supports this invocation was
+		# released with perl 5.8.3
+		Exporter->import('import');
+	}
+}
+
+our @EXPORT = qw(
+			packet_bin_read
+			packet_txt_read
+			packet_bin_write
+			packet_txt_write
+			packet_flush
+			packet_initialize
+			packet_read_capabilities
+			packet_write_capabilities
+			packet_read_and_check_capabilities
+		);
+our @EXPORT_OK = @EXPORT;
+
+sub packet_bin_read {
+	my $buffer;
+	my $bytes_read = read STDIN, $buffer, 4;
+	if ( $bytes_read == 0 ) {
+		# EOF - Git stopped talking to us!
+		return ( -1, "" );
+	} elsif ( $bytes_read != 4 ) {
+		die "invalid packet: '$buffer'";
+	}
+	my $pkt_size = hex($buffer);
+	if ( $pkt_size == 0 ) {
+		return ( 1, "" );
+	} elsif ( $pkt_size > 4 ) {
+		my $content_size = $pkt_size - 4;
+		$bytes_read = read STDIN, $buffer, $content_size;
+		if ( $bytes_read != $content_size ) {
+			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
+		}
+		return ( 0, $buffer );
+	} else {
+		die "invalid packet size: $pkt_size";
+	}
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.\n"
+		    . "Received: '$buf'";
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
+sub packet_initialize {
+	my ($name, $version) = @_;
+
+	( packet_txt_read() eq ( 0, $name . "-client" ) )	|| die "bad initialize";
+	( packet_txt_read() eq ( 0, "version=" . $version ) )	|| die "bad version";
+	( packet_bin_read() eq ( 1, "" ) )			|| die "bad version end";
+
+	packet_txt_write( $name . "-server" );
+	packet_txt_write( "version=" . $version );
+	packet_flush();
+}
+
+sub packet_read_capabilities {
+	my @cap;
+	while (1) {
+		my ( $res, $buf ) = packet_bin_read();
+		return ( $res, @cap ) if ( $res != 0 );
+		unless ( $buf =~ s/\n$// ) {
+			die "A non-binary line MUST be terminated by an LF.\n"
+			    . "Received: '$buf'";
+		}
+		die "bad capability buf: '$buf'" unless ( $buf =~ s/capability=// );
+		push @cap, $buf;
+	}
+}
+
+sub packet_read_and_check_capabilities {
+	my @local_caps = @_;
+	my @remote_res_caps = packet_read_capabilities();
+	my $res = shift @remote_res_caps;
+	my %remote_caps = map { $_ => 1 } @remote_res_caps;
+	foreach (@local_caps) {
+		die "'$_' capability not available" unless (exists($remote_caps{$_}));
+	}
+	return $res;
+}
+
+sub packet_write_capabilities {
+	packet_txt_write( "capability=" . $_ ) foreach (@_);
+	packet_flush();
+}
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index ba18b207c6..2e8ad4d496 100644
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -30,9 +30,12 @@
 #     to the "list_available_blobs" response.
 #
 
+use 5.008;
+use lib (split(/:/, $ENV{GITPERLLIB}));
 use strict;
 use warnings;
 use IO::File;
+use Git::Packet;
 
 my $MAX_PACKET_CONTENT_SIZE = 65516;
 my $log_file                = shift @ARGV;
@@ -55,97 +58,6 @@ sub rot13 {
 	return $str;
 }
 
-sub packet_bin_read {
-	my $buffer;
-	my $bytes_read = read STDIN, $buffer, 4;
-	if ( $bytes_read == 0 ) {
-		# EOF - Git stopped talking to us!
-		return ( -1, "" );
-	} elsif ( $bytes_read != 4 ) {
-		die "invalid packet: '$buffer'";
-	}
-	my $pkt_size = hex($buffer);
-	if ( $pkt_size == 0 ) {
-		return ( 1, "" );
-	} elsif ( $pkt_size > 4 ) {
-		my $content_size = $pkt_size - 4;
-		$bytes_read = read STDIN, $buffer, $content_size;
-		if ( $bytes_read != $content_size ) {
-			die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
-		}
-		return ( 0, $buffer );
-	} else {
-		die "invalid packet size: $pkt_size";
-	}
-}
-
-sub packet_txt_read {
-	my ( $res, $buf ) = packet_bin_read();
-	unless ( $res == -1 or $buf eq '' or $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.\n"
-		    . "Received: '$buf'";
-	}
-	return ( $res, $buf );
-}
-
-sub packet_bin_write {
-	my $buf = shift;
-	print STDOUT sprintf( "%04x", length($buf) + 4 );
-	print STDOUT $buf;
-	STDOUT->flush();
-}
-
-sub packet_txt_write {
-	packet_bin_write( $_[0] . "\n" );
-}
-
-sub packet_flush {
-	print STDOUT sprintf( "%04x", 0 );
-	STDOUT->flush();
-}
-
-sub packet_initialize {
-	my ($name, $version) = @_;
-
-	( packet_txt_read() eq ( 0, $name . "-client" ) )       || die "bad initialize";
-	( packet_txt_read() eq ( 0, "version=" . $version ) )   || die "bad version";
-	( packet_bin_read() eq ( 1, "" ) )                      || die "bad version end";
-
-	packet_txt_write( $name . "-server" );
-	packet_txt_write( "version=" . $version );
-	packet_flush();
-}
-
-sub packet_read_capabilities {
-	my @cap;
-	while (1) {
-		my ( $res, $buf ) = packet_bin_read();
-		return ( $res, @cap ) if ( $res != 0 );
-		unless ( $buf =~ s/\n$// ) {
-			die "A non-binary line MUST be terminated by an LF.\n"
-			    . "Received: '$buf'";
-		}
-		die "bad capability buf: '$buf'" unless ( $buf =~ s/capability=// );
-		push @cap, $buf;
-	}
-}
-
-sub packet_read_and_check_capabilities {
-	my @local_caps = @_;
-	my @remote_res_caps = packet_read_capabilities();
-	my $res = shift @remote_res_caps;
-	my %remote_caps = map { $_ => 1 } @remote_res_caps;
-	foreach (@local_caps) {
-        	die "'$_' capability not available" unless (exists($remote_caps{$_}));
-	}
-	return $res;
-}
-
-sub packet_write_capabilities {
-	packet_txt_write( "capability=" . $_ ) foreach (@_);
-	packet_flush();
-}
-
 print $debug "START\n";
 $debug->flush();
 
-- 
2.15.0.rc1.106.g7e97f58a41

