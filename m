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
	by dcvr.yhbt.net (Postfix) with ESMTP id B06341F461
	for <e@80x24.org>; Fri, 17 May 2019 19:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729058AbfEQT4Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 May 2019 15:56:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45929 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728297AbfEQT4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 15:56:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id b18so8275983wrq.12
        for <git@vger.kernel.org>; Fri, 17 May 2019 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N1cXo9OerMOr2PDE69u/yN4T0DTo3NxEn/wP4arpNzE=;
        b=grJuKcqDz7w/2okjwFrlkZMzrt3TtuDjts2HmjFxjp6g4i6hXqKDS2ZtyKxNonJsUd
         rTb6jFkJK/ovDv+iPYRgMYL6TT9lo+tT9EvqVmgJzW0ws4S5snja1n68ttV5dGHA89My
         6e+4IikNPsAIjL7xC06dIBSpKpXIOTEGoWlb6909gXZXGzqQpGFcrEfAX3zKgrWQ1hta
         7aEOe26CyMjr9ribOdcgkaB2VBn5hzQWchy9s2M23UcUMbFrdNOeOP/jz3wqGLAei0TR
         FlrtWnyWn8Z17u56UiCYN7B99Ht5kVHb3RaEkTe2xENlD2rbEs1UcIS9katz8iQM3Q2E
         1eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N1cXo9OerMOr2PDE69u/yN4T0DTo3NxEn/wP4arpNzE=;
        b=EU6Ksnjdz07X2HZ5aMB4pREj4IOe55qgViWWJ1yQYEjV2Ww3dWlNxkLPq3oFRlymRl
         BH864Lx8b3PIfkivUGE1Er962mFQcs4tyueeSq9goqZTJxD6C/srxaaZfod1YmImwZ1y
         b/H1dlzqzHBMIn/2VnF05TlQwc8CnoS+Gkm4cDLBdzbd74UmPVea8qZub9lOuzR4+EZR
         ZBrK6pxD+stSM3UL8TVsSTfeuboNtrQ4XYkocraja/Dx2SDiYqIV8J8bCe8DkPO9+Hjl
         VHe1HIsgcCutbClpktvqJxwyGRgUdnei92YWJJH1wfz+000i0a+eeEoO20bYGKEk7tMz
         1PQQ==
X-Gm-Message-State: APjAAAVwZP1cCeTnly9rIDsWZvimyRM02pilL9A3BeeLGRmmh+9eNWbQ
        HmqRjMEK1eHGULLSrRhKIe3aFuCOiFg=
X-Google-Smtp-Source: APXvYqwSk61qzaS+TGlJllmrOfrRSjErLCwJYh8DBldqmCAxxA59X4iUQ9Grpcg+6UithX55LDv4Xw==
X-Received: by 2002:adf:f407:: with SMTP id g7mr19720356wro.196.1558122982426;
        Fri, 17 May 2019 12:56:22 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r2sm18691149wrr.65.2019.05.17.12.56.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 17 May 2019 12:56:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Stephen Boyd <swboyd@chromium.org>, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, sunshine@sunshineco.com,
        xypron.glpk@gmx.de, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] send-email: remove support for deprecated sendemail.smtpssl
Date:   Fri, 17 May 2019 21:55:45 +0200
Message-Id: <20190517195545.29729-6-avarab@gmail.com>
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

