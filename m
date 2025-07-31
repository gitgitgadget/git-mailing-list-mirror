Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136401DDA3E
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973838; cv=none; b=UDCx3PE2Tsc6QC8JdmB6JSypk0e6vTZIgo2Z9H1A9jIEKh37qlCmGsxh01g3c9wdeKLVycKrSq0h11NGbqhSn29BNlKLj1QIRuig7zAVyjqmxUnrmFsj3Em0bEI7GKfTbNU8gvTUnQxdjhLvQjdyKDSvmtA10KoxZF0g3Av3MiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973838; c=relaxed/simple;
	bh=riafus0BS+HWOv6eI3GtZeESHkuzXkqNhiG5AlG5wJo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AwgbTnh5DjkHPaXdXccnJAZk1kjXoGdf+CtiPYSDidoAJMe8yv/mrFVfQCkq5ueMlth5RbjkVfP43DxIofZwYbUf/M75s/HHFcpA+UmE4AEcq7m3UW2zPz4pqi/r39WY5+GM2ghrxXKCTXNNA92XKWENjMvzDcTTjoae1+mrlIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bqxXOg7R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aSlbXDfi; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bqxXOg7R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aSlbXDfi"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 568771400303;
	Thu, 31 Jul 2025 10:57:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 31 Jul 2025 10:57:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753973835;
	 x=1754060235; bh=UDM6nFHsz0P7aIDSttKELKzhTkTE0BBdFl2VNUiLxBI=; b=
	bqxXOg7Rfmf8ldEWqA+obiLRDcRn4BilRxPMkVAiZnFtsEKunNcQPeQjjGuE28ms
	wNsA/U1Jd610ud0ysytf5FBfVASsjNBivaB1JynHx+NjmAvkfWh4TclSumiOM9sA
	f8XTvqcw9ZahuQPIlfEI/fq7DBaLy1ZaMFeaFZIEqszC2CZ2RF9YkWWsnNF+pAur
	tHERVsG0D/t1ZOTRJ35yRHbFn38RnvPd+eZbIReia7h7Go6EYI3DHbomoSPtzlkg
	vGNX7yEJU5HC1iIRtQsXPsW2EpdFNFMFT583RRtEU/rMQRB2EluPLyhQ53EzRSSF
	1eeeLbWeIrXNMonhvdPScg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753973835; x=
	1754060235; bh=UDM6nFHsz0P7aIDSttKELKzhTkTE0BBdFl2VNUiLxBI=; b=a
	SlbXDfiLNAxhOViId27cBxmRvF3OwL45gX4Ka6ssBrkdHoKmCLf6IHH1+EeyxUb4
	fFdA+vmd90OlPoZ2o+TF+Jixry2/TIx2rSwsfR8crSYzkqG1Od6geKptEaqqQU9b
	iZDdjrw5Lu9+ey2ZCl1rA5+DPiCtkhzV1/SVpr44Akrl3kfsVPk9k2FhYK2HuBrm
	vtTSR2AM7xBBImJx8YdEudqmBOenoO9kfQtCq27/403HJG0BPOp98tN4wI5YdrIZ
	OfdHlI2I+EuE6P8uuX7/IXl6dG5sbQfoqfQgqxR7xV+VKIXIBNrTNBuIWE645pUN
	wHgvuUQ+AqdwuqhNvuPaA==
X-ME-Sender: <xms:S4SLaHT-4iOsgvi_ZyGCMh7YDMUJZqvqHxhfpVufoVNa6U7D2-NkWw>
    <xme:S4SLaBPq9as81jYv2TKs_28WX73iK2tawpy4tQLO_bkos7qoangblQMSV_JkO35KO
    aUsJxwtrR_N3yt2HQ>
