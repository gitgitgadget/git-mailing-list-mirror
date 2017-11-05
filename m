Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 58DEF2055E
	for <e@80x24.org>; Sun,  5 Nov 2017 21:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751303AbdKEVi4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 16:38:56 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:45632 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751139AbdKEViy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 16:38:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id y80so10269896wmd.0
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 13:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4DeuN2h638jqdXMHW0cYrj3LpZ9dscw6wQ//Be16cbo=;
        b=FR+4HXz7J1x6sUF/NyQbmVrFzhJOf1oA8xnVUYNyMh/GvTeP2WDapPMpI/5iOrVrxG
         9y7BCLumKMs2+m09ZeqqTdA+XDqUCkWH/Ou251FHCU1iGEPEicg9ulk9kdLffppnQ1K6
         yeQn0JHtbawgusZAbI+xC0l2FH7xmUzeaRHWSpwEJJnyvCaEsDChADa2riVxDhRxu+yk
         tS8XOlq/SFTuHw/5XNsdzCrAMJwVs3ji3rrq6V8m9Pmm4aUd8BO5EnmN7X+L7LAdGIn9
         SUqdEZHDAahbk9S4Kkh4viGSBnLl4o0cRwzuIMRROayMuVViuA9/JUYjNR+B+bg/aO9d
         nNyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4DeuN2h638jqdXMHW0cYrj3LpZ9dscw6wQ//Be16cbo=;
        b=d65gJq4kovaOgKzGW+6trDq7+0S1AxlAKSJjvbzG0xVMIJXPykKZhqI3uDXgjkglfi
         04O/2ga3JU8PREgDBOnEmvvNSFkW3JKojc+EYLyIL9XlBL50pXvqBZsYZ415Xgyle9ve
         soBnBO4cB3FVIoPCB3gWs1HaDDHFn1kvooW37UsdC9QudNDsZybV8V0wwZf6tqFQY1NX
         Xofv1ueN1Tz4ujQa2PvAvbLdMbrWE/ZFSBGJ3sZTiQA0iKEuYOrEsz+cOYWDGW5NgcWR
         I99OHuUm/xMkleTr1zIl05FipXjounOaVgPKK31PkjOjTnP5+9KgkZx5/4FSaYJ8n2+Y
         /Veg==
X-Gm-Message-State: AJaThX4Fqd44Fpq2SSsgNcTziPNfWJeThINPJtdUNLvE8DA6+62gboqu
        mMTlhfpZOq/lISg45o5GjVThGpXE
X-Google-Smtp-Source: ABhQp+SiEZ0lsylfDOTAL9ZaK5bC/EqeVhHM9RQwJ8qSJzCeFEVof/Xq11S4ulvlKLOz9Az+NZJC/A==
X-Received: by 10.28.100.212 with SMTP id y203mr3918525wmb.64.1509917932555;
        Sun, 05 Nov 2017 13:38:52 -0800 (PST)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id h2sm5147323wrf.47.2017.11.05.13.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Nov 2017 13:38:51 -0800 (PST)
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
Subject: [PATCH v2 8/8] Add Git/Packet.pm from parts of t0021/rot13-filter.pl
Date:   Sun,  5 Nov 2017 22:38:36 +0100
Message-Id: <20171105213836.11717-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.15.0.8.g15d566f848
In-Reply-To: <20171105213836.11717-1-chriscool@tuxfamily.org>
References: <20171105213836.11717-1-chriscool@tuxfamily.org>
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
 perl/Git/Packet.pm      | 168 ++++++++++++++++++++++++++++++++++++++++++++++++
 perl/Makefile           |   1 +
 t/t0021/rot13-filter.pl | 140 +---------------------------------------
 3 files changed, 172 insertions(+), 137 deletions(-)
 create mode 100644 perl/Git/Packet.pm

diff --git a/perl/Git/Packet.pm b/perl/Git/Packet.pm
new file mode 100644
index 0000000000..255b28c098
--- /dev/null
+++ b/perl/Git/Packet.pm
@@ -0,0 +1,168 @@
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
+			packet_required_key_val_read
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
+	unless ( $buf =~ s/\n$// ) {
+		die "A non-binary line MUST be terminated by an LF.\n"
+		    . "Received: '$buf'";
+	}
+	return $buf;
+}
+
+sub packet_txt_read {
+	my ( $res, $buf ) = packet_bin_read();
+	unless ( $res == -1 or $buf eq '' ) {
+		$buf = remove_final_lf_or_die($buf);
+	}
+	return ( $res, $buf );
+}
+
+sub packet_required_key_val_read {
+	my ( $key ) = @_;
+	my ( $res, $buf ) = packet_txt_read();
+	unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
+		die "bad $key: '$buf'";
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
index f919d798a6..6fd7fa476b 100644
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
@@ -55,143 +58,6 @@ sub rot13 {
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
-	unless ( $buf =~ s/\n$// ) {
-		die "A non-binary line MUST be terminated by an LF.\n"
-		    . "Received: '$buf'";
-	}
-	return $buf;
-}
-
-sub packet_txt_read {
-	my ( $res, $buf ) = packet_bin_read();
-	unless ( $res == -1 or $buf eq '' ) {
-		$buf = remove_final_lf_or_die($buf);
-	}
-	return ( $res, $buf );
-}
-
-sub packet_required_key_val_read {
-	my ( $key ) = @_;
-	my ( $res, $buf ) = packet_txt_read();
-	unless ( $res == -1 or ( $buf =~ s/^$key=// and $buf ne '' ) ) {
-		die "bad $key: '$buf'";
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
2.15.0.7.ga9ff306ed9.dirty