Remove the sendemail.smtpssl configuration variable and its associated
--smtp-ssl command-line option. This has been documented as deprecated
since f6bebd121a ("git-send-email: add support for TLS via
Net::SMTP::SSL", 2008-06-25) and 65180c6618 ("List send-email config
options in config.txt.", 2009-07-22), respectively. Waiting for 10
years should be enough.

This allows us to fix a special case in read_config(). We couldn't
just parse sendemail.smtpEncryption like everything else because we'd
need to fall back on sendemail.smtpssl. Now that we don't need to do
that we don't need this special case anymore. Let's still find out if
someone's using this and die() with a helpful message if that's the
case.

Because of my recent improvements to the command-line and config
parsing we can also revert fa835cd572 ("git-send-email: prevent
undefined variable warnings if no encryption is set", 2008-06-26),
since we now sensibly support setting defaults for these mixed config
& command-line options.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/sendemail.txt |  3 ---
 Documentation/git-send-email.txt   |  3 ---
 git-send-email.perl                | 26 +++++++++-----------------
 t/t9001-send-email.sh              |  9 +++++++++
 4 files changed, 18 insertions(+), 23 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 0006faf800..d7855bff1f 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -8,9 +8,6 @@ sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpssl (deprecated)::
-	Deprecated alias for 'sendemail.smtpEncryption = ssl'.
-
 sendemail.smtpsslcertpath::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index a861934c69..6cf5c32ce8 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -236,9 +236,6 @@ The --smtp-server-option option must be repeated for each option you want
 to pass to the server. Likewise, different lines in the configuration files
 must be used for each option.
 
---smtp-ssl::
-	Legacy alias for '--smtp-encryption ssl'.
-
 --smtp-ssl-cert-path::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
diff --git a/git-send-email.perl b/git-send-email.perl
index 80cbbfd2b8..b1ed45b907 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -77,7 +77,6 @@ sub usage {
     --smtp-user             <str>  * Username for SMTP-AUTH.
     --smtp-pass             <str>  * Password for SMTP-AUTH; not necessary.
     --smtp-encryption       <str>  * tls or ssl; anything else disables.
-    --smtp-ssl                     * Deprecated. Use '--smtp-encryption ssl'.
     --smtp-ssl-cert-path    <str>  * Path to ca-certificates (either directory or file).
                                      Pass an empty string to disable certificate
                                      verification.
@@ -236,7 +235,7 @@ sub do_edit {
 my ($cover_cc, $cover_to);
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
-my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
+my ($smtp_authuser, $smtp_ssl_cert_path);
 my ($batch_size, $relogin_delay);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($confirm);
@@ -250,6 +249,9 @@ sub do_edit {
 my $use_xmailer = 1;
 my $validate = 1;
 my $target_xfer_encoding = 'auto';
+my $smtp_encryption = '';
+# Deprecated variables
+my $deprecated_smtp_ssl;
 
 my %config_bool_settings = (
     "thread" => \$thread,
@@ -266,10 +268,12 @@ sub do_edit {
 );
 
 my %config_settings = (
+    "smtpencryption" => \$smtp_encryption,
     "smtpserver" => \$smtp_server,
     "smtpserverport" => \$smtp_server_port,
     "smtpserveroption" => \@smtp_server_options,
     "smtpuser" => \$smtp_authuser,
+    "smtpssl" => \$deprecated_smtp_ssl,
     "smtppass" => \$smtp_authpass,
     "smtpdomain" => \$smtp_domain,
     "smtpauth" => \$smtp_auth,
@@ -366,18 +370,6 @@ sub read_config {
 			$$target = $v;
 		}
 	}
-
-	if (!defined $smtp_encryption) {
-		my $setting = "$prefix.smtpencryption";
-		my $enc = Git::config(@repo, $setting);
-		return unless defined $enc;
-		return if $configured->{$setting}++;
-		if (defined $enc) {
-			$smtp_encryption = $enc;
-		} elsif (Git::config_bool(@repo, "$prefix.smtpssl")) {
-			$smtp_encryption = 'ssl';
-		}
-	}
 }
 
 # sendemail.identity yields to --identity. We must parse this
@@ -426,7 +418,7 @@ sub read_config {
 		    "smtp-server-port=s" => \$smtp_server_port,
 		    "smtp-user=s" => \$smtp_authuser,
 		    "smtp-pass:s" => \$smtp_authpass,
-		    "smtp-ssl" => sub { $smtp_encryption = 'ssl' },
+		    "smtp-ssl" => sub { $deprecated_smtp_ssl = 1 },
 		    "smtp-encryption=s" => \$smtp_encryption,
 		    "smtp-ssl-cert-path=s" => \$smtp_ssl_cert_path,
 		    "smtp-debug:i" => \$debug_net_smtp,
@@ -484,8 +476,8 @@ sub read_config {
 	"(via command-line or configuration option)\n")
 	if defined $relogin_delay and not defined $batch_size;
 
-# 'default' encryption is none -- this only prevents a warning
-$smtp_encryption = '' unless (defined $smtp_encryption);
+die __("Use of deprecated option --smtp-ssl (or smtp.smtpssl config), use --smtp-encryption=ssl (or sendemail.smtpEncryption=ssl) instead\n")
+	if $deprecated_smtp_ssl;
 
 # Set CC suppressions
 my(%suppress_cc);
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 890e2874c3..b5ccfa8737 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1849,6 +1849,15 @@ test_expect_success 'aliases and sendemail.identity' '
 	test_i18ngrep "cloud-aliases" stderr
 '
 
+test_expect_success 'deprecated --smtp-ssl (or sendemail.smtpssl=true)' '
+	test_must_fail git -c sendemail.smtpssl=true send-email -1 2>stderr &&
+	test_i18ngrep "deprecated option.*or.*config" stderr &&
+	test_must_fail git send-email --smtp-ssl -1 &&
+	test_i18ngrep "deprecated option.*or.*config" stderr &&
+	test_must_fail git -c sendemail.identity=test -c sendemail.test.smtpssl=true send-email -1 &&
+	test_i18ngrep "deprecated option.*or.*config" stderr
+'
+
 test_sendmail_aliases () {
 	msg="$1" && shift &&
 	expect="$@" &&
-- 
2.21.0.1020.gf2820cf01a