X-ME-Received: <xmr:S4SLaNQrc0__K3f0H7dFlsedxKAAVZvv7TR4Sxkl3AVjq3sNO-6izxarlPOhvWx6pic6G9jAV9PK3AfYf1Q4Uz-bi5StMAhVYFByyAeHQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeefhfeugeelheefjeektdffhedvhfdvteefgfdtudffudevveetgeeuuedtkefhgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjhhgtrghrlhdtkedugeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:S4SLaHjwT_OjRbfIyppcYSI5YSycxw6T63JI4uRniL-9r46CoIN1SQ>
    <xmx:S4SLaO9R5bgB5d_qkJXkzvCV7Fw9uqcj8tJUSYqjR-KuXuwSeCQdYw>
    <xmx:S4SLaGETnZl_knVN7d9ClPxsgjejIhrv7hV63UYQ3d84-wnFwrEkfA>
    <xmx:S4SLaJlqhIElbr-VOKViBH7SXgcXSAMdcATKLQ3MNxMJ_WDeFE5aig>
    <xmx:S4SLaNv88VScTR_58v-gA11qb3ersV034hXsAYbleN0rM6X1UI0C1Ney>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 10:57:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12a4564f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 14:57:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 31 Jul 2025 16:56:53 +0200
Subject: [PATCH v2 5/6] builtin/remote: rework how remote refs get renamed
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-pks-remote-rename-improvements-v2-5-dda6f083674d@pks.im>
References: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
In-Reply-To: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

It was recently reported [1] that renaming a remote that has dangling
symrefs is broken. This issue can be trivially reproduced:

    $ git init repo
    Initialized empty Git repository in /tmp/repo/.git/
    $ cd repo/
    $ git remote add origin /dev/null
    $ git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master
    $ git remote rename origin renamed
    $ git symbolic-ref refs/remotes/origin/HEAD
    refs/remotes/origin/master
    $ git symbolic-ref refs/remotes/renamed/HEAD
    fatal: ref refs/remotes/renamed/HEAD is not a symbolic ref

As one can see, the "HEAD" reference did not get renamed but stays in
the same place. There are two issues here:

  - We use `refs_resolve_ref_unsafe()` to resolve references, but we
    don't pass the `RESOLVE_REF_NO_RECURSE` flag. Consequently, if the
    reference does not resolve, the function will fail and we thus
    ignore this branch.

  - We use `refs_for_each_ref()` to iterate through the old remote's
    references, but that function ignores broken references.

Both of these issues are easy to fix. But having a closer look at the
logic that renames remote references surfaces that it leaves a lot to be
desired overall.

The problem is that we're using O(|refs| + |symrefs| * 2) many reference
transactions to perform the renames. We first delete all symrefs, then
individually rename every direct reference and finally we recreate the
symrefs. On the one hand this isn't even remotely an atomic operation,
so if we hit any error we'll already have deleted all references.

But more importantly it is also extremely inefficient. The number of
transactions for symrefs doesn't really bother us too much, as there
should generally only be a single symref anyway ("HEAD"). But the
renames are very expensive:

  - For the "reftable" backend we perform auto-compaction after every
    single rename, which does add up.

  - For the "files" backend we potentially have to rewrite the
    "packed-refs" file on every single rename in case they are packed.
    The consequence here is quadratic runtime performance. Renaming a
    100k references takes hours to complete.

Refactor the code to use a single transaction to perform all the
reference updates atomically, which speeds up the transaction quite
significantly:

    Benchmark 1: rename remote (refformat = files, revision = HEAD~)
      Time (mean ± σ):     238.770 s ± 13.857 s    [User: 91.473 s, System: 143.793 s]
      Range (min … max):   204.863 s … 247.699 s    10 runs

    Benchmark 2: rename remote (refformat = files, revision = HEAD)
      Time (mean ± σ):      2.103 s ±  0.036 s    [User: 0.360 s, System: 1.313 s]
      Range (min … max):    2.011 s …  2.141 s    10 runs

    Summary
      rename remote (refformat = files, revision = HEAD) ran
      113.53 ± 6.87 times faster than rename remote (refformat = files, revision = HEAD~)

