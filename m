From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Wed, 14 May 2014 12:06:35 -0700
Message-ID: <xmqqppjgji2s.fsf@gitster.dls.corp.google.com>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
	<xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
	<53729b2150a84_34aa9e5304e0@nysa.notmuch>
	<xmqq38gdmhdo.fsf@gitster.dls.corp.google.com>
	<5372a0f6650d2_36c411ff3002e@nysa.notmuch>
	<5372D205.4040004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 21:18:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkegj-0006ms-SP
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 21:18:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751683AbaENTR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 15:17:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56265 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857AbaENTRz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 15:17:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A05AC16F3C;
	Wed, 14 May 2014 15:17:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AnFq23MmBaqB7oHcIIGjx8+xP/c=; b=wHWQxX
	CxanKIhhO/vnOYDAXeBzIoKbLk5BaML5+3Nz2Urvo74nL3kM2go41qEA/SagNQrf
	N28ZS+JIxL1ZzeNVaVr6FJoS4zNIgi26ImlFqTYuEfvzGHaaeRoTxpjm8Qrb7ELq
	3ksQQETmTk6sS1uXYGwr5aZpupDHsKBe5GxMM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cDs7QT1u2BtGObhg4L4nz5b39DjyDgur
	rAsaZ8sKzjFp0DZ46k+Ogh47NW2gQLc57F11NpFDP/rtgVZHCSSfbNO9GWE192Iy
	UmWr1NHmXzGe0W58QXuC+qbD+kG9Z4Iy/ERfuuAfOQn8kDBZT7El7S95Av1jCoy7
	nYEJvb/ybIg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 95F2616F3A;
	Wed, 14 May 2014 15:17:49 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3426E1644F;
	Wed, 14 May 2014 15:06:37 -0400 (EDT)
In-Reply-To: <5372D205.4040004@gmail.com> (Marius Storm-Olsen's message of
	"Tue, 13 May 2014 21:16:37 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DF7E2BCA-DB9A-11E3-B8E8-DDB853EDF712-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248937>

Marius Storm-Olsen <mstormo@gmail.com> writes:

> On 5/13/2014 5:47 PM, Felipe Contreras wrote:
>> I was going to do more than pointing to commits, I was going to
>> provide the fixes with test cases and a detailed explanation. But
>> then you made your decision.
>
> I believe the regression in question, mentioned at the bottom of this post
>
> http://thread.gmane.org/gmane.comp.version-control.git/248263/focus=248269
>
>     "Since you are not going to do so, I do not feel compelled to fix
>      the synchronization crash regression that is present in v2.0.0-rc2
>      and I already warned you about."
>
> is referring to this patch
>
> http://thread.gmane.org/gmane.comp.version-control.git/247546/focus=247549
>
> but I admit, I'm getting a bit fuzzy around these discussions.

Thanks for trying to help.

The patch you pointed out however names 2594a79 as the culprit, but
it has been in 1.8.3 and upwards, so I am not sure what to say.  As
I do not recall seeing anything about "I already warned you about",
I fished the archive again, but the closest I found was this:

    http://thread.gmane.org/gmane.comp.version-control.git/248063/focus=248601

in which we heard "You won't be able to find the breakage." when I
hinted bisecting.  The only thing we saw was "I already said this
multiple times, but let me be clear once more: MASTER HAS A
REGRESSION (for all versions of Mercurial)." and I can believe if he
said that exact phrase multiple times, but I do not think he said
anything useful than "I broke 2.0 prereleases" anywhere---at least I
didn't find any "... with this commit in what way".

So at this point, I would have to say that the users of remote-hg is
taken hostage by its author.  One safe way forward at this point in
order to avoid regression would be to revert everything done by him
as suspicious, but that is a route that is too overcautious even for
me, and I am not willing to travel that road.

The "synch crash regression" points me more towards 3994e64d
(transport-helper: fix sync issue on crashes, 2014-04-12), though.
I would happily revert the merge d508e4a that pulled the topic into
v2.0.0-rc1.

-- >8 --
Subject: [PATCH] Revert "Merge branch 'fc/transport-helper-sync-error-fix'"

This reverts commit d508e4a8e2391ae2596403b6478d01cf3d5f928f,
reversing changes made to e42552135a2a396f37053a89f44952ea907870b2.

The author of the original topic says he broke the upcoming 2.0
release with something that relates to "synchronization crash
regression" while refusing to give further specifics, so this would
unfortunately be the safest option for the upcoming release.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/RelNotes/2.0.0.txt |  4 ---
 t/t5801-remote-helpers.sh        | 31 +++++------------
 transport-helper.c               | 73 ++++++++++++++++------------------------
 3 files changed, 37 insertions(+), 71 deletions(-)

diff --git a/Documentation/RelNotes/2.0.0.txt b/Documentation/RelNotes/2.0.0.txt
index 6e628d4..97f7df0 100644
--- a/Documentation/RelNotes/2.0.0.txt
+++ b/Documentation/RelNotes/2.0.0.txt
@@ -88,10 +88,6 @@ UI, Workflows & Features
  * "git grep" learned to behave in a way similar to native grep when
    "-h" (no header) and "-c" (count) options are given.
 
- * "git push" via transport-helper interface (e.g. remote-hg) has
-   been updated to allow forced ref updates in a way similar to the
-   natively supported transports.
-
  * The "simple" mode is the default for "git push".
 
  * "git add -u" and "git add -A", when run without any pathspec, is a
diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index a00a660..25fd2e7 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -212,30 +212,19 @@ test_expect_success 'push update refs failure' '
 	echo "update fail" >>file &&
 	git commit -a -m "update fail" &&
 	git rev-parse --verify testgit/origin/heads/update >expect &&
-	test_expect_code 1 env GIT_REMOTE_TESTGIT_FAILURE="non-fast forward" \
-		git push origin update &&
+	GIT_REMOTE_TESTGIT_PUSH_ERROR="non-fast forward" &&
+	export GIT_REMOTE_TESTGIT_PUSH_ERROR &&
+	test_expect_code 1 git push origin update &&
 	git rev-parse --verify testgit/origin/heads/update >actual &&
 	test_cmp expect actual
 	)
 '
 
