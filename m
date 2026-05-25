Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B557351C1E
	for <git@vger.kernel.org>; Mon, 25 May 2026 10:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704921; cv=none; b=gt4eCHbCWIaM4jXlrUN0UxtAurHqWogtK9iYYxaS6Z6zfnSHAlC80oMJ3KR7u8TyfjwaaZQu5TKrTdybQD3kznlv7bEmYAROXSQlKhl6e53pqgcAGXIip8xlMPmwBI8M0zklwx7sm7bV7tTRK/pgdW3hAYDlRqz+oNZayL/353I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704921; c=relaxed/simple;
	bh=fNqWmpPA4Acog1H0BvG2VAdsaxiVua2/DlTMWJh928s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=bOfJ3UlbAGRdtfsUOu+C4Fw7c3uR4D4FBr8eQHB15SkXPtvuaBod0SdVJsrAN/6rs8HMcply25IP+OJrSGolxwOiNIVJTNDjqeU43Ja0E8FocyNs3naOrZ9b0WeUbtBJrqqexnKGJzIsTYh/fWnyTlpmv+mZ76J+9X5bLPsLF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rEmn8uy6; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEmn8uy6"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516d65a15f6so31746341cf.1
        for <git@vger.kernel.org>; Mon, 25 May 2026 03:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704915; x=1780309715; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rrGOQ/a4CXudMvpeMrpSNuSC1VxO1PRc3WjkKtna3T0=;
        b=rEmn8uy6UA2Whe1/kHjdyi2N8iRz2jmR53LzGqfFlX1eXezm1ygNw+vfGBspiWBXbz
         HMjG9VfMKfyI18WCnKlONgNFlEn85wEWRtGyLnDOYdEEywe5txSDVe2loytXY/XUuliF
         VgTwHFuQFjUrtZl9dPqNPimEsl4V2HC3sT19BbwmYjaJ1Y4szyVzu5RFzeL3ClVZfR7t
         fuhNO7hlzka0pCoaQ6P4vtdk352tTKaPSbOetoQsElzJUq3ya3tZ5LgOkJh+L1Phd0+y
         9HZrCDVs7JOBmdUCrGGuBDFG0KYoRWDO49jSMSTWSozLKzzZcYZChuupay0uDvDrF1Py
         lxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704915; x=1780309715;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rrGOQ/a4CXudMvpeMrpSNuSC1VxO1PRc3WjkKtna3T0=;
        b=pwJz7sVCJZgRumKbX003xpAQY/NR6I86IGfRoJ8kvi5qDzDZ95XlCr3Y5+aGr5h+2p
         n31YBl5Wwc8FttQZHWKHEeLqqyzFfwa1u2ib1hWaWpR5KeWbFn4hxcf/tnQxHjmFjRLs
         rN8wcJ8EgmaDHxTGW5/RMqH8wMgyBC4T4P7LEAM+KMImLfq5JDszUj7gMDUucFUJamkg
         bXEQzWgCcxykd5Y53bXkl+p5ESygJVkMs90Pu/f3viUlldxPYaM7U6IL0HInQQmaWkQ1
         +W+w0YCDaOmwuv8b3IQlzHeLO3JAOqKAQku73zzEhO7st+ZXKK8aad+qdL9EeaD6JxI7
         O8FQ==
X-Gm-Message-State: AOJu0YxMTkwUNgGV59jRBM1SNQ4aKRfZBdAMvhEdNvODxl0t/YvE7bsw
	KZ2m00ZGO8e1XNeFNjKFJBnVwO2xqGqzL6rF5X6yNgCjcXWSj+klBzt+nfFEww==
X-Gm-Gg: Acq92OFnsAL37IrRzQgCmIqKpl3dOTckufIJkVlR/HZ2kk7Fs+ocwbhdfZ7lp6QbFkG
	5V8K8JhyPRPHW1yvbzvM9LuulrKY4XABQkPt5FPTcSeyFvBVG/kDOUXiBL/gyG/qw5pr1fRu7qO
	IeSYVCT2f7ONJvDUY4MMFNlCuIMLvyMqMa6tiC3pFUtKw9RewGHnxUl9kcHJnZX6xX/74zT3ZKX
	m6csyiNBlgCas/wQsPHg7CIBvV/Vo83BICc9mbXJxUsQkkurxFE+oRGcnioNrEmMiYGoKE08gAT
	uWL5IDjcr0K0EO3wLRubL2DkJP67nw9aKj10sJ/49IuJGTiQsYOSELH0c9uDjD+UhT8rb1D0Mxu
	snf4NTLedlwjMTt3rTk3i06+DVkei+IO6ju8YzVsWLz1I/1+/TmbcQGBvaRXXAts/FOnXSPwFsj
	7TM8oIXU6QRIGeeflMcyNvTjF30am0AzkuBXiP
