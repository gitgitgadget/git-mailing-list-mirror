Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 970D41F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 13:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753083AbdKJNXh (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 08:23:37 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:46953 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbdKJNXg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 08:23:36 -0500
Received: by mail-wr0-f196.google.com with SMTP id y42so8615647wrd.3
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 05:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uRbqYfi62/tS50v4zFWZMTEpfLTE+3yM+3Z+7Vo6gzY=;
        b=XUn3X0xYFEluB2+VvTRFx9lDNfFTVwuRJzaugI/0NKL+FWiSGX4vodpm4cbugXOLDw
         oTLoVmNOFxsVY2NraXZaiPmMtMF1F7X/6EIAAD/F5ZbnDTj3bFIQ0Q4aijlYE1mtJ1Co
         IKUV8oxe2Nr/Jm8pkoNKTwa+N6F8EqQaoSfltRNHFjQZ1Mq2lS6yXr8dCvWGjWUFTyRl
         FNhWv9+TQMYm1a8q6Lg1q+CIYxYvSs1xS2xY0/PDdm+wtIvQX8MQQOv2URBo5TxNtOVX
         MK61fXbo8NBtaJNSEZ5HGBmpxUNwMh3x/qY85atsNs3pT6Nz/g6ml132ueaziWuAPk8f
         XxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uRbqYfi62/tS50v4zFWZMTEpfLTE+3yM+3Z+7Vo6gzY=;
        b=iQpql4tDWYeFKCPz5fVyaZb8ANHEWWkE8nFfyj5byq25QaWeXeFTyr+tjehnEbmt6A
         uQHbNI/SsWUvEDqTPQ5SAP+IsctxyIs63sTO+PJehAm1gPuyXVwE9+3b2g2HmeUZtr3B
         rMIL+kn8KmEMbJRWv6xXaxmhnhv4omph95xmKx3TQbdMiE9Ske01JPV1dAyUv5RgbyKa
         tNNJZWD/v1kAQho7nTuunjGA9w4gbsyrZpwGw84ale0spg7bzpFD3gRbd0GUy43JTERA
         hb3LTQWLzYBLrK/azk3+4yepE8SizGuTtOXSeyh897VsxCNwfCkbsL4BEEEyZwA35MBd
         OQLQ==
X-Gm-Message-State: AJaThX6IrIDdMQ4ggJY3QgBmjbnNHhs7Ahd2tpbAKrHTWvFtAMjRfmWU
        /7bI0ZTU6jW12EsiotjixO6BWAbK
X-Google-Smtp-Source: AGs4zMb7OuhnigTZRVoj1kDWzmuwpIYD4Yeah7PWrkxV1TpVGzYn2+cwgXZS8vDFXMMEjJEDEpAJJw==
X-Received: by 10.223.199.205 with SMTP id y13mr325158wrg.71.1510320214999;
        Fri, 10 Nov 2017 05:23:34 -0800 (PST)
Received: from christian-Latitude-E6330.register.onboard.eurostar.com ([82.113.183.179])
        by smtp.gmail.com with ESMTPSA id 19sm2232731wmn.15.2017.11.10.05.23.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Nov 2017 05:23:34 -0800 (PST)
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
Subject: [PATCH v3 8/8] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
Date:   Fri, 10 Nov 2017 14:22:00 +0100
Message-Id: <20171110132200.7871-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.132.g7ad97d78be
In-Reply-To: <20171110132200.7871-1-chriscool@tuxfamily.org>
References: <20171110132200.7871-1-chriscool@tuxfamily.org>
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
 perl/Git/Packet.pm      | 169 ++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile           |   1 +
 t/t0021/rot13-filter.pl | 141 +---------------------------------------
 3 files changed, 173 insertions(+), 138 deletions(-)
 create mode 100644 perl/Git/Packet.pm

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
new file mode 100644
index 0000000000..1682403ffc
--- /dev/null
+++ b/perl/Git/Packet.pm
@@ -0,0 +1,169 @@
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
+			packet_compare_lists
+			packet_bin_read
+			packet_txt_read
+			packet_key_val_read
+			packet_bin_write
+			packet_txt_write
+			packet_flush
+			packet_initialize
+			packet_read_capabilities
+			packet_read_and_check_capabilities
+			packet_check_and_write_capabilities
+		);
+our @EXPORT_OK = @EXPORT;
+
+sub packet_compare_lists {
+	my ($expect, @result) = @_;
+	my $ix;
+	if (scalar @$expect != scalar @result) {
+		return undef;
+	}
+	for ($ix = 0; $ix < $#result; $ix++) {
+		if ($expect->[$ix] ne $result[$ix]) {
+			return undef;
+		}
+	}
+	return 1;
+}
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
+sub remove_final_lf_or_die {
+	my $buf = shift;
+	if ( $buf =~ s/\n$// ) {
+		return $buf;
+	}
+	die "A non-binary line MUST be terminated by an LF.\n"
+	    . "Received: '$buf'";
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	if ( $res != -1 and $buf ne '' ) {
+		$buf = remove_final_lf_or_die($buf);
+	}
+	return ( $res, $buf );
+}
+
+# Read a text line and check that it is in the form "key=value"
+sub packet_key_val_read {
+	my ( $key ) = @_;
+	my ( $res, $buf ) = packet_txt_read();
+	if ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
+		return ( $res, $buf );
+	}
+	die "bad $key: '$buf'";
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
+	packet_compare_lists([0, $name . "-client"], packet_txt_read()) ||
+		die "bad initialize";
+	packet_compare_lists([0, "version=" . $version], packet_txt_read()) ||
+		die "bad version";
+	packet_compare_lists([1, ""], packet_bin_read()) ||
+		die "bad version end";
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
+		if ( $res == -1 ) {
+			die "unexpected EOF when reading capabilities";
+		}
+		return ( $res, @cap ) if ( $res != 0 );
+		$buf = remove_final_lf_or_die($buf);
+		unless ( $buf =~ s/capability=// ) {
+			die "bad capability buf: '$buf'";
+		}
+		push @cap, $buf;
+	}
+}
+
+# Read remote capabilities and check them against capabilities we require
+sub packet_read_and_check_capabilities {
+	my @required_caps = @_;
+	my ($res, @remote_caps) = packet_read_capabilities();
+	my %remote_caps = map { $_ => 1 } @remote_caps;
+	foreach (@required_caps) {
+		unless (exists($remote_caps{$_})) {
+			die "required '$_' capability not available from remote" ;
+		}
+	}
+	return %remote_caps;
+}
+
+# Check our capabilities we want to advertise against the remote ones
+# and then advertise our capabilities
+sub packet_check_and_write_capabilities {
+	my ($remote_caps, @our_caps) = @_;
+	foreach (@our_caps) {
+		unless (exists($remote_caps->{$_})) {
+			die "our capability '$_' is not available from remote"
+		}
+		packet_txt_write( "capability=" . $_ );
+	}
+	packet_flush();
+}
+
+1;
diff --git a/perl/Makefile b/perl/Makefile
index 15d96fcc7a..f657de20e3 100644
--- a/perl/Makefile
+++ b/perl/Makefile
@@ -30,6 +30,7 @@ instdir_SQ = $(subst ','\'',$(prefix)/lib)
 modules += Git
 modules += Git/I18N
 modules += Git/IndexInfo