For the "reftable" backend we see a significant speedup, as well, but
given that we don't have quadratic runtime behaviour there it's way less
extreme:

    Benchmark 1: rename remote (refformat = reftable, revision = HEAD~)
      Time (mean ± σ):      8.604 s ±  0.539 s    [User: 4.985 s, System: 2.368 s]
      Range (min … max):    7.880 s …  9.556 s    10 runs

    Benchmark 2: rename remote (refformat = reftable, revision = HEAD)
      Time (mean ± σ):      1.177 s ±  0.103 s    [User: 0.446 s, System: 0.270 s]
      Range (min … max):    1.023 s …  1.410 s    10 runs

    Summary
      rename remote (refformat = reftable, revision = HEAD) ran
        7.31 ± 0.79 times faster than rename remote (refformat = reftable, revision = HEAD~)

There is one issue though with using atomic transactions: when nesting a
remote into itself it can happen that renamed references conflict with
the old referencse. For example, when we have a reference
"refs/remotes/origin/foo" and we rename "origin" to "origin/foo", then
we'll end up with an F/D conflict when we try to create the renamed
reference "refs/remotes/origin/foo/foo".

This situation is overall quite unlikely to happen: people tend to not
use nested remotes, and if they do they must at the same time also have
a conflicting refname. But the end result would be that the old remote
references stay intact whereas all the other parts of the repository
have been adjusted for the new remote name.

Address this by queueing and preparing the reference update before we
touch any other part of the repository. Like this we can make sure that
the reference update will go through before rewriting the configuration.
Otherwise, if the transaction fails to prepare we can gracefully abort
the whole operation without any changes having been performed in the
repository yet. Furthermore, we can detect the conflict and print some
helpful advice for how the user can resolve this situation. So overall,
the tradeoff is that:

  - Reference transactions are now all-or-nothing. This is a significant
    improvement over the previous state where we may have ended up with
    partially-renamed references.

  - Rewriting references is now significantly faster.

  - We only rewrite the configuration in case we know that all
    references can be updated.

  - But we may refuse to rename a remote in case references conflict.

Overall this seems like an acceptable tradeoff.

While at it, fix the handling of symbolic/broken references by using
`refs_for_each_rawref()`. Add tests that cover both this reported issue
and tests that exercise nesting of remotes.

One thing to note: with this change we cannot provide a proper progress
monitor anymore as we queue the references into the transactions as we
iterate through them. Consequently, as we don't know yet how many refs
there are in total, we cannot report how many percent of the operation
is done anymore. But that's a small price to pay considering that you
now shouldn't need the progress monitor in most situations at all
anymore.

[1]: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>

Reported-by: Han Jiang <jhcarl0814@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c  | 296 ++++++++++++++++++++++++++++++++++++------------------
 t/t5505-remote.sh |  73 ++++++++++++++
 2 files changed, 270 insertions(+), 99 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 34ddcaf5f6..db481f39bc 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1,8 +1,11 @@
 #define USE_THE_REPOSITORY_VARIABLE
 
 #include "builtin.h"
+#include "advice.h"
 #include "config.h"
+#include "date.h"
 #include "gettext.h"
+#include "ident.h"
 #include "parse-options.h"
 #include "path.h"
 #include "transport.h"
