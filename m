Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9195D125CD
	for <git@vger.kernel.org>; Fri, 16 Feb 2024 05:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708060809; cv=none; b=IYFqdMiNx28ZPQDfSWTkhvqqXPqYARcs1yuIyPi7g/eM2lo5u1/bSz7Anh7IufXMPkaCSJYDtXhhnnS+ZGyaK4sxv9qgA5TyAlqyQOrXj0Hdzy8iKdtfdF8NcV1msJcL0iIdZDVPKDXTqbsqNh4Q8sQOx/5UrAtxwsO/VJN2B9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708060809; c=relaxed/simple;
	bh=TO38z4iptMeFcm4vYzvirVR9FAt9+tfZiUB1RFOWnts=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=r/OMLsCmNTj3Aqe2pg034yCLzctBBMZktQvYr1K/dAaBIPWmHYvzk0RodaUX9/4iZzI3h+Q9yQdGZcD1xRdPNy6VIhOsr45ihnO1H3TVMDMIUWhJ0ImyI8Tgn3AcQEZR/FW9tfoe25qqPnsznN7g9k/X4fTobzAFqPX4jxM5hw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=sz2tk6ch; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="sz2tk6ch"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708060802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OLqG/RludB6m6BfY3qsf8ZmcvgObBDk9tmexntDSiqc=;
	b=sz2tk6chMIRtL4HWm7dApQnnu4ICSwD/4t8cwXCgyeQEj79/8llnRtF2LQBt/qfyEe1Eiw
	I3HHmw7Br2/n6ZaepH8j6PqHqctW7ocIIe9N3Z3HMO5JwH0lkybPYXSDu1NEqz3v+gb+pQ
	Q5BjJNqUQ+P+WfgxQ0HsbMdLGqQiywbmmGK9WouvMDVVwIgbikywlNBJ+0/81Ngct7q2xt
	eFufU0JawTm7m3ddQ87jsIJle6n2u8h/CD2IQTQ20hayrA8T3MewSt6xPfyd9DtTJu/XgH
	mgbuAcVOZeHQFyZGndXBhkRKIqI1xbMqcZ0FWj9UOY7px8WXe0TXqkaz07ZQzA==
To: git@vger.kernel.org
Subject: [PATCH] documentation: send-email: use camel case consistently
Date: Fri, 16 Feb 2024 06:19:56 +0100
Message-Id: <b0577267402f6177d8ba5646e12d7691437e6e8f.1708060779.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Correct a few random "sendemail.*" configuration parameter names in the
documentation that, for some reason, didn't use camel case format.

There's only one "Fixes" tag, while there should actually be a whole bunch
of them to cover all the patches that introduced the configuration parameter
names fixed by this patch.  I think we're fine with just one.

Fixes: 0ee42c86cf71 ("config.txt: move sendemail-config.txt to config/")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---
 Documentation/config/sendemail.txt | 12 ++++++------
 Documentation/git-send-email.txt   | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 7fc770ee9e69..bfdf1a633cae 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -8,7 +8,7 @@ sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpsslcertpath::
+sendemail.smtpSslCertPath::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
 
@@ -62,27 +62,27 @@ sendemail.chainReplyTo::
 sendemail.envelopeSender::
 sendemail.from::
 sendemail.headerCmd::
-sendemail.signedoffbycc::
+sendemail.signedOffByCc::
 sendemail.smtpPass::
-sendemail.suppresscc::
+sendemail.suppressCc::
 sendemail.suppressFrom::
 sendemail.to::
-sendemail.tocmd::
+sendemail.toCmd::
 sendemail.smtpDomain::
 sendemail.smtpServer::
 sendemail.smtpServerPort::
 sendemail.smtpServerOption::
 sendemail.smtpUser::
 sendemail.thread::
 sendemail.transferEncoding::
 sendemail.validate::
 sendemail.xmailer::
 	These configuration variables all provide a default for
 	linkgit:git-send-email[1] command-line options. See its
 	documentation for details.
 