-clean_mark () {
-	cut -f 2 -d ' ' "$1" |
-	git cat-file --batch-check |
-	grep commit |
-	sort >$(basename "$1")
-}
-
-cmp_marks () {
-	test_when_finished "rm -rf git.marks testgit.marks" &&
-	clean_mark ".git/testgit/$1/git.marks" &&
-	clean_mark ".git/testgit/$1/testgit.marks" &&
-	test_cmp git.marks testgit.marks
-}
-
 test_expect_success 'proper failure checks for fetching' '
-	(cd local &&
-	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git fetch 2>error &&
+	(GIT_REMOTE_TESTGIT_FAILURE=1 &&
+	export GIT_REMOTE_TESTGIT_FAILURE &&
+	cd local &&
+	test_must_fail git fetch 2> error &&
 	cat error &&
 	grep -q "Error while running fast-import" error
 	)
@@ -243,11 +232,7 @@ test_expect_success 'proper failure checks for fetching' '
 
 test_expect_success 'proper failure checks for pushing' '
 	(cd local &&
-	git checkout -b crash master &&
-	echo crash >>file &&
-	git commit -a -m crash &&
-	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all &&
-	cmp_marks origin
+	test_must_fail env GIT_REMOTE_TESTGIT_FAILURE=1 git push --all
 	)
 '
 
diff --git a/transport-helper.c b/transport-helper.c
index b468e4f..86e1679 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -58,7 +58,7 @@ static int recvline_fh(FILE *helper, struct strbuf *buffer, const char *name)
 	if (strbuf_getline(buffer, helper, '\n') == EOF) {
 		if (debug)
 			fprintf(stderr, "Debug: Remote helper quit.\n");
-		return 1;
+		exit(128);
 	}
 
 	if (debug)
@@ -71,6 +71,12 @@ static int recvline(struct helper_data *helper, struct strbuf *buffer)
 	return recvline_fh(helper->out, buffer, helper->name);
 }
 