@@ -610,36 +613,161 @@ static int add_branch_for_removal(const char *refname,
 struct rename_info {
 	const char *old_name;
 	const char *new_name;
-	struct string_list *remote_branches;
-	uint32_t symrefs_nr;
+	struct ref_transaction *transaction;
+	struct progress *progress;
+	struct strbuf *err;
+	uint32_t progress_nr;
+	uint64_t index;
 };
 
-static int read_remote_branches(const char *refname, const char *referent UNUSED,
-				const struct object_id *oid UNUSED,
-				int flags UNUSED, void *cb_data)
+static void compute_renamed_ref(struct rename_info *rename,
+				const char *refname,
+				struct strbuf *out)
+{
+	strbuf_reset(out);
+	strbuf_addstr(out, refname);
+	strbuf_splice(out, strlen("refs/remotes/"), strlen(rename->old_name),
+		      rename->new_name, strlen(rename->new_name));
+}
+
+static int rename_one_reflog_entry(const char *old_refname,
+				   struct object_id *old_oid,
+				   struct object_id *new_oid,
+				   const char *committer,
+				   timestamp_t timestamp, int tz,
+				   const char *msg, void *cb_data)
 {
 	struct rename_info *rename = cb_data;
-	struct strbuf buf = STRBUF_INIT;
-	struct string_list_item *item;
-	int flag;
-	const char *symref;
-
-	strbuf_addf(&buf, "refs/remotes/%s/", rename->old_name);
-	if (starts_with(refname, buf.buf)) {
-		item = string_list_append(rename->remote_branches, refname);
-		symref = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						 refname, RESOLVE_REF_READING,
-						 NULL, &flag);
-		if (symref && (flag & REF_ISSYMREF)) {
-			item->util = xstrdup(symref);
-			rename->symrefs_nr++;
-		} else {
-			item->util = NULL;
-		}
+	struct strbuf new_refname = STRBUF_INIT;
+	struct strbuf identity = STRBUF_INIT;
+	struct strbuf name = STRBUF_INIT;
+	struct strbuf mail = STRBUF_INIT;
+	struct ident_split ident;
+	const char *date;
+	int error;
+
+	compute_renamed_ref(rename, old_refname, &new_refname);
+
+	if (split_ident_line(&ident, committer, strlen(committer)) < 0) {
+		error = -1;
+		goto out;
 	}
-	strbuf_release(&buf);
 
-	return 0;
+	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
+	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
+
+	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
+	strbuf_addstr(&identity, fmt_ident(name.buf, mail.buf,
+					  WANT_BLANK_IDENT, date, 0));
+
+	error = ref_transaction_update_reflog(rename->transaction, new_refname.buf,
+					      new_oid, old_oid, identity.buf, msg,
+					      rename->index++, rename->err);
+
+out:
+	strbuf_release(&new_refname);
+	strbuf_release(&identity);
+	strbuf_release(&name);
+	strbuf_release(&mail);
+	return error;
+}
+
+static int rename_one_reflog(const char *old_refname,
+			     const struct object_id *old_oid,
+			     struct rename_info *rename)
+{
+	struct strbuf new_refname = STRBUF_INIT;
+	struct strbuf message = STRBUF_INIT;
+	int error;
+
+	if (!refs_reflog_exists(get_main_ref_store(the_repository), old_refname))
+		return 0;
+
+	error = refs_for_each_reflog_ent(get_main_ref_store(the_repository),
+					 old_refname, rename_one_reflog_entry, rename);
+	if (error < 0)
+		goto out;
+
+	compute_renamed_ref(rename, old_refname, &new_refname);
+
+	/*
+	 * Manually write the reflog entry for the now-renamed ref. We cannot
+	 * rely on `rename_one_ref()` to do this for us as that would screw
+	 * over order in which reflog entries are being written.
+	 *
+	 * Furthermore, we only append the entry in case the reference
+	 * resolves. Missing references shouldn't have reflogs anyway.
+	 */
+	strbuf_addf(&message, "remote: renamed %s to %s", old_refname,
+		    new_refname.buf);
+
+	error = ref_transaction_update_reflog(rename->transaction, new_refname.buf,
+					      old_oid, old_oid, git_committer_info(0),
+					      message.buf, rename->index++, rename->err);
+	if (error < 0)
+		return error;
+
+out:
+	strbuf_release(&new_refname);
+	strbuf_release(&message);
+	return error;
+}
+
+static int rename_one_ref(const char *old_refname, const char *referent,
+			  const struct object_id *oid,
+			  int flags, void *cb_data)
+{
+	struct strbuf new_referent = STRBUF_INIT;
+	struct strbuf new_refname = STRBUF_INIT;
+	struct rename_info *rename = cb_data;
+	const char *ptr = old_refname;
+	int error;
+
+	if (!skip_prefix(ptr, "refs/remotes/", &ptr) ||
+	    !skip_prefix(ptr, rename->old_name, &ptr) ||
+	    !skip_prefix(ptr, "/", &ptr)) {
+		error = 0;
+		goto out;
+	}
+
+	compute_renamed_ref(rename, old_refname, &new_refname);
+
+	if (flags & REF_ISSYMREF) {
+		/*
+		 * Stupidly enough `referent` is not pointing to the immediate
+		 * target of a symref, but it's the recursively resolved value.
+		 * So symrefs pointing to symrefs would be misresolved, and
+		 * unborn symrefs don't have any value for the `referent` at all.
+		 */
+		referent = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+						   old_refname, RESOLVE_REF_NO_RECURSE,
+						   NULL, NULL);
+		compute_renamed_ref(rename, referent, &new_referent);
+		oid = NULL;
+	}
+
+	error = ref_transaction_delete(rename->transaction, old_refname,
+				       oid, referent, REF_NO_DEREF, NULL, rename->err);
+	if (error < 0)
+		goto out;
+
+	error = ref_transaction_update(rename->transaction, new_refname.buf, oid, null_oid(the_hash_algo),
+				       (flags & REF_ISSYMREF) ? new_referent.buf : NULL, NULL,
+				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
+				       NULL, rename->err);
+	if (error < 0)
+		goto out;
+
+	error = rename_one_reflog(old_refname, oid, rename);
+	if (error < 0)
+		goto out;
+
+	display_progress(rename->progress, ++rename->progress_nr);
+
+out:
+	strbuf_release(&new_referent);
+	strbuf_release(&new_refname);
+	return error;
 }
 
 static int migrate_file(struct remote *remote)
