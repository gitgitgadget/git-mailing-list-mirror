Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8768D2FD69D
	for <git@vger.kernel.org>; Sun, 19 Jul 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784490888; cv=none; b=oHT0hBAA6c+5xPVtiGUPe9VK+TL5CG10fK4ayqO6cB9cQuPUrpanAYAkO0XHjbM2mYlc6rW4Qb1TCWTnLWQ0ffo9RGaTBdb7uNkkCNtw737CE3rxxTgVq1ffXyj3AszT8qS8tPwQ2GpZXHqmrmzV6eNiWQvAw0VRL0YNk7V4c/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784490888; c=relaxed/simple;
	bh=hma9J5htwZiXcV+YYYRrmqRe+u/jbUmnDrcADlvTIfE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=YBKrtneFsrlzx+uTyrs4X4TwzantAHMXS8qDC8rwz0eaSPomF8ewj8aTh98u9ClP0d/qZzXBAMNrE950uG/j5ghnD0Rm2IG0Oa0iI1wc7OBfdiKqM0Wh7JUmcRexsa+ucxAB5zEHK1zpRAX7eBASQB3aqWsu0W0qhQ5DROs3Tdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7gzCCVv; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7gzCCVv"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92e5c92c389so593549885a.3
        for <git@vger.kernel.org>; Sun, 19 Jul 2026 12:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784490884; x=1785095684; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=y85LpxFfXoY/RxYqUpHfy+0kwRMyAPpjv9JYQn783VQ=;
        b=G7gzCCVvEAEHFrOII6ZohIZAsKtMtVnM9UovPmU4xsh6AyTloTB7CIkGqs4vnne2QC
         yB6WaUK+R5oa5va3H0Agz83IDxXhCWlk/xbkIgIi85nywWtRk0kwZj52BMz49rwBSUXm
         kvbQmUTF/NlbIDCA78bV/KO9o522XBalCbFbrZ231PHpc/h4KKsYX007IuqYlQRaRcCC
         /aStU3rS9F3IEqqhu3rI7WmhEoZYy7iHJri31kpaDCRN2NVRshmu2L6j93ZrxZ1vlux6
         dqx3gZ3BQkLxF5tuIQthIZ4ByOxYPd3z2sEUVm8dM0pQhxnP+ZOtSC3I0bifK2f66pqn
         nIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784490884; x=1785095684;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y85LpxFfXoY/RxYqUpHfy+0kwRMyAPpjv9JYQn783VQ=;
        b=G51ITDJ1/4Sbsy6R7/DK7J8QZrfn7IZ7tIK9bQ64f6x60ELGer7ytmNV3C/fQEALYb
         bcTL0aPGxDn8V1uQM2hQl07q4nb209dQNc37tXCtJLK3oap6crVKLNdK8cAi+uTpOO9C
         tKH65BsGmnOpz+Jxa7sI6pjG2vpQ5+wHgqrJl1WFzAXawhTrYCFlzjFVhBXN1LwCXzMe
         KuNPRPN4d54qCo/Wift123SxqCclAurdZ9bn2PtbLxS20JcBN9yRh2Pt3O+vtPANFa8v
         U6ZZrdctV3KtUdagkXZOrRnR7ciC7zqTKFQXBzpAQQAPYvddYn1QvrjGMrNaM0RfRgNK
         A3AA==
X-Gm-Message-State: AOJu0Yzuxt4fWA4fVB6yQtiFhNEnDoAHq9Zb6NsMGObXd+TFGIS2C50N
	U16jR6gwz4lMJjJNmq/dot3bwpjCv7XI3octuVi2PZzXmUwJbFjJP9eX0YAWMQ==
X-Gm-Gg: AfdE7cnyJ7J7aDwZy5DTv0VlDIanmK1gAVmlkBnvg7r8vM5xzJgk1rCrsB630LmbyvP
	no2UVz88xW7HJQb77j1JwfEbV2jmGPyJijNcnsevBcjB8KGenyK5LfGyNAwKjF/M0NdSJzMldZ9
	DKKudg1LxcnKjoEnKjDKV38lxqM4qFxU7BM+Tay0k8fNkamOJg7XKGJhrW+pt+aK9X6hFiX47kJ
	XeIrmh4So5BVRNN1EddmtAMfiGzQqdfOBWzSwIa70DRyiF5TMw2CkaxeuuSpyVRO1rYyjyWA9tD
	uHf3Lq1g3Iood/9XoTUCfKrkVLXpAlBnlVe42Njyw1MbtlthhdHU3iOwGh5YVuvEiThFysiRzlC
	9IohuC1llw2foK4oRbbNHEV61lLHLvWUPTWD35OoMQJLfrFX7c6nc3es4blKIwsYijtgbWUwu+l
	aKTBE=
