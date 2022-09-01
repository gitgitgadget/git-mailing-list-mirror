Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF004ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 00:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbiIAAa1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 20:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbiIAAaK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 20:30:10 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0867946DB4
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:08 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id d5so8169634wms.5
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=SHNMajoaPTP2MJWJ6AkRDSQv92Srq80YyiWtJHQHFVs=;
        b=okfIMDnT9YePMX4MQIt8ZxoSlecEG9WyjyVqbNasAGECVPWYFQSnifTKW/uc8W0Jmw
         uNciu1czvbLXZ0FaKfc+yxm18kHKI2LGzEikqwoIqEQD+1Je69IYcMDApMvQ6/GdHYxO
         K48d2g9WsVjoc6FMJEo2hWq98rE3Qe9Kh/UgmTu6zyuYd0/E+I1pSkxaT4hTCHnk4vaN
         F71EvgZe3/wfrR7HTvT+ZxnOlxtV2L+FbhERyaF4Gq9fZ4cZRMu/0G0EvOM3u9RFjXHw
         VLBqhwHPU59ciL6nTD0YbM7o7PyPqf4wekl+/jXxY+addPFkXgxgHeTLU4vvUxXP+9/G
         REvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=SHNMajoaPTP2MJWJ6AkRDSQv92Srq80YyiWtJHQHFVs=;
        b=2DTi3wPt98J3943ODVaQ3JMWNGkCuA/vFaQSSQnQbcGP6il3ptWHufKnWAahlDZNFf
         +8LbMZa/DO3uuz11bpi3EjXuM5Pkz27TFpHsRihN42u35+8eHmb5MH/qdXa/eVCGifXV
         RsNyhymqoS6s6ChYWAZOXYgpu2aAcFNCYkr298qXLpzQUkbMwfbfaoTU2R/MKxfE3FEQ
         8HWqsgNn7+wvZU5EfRwC/+1uOrFYMSG6ecGWroLf29Ju/EOuiKCezgINAqIhI01CozAu
         CD84d7H7WRrdv0OjxF6RaQj+F9NRVMg1FxCerTSTxx/RyTjPhid65m+Ye65+aQpVpLo9
         hCXA==
X-Gm-Message-State: ACgBeo0PLMFBuAiAm5J2UEvMEOgxWom4TTuw4BKIS3njwXKztx3NHUoW
        e5H8pTUqkkAE0AsKau1eO4FHaZc1HUc=
X-Google-Smtp-Source: AA6agR5lLTRNapFn+lZizQphsFVdZxnewpDfGjeHV3jKb9LNU4kWql9wGQZaHTqWzhIBkGfVfvtF5w==
X-Received: by 2002:a05:600c:410d:b0:3a6:1db8:b419 with SMTP id j13-20020a05600c410d00b003a61db8b419mr3376202wmi.119.1661992206302;
        Wed, 31 Aug 2022 17:30:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4848000000b00226d01a4635sm13182910wrs.35.2022.08.31.17.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 17:30:05 -0700 (PDT)
Message-Id: <62fc652eb47a4df83d88a197e376f28dbbab3b52.1661992197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
From:   "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 00:29:44 +0000
Subject: [PATCH 06/18] chainlint.pl: validate test scripts in parallel
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric Sunshine <sunshine@sunshineco.com>

Although chainlint.pl has undergone a good deal of optimization during
its development -- increasing in speed significantly -- parsing and
validating 1050+ scripts and 16500+ tests via Perl is not exactly
instantaneous. However, perceived performance can be improved by taking
advantage of the fact that there is no interdependence between test
scripts or test definitions, thus parsing and validating can be done in
parallel. The number of available cores is determined automatically but
can be overridden via the --jobs option.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.pl | 50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index d526723ac00..898573a9100 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -15,9 +15,11 @@
 
 use warnings;
 use strict;
+use Config;
 use File::Glob;
 use Getopt::Long;
 
+my $jobs = -1;
 my $show_stats;
 my $emit_all;
 
@@ -569,6 +571,16 @@ if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
 	$interval = sub { return Time::HiRes::tv_interval(shift); };
 }
 
+sub ncores {
+	# Windows
+	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
+	# Linux / MSYS2 / Cygwin / WSL
+	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor\s*:/, <>)); } if -r '/proc/cpuinfo';
+	# macOS & BSD
+	return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
+	return 1;
+}
+
 sub show_stats {
 	my ($start_time, $stats) = @_;
 	my $walltime = $interval->($start_time);
@@ -621,7 +633,9 @@ sub exit_code {
 Getopt::Long::Configure(qw{bundling});
 GetOptions(
 	"emit-all!" => \$emit_all,
+	"jobs|j=i" => \$jobs,
 	"stats|show-stats!" => \$show_stats) or die("option error\n");
+$jobs = ncores() if $jobs < 1;
 
 my $start_time = $getnow->();
 my @stats;
@@ -633,6 +647,40 @@ unless (@scripts) {
 	exit;
 }
 
-push(@stats, check_script(1, sub { shift(@scripts); }, sub { print(@_); }));
+unless ($Config{useithreads} && eval {
+	require threads; threads->import();
+	require Thread::Queue; Thread::Queue->import();
+	1;
+	}) {
+	push(@stats, check_script(1, sub { shift(@scripts); }, sub { print(@_); }));
+	show_stats($start_time, \@stats) if $show_stats;
+	exit(exit_code(\@stats));
+}
+
+my $script_queue = Thread::Queue->new();
+my $output_queue = Thread::Queue->new();
+
+sub next_script { return $script_queue->dequeue(); }
+sub emit { $output_queue->enqueue(@_); }
+
+sub monitor {
+	while (my $s = $output_queue->dequeue()) {
+		print($s);
+	}
+}
+
+my $mon = threads->create({'context' => 'void'}, \&monitor);
+threads->create({'context' => 'list'}, \&check_script, $_, \&next_script, \&emit) for 1..$jobs;
+
+$script_queue->enqueue(@scripts);
+$script_queue->end();
+
+for (threads->list()) {
+	push(@stats, $_->join()) unless $_ == $mon;
+}
+
+$output_queue->end();
+$mon->join();
+
 show_stats($start_time, \@stats) if $show_stats;
 exit(exit_code(\@stats));
-- 
gitgitgadget