@@ -727,6 +855,14 @@ static void handle_push_default(const char* old_name, const char* new_name)
 	strbuf_release(&push_default.origin);
 }
 
+static const char conflicting_remote_refs_advice[] = N_(
+	"The remote you are trying to rename has conflicting references in the\n"
+	"new target refspec. This is most likely caused by you trying to nest\n"
+	"a remote into itself, e.g. by renaming 'parent' into 'parent/child'\n"
+	"or by unnesting a remote, e.g. the other way round.\n"
+	"\n"
+	"If that is the case, you can address this by first renaming the\n"
+	"remote to a different name.\n");
 
 static int mv(int argc, const char **argv, const char *prefix,
 	      struct repository *repo UNUSED)
@@ -738,11 +874,11 @@ static int mv(int argc, const char **argv, const char *prefix,
 	};
 	struct remote *oldremote, *newremote;
 	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT,
-		old_remote_context = STRBUF_INIT;
-	struct string_list remote_branches = STRING_LIST_INIT_DUP;
-	struct rename_info rename;
-	int refs_renamed_nr = 0, refspecs_need_update = 0;
-	struct progress *progress = NULL;
+		old_remote_context = STRBUF_INIT, err = STRBUF_INIT;
+	struct rename_info rename = {
+		.err = &err,
+	};
+	int refspecs_need_update = 0;
 	int result = 0;
 
 	argc = parse_options(argc, argv, prefix, options,
@@ -753,8 +889,6 @@ static int mv(int argc, const char **argv, const char *prefix,
 
 	rename.old_name = argv[0];
 	rename.new_name = argv[1];
-	rename.remote_branches = &remote_branches;
-	rename.symrefs_nr = 0;
 
 	oldremote = remote_get(rename.old_name);
 	if (!remote_is_configured(oldremote, 1)) {
@@ -788,6 +922,30 @@ static int mv(int argc, const char **argv, const char *prefix,
 		refspecs_need_update = !!strstr(oldremote->fetch.items[i].raw,
 						old_remote_context.buf);
 
+	if (refspecs_need_update) {
+		rename.transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
+							       0, &err);
+		if (!rename.transaction)
+			goto out;
+
+		if (show_progress)
+			rename.progress = start_delayed_progress(the_repository,
+								 _("Renaming remote references"), 0);
+
+		result = refs_for_each_rawref(get_main_ref_store(the_repository),
+				rename_one_ref, &rename);
+		if (result < 0)
+			die(_("queueing remote ref renames failed: %s"), rename.err->buf);
+
+		result = ref_transaction_prepare(rename.transaction, &err);
+		if (result < 0) {
+			error("renaming remote references failed: %s", err.buf);
+			if (result == REF_TRANSACTION_ERROR_NAME_CONFLICT)
+				advise(conflicting_remote_refs_advice);
+			die(NULL);
+		}
+	}
+
 	if (oldremote->fetch.nr) {
 		strbuf_reset(&buf);
 		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
@@ -829,83 +987,23 @@ static int mv(int argc, const char **argv, const char *prefix,
 		}
 	}
 
-	if (!refspecs_need_update)
-		goto out;
-
-	/*
-	 * First remove symrefs, then rename the rest, finally create
-	 * the new symrefs.
-	 */
-	refs_for_each_ref(get_main_ref_store(the_repository),
-			  read_remote_branches, &rename);
-	if (show_progress) {
-		/*
-		 * Count symrefs twice, since "renaming" them is done by
-		 * deleting and recreating them in two separate passes.
-		 */
-		progress = start_progress(the_repository,
-					  _("Renaming remote references"),
-					  rename.remote_branches->nr + rename.symrefs_nr);
-	}
-	for (size_t i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
-		struct strbuf referent = STRBUF_INIT;
-
-		if (refs_read_symbolic_ref(get_main_ref_store(the_repository), item->string,
-					   &referent))
-			continue;
-		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, item->string, NULL, REF_NO_DEREF))
-			die(_("deleting '%s' failed"), item->string);
-
-		strbuf_release(&referent);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	for (size_t i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
+	if (refspecs_need_update) {
+		result = ref_transaction_commit(rename.transaction, &err);
+		if (result < 0)
+			die(_("renaming remote refs failed: %s"), rename.err->buf);
 
-		if (item->util)
-			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf2);
-		strbuf_addf(&buf2, "remote: renamed %s to %s",
-				item->string, buf.buf);
-		if (refs_rename_ref(get_main_ref_store(the_repository), item->string, buf.buf, buf2.buf))
-			die(_("renaming '%s' failed"), item->string);
-		display_progress(progress, ++refs_renamed_nr);
-	}
-	for (size_t i = 0; i < remote_branches.nr; i++) {
-		struct string_list_item *item = remote_branches.items + i;
+		stop_progress(&rename.progress);
 
-		if (!item->util)
-			continue;
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, item->string);
-		strbuf_splice(&buf, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf2);
-		strbuf_addstr(&buf2, item->util);
-		strbuf_splice(&buf2, strlen("refs/remotes/"), strlen(rename.old_name),
-				rename.new_name, strlen(rename.new_name));
-		strbuf_reset(&buf3);
-		strbuf_addf(&buf3, "remote: renamed %s to %s",
-				item->string, buf.buf);
-		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf))
-			die(_("creating '%s' failed"), buf.buf);
-		display_progress(progress, ++refs_renamed_nr);
+		handle_push_default(rename.old_name, rename.new_name);
 	}
