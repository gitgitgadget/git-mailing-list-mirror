Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C653A1F428
	for <e@80x24.org>; Tue, 14 Aug 2018 18:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeHNVEK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:04:10 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37803 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbeHNVEK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:04:10 -0400
Received: by mail-wm0-f68.google.com with SMTP id n11-v6so13078016wmc.2
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L9/zFaKLT3LG7tp86gv+5F5LuUAq8t+ny/DIPrNGSFI=;
        b=fGWSNQyeXxAsxSyXeanlJqaNyJ11x7U1idH5x+mHXj1MQn3AHpan1fD2hQ++7ql9ru
         vPsoZyPY/u7skpWfc6NaU9T2mfR208v04ZgPtQPnExBGxC8be0rRPqv42NFxJqLYZGLv
         nWyCF5bu/Zi3uohNJtlGgNZW/cFf0TgMlCF8h8YVGjNxQ1n4LW/7B2KwX88nE1NgviX9
         C1UWUicOdPkSZckMQdSlCUpbDA0ntmBYe+pBtTg8yB0Ed0THnPFk/dA6iyEbE+upmqxE
         OXfhSlKsaTA5Tp4J4/MpKptwo4nUROuCbHrY30RZtSNuqQ7WOflXQAku+NMB3mVvQATR
         dmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L9/zFaKLT3LG7tp86gv+5F5LuUAq8t+ny/DIPrNGSFI=;
        b=hyoIWpufh0z0ht5pwH/wVfdf1zkY2dH8OaUh29QWKC7cftVulFLN4QlTF//4w2widZ
         9v1dbNfi+bz12JT0cUkFWz66DZ1NtwX895QfzKLAlRww48UNRxfJ+9DVf08zCFOBSmdQ
         wwPDwYIcD4UxKZLOpJBYnLko9KjtfJp/VfSYcBHAbbJ1XX/z06z44utYCzf2zk+7vwJz
         JV0Pdk4OAMIeoVoizIiUG3bPJjrpl9OM64wA9EaHjTmlbIUsyKKdq7UefT8729X9yTHk
         Q+0j9qgRpqifSzSSLChEhd3EiVO8XcYEra8oAHdpp4Y2bsOhbdeQ4bda8gsgx2XZAWK1
         o+Sg==
X-Gm-Message-State: AOUpUlHbubcVenYcw+cHrOb60WyCWLCpAEKxmnAsEm95szquA8VSjcA7
        m9Oz3QTYP7olghqY23Iq+vQ6nWmXWLw=
X-Google-Smtp-Source: AA+uWPz9Fqsx3LluFLq/Tyu387b+eUW0QFHOr6ubrrbjr0+lqulAQDnqR6437ZxJpdquyNj05Aw07A==
X-Received: by 2002:a1c:9f12:: with SMTP id i18-v6mr11924321wme.124.1534270546249;
        Tue, 14 Aug 2018 11:15:46 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id e137-v6sm25416248wma.20.2018.08.14.11.15.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 11:15:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] send-email: add an option to impose delay sent E-Mails
Date:   Tue, 14 Aug 2018 18:15:34 +0000
Message-Id: <20180814181534.21234-1-avarab@gmail.com>
X-Mailer: git-send-email 2.18.0.865.gffc8e1a3cd6
In-Reply-To: <20180325182803.30036-1-avarab@gmail.com>
References: <20180325182803.30036-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --send-delay option with a corresponding sendemail.smtpSendDelay
configuration variable. When set to e.g. 2, this causes send-email to
sleep 2 seconds before sending the next E-Mail. We'll only sleep
between sends, not before the first send, or after the last.

This option has two uses. Firstly, to be able to Ctrl+C a long send
with "all" if you have a change of heart. Secondly, as a hack in some
mail setups to, with a sufficiently high delay, force the receiving
client to sort the E-Mails correctly.

Some popular E-Mail clients completely ignore the "Date" header, which
format-patch is careful to set such that the patches will be displayed
in order, and instead sort by the time the E-mail was received.