X-Received: by 2002:a05:620a:bc7:b0:92e:c117:5ed7 with SMTP id af79cd13be357-930b43512e2mr1114956485a.87.1784490883882;
        Sun, 19 Jul 2026 12:54:43 -0700 (PDT)
Received: from [127.0.0.1] ([52.188.87.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b54773fbsm707112485a.39.2026.07.19.12.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 12:54:43 -0700 (PDT)
Message-Id: <723450c5a0dbbb46ad8ec7cacc59262f6ad760fa.1784490878.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
References: <pull.2185.git.1784490878.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 19 Jul 2026 19:54:36 +0000
Subject: [PATCH 3/4] doc: convert git-send-email synopsis and options to new
 style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Replace [verse] with [synopsis] in the SYNOPSIS block and remove
single-quote formatting from the command name.

Backtick-quote all option terms in the OPTIONS section, convert
the standalone placeholder _<encoding>_ in prose, fix single-quoted
server names to backtick form, and convert mbox(5) to `mbox`(5).

Also update config/sendemail.adoc: backtick-quote all configuration
key terms and fix a bare sendemail.aliasesFile reference in prose.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/sendemail.adoc |  92 ++++++++--------
 Documentation/git-send-email.adoc   | 162 ++++++++++++++--------------
 2 files changed, 127 insertions(+), 127 deletions(-)

diff --git a/Documentation/config/sendemail.adoc b/Documentation/config/sendemail.adoc
index 1d700559b4..5499f91036 100644
--- a/Documentation/config/sendemail.adoc
+++ b/Documentation/config/sendemail.adoc
@@ -1,25 +1,25 @@
-sendemail.identity::
+`sendemail.identity`::
 	A configuration identity. When given, causes values in the
 	`sendemail.<identity>` subsection to take precedence over
 	values in the `sendemail` section. The default identity is
 	the value of `sendemail.identity`.
 
-sendemail.smtpEncryption::
+`sendemail.smtpEncryption`::
 	See linkgit:git-send-email[1] for description.  Note that this
 	setting is not subject to the `identity` mechanism.
 
-sendemail.smtpSSLCertPath::
+`sendemail.smtpSSLCertPath`::
 	Path to ca-certificates (either a directory or a single file).
 	Set it to an empty string to disable certificate verification.
 
-sendemail.smtpSSLClientCert::
+`sendemail.smtpSSLClientCert`::
 	Path to the client certificate file to present if requested by the
 	server. This is required when the server is set up to verify client
 	certificates. If the corresponding private key is not included in the
 	file, it must be supplied using `sendemail.smtpSSLClientKey` or the
 	`--smtp-ssl-client-key` option.
 
-sendemail.smtpSSLClientKey::
+`sendemail.smtpSSLClientKey`::
 	Path to the client private key file that corresponds to the client
 	certificate. To avoid misconfiguration, this configuration must be used
 	in conjunction with `sendemail.smtpSSLClientCert` or the
@@ -28,45 +28,45 @@ sendemail.smtpSSLClientKey::
 	the certificate. Visit https://metacpan.org/pod/IO::Socket::SSL for more
 	details.
 
-sendemail.<identity>.*::
-	Identity-specific versions of the `sendemail.*` parameters
+`sendemail.<identity>.<config>`::
+	Identity-specific versions of the `sendemail.<config>` parameters
 	found below, taking precedence over those when this
 	identity is selected, through either the command-line or
 	`sendemail.identity`.
 
-sendemail.multiEdit::
+`sendemail.multiEdit`::
 	If `true` (default), a single editor instance will be spawned to edit
 	files you have to edit (patches when `--annotate` is used, and the
 	summary when `--compose` is used). If `false`, files will be edited one
 	after the other, spawning a new editor each time.
 
-sendemail.confirm::
+`sendemail.confirm`::
 	Sets the default for whether to confirm before sending. Must be
 	one of `always`, `never`, `cc`, `compose`, or `auto`. See `--confirm`
 	in the linkgit:git-send-email[1] documentation for the meaning of these
 	values.
 
-sendemail.mailmap::
+`sendemail.mailmap`::
 	If `true`, makes linkgit:git-send-email[1] assume `--mailmap`,
 	otherwise assume `--no-mailmap`. `False` by default.
 
-sendemail.mailmap.file::
+`sendemail.mailmap.file`::
 	The location of a linkgit:git-send-email[1] specific augmenting
 	mailmap file. The default mailmap and `mailmap.file` are loaded
 	first. Thus, entries in this file take precedence over entries in
 	the default mailmap locations. See linkgit:gitmailmap[5].
 
-sendemail.mailmap.blob::
+`sendemail.mailmap.blob`::
 	Like `sendemail.mailmap.file`, but consider the value as a reference
 	to a blob in the repository. Entries in `sendemail.mailmap.file`
 	take precedence over entries here. See linkgit:gitmailmap[5].
 
-sendemail.aliasesFile::
+`sendemail.aliasesFile`::
 	To avoid typing long email addresses, point this to one or more
 	email aliases files.  You must also supply `sendemail.aliasFileType`.
 
-sendemail.aliasFileType::
-	Format of the file(s) specified in sendemail.aliasesFile. Must be
+`sendemail.aliasFileType`::
+	Format of the file(s) specified in `sendemail.aliasesFile`. Must be
 	one of `mutt`, `mailrc`, `pine`, `elm`, `gnus`, or `sendmail`.
 +
 What an alias file in each format looks like can be found in
@@ -75,7 +75,7 @@ differences and limitations from the standard formats are
 described below:
 +
 --
-sendmail;;
+`sendmail`;;
 *	Quoted aliases and quoted addresses are not supported: lines that
 	contain a `"` symbol are ignored.
 *	Redirection to a file (`/path/name`) or pipe (`|command`) is not
@@ -85,54 +85,54 @@ sendmail;;
 	explicitly unsupported constructs, and any other lines that are not
 	recognized by the parser.
 --
-sendemail.annotate::
-sendemail.bcc::
-sendemail.cc::
-sendemail.ccCmd::
-sendemail.chainReplyTo::
-sendemail.envelopeSender::
-sendemail.from::
-sendemail.headerCmd::
-sendemail.signedOffByCc::
-sendemail.smtpPass::
-sendemail.suppressCc::
-sendemail.suppressFrom::
-sendemail.to::
-sendemail.toCmd::
-sendemail.smtpDomain::
-sendemail.smtpServer::
-sendemail.smtpServerPort::
-sendemail.smtpServerOption::
-sendemail.smtpUser::
-sendemail.imapSentFolder::
-sendemail.useImapOnly::
-sendemail.thread::
-sendemail.transferEncoding::
-sendemail.validate::
-sendemail.xmailer::
+`sendemail.annotate`::
+`sendemail.bcc`::
+`sendemail.cc`::
+`sendemail.ccCmd`::
+`sendemail.chainReplyTo`::
+`sendemail.envelopeSender`::
+`sendemail.from`::
+`sendemail.headerCmd`::
+`sendemail.signedOffByCc`::
+`sendemail.smtpPass`::
+`sendemail.suppressCc`::
+`sendemail.suppressFrom`::
+`sendemail.to`::
+`sendemail.toCmd`::
+`sendemail.smtpDomain`::
+`sendemail.smtpServer`::
+`sendemail.smtpServerPort`::
+`sendemail.smtpServerOption`::
+`sendemail.smtpUser`::
+`sendemail.imapSentFolder`::
+`sendemail.useImapOnly`::
+`sendemail.thread`::
+`sendemail.transferEncoding`::
+`sendemail.validate`::
+`sendemail.xmailer`::
 	These configuration variables all provide a default for
 	linkgit:git-send-email[1] command-line options. See its
 	documentation for details.
 
-sendemail.outlookidfix::
+`sendemail.outlookidfix`::
 	If `true`, makes linkgit:git-send-email[1] assume `--outlook-id-fix`,
 	and if `false` assume `--no-outlook-id-fix`. If not specified, it will
 	behave the same way as if `--outlook-id-fix` is not specified.
 
-sendemail.signedOffCc (deprecated)::
+`sendemail.signedOffCc` (deprecated)::
 	Deprecated alias for `sendemail.signedOffByCc`.
 
-sendemail.smtpBatchSize::
+`sendemail.smtpBatchSize`::
 	Number of messages to be sent per connection, after that a relogin
 	will happen.  If the value is `0` or undefined, send all messages in
 	one connection.
 	See also the `--batch-size` option of linkgit:git-send-email[1].
 
-sendemail.smtpReloginDelay::
+`sendemail.smtpReloginDelay`::
 	Seconds to wait before reconnecting to the smtp server.
 	See also the `--relogin-delay` option of linkgit:git-send-email[1].
 
-sendemail.forbidSendmailVariables::
+`sendemail.forbidSendmailVariables`::
 	To avoid common misconfiguration mistakes, linkgit:git-send-email[1]
 	will abort with a warning if any configuration options for `sendmail`
 	exist. Set this variable to bypass the check.
diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
index dea3b86460..5c9ab39944 100644
--- a/Documentation/git-send-email.adoc
+++ b/Documentation/git-send-email.adoc
@@ -8,11 +8,11 @@ git-send-email - Send a collection of patches as emails
 
 SYNOPSIS
 --------
-[verse]
-'git send-email' [<options>] (<file>|<directory>)...
-'git send-email' [<options>] <format-patch-options>
-'git send-email' --dump-aliases
-'git send-email' --translate-aliases
+[synopsis]
+git send-email [<options>] (<file>|<directory>)...
+git send-email [<options>] <format-patch-options>
+git send-email --dump-aliases
+git send-email --translate-aliases
 
 
 DESCRIPTION
@@ -48,24 +48,24 @@ OPTIONS
 Composing
 ~~~~~~~~~
 
---annotate::
+`--annotate`::
 	Review and edit each patch you're about to send. Default is the value
 	of `sendemail.annotate`. See the CONFIGURATION section for
 	`sendemail.multiEdit`.
 
---bcc=<address>,...::
+`--bcc=<address>,...`::
 	Specify a `Bcc:` value for each email. Default is the value of
 	`sendemail.bcc`.
 +
 This option may be specified multiple times.
 
---cc=<address>,...::
+`--cc=<address>,...`::
 	Specify a starting `Cc:` value for each email.
 	Default is the value of `sendemail.cc`.
 +
 This option may be specified multiple times.
 
---compose::
+`--compose`::
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
@@ -80,7 +80,7 @@ Missing `From` or `In-Reply-To` headers will be prompted for.
 +
 See the CONFIGURATION section for `sendemail.multiEdit`.
 
---from=<address>::
+`--from=<address>`::
 	Specify the sender of the emails.  If not specified on the command line,
 	the value of the `sendemail.from` configuration option is used.  If
 	neither the command-line option nor `sendemail.from` are set, then the
@@ -88,12 +88,12 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	the value of `GIT_AUTHOR_IDENT`, or `GIT_COMMITTER_IDENT` if that is not
 	set, as returned by `git var -l`.
 
---reply-to=<address>::
+`--reply-to=<address>`::
 	Specify the address where replies from recipients should go to.
 	Use this if replies to messages should go to another address than what
 	is specified with the `--from` parameter.
 
---in-reply-to=<identifier>::
+`--in-reply-to=<identifier>`::
 	Make the first mail (or all the mails with `--no-thread`) appear as a
 	reply to the given Message-ID, which avoids breaking threads to
 	provide a new patch series.
@@ -115,8 +115,8 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
 Only necessary if `--compose` is also set.  If `--compose`
 is not set, this will be prompted for.
 
---outlook-id-fix::
---no-outlook-id-fix::
+`--outlook-id-fix`::
+`--no-outlook-id-fix`::
 	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
 	assign a new random Message-ID, thus breaking threads.
 +
@@ -126,15 +126,15 @@ threading. Use it only when you know that the server reports the
 rewritten Message-ID the same way as Outlook servers do.
 +
 Without this option specified, the fix is done by default when talking
-to 'smtp.office365.com' or 'smtp-mail.outlook.com'. Use
+to `smtp.office365.com` or `smtp-mail.outlook.com`. Use
 `--no-outlook-id-fix` to disable even when talking to these two servers.
 
---subject=<string>::
+`--subject=<string>`::
 	Specify the initial subject of the email thread.
 	Only necessary if `--compose` is also set.  If `--compose`
 	is not set, this will be prompted for.
 
---to=<address>,...::
+`--to=<address>,...`::
 	Specify the primary recipient of the emails generated. Generally, this
 	will be the upstream maintainer of the project involved. Default is the
 	value of the `sendemail.to` configuration value; if that is unspecified,
@@ -142,20 +142,20 @@ to 'smtp.office365.com' or 'smtp-mail.outlook.com'. Use
 +
 This option may be specified multiple times.
 
---8bit-encoding=<encoding>::
+`--8bit-encoding=<encoding>`::
 	When encountering a non-ASCII message or subject that does not
 	declare its encoding, add headers/quoting to indicate it is
-	encoded in <encoding>.  Default is the value of the
+	encoded in _<encoding>_.  Default is the value of the
 	`sendemail.assume8bitEncoding`; if that is unspecified, this
 	will be prompted for if any non-ASCII files are encountered.
 +
 Note that no attempts whatsoever are made to validate the encoding.
 
---compose-encoding=<encoding>::
+`--compose-encoding=<encoding>`::
 	Specify encoding of compose message. Default is the value of the
 	`sendemail.composeEncoding`; if that is unspecified, UTF-8 is assumed.
 
---transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)::
+`--transfer-encoding=(7bit|8bit|quoted-printable|base64|auto)`::
 	Specify the transfer encoding to be used to send the message over SMTP.
 	`7bit` will fail upon encountering a non-ASCII message. `quoted-printable`
 	can be useful when the repository contains files that contain carriage
@@ -167,8 +167,8 @@ Note that no attempts whatsoever are made to validate the encoding.
 Default is the value of the `sendemail.transferEncoding` configuration
 value; if that is unspecified, default to `auto`.
 
---xmailer::
---no-xmailer::
+`--xmailer`::
+`--no-xmailer`::
 	Add (or prevent adding) the `X-Mailer:` header.  By default,
 	the header is added, but it can be turned off by setting the
 	`sendemail.xmailer` configuration variable to `false`.
@@ -176,7 +176,7 @@ value; if that is unspecified, default to `auto`.
 Sending
 ~~~~~~~
 
---envelope-sender=<address>::
+`--envelope-sender=<address>`::
 	Specify the envelope sender used to send the emails.
 	This is useful if your default address is not the address that is
 	subscribed to a list. In order to use the `From` address, set the
@@ -185,7 +185,7 @@ Sending
 	`sendemail.envelopeSender` configuration variable; if that is
 	unspecified, choosing the envelope sender is left to your MTA.
 
---sendmail-cmd=<command>::
+`--sendmail-cmd=<command>`::
 	Specify a command to run to send the email. The command should
 	be sendmail-like; specifically, it must support the `-i` option.
 	The command will be executed in the shell if necessary.  Default
@@ -193,7 +193,7 @@ Sending
 	`--smtp-server` is also unspecified, `git send-email` will search
 	for `sendmail` in `/usr/sbin`, `/usr/lib` and `$PATH`.
 
---smtp-encryption=<encryption>::
+`--smtp-encryption=<encryption>`::
 	Specify in what way encrypting begins for the SMTP connection.
 	Valid values are `ssl` and `tls`. Any other value reverts to plain
 	(unencrypted) SMTP, which defaults to port 25.
@@ -207,14 +207,14 @@ Sending
 	documentation or your server configuration to make sure
 	for your own case. Default is the value of `sendemail.smtpEncryption`.
 
---smtp-domain=<FQDN>::
+`--smtp-domain=<FQDN>`::
 	Specify the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
 	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
 	`sendemail.smtpDomain`.
 
---smtp-auth=<mechanisms>::
+`--smtp-auth=<mechanisms>`::
 	Whitespace-separated list of allowed SMTP-AUTH mechanisms. This setting
 	forces using only the listed mechanisms. Example:
 +
@@ -229,7 +229,7 @@ is specified, all mechanisms supported by the SASL library can be used. The
 special value `none` maybe specified to completely disable authentication
 independently of `--smtp-user`.
 
---smtp-pass[=<password>]::
+`--smtp-pass[=<password>]`::
 	Password for SMTP-AUTH. The argument is optional: If no
 	argument is specified, then the empty string is used as
 	the password. Default is the value of `sendemail.smtpPass`,
@@ -241,10 +241,10 @@ or on the command line. If a username has been specified (with
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
 a password is obtained using linkgit:git-credential[1].
 
---no-smtp-auth::
+`--no-smtp-auth`::
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`.
 
---smtp-server=<host>::
+`--smtp-server=<host>`::
 	Specify the outgoing SMTP server to use (e.g.
 	`smtp.example.com` or a raw IP address).  If unspecified, and if
 	`--sendmail-cmd` is also unspecified, the default is to search
@@ -257,7 +257,7 @@ option.  This method does not support passing arguments or using plain
 command names.  For those use cases, consider using `--sendmail-cmd`
 instead.
 
---smtp-server-port=<port>::
+`--smtp-server-port=<port>`::
 	Specify a port different from the default port (SMTP
 	servers typically listen to smtp port 25, but may also listen to
 	submission port 587, or the common SSL smtp port 465);
@@ -265,7 +265,7 @@ instead.
 	are also accepted. The port can also be set with the
 	`sendemail.smtpServerPort` configuration variable.
 
---smtp-server-option=<option>::
+`--smtp-server-option=<option>`::
 	Specify the outgoing SMTP server option to use.
 	Default value can be specified by the `sendemail.smtpServerOption`
 	configuration option.
@@ -274,15 +274,15 @@ The `--smtp-server-option` option must be repeated for each option you want
 to pass to the server. Likewise, different lines in the configuration files
 must be used for each option.
 
---smtp-ssl::
+`--smtp-ssl`::
 	Legacy alias for `--smtp-encryption ssl`.
 
---smtp-ssl-cert-path <path>::
+`--smtp-ssl-cert-path <path>`::
 	Path to a store of trusted CA certificates for SMTP SSL/TLS
 	certificate validation (either a directory that has been processed
 	by `c_rehash`, or a single file containing one or more PEM format
 	certificates concatenated together: see the description of the
-	`-CAfile` _<file>_ and the `-CApath` _<dir>_ options of
+	`-CAfile <file>` and the `-CApath <dir>` options of
 	https://docs.openssl.org/master/man1/openssl-verify/
 	[OpenSSL's verify(1) manual page] for more information on these).
 	Set it to an empty string to disable certificate verification.
@@ -290,7 +290,7 @@ must be used for each option.
 	variable, if set, or the backing SSL library's compiled-in default
 	otherwise (which should be the best choice on most platforms).
 
---smtp-ssl-client-cert <path>::
+`--smtp-ssl-client-cert <path>`::
 	Path to the client certificate file to present if requested by the
 	server. This option is required when the server is set up to verify
 	client certificates. If the corresponding private key is not included in
@@ -299,7 +299,7 @@ must be used for each option.
 	to the value of the `sendemail.smtpSSLClientCert` configuration
 	variable, if set.
 
---smtp-ssl-client-key <path>::
+`--smtp-ssl-client-key <path>`::
 	Path to the client private key file that corresponds to the client
 	certificate. To avoid misconfiguration, this option must be used in
 	conjunction with the `sendemail.smtpSSLClientKey` configuration variable
@@ -309,17 +309,17 @@ must be used for each option.
 	more details. Defaults to the value of the `sendemail.smtpSSLClientKey`
 	configuration variable, if set.
 
---smtp-user=<user>::
+`--smtp-user=<user>`::
 	Username for SMTP-AUTH. Default is the value of `sendemail.smtpUser`;
 	if a username is not specified (with `--smtp-user` or `sendemail.smtpUser`),
 	then authentication is not attempted.
 
---smtp-debug=(0|1)::
+`--smtp-debug=(0|1)`::
 	Enable (1) or disable (0) debug output. If enabled, SMTP
 	commands and replies will be printed. Useful to debug TLS
 	connection and authentication problems.
 
---imap-sent-folder=<folder>::
+`--imap-sent-folder=<folder>`::
 	Some email providers (e.g. iCloud) do not send a copy of the emails sent
 	using SMTP to the `Sent` folder or similar in your mailbox. Use this option
 	to use `git imap-send` to send a copy of the emails to the folder specified
@@ -331,8 +331,8 @@ must be used for each option.
 This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
 for instructions.
 
---use-imap-only::
---no-use-imap-only::
+`--use-imap-only`::
+`--no-use-imap-only`::
 	If this is set, all emails will only be copied to the IMAP folder specified
 	with `--imap-sent-folder` or `sendemail.imapSentFolder` and will not be sent
 	to the recipients. Useful if you just want to create a draft of the emails
@@ -344,8 +344,8 @@ for instructions.
 This feature requires setting up `git imap-send`. See linkgit:git-imap-send[1]
 for instructions.
 
---batch-size=<num>::
-	Some email servers (e.g. 'smtp.163.com') limit the number of emails to be
+`--batch-size=<num>`::
+	Some email servers (e.g. `smtp.163.com`) limit the number of emails to be
 	sent per session (connection) and this will lead to a failure when
 	sending many messages.  With this option, send-email will disconnect after
 	sending _<num>_ messages and wait for a few seconds
@@ -354,7 +354,7 @@ for instructions.
 	retype your password every time this happens.  Defaults to the
 	`sendemail.smtpBatchSize` configuration variable.
 
---relogin-delay=<int>::
+`--relogin-delay=<int>`::
 	Waiting _<int>_ seconds before reconnecting to SMTP server. Used together
 	with `--batch-size` option.  Defaults to the `sendemail.smtpReloginDelay`
 	configuration variable.
@@ -362,29 +362,29 @@ for instructions.
 Automating
 ~~~~~~~~~~
 
---no-to::
---no-cc::
---no-bcc::
+`--no-to`::
+`--no-cc`::
+`--no-bcc`::
 	Clear any list of `To:`, `Cc:`, `Bcc:` addresses previously
 	set via config.
 
---no-identity::
+`--no-identity`::
 	Clear the previously read value of `sendemail.identity` set
 	via config, if any.
 
---to-cmd=<command>::
+`--to-cmd=<command>`::
 	Specify a command to execute once per patch file which
 	should generate patch file specific `To:` entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.toCmd` configuration value.
 
---cc-cmd=<command>::
+`--cc-cmd=<command>`::
 	Specify a command to execute once per patch file which
 	should generate patch file specific `Cc:` entries.
 	Output of this command must be single email address per line.
 	Default is the value of `sendemail.ccCmd` configuration value.
 
---header-cmd=<command>::
+`--header-cmd=<command>`::
 	Specify a command that is executed once per outgoing message
 	and output RFC 2822 style header lines to be inserted into
 	them. When the `sendemail.headerCmd` configuration variable is
@@ -392,11 +392,11 @@ Automating
 	at the command line, its value takes precedence over the
 	`sendemail.headerCmd` configuration variable.
 
---no-header-cmd::
+`--no-header-cmd`::
 	Disable any header command in use.
 
---chain-reply-to::
---no-chain-reply-to::
+`--chain-reply-to`::
+`--no-chain-reply-to`::
 	If this is set, each email will be sent as a reply to the previous
 	email sent.  If disabled with `--no-chain-reply-to`, all emails after
 	the first will be sent as replies to the first email sent.  When using
@@ -404,34 +404,34 @@ Automating
 	entire patch series. Disabled by default, but the `sendemail.chainReplyTo`
 	configuration variable can be used to enable it.
 
---identity=<identity>::
+`--identity=<identity>`::
 	A configuration identity. When given, causes values in the
 	`sendemail.<identity>` subsection to take precedence over
 	values in the `sendemail` section. The default identity is
 	the value of `sendemail.identity`.
 
---signed-off-by-cc::
---no-signed-off-by-cc::
+`--signed-off-by-cc`::
+`--no-signed-off-by-cc`::
 	If this is set, add emails found in the `Signed-off-by` trailer or `Cc:`
 	lines to the cc list. Default is the value of `sendemail.signedOffByCc`
 	configuration value; if that is unspecified, default to
 	`--signed-off-by-cc`.
 
---cc-cover::
---no-cc-cover::
+`--cc-cover`::
+`--no-cc-cover`::
 	If this is set, emails found in `Cc:` headers in the first patch of
 	the series (typically the cover letter) are added to the cc list
 	for each email set. Default is the value of `sendemail.ccCover`
 	configuration value; if that is unspecified, default to `--no-cc-cover`.
 
---to-cover::
---no-to-cover::
+`--to-cover`::
+`--no-to-cover`::
 	If this is set, emails found in `To:` headers in the first patch of
 	the series (typically the cover letter) are added to the to list
 	for each email set. Default is the value of `sendemail.toCover`
 	configuration value; if that is unspecified, default to `--no-to-cover`.
 
---suppress-cc=<category>::
+`--suppress-cc=<category>`::
 	Specify an additional category of recipients to suppress the
 	auto-cc of:
 +
@@ -456,14 +456,14 @@ Default is the value of `sendemail.suppressCc` configuration value; if
 that is unspecified, default to `self` if `--suppress-from` is
 specified, as well as `body` if `--no-signed-off-by-cc` is specified.
 
---suppress-from::
---no-suppress-from::
+`--suppress-from`::
+`--no-suppress-from`::
 	If this is set, do not add the `From:` address to the `Cc:` list.
 	Default is the value of `sendemail.suppressFrom` configuration
 	value; if that is unspecified, default to `--no-suppress-from`.
 
---thread::
---no-thread::
+`--thread`::
+`--no-thread`::
 	If this is set, the `In-Reply-To` and `References` headers will be
 	added to each email sent.  Whether each mail refers to the
 	previous email (`deep` threading per `git format-patch`
@@ -481,8 +481,8 @@ exists when `git send-email` is asked to add it (especially note that
 Failure to do so may not produce the expected result in the
 recipient's MUA.
 
---mailmap::
---no-mailmap::
+`--mailmap`::
+`--no-mailmap`::
 	Use the mailmap file (see linkgit:gitmailmap[5]) to map all
 	addresses to their canonical real name and email address. Additional
 	mailmap data specific to `git send-email` may be provided using the
@@ -492,7 +492,7 @@ recipient's MUA.
 Administering
 ~~~~~~~~~~~~~
 
---confirm=<mode>::
+`--confirm=<mode>`::
 	Confirm just before sending:
 +
 --
@@ -508,22 +508,22 @@ Default is the value of `sendemail.confirm` configuration value; if that
 is unspecified, default to `auto` unless any of the suppress options
 have been specified, in which case default to `compose`.
 
---dry-run::
+`--dry-run`::
 	Do everything except actually send the emails.
 
---format-patch::
---no-format-patch::
+`--format-patch`::
+`--no-format-patch`::
 	When an argument may be understood either as a reference or as a file name,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
 	occurs, `git send-email` will fail.
 
---quiet::
+`--quiet`::
 	Make `git send-email` less verbose.  One line per email should be
 	all that is output.
 
---validate::
---no-validate::
+`--validate`::
+`--no-validate`::
 	Perform sanity checks on patches.
 	Currently, validation means the following:
 +
@@ -539,20 +539,20 @@ have been specified, in which case default to `compose`.
 Default is the value of `sendemail.validate`; if this is not set,
 default to `--validate`.
 
---force::
+`--force`::
 	Send emails even if safety checks would prevent it.
 
 
 Information
 ~~~~~~~~~~~
 
---dump-aliases::
+`--dump-aliases`::
 	Instead of the normal operation, dump the shorthand alias names from
 	the configured alias file(s), one per line in alphabetical order. Note
 	that this only includes the alias name and not its expanded email addresses.
 	See `sendemail.aliasesFile` for more information about aliases.
 
---translate-aliases::
+`--translate-aliases`::
 	Instead of the normal operation, read from standard input and
 	interpret each line as an email alias. Translate it according to the
 	configured alias file(s). Output each translated name and email
@@ -718,7 +718,7 @@ include::format-patch-caveats.adoc[]
 
 SEE ALSO
 --------
-linkgit:git-format-patch[1], linkgit:git-imap-send[1], mbox(5)
+linkgit:git-format-patch[1], linkgit:git-imap-send[1], `mbox`(5)
 
 GIT
 ---
-- 
gitgitgadget

