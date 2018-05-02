Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE04C21841
	for <e@80x24.org>; Wed,  2 May 2018 09:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbeEBJio (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 05:38:44 -0400
Received: from mout.gmx.net ([212.227.17.22]:36539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750883AbeEBJil (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 05:38:41 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MJWAZ-1fBtD02Na7-0036G2; Wed, 02 May 2018 11:38:27 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] Finish the conversion from die("BUG: ...") to BUG()
Date:   Wed,  2 May 2018 11:38:13 +0200
Message-Id: <cover.1525253892.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
In-Reply-To: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kmgedC7PHAjplZWjZ6hr0GFADhiedgAAozgnkDLRx1LQgD0bFKY
 fsaBkEZIt3100OUsWBfDpXxJ6ojnL2m9hvjj1x1zi2kOvZubZZhePev1V9UGBkgV3eA6G3j
 73jnStO9Avq4DBwBSBPLv3Tqk3oCtewKBW4Q3Obtsy7+76bUujAtTHiJi3EoqwJ3T5SQFpZ
 9/CAqUh4jMQ3GRbSvcE3A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BKTVC4PlIiA=:GuyYDKSruZ2LrZpKvmwqLZ
 MUcuFXiytHXxtZs+A0LD/a1UhJwG/gBSjQq91YnvkqmvKKiHOF1ECYLoYU28sqsCbgpii9Y7Q
 l7CuFHX7XkohU8MqX2PLZqVfI0OgpDn9Vr60e9ga9VMyzF5msl89Abl7sOYqEQSpYAp4EKKT3
 s5QMpHg0PpUmhebAVfyQDlDyGnIdrDuSOxeM8s2N0z/6vXH+7+/R9oJVbrRiYUWAtEqhyWZII
 iEa3w7wRE6GeSQVhZ3I9sK0oGnwR+olgcoyyN99W4n3jUaxcPL3dNSGV6buCDyCoZppNZHRxB
 8/dnCKI9vOOhgMgj7z9/3ZuMaF6OMZ6imnIpaW0IdsMCVprK1jlEecyiiya4Sq9vKPH3TdYsj
 mVikDrVjmJRXSF5gCUrRXYCX5+Y3LYxdcTCD4p1NLhFTWuOzc4F6bbyYb76s9efPlcx+bNT3D
 2pfPKFpPbSUbsbf8jTDe/iIoq6jwqgksBAx5l8JS9zYOwJ3LG2RnN2ybcDZGXcJSTAeipweDp
 brrBxbef1ZQt3I7FpChmyK9B4572sMgQr/gdDSE25rKzqeao0bneas21AJrAANvu7Q0zo26YT
 446vxTyDsuvJqU9xm5y36NwHGiqhpDRTZ1HvkBn/M05RROW268xOdtxL9ZUfv/qNrSoFpw4CM
 KMXg2kTxjETUsoROMLKP3ZidkUn56rg7vMUcyvUSNq04Srtg1Jla2r/cuiXKeJ2O80BklZf6h
 dYHTh+MGjjB6bAEsfuKEA2usTlEDg0ywDQUTOjA0UrOHw8/CECUNqbjjNau3wO6kKyLv5xdfA
 Wq4nV8P
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The BUG() macro was introduced in this patch series:
https://public-inbox.org/git/20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net

The second patch in that series converted one caller from die("BUG: ")
to use the BUG() macro.

It seems that there was no concrete plan to address the same issue in
the rest of the code base.

This patch series tries to do that.

Note: I would be very surprised if the monster commit 3/4 ("Replace all
die("BUG: ...") calls by BUG() ones") would apply cleanly on `pu` (I
develop this on top of `master`).

For that reason, the commit message contains the precise Unix shell
invocation (GNU sed semantics, not BSD sed ones, because I know that the
Git maintainer as well as the author of the patch introducing BUG() both
use Linux and not macOS or any other platform that would offer a BSD
sed). It should be straight-forward to handle merge
conflicts/non-applying patches by simply re-running that command.

Changes since v2:

- Avoided the entire discussion about the previous 2/6 (now dropped)
  that prepared t1406 to handle SIGABRT by side-stepping the issue: the
  ref-store test helper will no longer call abort() in BUG() calls but
  exit with exit code 99 instead.

- As a consequence, I could fold 3/6 into 4/6 (i.e. *not* special-case
  the refs/*.c code but do one wholesale die("BUG: ...") -> BUG()
  conversion).

- Further consequence: 1/6, which added handling for ok=sigabrt to
  test_must_fail, was dropped.

- I also used the opportunity to explain in the commit message of the last
  commit why the localization was dropped from one die(_("BUG: ...")) call.


Johannes Schindelin (4):
  test-tool: help verifying BUG() code paths
  run-command: use BUG() to report bugs, not die()
  Replace all die("BUG: ...") calls by BUG() ones
  Convert remaining die*(BUG) messages

 apply.c                          |  4 ++--
 archive-tar.c                    |  2 +-
 attr.c                           | 10 +++++-----
 blame.c                          |  2 +-
 builtin/am.c                     | 20 +++++++++----------
 builtin/branch.c                 |  2 +-
 builtin/cat-file.c               |  4 ++--
 builtin/clone.c                  |  2 +-
 builtin/commit.c                 |  2 +-
 builtin/config.c                 |  2 +-
 builtin/fast-export.c            |  2 +-
 builtin/fsck.c                   |  2 +-
 builtin/index-pack.c             |  4 ++--
 builtin/init-db.c                |  2 +-
 builtin/ls-files.c               |  2 +-
 builtin/notes.c                  |  8 ++++----
 builtin/pack-objects.c           |  4 ++--
 builtin/pull.c                   |  2 +-
 builtin/receive-pack.c           |  2 +-
 builtin/replace.c                |  2 +-
 builtin/update-index.c           |  2 +-
 bulk-checkin.c                   |  2 +-
 color.c                          |  4 ++--
 column.c                         |  2 +-
 config.c                         | 12 +++++------
 date.c                           |  2 +-
 diff.c                           | 12 +++++------
 dir-iterator.c                   |  2 +-
 git-compat-util.h                |  2 +-
 grep.c                           | 16 +++++++--------
 http.c                           |  8 ++++----
 imap-send.c                      |  2 +-
 lockfile.c                       |  2 +-
 mailinfo.c                       |  2 +-
 merge-recursive.c                | 12 +++++------
 notes-merge.c                    |  4 ++--
 pack-bitmap-write.c              |  2 +-
 pack-bitmap.c                    |  6 +++---
 pack-objects.c                   |  2 +-
 packfile.c                       |  6 +++---
 pathspec.c                       | 12 +++++------
 pkt-line.c                       |  2 +-
 prio-queue.c                     |  2 +-
 ref-filter.c                     |  4 ++--
 refs.c                           | 34 ++++++++++++++++----------------
 refs/files-backend.c             | 20 +++++++++----------
 refs/iterator.c                  |  6 +++---
 refs/packed-backend.c            | 16 +++++++--------
 refs/ref-cache.c                 |  2 +-
 remote.c                         |  2 +-
 revision.c                       |  4 ++--
 run-command.c                    | 33 ++++++++++++++-----------------
 setup.c                          |  4 ++--
 sha1-lookup.c                    |  2 +-
 sha1-name.c                      |  4 ++--
 shallow.c                        |  6 +++---
 sigchain.c                       |  2 +-
 strbuf.c                         |  4 ++--
 submodule.c                      |  8 ++++----
 t/helper/test-example-decorate.c | 16 +++++++--------
 t/helper/test-tool.c             |  2 ++
 tmp-objdir.c                     |  2 +-
 trailer.c                        |  6 +++---
 transport.c                      |  4 ++--
 unpack-trees.c                   |  2 +-
 usage.c                          |  5 +++++
 vcs-svn/fast_export.c            |  6 ++++--
 worktree.c                       |  2 +-
 wrapper.c                        |  4 ++--
 wt-status.c                      | 20 +++++++++----------
 zlib.c                           |  4 ++--
 71 files changed, 214 insertions(+), 208 deletions(-)


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/use-bug-macro-v2
Fetch-It-Via: git fetch https://github.com/dscho/git use-bug-macro-v2

Branch-diff vs v1:
 1: 97894dd28d7 < -:  ------- test_must_fail: support ok=sigabrt
 2: 9bbfd73a8e0 < -:  ------- t1406: prepare for the refs code to fail with BUG()
 3: b44ce003ae6 < -:  ------- refs/*: report bugs using the BUG() macro
 -:  ------- > 1: 6e2bfd3a6eb test-tool: help verifying BUG() code paths
 4: 89539a1af3d = 2: 91ddc7ed5ce run-command: use BUG() to report bugs, not die()
 5: 42584f2f7c9 ! 3: 2133197fdc9 Replace all die("BUG: ...") calls by BUG() ones
     @@ -1199,6 +1199,214 @@
       	extra_refname = find_descendant_ref(dirname.buf, extras, skip);
       	if (extra_refname)
      
     +diff --git a/refs/files-backend.c b/refs/files-backend.c
     +--- a/refs/files-backend.c
     ++++ b/refs/files-backend.c
     +@@
     + 	if (refs->store_flags & REF_STORE_MAIN)
     + 		return;
     + 
     +-	die("BUG: operation %s only allowed for main ref store", caller);
     ++	BUG("operation %s only allowed for main ref store", caller);
     + }
     + 
     + /*
     +@@
     + 	struct files_ref_store *refs;
     + 
     + 	if (ref_store->be != &refs_be_files)
     +-		die("BUG: ref_store is type \"%s\" not \"files\" in %s",
     ++		BUG("ref_store is type \"%s\" not \"files\" in %s",
     + 		    ref_store->be->name, caller);
     + 
     + 	refs = (struct files_ref_store *)ref_store;
     + 
     + 	if ((refs->store_flags & required_flags) != required_flags)
     +-		die("BUG: operation %s requires abilities 0x%x, but only have 0x%x",
     ++		BUG("operation %s requires abilities 0x%x, but only have 0x%x",
     + 		    caller, required_flags, refs->store_flags);
     + 
     + 	return refs;
     +@@
     + 		strbuf_addf(sb, "%s/logs/%s", refs->gitcommondir, refname);
     + 		break;
     + 	default:
     +-		die("BUG: unknown ref type %d of ref %s",
     ++		BUG("unknown ref type %d of ref %s",
     + 		    ref_type(refname), refname);
     + 	}
     + }
     +@@
     + 		strbuf_addf(sb, "%s/%s", refs->gitcommondir, refname);
     + 		break;
     + 	default:
     +-		die("BUG: unknown ref type %d of ref %s",
     ++		BUG("unknown ref type %d of ref %s",
     + 		    ref_type(refname), refname);
     + 	}
     + }
     +@@
     + 
     + 	}
     + 	if (!ret && sb.len)
     +-		die("BUG: reverse reflog parser had leftover data");
     ++		BUG("reverse reflog parser had leftover data");
     + 
     + 	fclose(logfp);
     + 	strbuf_release(&sb);
     +@@
     + static int files_reflog_iterator_peel(struct ref_iterator *ref_iterator,
     + 				   struct object_id *peeled)
     + {
     +-	die("BUG: ref_iterator_peel() called for reflog_iterator");
     ++	BUG("ref_iterator_peel() called for reflog_iterator");
     + }
     + 
     + static int files_reflog_iterator_abort(struct ref_iterator *ref_iterator)
     +@@
     + 	assert(err);
     + 
     + 	if (transaction->state != REF_TRANSACTION_OPEN)
     +-		die("BUG: commit called for transaction that is not open");
     ++		BUG("commit called for transaction that is not open");
     + 
     + 	/* Fail if a refname appears more than once in the transaction: */
     + 	for (i = 0; i < transaction->nr; i++)
     +@@
     + 	 */
     + 	if (refs_for_each_rawref(&refs->base, ref_present,
     + 				 &affected_refnames))
     +-		die("BUG: initial ref transaction called with existing refs");
     ++		BUG("initial ref transaction called with existing refs");
     + 
     + 	packed_transaction = ref_store_transaction_begin(refs->packed_ref_store, err);
     + 	if (!packed_transaction) {
     +@@
     + 
     + 		if ((update->flags & REF_HAVE_OLD) &&
     + 		    !is_null_oid(&update->old_oid))
     +-			die("BUG: initial ref transaction with old_sha1 set");
     ++			BUG("initial ref transaction with old_sha1 set");
     + 		if (refs_verify_refname_available(&refs->base, update->refname,
     + 						  &affected_refnames, NULL,
     + 						  err)) {
     +
     +diff --git a/refs/iterator.c b/refs/iterator.c
     +--- a/refs/iterator.c
     ++++ b/refs/iterator.c
     +@@
     + static int empty_ref_iterator_peel(struct ref_iterator *ref_iterator,
     + 				   struct object_id *peeled)
     + {
     +-	die("BUG: peel called for empty iterator");
     ++	BUG("peel called for empty iterator");
     + }
     + 
     + static int empty_ref_iterator_abort(struct ref_iterator *ref_iterator)
     +@@
     + 		(struct merge_ref_iterator *)ref_iterator;
     + 
     + 	if (!iter->current) {
     +-		die("BUG: peel called before advance for merge iterator");
     ++		BUG("peel called before advance for merge iterator");
     + 	}
     + 	return ref_iterator_peel(*iter->current, peeled);
     + }
     +@@
     + 			 * trimming, report it as a bug:
     + 			 */
     + 			if (strlen(iter->iter0->refname) <= iter->trim)
     +-				die("BUG: attempt to trim too many characters");
     ++				BUG("attempt to trim too many characters");
     + 			iter->base.refname = iter->iter0->refname + iter->trim;
     + 		} else {
     + 			iter->base.refname = iter->iter0->refname;
     +
     +diff --git a/refs/packed-backend.c b/refs/packed-backend.c
     +--- a/refs/packed-backend.c
     ++++ b/refs/packed-backend.c
     +@@
     + 	struct packed_ref_store *refs;
     + 
     + 	if (ref_store->be != &refs_be_packed)
     +-		die("BUG: ref_store is type \"%s\" not \"packed\" in %s",
     ++		BUG("ref_store is type \"%s\" not \"packed\" in %s",
     + 		    ref_store->be->name, caller);
     + 
     + 	refs = (struct packed_ref_store *)ref_store;
     + 
     + 	if ((refs->store_flags & required_flags) != required_flags)
     +-		die("BUG: unallowed operation (%s), requires %x, has %x\n",
     ++		BUG("unallowed operation (%s), requires %x, has %x\n",
     + 		    caller, required_flags, refs->store_flags);
     + 
     + 	return refs;
     +@@
     + 			"packed_refs_unlock");
     + 
     + 	if (!is_lock_file_locked(&refs->lock))
     +-		die("BUG: packed_refs_unlock() called when not locked");
     ++		BUG("packed_refs_unlock() called when not locked");
     + 	rollback_lock_file(&refs->lock);
     + }
     + 
     +@@
     + 	char *packed_refs_path;
     + 
     + 	if (!is_lock_file_locked(&refs->lock))
     +-		die("BUG: write_with_updates() called while unlocked");
     ++		BUG("write_with_updates() called while unlocked");
     + 
     + 	/*
     + 	 * If packed-refs is a symlink, we want to overwrite the
     +@@
     + 			       const char *refname, const char *target,
     + 			       const char *logmsg)
     + {
     +-	die("BUG: packed reference store does not support symrefs");
     ++	BUG("packed reference store does not support symrefs");
     + }
     + 
     + static int packed_rename_ref(struct ref_store *ref_store,
     + 			    const char *oldrefname, const char *newrefname,
     + 			    const char *logmsg)
     + {
     +-	die("BUG: packed reference store does not support renaming references");
     ++	BUG("packed reference store does not support renaming references");
     + }
     + 
     + static int packed_copy_ref(struct ref_store *ref_store,
     + 			   const char *oldrefname, const char *newrefname,
     + 			   const char *logmsg)
     + {
     +-	die("BUG: packed reference store does not support copying references");
     ++	BUG("packed reference store does not support copying references");
     + }
     + 
     + static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
     +@@
     + 			       const char *refname, int force_create,
     + 			       struct strbuf *err)
     + {
     +-	die("BUG: packed reference store does not support reflogs");
     ++	BUG("packed reference store does not support reflogs");
     + }
     + 
     + static int packed_delete_reflog(struct ref_store *ref_store,
     +
     +diff --git a/refs/ref-cache.c b/refs/ref-cache.c
     +--- a/refs/ref-cache.c
     ++++ b/refs/ref-cache.c
     +@@
     + 	dir = &entry->u.subdir;
     + 	if (entry->flag & REF_INCOMPLETE) {
     + 		if (!dir->cache->fill_ref_dir)
     +-			die("BUG: incomplete ref_store without fill_ref_dir function");
     ++			BUG("incomplete ref_store without fill_ref_dir function");
     + 
     + 		dir->cache->fill_ref_dir(dir->cache->ref_store, dir, entry->name);
     + 		entry->flag &= ~REF_INCOMPLETE;
     +
      diff --git a/remote.c b/remote.c
      --- a/remote.c
      +++ b/remote.c
 6: 0e85c7a16e3 ! 4: 57b3a3e9fe3 Convert remaining die*(BUG) messages
     @@ -4,6 +4,12 @@
          
          These were not caught by the previous commit, as they did not match the
          regular expression.
     +    
     +    While at it, remove the localization from one instance: we never want
     +    BUG() messages to be translated, as they target Git developers, not the
     +    end user (hence it would be quite unhelpful to not only burden the
     +    translators, but then even end up with a bug report in a language that
     +    no core Git contributor understands).
          
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
-- 
2.17.0.windows.1.36.gdf4ca5fb72a