+static void xchgline(struct helper_data *helper, struct strbuf *buffer)
+{
+	sendline(helper, buffer);
+	recvline(helper, buffer);
+}
+
 static void write_constant(int fd, const char *str)
 {
 	if (debug)
@@ -157,8 +163,7 @@ static struct child_process *get_helper(struct transport *transport)
 	while (1) {
 		const char *capname;
 		int mandatory = 0;
-		if (recvline(data, &buf))
-			exit(128);
+		recvline(data, &buf);
 
 		if (!*buf.buf)
 			break;
@@ -195,9 +200,15 @@ static struct child_process *get_helper(struct transport *transport)
 		} else if (!strcmp(capname, "signed-tags")) {
 			data->signed_tags = 1;
 		} else if (starts_with(capname, "export-marks ")) {
-			data->export_marks = xstrdup(capname + strlen("export-marks "));
+			struct strbuf arg = STRBUF_INIT;
+			strbuf_addstr(&arg, "--export-marks=");
+			strbuf_addstr(&arg, capname + strlen("export-marks "));
+			data->export_marks = strbuf_detach(&arg, NULL);
 		} else if (starts_with(capname, "import-marks")) {
-			data->import_marks = xstrdup(capname + strlen("import-marks "));
+			struct strbuf arg = STRBUF_INIT;
+			strbuf_addstr(&arg, "--import-marks=");
+			strbuf_addstr(&arg, capname + strlen("import-marks "));
+			data->import_marks = strbuf_detach(&arg, NULL);
 		} else if (starts_with(capname, "no-private-update")) {
 			data->no_private_update = 1;
 		} else if (mandatory) {
@@ -296,9 +307,7 @@ static int set_helper_option(struct transport *transport,
 		quote_c_style(value, &buf, NULL, 0);
 	strbuf_addch(&buf, '\n');
 
-	sendline(data, &buf);
-	if (recvline(data, &buf))
-		exit(128);
+	xchgline(data, &buf);
 
 	if (!strcmp(buf.buf, "ok"))
 		ret = 0;
@@ -370,8 +379,7 @@ static int fetch_with_fetch(struct transport *transport,
 	sendline(data, &buf);
 
 	while (1) {
-		if (recvline(data, &buf))
-			exit(128);
+		recvline(data, &buf);
 
 		if (starts_with(buf.buf, "lock ")) {
 			const char *name = buf.buf + 5;
@@ -422,8 +430,6 @@ static int get_exporter(struct transport *transport,
 	struct helper_data *data = transport->data;
 	struct child_process *helper = get_helper(transport);
 	int argc = 0, i;
-	struct strbuf tmp = STRBUF_INIT;
-
 	memset(fastexport, 0, sizeof(*fastexport));
 
 	/* we need to duplicate helper->in because we want to use it after
@@ -434,14 +440,10 @@ static int get_exporter(struct transport *transport,
 	fastexport->argv[argc++] = "--use-done-feature";
 	fastexport->argv[argc++] = data->signed_tags ?
 		"--signed-tags=verbatim" : "--signed-tags=warn-strip";
-	if (data->export_marks) {
-		strbuf_addf(&tmp, "--export-marks=%s.tmp", data->export_marks);
-		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
-	}
-	if (data->import_marks) {
-		strbuf_addf(&tmp, "--import-marks=%s", data->import_marks);
-		fastexport->argv[argc++] = strbuf_detach(&tmp, NULL);
-	}
+	if (data->export_marks)
+		fastexport->argv[argc++] = data->export_marks;
+	if (data->import_marks)
+		fastexport->argv[argc++] = data->import_marks;
 
 	for (i = 0; i < revlist_args->nr; i++)
 		fastexport->argv[argc++] = revlist_args->items[i].string;
@@ -561,9 +563,7 @@ static int process_connect_service(struct transport *transport,
 		goto exit;
 
 	sendline(data, &cmdbuf);
-	if (recvline_fh(input, &cmdbuf, name))
-		exit(128);
-
+	recvline_fh(input, &cmdbuf, name);
 	if (!strcmp(cmdbuf.buf, "")) {
 		data->no_disconnect_req = 1;
 		if (debug)
@@ -739,22 +739,16 @@ static int push_update_ref_status(struct strbuf *buf,
 	return !(status == REF_STATUS_OK);
 }
 
-static int push_update_refs_status(struct helper_data *data,
+static void push_update_refs_status(struct helper_data *data,
 				    struct ref *remote_refs,
 				    int flags)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct ref *ref = remote_refs;
-	int ret = 0;
-
 	for (;;) {
 		char *private;
 
-		if (recvline(data, &buf)) {
-			ret = 1;
-			break;
-		}
-
+		recvline(data, &buf);
 		if (!buf.len)
 			break;
 
@@ -772,7 +766,6 @@ static int push_update_refs_status(struct helper_data *data,
 		free(private);
 	}
 	strbuf_release(&buf);
-	return ret;
 }
 
 static int push_refs_with_push(struct transport *transport,
@@ -853,7 +846,8 @@ static int push_refs_with_push(struct transport *transport,
 	sendline(data, &buf);
 	strbuf_release(&buf);
 
-	return push_update_refs_status(data, remote_refs, flags);
+	push_update_refs_status(data, remote_refs, flags);
+	return 0;
 }
 
 static int push_refs_with_export(struct transport *transport,
@@ -911,15 +905,7 @@ static int push_refs_with_export(struct transport *transport,
 
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
-	if (push_update_refs_status(data, remote_refs, flags))
-		return 1;
-
-	if (data->export_marks) {
-		strbuf_addf(&buf, "%s.tmp", data->export_marks);
-		rename(buf.buf, data->export_marks);
-		strbuf_release(&buf);
-	}
-
+	push_update_refs_status(data, remote_refs, flags);
 	return 0;
 }
 
@@ -988,8 +974,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 
 	while (1) {
 		char *eov, *eon;
-		if (recvline(data, &buf))
-			exit(128);
+		recvline(data, &buf);
 
 		if (!*buf.buf)
 			break;
-- 
2.0.0-rc3-417-gef3bd82
