Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C96920A25
	for <e@80x24.org>; Sat, 16 Sep 2017 08:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdIPIH7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:07:59 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34887 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751262AbdIPIHx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:07:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id e64so4516704wmi.2
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uYt07/H7anDLnmfp8Mz7PZgJ+LHWZk3xyQBQFhdYp88=;
        b=b9LLFnRFDC8tV8Di8LIewT4TYuQt4qSGsHEnNG69jYeHJ+AJvDHp9/tT9cVkc7L4he
         OUAdWWMSo6Thfv1iEBCPpf+l5N+JMyRVVTVw1iNQUNeMc22YcRsFucGAAa4owA+qLoS2
         Iaj2ggxFJHAGmPhODrTje5ofIwpwK0/a/VVg7nHFsO4NE7PUtbwFCUlJLCIhlLiqgmn0
         3Qb8K5R6Z7Pd53jlq8bU0musuOYK2zt6rtY/eEUl6XLDBweuJLdpGXkjtah913cjVvX4
         ZtkN6tASGABnT2j9DNvU+ctZtrGZxOVh6O+vuVMTMqbhobe2okfVOEol1mw1lRmxBLIJ
         /SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uYt07/H7anDLnmfp8Mz7PZgJ+LHWZk3xyQBQFhdYp88=;
        b=UoDQu+Qb8iVKd1jQnD3NWq+DQvAQVJE9nQoxMag4GeURKsTG235HWhFucCKu0IRK/i
         TBEv9FXkfnRbRPf24DLzedQJIiOaGNAo22HRb/gEviDNrbem62OL9T3WHH5c7oe3JPeu
         6PI6RdWs4/MFXVwt4Mt+t25dELcNwXN4Z9x8HaBJSdlfM9TTkTE/poM1pB3i7JH1epsm
         EUPB/QAHEpnpewRb2fjkKJPvS48PlueGdjsXDzFdfQMcRFFSsHqXAKW1PjFNCVCp7KeN
         hsQYLfEp/nvVJSxYi/0Z7r6cx5Gp6WOVMft/eo5KPd2fsjlvylFCtT1xcg4vQS/jN6hP
         EFVQ==
X-Gm-Message-State: AHPjjUjJAksbXfRb+EIE6LmJ3Y5dUqlCFCYLRWNmw0FZqHD5AeU7LWQv
        4bmeD/bMPLeAcU3H
X-Google-Smtp-Source: AOwi7QApJW5zQhLTnuX/B8Z+ITkcKNUpOBfDjGx7BAISImbiQ+M4VKTE/UIdxguySUXEbks1UXnJHA==
X-Received: by 10.28.9.135 with SMTP id 129mr4702317wmj.93.1505549272080;
        Sat, 16 Sep 2017 01:07:52 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.07.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:07:51 -0700 (PDT)
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
Subject: [PATCH v6 07/40] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
Date:   Sat, 16 Sep 2017 10:06:58 +0200
Message-Id: <20170916080731.13925-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
2.14.1.576.g3f707d88cd