X-Received: by 2002:a05:622a:1a8e:b0:50f:f030:920d with SMTP id d75a77b69052e-516c56114d3mr203184841cf.30.1779704914923;
        Mon, 25 May 2026 03:28:34 -0700 (PDT)
Received: from [127.0.0.1] ([130.131.15.84])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80ded51esm108685666d6.17.2026.05.25.03.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:28:34 -0700 (PDT)
Message-Id: <b9c2adfa1ddf9923a30dea726b51638e979c05b1.1779704908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
References: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
	<pull.2117.v2.git.1779704908.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 25 May 2026 10:28:25 +0000
Subject: [PATCH v2 4/6] doc: convert git-am synopsis and options to new style
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

Convert git-am from [verse]/single-quote style to the modern
synopsis-block style:

- Replace [verse] with [synopsis] in SYNOPSIS block
- Backtick-quote all OPTIONS terms
- Convert inline man page refs
- Convert inline command refs
- Convert prose placeholders:

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/am.adoc                  |   6 +-
 Documentation/format-patch-caveats.adoc       |   2 +-
 .../format-patch-end-of-commit-message.adoc   |   4 +-
 Documentation/git-am.adoc                     | 132 +++++++++---------
 4 files changed, 72 insertions(+), 72 deletions(-)

diff --git a/Documentation/config/am.adoc b/Documentation/config/am.adoc
index e9561e12d7..250e6b5047 100644
--- a/Documentation/config/am.adoc
+++ b/Documentation/config/am.adoc
@@ -1,11 +1,11 @@
-am.keepcr::
+`am.keepcr`::
 	If true, linkgit:git-am[1] will call linkgit:git-mailsplit[1]
 	for patches in mbox format with parameter `--keep-cr`. In this
 	case linkgit:git-mailsplit[1] will
 	not remove `\r` from lines ending with `\r\n`. Can be overridden
 	by giving `--no-keep-cr` from the command line.
 
-am.threeWay::
+`am.threeWay`::
 	By default, linkgit:git-am[1] will fail if the patch does not
 	apply cleanly. When set to true, this setting tells
 	linkgit:git-am[1] to fall back on 3-way merge if the patch
@@ -13,7 +13,7 @@ am.threeWay::
 	have those blobs available locally (equivalent to giving the
 	`--3way` option from the command line). Defaults to `false`.
 
-am.messageId::
+`am.messageId`::
 	Add a `Message-ID` trailer based on the email header to the
 	commit when using linkgit:git-am[1] (see
 	linkgit:git-interpret-trailers[1]). See also the `--message-id`
diff --git a/Documentation/format-patch-caveats.adoc b/Documentation/format-patch-caveats.adoc
index 807a65b885..133e4757e7 100644
--- a/Documentation/format-patch-caveats.adoc
+++ b/Documentation/format-patch-caveats.adoc
@@ -28,6 +28,6 @@ repositories. This goes to show that this behavior does not only impact
 email workflows.
 
 Given these limitations, one might be tempted to use a general-purpose
-utility like patch(1) instead. However, patch(1) will not only look for
+utility like `patch`(1) instead. However, `patch`(1) will not only look for
 unindented diffs (like linkgit:git-am[1]) but will try to apply indented
 diffs as well.
diff --git a/Documentation/format-patch-end-of-commit-message.adoc b/Documentation/format-patch-end-of-commit-message.adoc
index ec1ef79f5e..a1a624d2ac 100644
--- a/Documentation/format-patch-end-of-commit-message.adoc
+++ b/Documentation/format-patch-end-of-commit-message.adoc
@@ -1,8 +1,8 @@
 Any line that is of the form:
 
 * three-dashes and end-of-line, or
-* a line that begins with "diff -", or
-* a line that begins with "Index: "
+* a line that begins with `diff -`, or
+* a line that begins with `Index: `
 
 is taken as the beginning of a patch, and the commit log message
 is terminated before the first occurrence of such a line.
diff --git a/Documentation/git-am.adoc b/Documentation/git-am.adoc
index ac65852918..28adf4cf65 100644
--- a/Documentation/git-am.adoc
+++ b/Documentation/git-am.adoc
@@ -8,17 +8,17 @@ git-am - Apply a series of patches from a mailbox
 
 SYNOPSIS
 --------
-[verse]
-'git am' [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--[no-]verify]
+[synopsis]
+git am [--signoff] [--keep] [--[no-]keep-cr] [--[no-]utf8] [--[no-]verify]
 	 [--[no-]3way] [--interactive] [--committer-date-is-author-date]
 	 [--ignore-date] [--ignore-space-change | --ignore-whitespace]
 	 [--whitespace=<action>] [-C<n>] [-p<n>] [--directory=<dir>]
 	 [--exclude=<path>] [--include=<path>] [--reject] [-q | --quiet]