Google's GMail is a good example of such a client. It ostensibly sorts
by some approximation of received time (although not by any "Received"
header). It's more usual than not to see patches showing out of order
in GMail. To take a few examples of orders seen on patches on the Git
mailing list:

    1 -> 3 -> 4 -> 2 -> 8 -> 7 (completion by Nguyễn Thái Ngọc Duy)
    2 -> 0 -> 1 -> 3 (pack search by Derrick Stolee)
    3 -> 2 -> 1 (fast-import by Jameson Miller)
    2 -> 3 -> 1 -> 5 -> 4 -> 6 (diff-highlight by Jeff King)

The reason to add the new "X-Mailer-Send-Delay" header is to make it
easy to tell what the imposed delay was, if any. This allows for
gathering some data on how the transfer of E-Mails with & without this
option behaves. This may not be workable without really long delays,
see [1] and [2].

The reason for why the getopt format is "send-delay=s" instead of
"send-delay=d" is because we're doing manual validation of the value
we get passed, which getopt would corrupt in cases of e.g. float
values before we could show a sensible error message.

1. https://public-inbox.org/git/20180325210132.GE74743@genre.crustytoothpaste.net/
2. https://public-inbox.org/git/xmqqpo3rehe4.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

I submitted this back in March hoping it would solve mail ordering
problems, but the other motive I had for this is that I'm paranoid
that I'm sending out bad E-Mails, and tend to "y" to each one because
"a" is too fast.

So I'm re-sending this with an updated commit message & rationale, and
not sending 2/2 to toggle this on by default. I'd still like to have
this feature.

 Documentation/config.txt         |  6 ++++
 Documentation/git-send-email.txt |  4 +++
 git-send-email.perl              | 18 ++++++++---
 t/t9001-send-email.sh            | 55 ++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 63365dcf3d..5eb81b64a7 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3216,6 +3216,12 @@ sendemail.smtpReloginDelay::
 	Seconds wait before reconnecting to smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
 
+sendemail.smtpSendDelay::
+	Seconds wait in between message sending before sending another
+	message. Set it to 0 to impose no extra delay, defaults to 0.
++
+See also the `--send-delay` option of linkgit:git-send-email[1].
+
 showbranch.default::
 	The default set of branches for linkgit:git-show-branch[1].
 	See linkgit:git-show-branch[1].
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 465a4ecbed..98fdd9b803 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -270,6 +270,10 @@ must be used for each option.
 	with --batch-size option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
 
+--send-delay=<int>::
+	Wait $<int> between sending emails. Defaults to the
+	`sendemail.smtpSendDelay` configuration variable.
+
 Automating
 ~~~~~~~~~~
 
