Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF26B1F461
	for <e@80x24.org>; Fri, 17 May 2019 19:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbfEQT4Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:56:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40062 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfEQT4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:56:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id h4so8327848wre.7
        for <git@vger.kernel.org>; Fri, 17 May 2019 12:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EKnmnwVOsIPI3esewNUdkHS2uubzviCxXP8JUiWSjlU=;
        b=LbZBsjpkZIaEGLN/Hr4iKfVjx4DLvMJCqtVU1929rTrJK/2yLGHqykp9OCYN5EFM7k
         69eVNwm6snT2T6sokqmqyZGXt7QqBM+13mnjX9Pv0ljsebyivwq5RcbqxNv6YT3JZtVO
         XgAg5NfP/HkGAc2s9v2WyyQJD1R32H2GrfymRuhqbqO+yG8/vB+x7D0JWdjX0TrSzIxS
         Q1UI2CgB6S5MQJmfoxgRBycJlVzwXJlseP16/wNa0OV22uA0VKz8fEkG2hKxGwfJwsn5
         HMC1MY97W93nAhexofjkbVRkTVRVNxUXM8jUfzcz0Jg8L7XF9bPrg83Z/7XyFbkGDz6R
         b5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EKnmnwVOsIPI3esewNUdkHS2uubzviCxXP8JUiWSjlU=;
        b=oSEfxVWqqaqPBFz+Js6PAxLy3XU6l2/ao/+kPxIpedZdytzO14tseXbxw5KVJIpobD
         hpi3vJ0v/RpH0INpw4NwLQrMEyMFXTcLkp6boO5H01Twy74xtoIQLO9P9wIGLB26z9AP
         mFplInhwrC/qJQM7kU6qqEzsTS/TpY/M8DTRpNLTmVv/1mfgYLdmkB99x72A5mDonwHJ
         rZkmsv3mJ/s1juOWyEX8QW6oUhJ4b+rGTxc+/RNPOEWU8ZKsK1vwtemRQbb9oAPGuJCf
         p/lVSaTEV6Qc3I6s8AJRd5opVwE/x/O2UXovAxz6iCpmGbvXjW2wLROX6pdpBvEXLkXR
         FDJQ==
X-Gm-Message-State: APjAAAXX0BxjyjNCjhKOu0j0NEScR4dnX7ccpsjGeFEOKIKrh+qgb/Ov
        1vrms9un0LrMOvzHCs4fEZ0xg+gjKgQ=
X-Google-Smtp-Source: APXvYqw1tw17Ga6KbHyx7PaXhs5MZRMM/noh10uDWwhVkuRsuBaEi0OBHfuMHoBPst5J0C7+4JMn6g==
X-Received: by 2002:adf:c188:: with SMTP id x8mr25586930wre.256.1558122980806;
        Fri, 17 May 2019 12:56:20 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r2sm18691149wrr.65.2019.05.17.12.56.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 12:56:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stephen Boyd <swboyd@chromium.org>, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] send-email: fix regression in sendemail.identity parsing