-	 [--[no-]scissors] [-S[<keyid>]] [--patch-format=<format>]
+	 [--[no-]scissors] [-S[<key-id>]] [--patch-format=<format>]
 	 [--quoted-cr=<action>]
 	 [--empty=(stop|drop|keep)]
 	 [(<mbox> | <Maildir>)...]
-'git am' (--continue | --skip | --abort | --quit | --retry | --show-current-patch[=(diff|raw)] | --allow-empty)
+git am (--continue | --skip | --abort | --quit | --retry | --show-current-patch[=(diff|raw)] | --allow-empty)
 
 DESCRIPTION
 -----------
@@ -30,45 +30,45 @@ history without merges.
 
 OPTIONS
 -------
-(<mbox>|<Maildir>)...::
+`(<mbox>|<Maildir>)...`::
 	The list of mailbox files to read patches from. If you do not
 	supply this argument, the command reads from the standard input.
 	If you supply directories, they will be treated as Maildirs.
 
--s::
---signoff::
+`-s`::
+`--signoff`::
 	Add a `Signed-off-by` trailer to the commit message (see
 	linkgit:git-interpret-trailers[1]), using the committer identity
 	of yourself.  See the signoff option in linkgit:git-commit[1]
 	for more information.
 
--k::
---keep::
+`-k`::
+`--keep`::
 	Pass `-k` flag to linkgit:git-mailinfo[1].
 
---keep-non-patch::
+`--keep-non-patch`::
 	Pass `-b` flag to linkgit:git-mailinfo[1].
 
---keep-cr::
---no-keep-cr::
+`--keep-cr`::
+`--no-keep-cr`::
 	With `--keep-cr`, call linkgit:git-mailsplit[1]
 	with the same option, to prevent it from stripping CR at the end of
 	lines. `am.keepcr` configuration variable can be used to specify the
 	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
 
--c::
---scissors::
+`-c`::
+`--scissors`::
 	Remove everything in body before a scissors line (see
 	linkgit:git-mailinfo[1]). Can be activated by default using
 	the `mailinfo.scissors` configuration variable.
 
---no-scissors::
+`--no-scissors`::
 	Ignore scissors lines (see linkgit:git-mailinfo[1]).
 
---quoted-cr=<action>::
+`--quoted-cr=<action>`::
 	This flag will be passed down to linkgit:git-mailinfo[1].
 
---empty=(drop|keep|stop)::
+`--empty=(drop|keep|stop)`::
 	How to handle an e-mail message lacking a patch:
 +
 --
@@ -82,23 +82,23 @@ OPTIONS
 	session. This is the default behavior.
 --
 
--m::
---message-id::
+`-m`::
+`--message-id`::
 	Pass the `-m` flag to linkgit:git-mailinfo[1],
 	so that the `Message-ID` header is added to the commit message.
 	The `am.messageid` configuration variable can be used to specify
 	the default behaviour.
 
---no-message-id::
+`--no-message-id`::
 	Do not add the Message-ID header to the commit message.
 	`--no-message-id` is useful to override `am.messageid`.
 
--q::
---quiet::
+`-q`::
+`--quiet`::
 	Be quiet. Only print error messages.
 
--u::
---utf8::
+`-u`::
+`--utf8`::
 	Pass `-u` flag to linkgit:git-mailinfo[1].
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
@@ -108,57 +108,57 @@ OPTIONS
 This was optional in prior versions of git, but now it is the
 default.   You can use `--no-utf8` to override this.
 
---no-utf8::
+`--no-utf8`::
 	Pass `-n` flag to linkgit:git-mailinfo[1].
 
--3::
---3way::
---no-3way::
+`-3`::
+`--3way`::
+`--no-3way`::
 	When the patch does not apply cleanly, fall back on
 	3-way merge if the patch records the identity of blobs
 	it is supposed to apply to and we have those blobs
 	available locally. `--no-3way` can be used to override
-	am.threeWay configuration variable. For more information,
-	see am.threeWay in linkgit:git-config[1].
+	`am.threeWay` configuration variable. For more information,
+	see `am.threeWay` in linkgit:git-config[1].
 
 include::rerere-options.adoc[]
 
---ignore-space-change::
---ignore-whitespace::
---whitespace=<action>::
--C<n>::
--p<n>::
---directory=<dir>::
---exclude=<path>::
---include=<path>::
---reject::
+`--ignore-space-change`::
+`--ignore-whitespace`::
+`--whitespace=<action>`::
+`-C<n>`::
+`-p<n>`::
+`--directory=<dir>`::
+`--exclude=<path>`::
+`--include=<path>`::
+`--reject`::
 	These flags are passed to the linkgit:git-apply[1] program that
 	applies the patch.
 +
