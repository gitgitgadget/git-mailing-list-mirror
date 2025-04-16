Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DB223D299
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 12:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805783; cv=none; b=pVpC3uTYxKU9z8R6WWQZ0OX5UXf4SegeaMZbrhgXWsQHQjoMuPRpZWl/PlB5IA9IixAZT3YWobfjemyISU4seU826ws9n+3jnDYbAs41cX8Qs/bhnGhK/Eg86lovmg92Lx6BLlgngfQ+eFlx1yXQxSl+T8o2otXsTHFKRHtdZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805783; c=relaxed/simple;
	bh=GHpYz4xySS5Frb/UlIPt3HE5+4eIq4ToWv+fDqrdj2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cFmEVXRKqOTnNRZe1RUTHD/MT+kTXj1MkglKXRRkx6NAOlqeDxe5+g74orjwSYL5u4+cPc69ZJyEU01H3JX6qmoQp3bF78+frLOI6y3h+OnLfQk3EQy3zU2epEMfk5mnkVoAmvqGIv5UYnlm8e4DgNAo6ODZmbDe6AK9hbEEnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lp+hM2gP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SYHgGFX0; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lp+hM2gP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SYHgGFX0"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0D8FB1140286;
	Wed, 16 Apr 2025 08:16:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 16 Apr 2025 08:16:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744805780;
	 x=1744892180; bh=LQ8cVtGUnKyRzFhfK0HMThKY7Iybj4eLlG+ysUuwMjo=; b=
	Lp+hM2gPpt0AX4LM59Uwq3qMlt6pmzT6nyVW8GBDz4YSR9ACgd53WQSVy0Jmm7eR
	5AuLQajMCQkW7n6yUNuIdUZPm7q+nc/ESB3QDxMiiAJrh5k0m1cHTquWd4ZZCg+U
	IF5Q5eKHwY6zm2j0U62CypJJ6wJm+VRMTa8qow7AUnWIvbseUCeKJsO3GI/dbFsI
	0w9sHWH9oVtmUbBxDswMuV4qWpCBbRvhKDHcPgQ4sz5Z43V1t5lzMvPSzaBH+Mz7
	K5zrDwmq14PEDJVJ02BNTo7KqLy8WaKA3k+/u0NX6LWy9HHo5EfHBAAMt2qwSeB8
	tpV9YabPlVy5v41hyxHIhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744805780; x=
	1744892180; bh=LQ8cVtGUnKyRzFhfK0HMThKY7Iybj4eLlG+ysUuwMjo=; b=S
	YHgGFX0IBIQubQqfOisuLFLkqC3Kq9QvoZ6C1BnuMTOrUz+Huntvd2qWtFXzqRZY
	0l13NajYuvRzOg47FnfUL+FJdgUPXHswi2Lok5LM2/Pt7tJnG7gElz9PLT4MAmvb
	SgUggE666ksAEwfS005IeODNaIDLnvVksoGwbOEtH5CmmtZsRi2RX1i5ftbfd8d8
	Z+VrDgQiFjhDeKL6pTUGsFNvfkZopcTDhuIZC1xVGv6hWoFpPnSG0kk0vthDIah5
	nvJAGYhrhOCXHruWRKo5yO3c+0++ZO+k+NimEq7cEZ3qesE4JBT8fIPY9BV+9e4I
	VOLMKYCS42SytkYj5wz9g==
X-ME-Sender: <xms:lJ__ZygUTHSpESiQBAjQYPpjB9NhiX0nkmUKio67Y0V8UmsJT-yCsw>
    <xme:lJ__ZzChVmutrNdCp-9a990ZDdrgwBWVvKgqypW0affZZ0z4fIbG44LF2YdaEWhk2
    FJpNEvzzWCGUEOspg>
X-ME-Received: <xmr:lJ__Z6EZVLhPFHXicJLysg4COvxK_FL1BM7BLevn0j_OYinvM-Y-gL9CAM798y_9HwPhse9srrXnXPh7DDRfGylKQF_Jy81_bixC6KOTA-5aIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeifeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefhfeugeelheefjeektdffhedvhfdvteefgfdt
    udffudevveetgeeuuedtkefhgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lJ__Z7T7JI4yJiaQqdncU1Uc7V1oAnx8hG2kskME4IySFTiodDYIEw>
    <xmx:lJ__Z_ynFh6q1QqlAG_6Vmrwl8WBc8bQFNn4QGzRvSRiEj8mh8RLgg>
    <xmx:lJ__Z56KyA_OAJ8xVTWJGIMfOtcr6gW7H9JzURpq0QgMOUr0TuF7-A>
    <xmx:lJ__Z8yKMiW4TIpExtIZ9zOQ8weGdxDDI8JRGx7jj2DiDh0cQzQzjQ>
    <xmx:lJ__Z7hFvUBhelypw8WpJlfGhkFjelbjSDZ6vAo_DB8UdcuFsPlrpZ5F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 08:16:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 85515b84 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 12:16:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 16 Apr 2025 14:16:10 +0200