Date:   Fri, 17 May 2019 21:55:44 +0200
Message-Id: <20190517195545.29729-5-avarab@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.259.g3cce4bfedb
In-Reply-To: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
References: <xmqqsgtd3fw3.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a regression in my recent 3494dfd3ee ("send-email: do defaults ->
config -> getopt in that order", 2019-05-09). I missed that the
$identity variable needs to be extracted from the command-line before
we do the config reading, as it determines which config variable we
should read first. See [1] for the report.

The sendemail.identity feature was added back in
34cc60ce2b ("send-email: Add support for SSL and SMTP-AUTH",
2007-09-03), there were no tests to assert that it worked properly.

So let's fix both the regression, and add some tests to assert that
this is being parsed properly. While I'm at it I'm adding a
--no-identity option to go with --[to|cc|bcc] variable, since the
semantics are similar. It's like to/cc/bcc except that unlike those we
don't support multiple identities, but we could now easily add it
support for it if anyone cares.

In just fixing the --identity command-line parsing bug I discovered
that a narrow fix to that wouldn't do. In read_config() we had a state
machine that would only set config values if they weren't set already,
and thus by proxy we wouldn't e.g. set "to" based on sendemail.to if
we'd seen sendemail.gmail.to before, with --identity=gmail.

I'd modified some of the relevant code in 3494dfd3ee, but just
reverting to that wouldn't do, since it would bring back the
regression fixed in that commit.

Refactor read_config() do what we actually mean here. We don't want to
set a given sendemail.VAR if a sendemail.$identity.VAR previously set
it. The old code was conflating this desire with the hardcoded
defaults for these variables, and as discussed in 3494dfd3ee that was
never going to work. Instead pass along the state of whether an
identity config set something before, as distinguished from the state
of the default just being false, or the default being a non-bool or
true (e.g. --transferencoding).

I'm still not happy with the test coverage here, e.g. there's nothing
testing sendemail.smtpEncryption, but I only have so much time to fix
this code.

1. https://public-inbox.org/git/5cddeb61.1c69fb81.47ed4.e648@mx.google.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-send-email.txt |  4 ++
 git-send-email.perl              | 60 ++++++++++++++++++++----------
 t/t9001-send-email.sh            | 64 ++++++++++++++++++++++++++++++++
 3 files changed, 108 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 8100ff4b0f..a861934c69 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -282,6 +282,10 @@ Automating
 	Clears any list of "To:", "Cc:", "Bcc:" addresses previously
 	set via config.
 
+--no-identity::
+	Clears the previously read value of `sendemail.identity` set
+	via config, if any.
+
 --to-cmd=<command>::
 	Specify a command to execute once per patch file which
 	should generate patch file specific "To:" entries.
diff --git a/git-send-email.perl b/git-send-email.perl
index b2c4a77671..80cbbfd2b8 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -182,7 +182,7 @@ sub format_2822_time {
 	$author,$sender,$smtp_authpass,$annotate,$compose,$time);
 # Things we either get from config, *or* are overridden on the
 # command-line.
-my ($no_cc, $no_to, $no_bcc);
+my ($no_cc, $no_to, $no_bcc, $no_identity);
 my (@config_to, @getopt_to);
 my (@config_cc, @getopt_cc);
 my (@config_bcc, @getopt_bcc);
@@ -325,44 +325,53 @@ sub signal_handler {
 
 # Read our sendemail.* config
 sub read_config {
-	my ($prefix) = @_;
+	my ($configured, $prefix) = @_;
 
 	foreach my $setting (keys %config_bool_settings) {
 		my $target = $config_bool_settings{$setting};
 		my $v = Git::config_bool(@repo, "$prefix.$setting");
-		$$target = $v if defined $v;
+		next unless defined $v;
+		next if $configured->{$setting}++;
+		$$target = $v;
 	}
 
 	foreach my $setting (keys %config_path_settings) {
 		my $target = $config_path_settings{$setting};
 		if (ref($target) eq "ARRAY") {
-			unless (@$target) {
-				my @values = Git::config_path(@repo, "$prefix.$setting");
-				@$target = @values if (@values && defined $values[0]);
-			}
+			my @values = Git::config_path(@repo, "$prefix.$setting");
+			next unless @values;
+			next if $configured->{$setting}++;
+			@$target = @values;
 		}
 		else {
 			my $v = Git::config_path(@repo, "$prefix.$setting");
-			$$target = $v if defined $v;
+			next unless defined $v;
+			next if $configured->{$setting}++;
+			$$target = $v;
 		}
 	}
 
 	foreach my $setting (keys %config_settings) {
 		my $target = $config_settings{$setting};
 		if (ref($target) eq "ARRAY") {
-			unless (@$target) {
-				my @values = Git::config(@repo, "$prefix.$setting");
-				@$target = @values if (@values && defined $values[0]);
-			}
+			my @values = Git::config(@repo, "$prefix.$setting");
+			next unless @values;
+			next if $configured->{$setting}++;
+			@$target = @values;
 		}
 		else {
 			my $v = Git::config(@repo, "$prefix.$setting");
-			$$target = $v if defined $v;
+			next unless defined $v;
+			next if $configured->{$setting}++;
+			$$target = $v;
 		}
 	}
 
 	if (!defined $smtp_encryption) {
-		my $enc = Git::config(@repo, "$prefix.smtpencryption");
+		my $setting = "$prefix.smtpencryption";
+		my $enc = Git::config(@repo, $setting);
+		return unless defined $enc;
+		return if $configured->{$setting}++;
 		if (defined $enc) {
 			$smtp_encryption = $enc;
 		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
@@ -371,17 +380,30 @@ sub read_config {
 	}
 }
 
+# sendemail.identity yields to --identity. We must parse this
+# special-case first before the rest of the config is read.
 $identity = Git::config(@repo, "sendemail.identity");
-read_config("sendemail.$identity") if defined $identity;
-read_config("sendemail");
+my $rc = GetOptions(
+	"identity=s" => \$identity,
+	"no-identity" => \$no_identity,
+);
+usage() unless $rc;
+undef $identity if $no_identity;
+
+# Now we know enough to read the config
+{
+    my %configured;
+    read_config(\%configured, "sendemail.$identity") if defined $identity;
+    read_config(\%configured, "sendemail");
+}
 
 # Begin by accumulating all the variables (defined above), that we will end up
 # needing, first, from the command line:
 
 my $help;
 my $git_completion_helper;
-my $rc = GetOptions("h" => \$help,
-                    "dump-aliases" => \$dump_aliases);
+$rc = GetOptions("h" => \$help,
+                 "dump-aliases" => \$dump_aliases);
 usage() unless $rc;
 die __("--dump-aliases incompatible with other options\n")
     if !$help and $dump_aliases and @ARGV;
@@ -410,8 +432,6 @@ sub read_config {
 		    "smtp-debug:i" => \$debug_net_smtp,
 		    "smtp-domain:s" => \$smtp_domain,
 		    "smtp-auth=s" => \$smtp_auth,
-		    "no-smtp-auth" => sub {$smtp_auth = 'none'},
-		    "identity=s" => \$identity,
 		    "annotate!" => \$annotate,
 		    "no-annotate" => sub {$annotate = 0},
 		    "compose" => \$compose,
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 61d484d1a6..890e2874c3 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1228,6 +1228,61 @@ test_expect_success $PREREQ 'sendemail.to works' '
 	grep "To: Somebody <somebody@ex.com>" stdout
 '
 
+test_expect_success $PREREQ 'setup sendemail.identity' '
+	git config --replace-all sendemail.to "default@example.com" &&
+	git config --replace-all sendemail.isp.to "isp@example.com" &&
+	git config --replace-all sendemail.cloud.to "cloud@example.com"
+'
+
+test_expect_success $PREREQ 'sendemail.identity: reads the correct identity config' '
+	git -c sendemail.identity=cloud send-email \
+		--dry-run \
+		--from="nobody@example.com" \
+		$patches >stdout &&
+	grep "To: cloud@example.com" stdout
+'
+
+test_expect_success $PREREQ 'sendemail.identity: identity overrides sendemail.identity' '
+	git -c sendemail.identity=cloud send-email \
+		--identity=isp \
+		--dry-run \
+		--from="nobody@example.com" \
+		$patches >stdout &&
+	grep "To: isp@example.com" stdout
+'
+
+test_expect_success $PREREQ 'sendemail.identity: --no-identity clears previous identity' '
+	git -c sendemail.identity=cloud send-email \
+		--no-identity \
+		--dry-run \
+		--from="nobody@example.com" \
+		$patches >stdout &&
+	grep "To: default@example.com" stdout
+'
+
+test_expect_success $PREREQ 'sendemail.identity: bool identity variable existance overrides' '
+	git -c sendemail.identity=cloud \
+		-c sendemail.xmailer=true \
+		-c sendemail.cloud.xmailer=false \
+		send-email \
+		--dry-run \
+		--from="nobody@example.com" \
+		$patches >stdout &&
+	grep "To: cloud@example.com" stdout &&
+	! grep "X-Mailer" stdout
+'
+
+test_expect_success $PREREQ 'sendemail.identity: bool variable fallback' '
+	git -c sendemail.identity=cloud \
+		-c sendemail.xmailer=false \
+		send-email \
+		--dry-run \
+		--from="nobody@example.com" \
+		$patches >stdout &&
+	grep "To: cloud@example.com" stdout &&
+	! grep "X-Mailer" stdout
+'
+
 test_expect_success $PREREQ '--no-to overrides sendemail.to' '
 	git send-email \
 		--dry-run \
@@ -1785,6 +1840,15 @@ test_expect_success '--dump-aliases must be used alone' '
 	test_must_fail git send-email --dump-aliases --to=janice@example.com -1 refs/heads/accounting
 '
 
+test_expect_success 'aliases and sendemail.identity' '
+	test_must_fail git \
+		-c sendemail.identity=cloud \
+		-c sendemail.aliasesfile=default-aliases \
+		-c sendemail.cloud.aliasesfile=cloud-aliases \
+		send-email -1 2>stderr &&
+	test_i18ngrep "cloud-aliases" stderr
+'
+
 test_sendmail_aliases () {
 	msg="$1" && shift &&
 	expect="$@" &&
-- 
2.21.0.1020.gf2820cf01a