+modules += Git/Packet
 modules += Git/SVN
 modules += Git/SVN/Memoize/YAML
 modules += Git/SVN/Fetcher
diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 6cd9ecffee..f1678851de 100644
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
@@ -55,144 +58,6 @@ sub rot13 {
 	return $str;
 }
 
-sub packet_compare_lists {
-	my ($expect, @result) = @_;
-	my $ix;
-	if (scalar @$expect != scalar @result) {
-		return undef;
-	}
-	for ($ix = 0; $ix < $#result; $ix++) {
-		if ($expect->[$ix] ne $result[$ix]) {
-			return undef;
-		}
-	}
-	return 1;
-}
-
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
-sub remove_final_lf_or_die {
-	my $buf = shift;
-	if ( $buf =~ s/\n$// ) {
-		return $buf;
-	}
-	die "A non-binary line MUST be terminated by an LF.\n"
-	    . "Received: '$buf'";
-}
-
-sub packet_txt_read {
-	my ( $res, $buf ) = packet_bin_read();
-	if ( $res != -1 and $buf ne '' ) {
-		$buf = remove_final_lf_or_die($buf);
-	}
-	return ( $res, $buf );
-}
-
-# Read a text line and check that it is in the form "key=value"
-sub packet_key_val_read {
-	my ( $key ) = @_;
-	my ( $res, $buf ) = packet_txt_read();
-	if ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
-		return ( $res, $buf );
-	}
-	die "bad $key: '$buf'";
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
-	packet_compare_lists([0, $name . "-client"], packet_txt_read()) ||
-		die "bad initialize";
-	packet_compare_lists([0, "version=" . $version], packet_txt_read()) ||
-		die "bad version";
-	packet_compare_lists([1, ""], packet_bin_read()) ||
-		die "bad version end";
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
-		if ( $res == -1 ) {
-			die "unexpected EOF when reading capabilities";
-		}
-		return ( $res, @cap ) if ( $res != 0 );
-		$buf = remove_final_lf_or_die($buf);
-		unless ( $buf =~ s/capability=// ) {
-			die "bad capability buf: '$buf'";
-		}
-		push @cap, $buf;
-	}
-}
-
-# Read remote capabilities and check them against capabilities we require
-sub packet_read_and_check_capabilities {
-	my @required_caps = @_;
-	my ($res, @remote_caps) = packet_read_capabilities();
-	my %remote_caps = map { $_ => 1 } @remote_caps;
-	foreach (@required_caps) {
-		unless (exists($remote_caps{$_})) {
-			die "required '$_' capability not available from remote" ;
-		}
-	}
-	return %remote_caps;
-}
-
-# Check our capabilities we want to advertise against the remote ones
-# and then advertise our capabilities
-sub packet_check_and_write_capabilities {
-	my ($remote_caps, @our_caps) = @_;
-	foreach (@our_caps) {
-		unless (exists($remote_caps->{$_})) {
-			die "our capability '$_' is not available from remote"
-		}
-		packet_txt_write( "capability=" . $_ );
-	}
-	packet_flush();
-}
-
 print $debug "START\n";
 $debug->flush();
 
-- 
2.15.0.132.g7ad97d78be