diff --git a/git-send-email.perl b/git-send-email.perl
index 2be5dac337..65b53ee9f1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -89,6 +89,7 @@ sub usage {
     --batch-size            <int>  * send max <int> message per connection.
     --relogin-delay         <int>  * delay <int> seconds between two successive login.
                                      This option can only be used with --batch-size
+    --send-delay            <int>  * ensure that <int> seconds pass between two successive sends.
 
   Automating:
     --identity              <str>  * Use the sendemail.<id> options.
@@ -225,7 +226,7 @@ sub do_edit {
 my ($to_cmd, $cc_cmd);
 my ($smtp_server, $smtp_server_port, @smtp_server_options);
 my ($smtp_authuser, $smtp_encryption, $smtp_ssl_cert_path);
-my ($batch_size, $relogin_delay);
+my ($batch_size, $relogin_delay, $send_delay);
 my ($identity, $aliasfiletype, @alias_files, $smtp_domain, $smtp_auth);
 my ($validate, $confirm);
 my (@suppress_cc);
@@ -259,6 +260,7 @@ sub do_edit {
     "smtpauth" => \$smtp_auth,
     "smtpbatchsize" => \$batch_size,
     "smtprelogindelay" => \$relogin_delay,
+    "smtpsenddelay" => \$send_delay,
     "to" => \@initial_to,
     "tocmd" => \$to_cmd,
     "cc" => \@initial_cc,
@@ -373,6 +375,7 @@ sub signal_handler {
 		    "no-xmailer" => sub {$use_xmailer = 0},
 		    "batch-size=i" => \$batch_size,
 		    "relogin-delay=i" => \$relogin_delay,
+		    "send-delay=s" => \$send_delay,
 	 );
 
 usage() if $help;
@@ -484,6 +487,8 @@ sub read_config {
 };
 die sprintf(__("Unknown --confirm setting: '%s'\n"), $confirm)
 	unless $confirm =~ /^(?:auto|cc|compose|always|never)/;
+die sprintf(__("Invalid --send-delay setting: '%s'\n"), $send_delay)
+	if defined $send_delay and $send_delay !~ /^[0-9]+$/s;
 
 # Debugging, print out the suppressions.
 if (0) {
@@ -1562,7 +1567,8 @@ sub send_message {
 # Returns 0 if an edit was done and the function should be called again, or 1
 # otherwise.
 sub process_file {
-	my ($t) = @_;
+	my ($i) = @_;
+	my $t = $files[$i];
 
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
@@ -1741,6 +1747,10 @@ sub process_file {
 		$message, $xfer_encoding, $target_xfer_encoding);
 	push @xh, "Content-Transfer-Encoding: $xfer_encoding";
 	unshift @xh, 'MIME-Version: 1.0' unless $has_mime_version;
+	if ($send_delay && $i > 0) {
+		push @xh, "X-Mailer-Send-Delay: $send_delay";
+		sleep $send_delay;
+	}
 
 	$needs_confirm = (
 		$confirm eq "always" or
@@ -1793,8 +1803,8 @@ sub process_file {
 	return 1;
 }
 
-foreach my $t (@files) {
-	while (!process_file($t)) {
+foreach my $i (0 .. $#files) {
+	while (!process_file($i)) {
 		# user edited the file
 	}
 }
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index b8e919e25d..791461fabd 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1759,6 +1759,61 @@ test_expect_success '--dump-aliases must be used alone' '
 	test_must_fail git send-email --dump-aliases --to=janice@example.com -1 refs/heads/accounting
 '
 
+test_expect_success '--send-delay expects whole non-negative seconds' '
+	test_must_fail git send-email --send-delay=-1 HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors &&
+	test_must_fail git send-email --send-delay=1.5 HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors &&
+	test_must_fail git -c sendemail.smtpSendDelay=-1 send-email HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors &&
+	test_must_fail git -c sendemail.smtpSendDelay=1.5 send-email HEAD~ 2>errors &&
+	test_i18ngrep "Invalid --send-delay setting" errors
+'
+
+test_expect_success $PREREQ "there is no default --send-delay" '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch -3 -o outdir &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		outdir/*.patch \
+		2>stderr >stdout &&
+	test $(grep -c "X-Mailer:" stdout) = 3 &&
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 0
+'
+
+test_expect_success $PREREQ '--send-delay adds a X-Mailer-Send-Delay header to affected E-Mails' '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch -3 -o outdir &&
+	git send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--send-delay=2 \
+		outdir/*.patch \
+		2>stderr >stdout &&
+	test $(grep -c "X-Mailer:" stdout) = 3 &&
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 2
+'
+
+test_expect_success $PREREQ '--send-delay=0 disables any imposed delay on E-Mail sending' '
+	clean_fake_sendmail &&
+	rm -fr outdir &&
+	git format-patch -3 -o outdir &&
+	git -c sendemail.smtpSendDelay=3 send-email \
+		--from="Example <nobody@example.com>" \
+		--to=nobody@example.com \
+		--smtp-server="$(pwd)/fake.sendmail" \
+		--send-delay=0 \
+		outdir/*.patch \
+		2>stderr >stdout &&
+	test $(grep -c "X-Mailer:" stdout) = 3 &&
+	test $(grep -c "X-Mailer-Send-Delay:" stdout) = 0
+'
+
 test_sendmail_aliases () {
 	msg="$1" && shift &&
 	expect="$@" &&
-- 
2.18.0.865.gffc8e1a3cd6