-sendemail.signedoffcc (deprecated)::
-	Deprecated alias for `sendemail.signedoffbycc`.
+sendemail.signedOffCc (deprecated)::
+	Deprecated alias for `sendemail.signedOffByCc`.
 
 sendemail.smtpBatchSize::
 	Number of messages to be sent per connection, after that a relogin
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index d1ef6a204e68..31acfa186457 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -138,7 +138,7 @@ Note that no attempts whatsoever are made to validate the encoding.
 
 --compose-encoding=<encoding>::
 	Specify encoding of compose message. Default is the value of the
-	'sendemail.composeencoding'; if that is unspecified, UTF-8 is assumed.
+	'sendemail.composeEncoding'; if that is unspecified, UTF-8 is assumed.
 
 --transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)::
 	Specify the transfer encoding to be used to send the message over SMTP.
@@ -174,7 +174,7 @@ Sending
 	Specify a command to run to send the email. The command should
 	be sendmail-like; specifically, it must support the `-i` option.
 	The command will be executed in the shell if necessary.  Default
-	is the value of `sendemail.sendmailcmd`.  If unspecified, and if
+	is the value of `sendemail.sendmailCmd`.  If unspecified, and if
 	--smtp-server is also unspecified, git-send-email will search
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and $PATH.
 
@@ -269,7 +269,7 @@ must be used for each option.
 	certificates concatenated together: see verify(1) -CAfile and
 	-CApath for more information on these). Set it to an empty string
 	to disable certificate verification. Defaults to the value of the
-	`sendemail.smtpsslcertpath` configuration variable, if set, or the
+	`sendemail.smtpSslCertPath` configuration variable, if set, or the
 	backing SSL library's compiled-in default otherwise (which should
 	be the best choice on most platforms).
 
@@ -313,7 +313,7 @@ Automating
 	Specify a command to execute once per patch file which
 	should generate patch file specific "To:" entries.
 	Output of this command must be single email address per line.
-	Default is the value of 'sendemail.tocmd' configuration value.
+	Default is the value of 'sendemail.toCmd' configuration value.
 
 --cc-cmd=<command>::
 	Specify a command to execute once per patch file which
@@ -348,19 +348,19 @@ Automating
 
 --[no-]signed-off-by-cc::
 	If this is set, add emails found in the `Signed-off-by` trailer or Cc: lines to the
-	cc list. Default is the value of `sendemail.signedoffbycc` configuration
+	cc list. Default is the value of `sendemail.signedOffByCc` configuration
 	value; if that is unspecified, default to --signed-off-by-cc.
 
 --[no-]cc-cover::
 	If this is set, emails found in Cc: headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
-	for each email set. Default is the value of 'sendemail.cccover'
+	for each email set. Default is the value of 'sendemail.ccCover'
 	configuration value; if that is unspecified, default to --no-cc-cover.
 
 --[no-]to-cover::
 	If this is set, emails found in To: headers in the first patch of
 	the series (typically the cover letter) are added to the to list
-	for each email set. Default is the value of 'sendemail.tocover'
+	for each email set. Default is the value of 'sendemail.toCover'
 	configuration value; if that is unspecified, default to --no-to-cover.
 
 --suppress-cc=<category>::
@@ -384,7 +384,7 @@ Automating
 - 'all' will suppress all auto cc values.
 --
 +
-Default is the value of `sendemail.suppresscc` configuration value; if
+Default is the value of `sendemail.suppressCc` configuration value; if
 that is unspecified, default to 'self' if --suppress-from is
 specified, as well as 'body' if --no-signed-off-cc is specified.
 
@@ -471,7 +471,7 @@ Information
 	Instead of the normal operation, dump the shorthand alias names from
 	the configured alias file(s), one per line in alphabetical order. Note
 	that this only includes the alias name and not its expanded email addresses.
-	See 'sendemail.aliasesfile' for more information about aliases.
+	See 'sendemail.aliasesFile' for more information about aliases.
 
 
 CONFIGURATION
