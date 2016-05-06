From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8: fix duplicate words of "the"
Date: Fri, 06 May 2016 11:30:31 -0700
Message-ID: <xmqqa8k33upk.fsf@gitster.mtv.corp.google.com>
References: <1462537893-18493-1-git-send-email-lip@dtdream.com>
	<20160506130922.GA5051@sigill.intra.peff.net>
	<xmqqoa8j3xk7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Li Peng <lip@dtdream.com>
X-From: git-owner@vger.kernel.org Fri May 06 20:30:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aykWN-0007Ty-T9
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578AbcEFSag (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:30:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61289 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758208AbcEFSaf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:30:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4EA8017E33;
	Fri,  6 May 2016 14:30:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TGEziyn9E/w7sr/oAf/Z3Nl0tko=; b=H2pHhU
	j4IltxPKMCQhDi2/1QDdcRPhBgdwYmNYhRxCVHWZsDK4/i76tCLPHeyFTvW3L1+m
	ziIc4/Z2PnqfE6GsPiY4SLuTz6atEAHQ94wgLtJS+zF664oTU47pEjY2S2NGWunb
	2QZUk2tR/AP+l30Kn+rGT4UcsnM00TOBU5YSs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gU5kuPAC0cT38rwf1wMCMGuE81RR3DWf
	VyMHZy/WW1xnu3c6MsRQPk0RYpDTEbDI6vDR+SVqk3h4SoSf5js60RX/aKE0ftP6
	aI8KXTnSYQGBtZKn8EGHsRRcXHRnxZQ2LIyp+0xXOMFUSEBdNLmepOxU7DD9taRq
	IkmwGeztQzY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4649C17E31;
	Fri,  6 May 2016 14:30:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B364917E30;
	Fri,  6 May 2016 14:30:32 -0400 (EDT)
In-Reply-To: <xmqqoa8j3xk7.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 06 May 2016 10:28:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9E0620F0-13B8-11E6-B9E0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293844>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>>
>> IMHO it would be fine to just do all of these in a single patch. They're
>> different files, yes, but it's all conceptually the same change.
>
> I can squash them into a single one.  So far, everything except two
> I saw was good.

So I tentatively queued this.

-- >8 --
From: Li Peng <lip@dtdream.com>
Date: Fri, 6 May 2016 20:36:46 +0800
Subject: [PATCH] typofix: assorted typofixes in comments, documentation and
 messages

Many instances of duplicate words (e.g. "the the path") and
a few typoes are fixed, originally in multiple patches.

    wildmatch: fix duplicate words of "the"
    t: fix duplicate words of "output"
    transport-helper: fix duplicate words of "read"
    Git.pm: fix duplicate words of "return"
    path: fix duplicate words of "look"
    pack-protocol.txt: fix duplicate words of "the"
    precompose-utf8: fix typo of "sequences"
    split-index: fix typo
    worktree.c: fix typo
    remote-ext: fix typo

Signed-off-by: Li Peng <lip@dtdream.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt | 2 +-
 builtin/remote-ext.c                      | 2 +-
 compat/precompose_utf8.c                  | 2 +-
 path.c                                    | 2 +-
 perl/Git.pm                               | 2 +-
 split-index.c                             | 2 +-
 t/t0000-basic.sh                          | 2 +-
 transport-helper.c                        | 2 +-
 wildmatch.c                               | 2 +-
 worktree.c                                | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index c6977bb..8b36343 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -526,7 +526,7 @@ Push Certificate
 
 A push certificate begins with a set of header lines.  After the
 header and an empty line, the protocol commands follow, one per
-line. Note that the the trailing LF in push-cert PKT-LINEs is _not_
+line. Note that the trailing LF in push-cert PKT-LINEs is _not_
 optional; it must be present.
 
 Currently, the following header fields are defined:
diff --git a/builtin/remote-ext.c b/builtin/remote-ext.c
index 7457c74..88eb8f9 100644
--- a/builtin/remote-ext.c
+++ b/builtin/remote-ext.c
@@ -168,7 +168,7 @@ static int command_loop(const char *child)
 		size_t i;
 		if (!fgets(buffer, MAXCOMMAND - 1, stdin)) {
 			if (ferror(stdin))
-				die("Comammand input error");
+				die("Command input error");
 			exit(0);
 		}
 		/* Strip end of line characters. */
diff --git a/compat/precompose_utf8.c b/compat/precompose_utf8.c
index dfbe6d8..4293b53 100644
--- a/compat/precompose_utf8.c
+++ b/compat/precompose_utf8.c
@@ -147,7 +147,7 @@ struct dirent_prec_psx *precompose_utf8_readdir(PREC_DIR *prec_dir)
 				if (errno || inleft) {
 					/*
 					 * iconv() failed and errno could be E2BIG, EILSEQ, EINVAL, EBADF
-					 * MacOS X avoids illegal byte sequemces.
+					 * MacOS X avoids illegal byte sequences.
 					 * If they occur on a mounted drive (e.g. NFS) it is not worth to
 					 * die() for that, but rather let the user see the original name
 					*/
diff --git a/path.c b/path.c
index 969b494..a5e953f 100644
--- a/path.c
+++ b/path.c
@@ -134,7 +134,7 @@ static struct common_dir common_list[] = {
  * definite
  * definition
  *
- * The trie would look look like:
+ * The trie would look like:
  * root: len = 0, children a and d non-NULL, value = NULL.
  *    a: len = 2, contents = bc, value = (data for "abc")
  *    d: len = 2, contents = ef, children i non-NULL, value = (data for "def")
diff --git a/perl/Git.pm b/perl/Git.pm
index 49eb88a..ce7e4e8 100644
--- a/perl/Git.pm
+++ b/perl/Git.pm
@@ -393,7 +393,7 @@ sub command_close_pipe {
 Execute the given C<COMMAND> in the same way as command_output_pipe()
 does but return both an input pipe filehandle and an output pipe filehandle.
 
-The function will return return C<($pid, $pipe_in, $pipe_out, $ctx)>.
+The function will return C<($pid, $pipe_in, $pipe_out, $ctx)>.
 See C<command_close_bidi_pipe()> for details.
 
 =cut
diff --git a/split-index.c b/split-index.c
index 968b780..3c75d4b 100644
--- a/split-index.c
+++ b/split-index.c
@@ -60,7 +60,7 @@ static void mark_base_index_entries(struct index_state *base)
 	 * To keep track of the shared entries between
 	 * istate->base->cache[] and istate->cache[], base entry
 	 * position is stored in each base entry. All positions start
-	 * from 1 instead of 0, which is resrved to say "this is a new
+	 * from 1 instead of 0, which is reserved to say "this is a new
 	 * entry".
 	 */
 	for (i = 0; i < base->cache_nr; i++)
diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 79b9074..60811a3 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -98,7 +98,7 @@ check_sub_test_lib_test () {
 }
 
 check_sub_test_lib_test_err () {
-	name="$1" # stdin is the expected output output from the test
+	name="$1" # stdin is the expected output from the test
 	# expected error output is in descriptior 3
 	(
 		cd "$name" &&
diff --git a/transport-helper.c b/transport-helper.c
index b934183..13b7a57 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1152,7 +1152,7 @@ static void udt_close_if_finished(struct unidirectional_transfer *t)
 }
 
 /*
- * Tries to read read data from source into buffer. If buffer is full,
+ * Tries to read data from source into buffer. If buffer is full,
  * no data is read. Returns 0 on success, -1 on error.
  */
 static int udt_do_read(struct unidirectional_transfer *t)
diff --git a/wildmatch.c b/wildmatch.c
index f91ba99..57c8765 100644
--- a/wildmatch.c
+++ b/wildmatch.c
@@ -136,7 +136,7 @@ static int dowild(const uchar *p, const uchar *text, unsigned int flags)
 				/*
 				 * Try to advance faster when an asterisk is
 				 * followed by a literal. We know in this case
-				 * that the the string before the literal
+				 * that the string before the literal
 				 * must belong to "*".
 				 * If match_slash is false, do not look past
 				 * the first slash as it cannot belong to '*'.
diff --git a/worktree.c b/worktree.c
index 6181a66..89ebe67 100644
--- a/worktree.c
+++ b/worktree.c
@@ -18,7 +18,7 @@ void free_worktrees(struct worktree **worktrees)
 
 /*
  * read 'path_to_ref' into 'ref'.  Also if is_detached is not NULL,
- * set is_detached to 1 (0) if the ref is detatched (is not detached).
+ * set is_detached to 1 (0) if the ref is detached (is not detached).
  *
  * $GIT_COMMON_DIR/$symref (e.g. HEAD) is practically outside $GIT_DIR so
  * for linked worktrees, `resolve_ref_unsafe()` won't work (it uses
-- 
2.8.2-507-g43e827d