Subject: [PATCH v2 4/4] Documentation: stop depending on Perl to generate
 command list
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250416-b4-pks-drop-perl-v2-4-bdd0492e9498@pks.im>
References: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
In-Reply-To: <20250416-b4-pks-drop-perl-v2-0-bdd0492e9498@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The "cmd-list.perl" script is used to extract the list of commands part
of a specific category and extracts the description of each command from
its respective manpage. The generated output is then included in git(1)
to list all Git commands.

The script is written in Perl. Refactor it to use shell scripting
exclusively so that we can get rid of the mandatory dependency on Perl
to build our documentation.

The converted script is slower compared to its Perl implementation. But
by being careful and not spawning external commands in `format_one ()`
we can mitigate the performance hit to a reasonable level:

    Benchmark 1: Perl
      Time (mean ± σ):      10.3 ms ±   0.2 ms    [User: 7.0 ms, System: 3.3 ms]
      Range (min … max):    10.0 ms …  11.1 ms    200 runs

    Benchmark 2: Shell
      Time (mean ± σ):      74.4 ms ±   0.4 ms    [User: 48.6 ms, System: 24.7 ms]
      Range (min … max):    73.1 ms …  75.5 ms    200 runs

    Summary
      Perl ran
        7.23 ± 0.13 times faster than Shell

While a sevenfold slowdown is significant, the benefit of not requiring
Perl for a fully-functioning Git installation outweighs waiting a couple
of milliseconds longer during the build process.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/Makefile      |   4 +-
 Documentation/cmd-list.perl |  80 ----------------------------------
 Documentation/cmd-list.sh   | 104 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/meson.build   |   4 +-
 meson.build                 |   2 +-
 5 files changed, 109 insertions(+), 85 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 6485d40f620..b109d25e9c8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -317,8 +317,8 @@ cmds_txt = cmds-ancillaryinterrogators.adoc \
 
 $(cmds_txt): cmd-list.made
 