-Valid <action> for the `--whitespace` option are:
+Valid _<action>_ for the `--whitespace` option are:
 `nowarn`, `warn`, `fix`, `error`, and `error-all`.
 
---patch-format::
+`--patch-format`::
 	By default the command will try to detect the patch format
 	automatically. This option allows the user to bypass the automatic
 	detection and specify the patch format that the patch(es) should be
 	interpreted as. Valid formats are mbox, mboxrd,
 	stgit, stgit-series, and hg.
 
--i::
---interactive::
+`-i`::
+`--interactive`::
 	Run interactively.
 
---verify::
--n::
---no-verify::
+`--verify`::
+`-n`::
+`--no-verify`::
 	Run the `pre-applypatch` and `applypatch-msg` hooks. This is the
 	default. Skip these hooks with `-n` or `--no-verify`. See also
 	linkgit:githooks[5].
 +
 Note that `post-applypatch` cannot be skipped.
 
---committer-date-is-author-date::
+`--committer-date-is-author-date`::
 	By default the command records the date from the e-mail
 	message as the commit author date, and uses the time of
 	commit creation as the committer date. This allows the
@@ -172,29 +172,29 @@ committer date when applying commits on top of a base which commit is
 older (in terms of the commit date) than the oldest patch you are
 applying.
 
---ignore-date::
+`--ignore-date`::
 	By default the command records the date from the e-mail
 	message as the commit author date, and uses the time of
 	commit creation as the committer date. This allows the
 	user to lie about the author date by using the same
 	value as the committer date.
 
---skip::
+`--skip`::
 	Skip the current patch.  This is only meaningful when
 	restarting an aborted patch.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
---no-gpg-sign::
-	GPG-sign commits. The `keyid` argument is optional and
+`-S[<key-id>]`::
+`--gpg-sign[=<key-id>]`::
+`--no-gpg-sign`::
+	GPG-sign commits. The _<key-id>_ is optional and
 	defaults to the committer identity; if specified, it must be
 	stuck to the option without a space. `--no-gpg-sign` is useful to
 	countermand both `commit.gpgSign` configuration variable, and
 	earlier `--gpg-sign`.
 
---continue::
--r::
---resolved::
+`--continue`::
+`-r`::
+`--resolved`::
 	After a patch failure (e.g. attempting to apply
 	conflicting patch), the user has applied it by hand and
 	the index file stores the result of the application.
@@ -202,36 +202,36 @@ applying.
 	extracted from the e-mail message and the current index
 	file, and continue.
 
---resolvemsg=<msg>::
-	When a patch failure occurs, <msg> will be printed
+`--resolvemsg=<msg>`::
+	When a patch failure occurs, _<msg>_ will be printed
 	to the screen before exiting.  This overrides the
 	standard message informing you to use `--continue`
 	or `--skip` to handle the failure.  This is solely
 	for internal use between linkgit:git-rebase[1] and
 	linkgit:git-am[1].
 
---abort::
+`--abort`::
 	Restore the original branch and abort the patching operation.
 	Revert the contents of files involved in the am operation to their
 	pre-am state.
 
---quit::
-	Abort the patching operation but keep HEAD and the index
+`--quit`::
+	Abort the patching operation but keep `HEAD` and the index
 	untouched.
 
---retry::
+`--retry`::
 	Try to apply the last conflicting patch again. This is generally
 	only useful for passing extra options to the retry attempt
 	(e.g., `--3way`), since otherwise you'll just see the same
 	failure again.
 
---show-current-patch[=(diff|raw)]::
+`--show-current-patch[=(diff|raw)]`::
 	Show the message at which linkgit:git-am[1] has stopped due to
 	conflicts.  If `raw` is specified, show the raw contents of
 	the e-mail message; if `diff`, show the diff portion only.
 	Defaults to `raw`.
 
---allow-empty::
+`--allow-empty`::
 	After a patch failure on an input e-mail message lacking a patch,
 	create an empty commit with the contents of the e-mail message
 	as its log message.
@@ -278,11 +278,11 @@ operation is finished, so if you decide to start over from scratch,
 run `git am --abort` before running the command with mailbox
 names.
 
-Before any patches are applied, ORIG_HEAD is set to the tip of the
+Before any patches are applied, `ORIG_HEAD` is set to the tip of the
 current branch.  This is useful if you have problems with multiple
 commits, like running linkgit:git-am[1] on the wrong branch or an error
 in the commits that is more easily fixed by changing the mailbox (e.g.
-errors in the "From:" lines).
+errors in the `From:` lines).
 
 [[caveats]]
 CAVEATS
-- 
gitgitgadget