-	stop_progress(&progress);
-
-	handle_push_default(rename.old_name, rename.new_name);
 
 out:
-	string_list_clear(&remote_branches, 1);
+	ref_transaction_free(rename.transaction);
 	strbuf_release(&old_remote_context);
 	strbuf_release(&buf);
 	strbuf_release(&buf2);
 	strbuf_release(&buf3);
+	strbuf_release(&err);
 	return result;
 }
 
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 2701eef85e..e592c0bcde 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -1658,4 +1658,77 @@ test_expect_success 'forbid adding superset of existing remote' '
 	test_grep ".outer. is a superset of existing remote .outer/inner." err
 '
 
+test_expect_success 'rename handles unborn HEAD' '
+	test_when_finished "git remote remove unborn-renamed" &&
+	git remote add unborn url &&
+	git symbolic-ref refs/remotes/unborn/HEAD refs/remotes/unborn/nonexistent &&
+	git remote rename unborn unborn-renamed &&
+	git symbolic-ref refs/remotes/unborn-renamed/HEAD >actual &&
+	echo refs/remotes/unborn-renamed/nonexistent >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename can nest a remote into itself' '
+	test_commit parent-commit &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_when_finished "git remote remove parent || true" &&
+	git remote add parent url &&
+	git update-ref refs/remotes/parent/branch $COMMIT_ID &&
+	test_when_finished "git remote remove parent/child" &&
+	git remote rename parent parent/child &&
+	git for-each-ref refs/remotes/ >actual &&
+	printf "$COMMIT_ID commit\trefs/remotes/parent/child/branch\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename can nest a remote into itself with a conflicting branch name' '
+	test_commit parent-conflict &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_when_finished "git remote remove parent || true" &&
+	git remote add parent url &&
+	git update-ref refs/remotes/parent/child $COMMIT_ID &&
+	test_when_finished "git remote remove parent/child" &&
+	test_must_fail git remote rename parent parent/child 2>err &&
+	test_grep "renaming remote references failed" err &&
+	test_grep "The remote you are trying to rename has conflicting references" err &&
+	git for-each-ref refs/remotes/ >actual &&
+	printf "$COMMIT_ID commit\trefs/remotes/parent/child\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename can unnest a remote' '
+	test_commit parent-child-commit &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_when_finished "git remote remove parent/child || true" &&
+	git remote add parent/child url &&
+	git update-ref refs/remotes/parent/child/branch $COMMIT_ID &&
+	git remote rename parent/child parent &&
+	git for-each-ref refs/remotes/ >actual &&
+	printf "$COMMIT_ID commit\trefs/remotes/parent/branch\n" >expected &&
+	test_cmp expected actual
+'
+
+test_expect_success 'rename moves around the reflog' '
+	test_commit reflog-old &&
+	COMMIT_ID=$(git rev-parse HEAD) &&
+	test_config core.logAllRefUpdates true &&
+	test_when_finished "git remote remove reflog-old || true" &&
+	git remote add reflog-old url &&
+	git update-ref refs/remotes/reflog-old/branch $COMMIT_ID &&
+	test-tool ref-store main for-each-reflog >actual &&
+	test_grep refs/remotes/reflog-old/branch actual &&
+	test-tool ref-store main for-each-reflog-ent refs/remotes/reflog-old/branch >reflog-entries-old &&
+	test_line_count = 1 reflog-entries-old &&
+	git remote rename reflog-old reflog-new &&
+	test-tool ref-store main for-each-reflog >actual &&
+	test_grep ! refs/remotes/reflog-old actual &&
+	test_grep refs/remotes/reflog-new/branch actual &&
+	test-tool ref-store main for-each-reflog-ent refs/remotes/reflog-new/branch >reflog-entries-new &&
+	cat >expect <<-EOF &&
+	$(cat reflog-entries-old)
+	$COMMIT_ID $COMMIT_ID $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1112912173 -0700	remote: renamed refs/remotes/reflog-old/branch to refs/remotes/reflog-new/branch
+	EOF
+	test_cmp expect reflog-entries-new
+'
+
 test_done

-- 
2.50.1.619.g074bbf1d35.dirty

