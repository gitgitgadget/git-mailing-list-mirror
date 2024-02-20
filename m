Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12601152DFC
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708466491; cv=none; b=s+fKsE5Cw43vQWqodS8bAyzDXUnSIQNucLRs93KHuld37orpcBYi/xk5W1lhGMhnW17QT5eFua6+iNrk0aVfgR4kx0zhcBI8XErjZXAXMti0TNTyTe+zfWNzzDiBKi2sQoy35QHjjQk4bNEJO6jYaA7KEZ0dE1JEBwlG+Z0PgYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708466491; c=relaxed/simple;
	bh=0UMLGZfAHykCuwKkzl9F1d+M9FsP8Z47yxODyb0Jx2U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n7NZDv5/wina288EmPDNa7ok2wbHjVrq60YYGRGLahyDyUq/2W0PtEAFsrhF8QrqBMsahiI1i61xDXzNs7RFo+hwhqWmYFbuUQuZnG6uHyPFyFxThmBY1q4VFpLULtX04apRap51KogOY5tsj2oZp4FhDO9FwCk0O5SC9hzaN64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=GAlQpyqH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="GAlQpyqH"
From: Dragan Simic <dsimic@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708466486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NwtSCscGWvc06f6I7pV8aArRvVqz68AJBvWPD+ytqAM=;
	b=GAlQpyqHY0TEAd38F4N6Yt+1NIlYr/qEyIA6IlAo7ttgs5mmw0NzKLdNOlFBHLbAd+0QEg
	cbOtwkJ2BtsIgcE822mfENHuCTJMriqc24Xe8yZRAUpBjvdkCXNGCrHKcBK6xGRdjIQJPH
	MPpb8xy87KvuYJF+wUv7BbnHQOE9u6R/LJxZzoFih1GZXAMaA9r1050IzPMeSFVqf7cSIw
	xLCwGY28AYO/8VRuRPyhm+LQXRLbzmhP7JUxlRKAh6i+NOD8Z/d48SX5IygfO/oqKrqf/6
	o3IYh9/ioBrPm7GecoMa4LjfCPYkPL3aosh6EPrCfbFwcLBo6i3FCGC5KFZ9Lg==
To: git@vger.kernel.org
Cc: gitster@pobox.com
Subject: [PATCH v3] documentation: send-email: use camel case consistently
Date: Tue, 20 Feb 2024 23:01:21 +0100
Message-Id: <877b5bec11caa8a328ee0d4f226fe0666fd35a10.1708466383.git.dsimic@manjaro.org>
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
documentation that, for some unknown reason and contrary to the expected,
didn't use camel case format.

The majority of the corrections are straightforward, by using camel case
to denote boundaries of the individual words that, stringed together, make
up configuration parameter names.  A couple of abbreviations found in some
of the corrected configuration parameter names present some exceptions,
which are described in detail below.

First, there's "SSL" as the abbreviation for "Secure Sockets Layer". [1]
As such, it's written using all uppercase letters, which is pretty much the
general rule for making abbreviations, with some exceptions.  For example,
one rather well-known exception to this general rule is "SoC", which is the
abbreviation for "system-on-chip". [2]

Second, there's "Cc" as the abbreviation for "carbon copy", which is another
exception.  As the acronym for "carbon copy", "cc" (mind the all lowercase
letters) stems from the rather old times when, literally, carbon copies were
made. [3]  Therefore, using "CC" (mind the all uppercase letters) or "cc"
(mind the all lowercase letters) would be technically correct in the email
domain, as the abbreviation or as mentioned in RFC2076, [4] respectively, but
the age of email has established "Cc" (mind the mixed uppercase and lowercase
letters) as some kind of de facto standard. [1][5][6]  Moreover, some of the
git utilities, primarily git-send-email(1), already refer to making email
carbon copies as specifying "Cc:" email headers.  As a result, "Cc" becomes
one of the exceptions to the general rule for making abbreviations.

[1] https://en.wikipedia.org/wiki/Transport_Layer_Security
[2] https://en.wikipedia.org/wiki/System_on_a_chip
[3] https://en.wikipedia.org/wiki/Carbon_copy
[4] https://datatracker.ietf.org/doc/html/rfc2076
[5] https://bugzilla.mozilla.org/show_bug.cgi?id=212059
[6] https://bugzilla.mozilla.org/show_bug.cgi?id=50826

Signed-off-by: Dragan Simic <dsimic@manjaro.org>
---

Notes:
    The version 3 includes further feedback from Junio, by adding a detailed
    rationale for using "Cc" instead of "CC", while also using "SSL", to the
    commit description.  No code changes were introduced.
    
    The version 2 includes feedback from Junio, by changing "Ssl" to "SSL"
    in a couple of places where "sendemail.smtpSSLCertPath" is mentioned.
    There are already instances of "SSL" being used, for example in various
    "http.proxySSL*" configuration parameter names.

 Documentation/config/sendemail.txt | 12 ++++++------
 Documentation/git-send-email.txt   | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/sendemail.txt b/Documentation/config/sendemail.txt
index 7fc770ee9e69..6a869d67eb90 100644
--- a/Documentation/config/sendemail.txt
+++ b/Documentation/config/sendemail.txt
@@ -8,7 +8,7 @@ sendemail.smtpEncryption::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the 'identity' mechanism.
 
-sendemail.smtpsslcertpath::
+sendemail.smtpSSLCertPath::
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
index d1ef6a204e68..8264f8738093 100644
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
+	`sendemail.smtpSSLCertPath` configuration variable, if set, or the
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