-cmd-list.made: cmd-list.perl ../command-list.txt $(MAN1_TXT)
-	$(QUIET_GEN)$(PERL_PATH) ./cmd-list.perl .. . $(cmds_txt) && \
+cmd-list.made: cmd-list.sh ../command-list.txt $(MAN1_TXT)
+	$(QUIET_GEN)$(SHELL_PATH) ./cmd-list.sh .. . $(cmds_txt) && \
 	date >$@
 
 mergetools-%.adoc: generate-mergetool-list.sh ../git-mergetool--lib.sh $(wildcard ../mergetools/*)
diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
deleted file mode 100755
index 0a0c1b3f611..00000000000
--- a/Documentation/cmd-list.perl
+++ /dev/null
@@ -1,80 +0,0 @@
-#!/usr/bin/perl -w
-
-use File::Compare qw(compare);
-
-sub format_one {
-	my ($source_dir, $out, $nameattr) = @_;
-	my ($name, $attr) = @$nameattr;
-	my ($path) = "$source_dir/Documentation/$name.adoc";
-	my ($state, $description);
-	my $mansection;
-	$state = 0;
-	open I, '<', "$path" or die "No such file $path.adoc";
-	while (<I>) {
-		if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
-			$mansection = $1;
-			next;
-		}
-		if (/^NAME$/) {
-			$state = 1;
-			next;
-		}
-		if ($state == 1 && /^----$/) {
-			$state = 2;
-			next;
-		}
-		next if ($state != 2);
-		chomp;
-		$description = $_;
-		last;
-	}
-	close I;
-	if (!defined $description) {
-		die "No description found in $path.adoc";
-	}
-	if (my ($verify_name, $text) = ($description =~ /^($name) - (.*)/)) {
-		print $out "linkgit:$name\[$mansection\]::\n\t";
-		if ($attr =~ / deprecated /) {
-			print $out "(deprecated) ";
-		}
-		print $out "$text.\n\n";
-	}
-	else {
-		die "Description does not match $name: $description";
-	}
-}
-
-my ($source_dir, $build_dir, @categories) = @ARGV;
-
-open IN, "<$source_dir/command-list.txt";
-while (<IN>) {
-	last if /^### command list/;
-}
-
-my %cmds = ();
-for (sort <IN>) {
-	next if /^#/;
-
-	chomp;
-	my ($name, $cat, $attr) = /^(\S+)\s+(.*?)(?:\s+(.*))?$/;
-	$attr = '' unless defined $attr;
-	push @{$cmds{$cat}}, [$name, " $attr "];
-}
-close IN;
-
-for my $out (@categories) {
-	my ($cat) = $out =~ /^cmds-(.*)\.adoc$/;
-	my ($path) = "$build_dir/$out";
-	open O, '>', "$path+" or die "Cannot open output file $out+";
-	for (@{$cmds{$cat}}) {
-		format_one($source_dir, \*O, $_);
-	}
-	close O;
-
-	if (-f "$path" && compare("$path", "$path+") == 0) {
-		unlink "$path+";
-	}
-	else {
-		rename "$path+", "$path";
-	}
-}
diff --git a/Documentation/cmd-list.sh b/Documentation/cmd-list.sh
new file mode 100755
index 00000000000..077def3b721
--- /dev/null
+++ b/Documentation/cmd-list.sh
@@ -0,0 +1,104 @@
+#!/bin/sh
+
+set -e
+
+format_one () {
+	source_dir="$1"
+	command="$2"
+	attributes="$3"
+
+	path="$source_dir/Documentation/$command.adoc"
+	if ! test -f "$path"
+	then
+		echo >&2 "No such file $path"
+		exit 1
+	fi
+
+	state=0
+	while read line
+	do
+		case "$state" in
+		0)
+			case "$line" in
+			git*\(*\)|scalar*\(*\))
+				mansection="${line##*\(}"
+				mansection="${mansection%\)}"
+				;;
+			NAME)
+				state=1;;
+			esac
+			;;
+		1)
+			if test "$line" = "----"
+			then
+				state=2
+			fi
+			;;
+		2)
+			description="$line"
+			break
+			;;
+		esac
+	done <"$path"
+
+	if test -z "$mansection"
+	then
+		echo "No man section found in $path" >&2
+		exit 1
+	fi
+
+	if test -z "$description"
+	then
+		echo >&2 "No description found in $path"
+		exit 1
+	fi
+
+	case "$description" in
+	"$command - "*)
+		text="${description#$command - }"
+
+		printf "linkgit:%s[%s]::\n\t" "$command" "$mansection"
+		case "$attributes" in
+		*" deprecated "*)
+			printf "(deprecated) "
+			;;
+		esac
+		printf "$text.\n\n"
+		;;
+	*)
+		echo >&2 "Description does not match $command: $description"
+		exit 1
+		;;
+	esac
+}
+
+source_dir="$1"
+build_dir="$2"
+shift 2
+
+for out
+do
+	category="${out#cmds-}"
+	category="${category%.adoc}"
+	path="$build_dir/$out"
+
+	while read command command_category attributes
+	do
+		case "$command" in
+		"#"*)
+			continue;;
+		esac
+
+		case "$command_category" in
+		"$category")
+			format_one "$source_dir" "$command" " $attributes ";;
+		esac
+	done <"$source_dir/command-list.txt" >"$build_dir/$out+"
+
+	if cmp "$build_dir/$out+" "$build_dir/$out" >/dev/null 2>&1
+	then
+		rm "$build_dir/$out+"
+	else
+		mv "$build_dir/$out+" "$build_dir/$out"
+	fi
+done
diff --git a/Documentation/meson.build b/Documentation/meson.build
index 8b9e692c599..b731c76e9e7 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -315,12 +315,12 @@ cmd_lists = [
 
 documentation_deps += custom_target(
   command: [
-    perl,
+    shell,
     '@INPUT@',
     meson.project_source_root(),
     meson.current_build_dir(),
   ] + cmd_lists,
-  input: 'cmd-list.perl',
+  input: 'cmd-list.sh',
   output: cmd_lists
 )
 
diff --git a/meson.build b/meson.build
index 8bab8f3481f..97753d2cfa7 100644
--- a/meson.build
+++ b/meson.build
@@ -779,7 +779,7 @@ endif
 # features. It is optional if you want to neither execute tests nor use any of
 # these optional features.
 perl_required = get_option('perl')
-if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers') or get_option('docs') != []
+if get_option('gitweb').enabled() or 'netrc' in get_option('credential_helpers')
   perl_required = true
 endif
 

-- 
2.49.0.805.g082f7c87e0.dirty

