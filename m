From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 18/33] refs: make error messages more consistent
Date: Fri,  6 May 2016 18:13:59 +0200
Message-ID: <b846ae21daff8fbbeb1b8ed9c8dbfb2a8035a81b.1462550456.git.mhagger@alum.mit.edu>
References: <cover.1462550456.git.mhagger@alum.mit.edu>
Cc: Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri May 06 18:15:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiP5-0008Bp-Pk
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:15:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758692AbcEFQO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 12:14:56 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:48400 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758550AbcEFQOy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 12:14:54 -0400
X-AuditID: 12074414-62bff700000008e6-e1-572cc2fdb778
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by  (Symantec Messaging Gateway) with SMTP id 74.12.02278.DF2CC275; Fri,  6 May 2016 12:14:53 -0400 (EDT)
Received: from michael.fritz.box (p508EA663.dip0.t-ipconnect.de [80.142.166.99])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u46GEHV0031758
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 6 May 2016 12:14:51 -0400
X-Mailer: git-send-email 2.8.1
In-Reply-To: <cover.1462550456.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqPv3kE64weqFMhbzN51gtOi60s1k
	0dB7hdni9or5zBbdU94yWvxo6WG2mHnV2oHd4+/7D0weO2fdZfd41ruH0ePiJWWP/Uu3sXks
	eH6f3ePzJrkA9ihum6TEkrLgzPQ8fbsE7oymXXOZC/Y5V3TOuMzSwDjTtIuRg0NCwESiY61w
	FyMXh5DAVkaJB3N2MkE4x5kkpv4EcTg52AR0JRb1NIPZIgIREg2vWhhBmpkFPjNKrOQGCQsL
	OEucefmMEcRmEVCVWHnqDDuIzSsQJXG/8wdYq4SAnMTl6Q/YQGxOAQuJQ73HweJCAuZAN9xg
	n8DIs4CRYRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRroVebmaJXmpK6SZGSHiJ7GA8clLuEKMA
	B6MSD2/GSe1wIdbEsuLK3EOMkhxMSqK83wt0woX4kvJTKjMSizPii0pzUosPMUpwMCuJ8F7Z
	B5TjTUmsrEotyodJSXOwKInzflus7ickkJ5YkpqdmlqQWgSTleHgUJLgbQbGkZBgUWp6akVa
	Zk4JQpqJgxNkOJeUSHFqXkpqUWJpSUY8KPzji4ERAJLiAdrLB9LOW1yQmAsUhWg9xajLcWT/
	vbVMQix5+XmpUuK8cw8CFQmAFGWU5sGtgCWTV4ziQB8L814GqeIBJiK4Sa+AljABLXk/VxNk
	SUkiQkqqgdF8waKn/enh7w389HcGCD2ewMCavlgmfRp/ZXC/zqxeienFJa8u2qvKBm2MZJaf
	bayZEH4savvtHX4yS/lDTLfb1Ex1aI3JKe1LfL0y48StppT7WdfcVs6PuGrioLMp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293807>

* Always start error messages with a lower-case letter.

* Always enclose reference names in single quotes.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c                |  8 ++++----
 refs/files-backend.c  | 32 ++++++++++++++++----------------
 t/t1400-update-ref.sh |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/refs.c b/refs.c
index b18d995..ba14105 100644
--- a/refs.c
+++ b/refs.c
@@ -504,7 +504,7 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 	filename = git_path("%s", pseudoref);
 	fd = hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
 	if (fd < 0) {
-		strbuf_addf(err, "Could not open '%s' for writing: %s",
+		strbuf_addf(err, "could not open '%s' for writing: %s",
 			    filename, strerror(errno));
 		return -1;
 	}
@@ -515,14 +515,14 @@ static int write_pseudoref(const char *pseudoref, const unsigned char *sha1,
 		if (read_ref(pseudoref, actual_old_sha1))
 			die("could not read ref '%s'", pseudoref);
 		if (hashcmp(actual_old_sha1, old_sha1)) {
-			strbuf_addf(err, "Unexpected sha1 when writing %s", pseudoref);
+			strbuf_addf(err, "unexpected sha1 when writing '%s'", pseudoref);
 			rollback_lock_file(&lock);
 			goto done;
 		}
 	}
 
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len) {
-		strbuf_addf(err, "Could not write to '%s'", filename);
+		strbuf_addf(err, "could not write to '%s'", filename);
 		rollback_lock_file(&lock);
 		goto done;
 	}
@@ -792,7 +792,7 @@ int ref_transaction_update(struct ref_transaction *transaction,
 
 	if (new_sha1 && !is_null_sha1(new_sha1) &&
 	    check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		strbuf_addf(err, "refusing to update ref with bad name %s",
+		strbuf_addf(err, "refusing to update ref with bad name '%s'",
 			    refname);
 		return -1;
 	}
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 97377c7..5a597bb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1701,7 +1701,7 @@ static int verify_lock(struct ref_lock *lock,
 			  lock->old_oid.hash, NULL)) {
 		if (old_sha1) {
 			int save_errno = errno;
-			strbuf_addf(err, "can't verify ref %s", lock->ref_name);
+			strbuf_addf(err, "can't verify ref '%s'", lock->ref_name);
 			errno = save_errno;
 			return -1;
 		} else {
@@ -1710,7 +1710,7 @@ static int verify_lock(struct ref_lock *lock,
 		}
 	}
 	if (old_sha1 && hashcmp(lock->old_oid.hash, old_sha1)) {
-		strbuf_addf(err, "ref %s is at %s but expected %s",
+		strbuf_addf(err, "ref '%s' is at %s but expected %s",
 			    lock->ref_name,
 			    sha1_to_hex(lock->old_oid.hash),
 			    sha1_to_hex(old_sha1));
@@ -1790,7 +1790,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		if (last_errno != ENOTDIR ||
 		    !verify_refname_available_dir(orig_refname, extras, skip,
 						  get_loose_refs(&ref_cache), err))
-			strbuf_addf(err, "unable to resolve reference %s: %s",
+			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    orig_refname, strerror(last_errno));
 
 		goto error_return;
@@ -1828,7 +1828,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 		/* fall through */
 	default:
 		last_errno = errno;
-		strbuf_addf(err, "unable to create directory for %s",
+		strbuf_addf(err, "unable to create directory for '%s'",
 			    ref_file.buf);
 		goto error_return;
 	}
@@ -2473,7 +2473,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 	strbuf_git_path(logfile, "logs/%s", refname);
 	if (force_create || should_autocreate_reflog(refname)) {
 		if (safe_create_leading_directories(logfile->buf) < 0) {
-			strbuf_addf(err, "unable to create directory for %s: "
+			strbuf_addf(err, "unable to create directory for '%s': "
 				    "%s", logfile->buf, strerror(errno));
 			return -1;
 		}
@@ -2487,7 +2487,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 
 		if (errno == EISDIR) {
 			if (remove_empty_directories(logfile)) {
-				strbuf_addf(err, "There are still logs under "
+				strbuf_addf(err, "there are still logs under "
 					    "'%s'", logfile->buf);
 				return -1;
 			}
@@ -2495,7 +2495,7 @@ static int log_ref_setup(const char *refname, struct strbuf *logfile, struct str
 		}
 
 		if (logfd < 0) {
-			strbuf_addf(err, "unable to append to %s: %s",
+			strbuf_addf(err, "unable to append to '%s': %s",
 				    logfile->buf, strerror(errno));
 			return -1;
 		}
@@ -2564,13 +2564,13 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
+		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
 			    strerror(errno));
 		close(logfd);
 		return -1;
 	}
 	if (close(logfd)) {
-		strbuf_addf(err, "unable to append to %s: %s", logfile->buf,
+		strbuf_addf(err, "unable to append to '%s': %s", logfile->buf,
 			    strerror(errno));
 		return -1;
 	}
@@ -2611,14 +2611,14 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	o = parse_object(sha1);
 	if (!o) {
 		strbuf_addf(err,
-			    "Trying to write ref %s with nonexistent object %s",
+			    "trying to write ref '%s' with nonexistent object %s",
 			    lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
 		return -1;
 	}
 	if (o->type != OBJ_COMMIT && is_branch(lock->ref_name)) {
 		strbuf_addf(err,
-			    "Trying to write non-commit object %s to branch %s",
+			    "trying to write non-commit object %s to branch '%s'",
 			    sha1_to_hex(sha1), lock->ref_name);
 		unlock_ref(lock);
 		return -1;
@@ -2628,7 +2628,7 @@ static int write_ref_to_lockfile(struct ref_lock *lock,
 	    write_in_full(fd, &term, 1) != 1 ||
 	    close_ref(lock) < 0) {
 		strbuf_addf(err,
-			    "Couldn't write %s", get_lock_file_path(lock->lk));
+			    "couldn't write '%s'", get_lock_file_path(lock->lk));
 		unlock_ref(lock);
 		return -1;
 	}
@@ -2649,7 +2649,7 @@ static int commit_ref_update(struct ref_lock *lock,
 	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
 	     log_ref_write(lock->orig_ref_name, lock->old_oid.hash, sha1, logmsg, flags, err) < 0)) {
 		char *old_msg = strbuf_detach(err, NULL);
-		strbuf_addf(err, "Cannot update the ref '%s': %s",
+		strbuf_addf(err, "cannot update the ref '%s': %s",
 			    lock->ref_name, old_msg);
 		free(old_msg);
 		unlock_ref(lock);
@@ -2684,7 +2684,7 @@ static int commit_ref_update(struct ref_lock *lock,
 		}
 	}
 	if (commit_ref(lock)) {
-		strbuf_addf(err, "Couldn't set %s", lock->ref_name);
+		strbuf_addf(err, "couldn't set '%s'", lock->ref_name);
 		unlock_ref(lock);
 		return -1;
 	}
@@ -3033,7 +3033,7 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
 	for (i = 1; i < n; i++)
 		if (!strcmp(refnames->items[i - 1].string, refnames->items[i].string)) {
 			strbuf_addf(err,
-				    "Multiple updates for ref '%s' not allowed.",
+				    "multiple updates for ref '%s' not allowed.",
 				    refnames->items[i].string);
 			return 1;
 		}
@@ -3137,7 +3137,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
 			 * Close it to free up the file descriptor:
 			 */
 			if (close_ref(update->lock)) {
-				strbuf_addf(err, "Couldn't close %s.lock",
+				strbuf_addf(err, "couldn't close '%s.lock'",
 					    update->refname);
 				goto cleanup;
 			}
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index af1b20d..40b0cce 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -479,7 +479,7 @@ test_expect_success 'stdin fails with duplicate refs' '
 	create $a $m
 	EOF
 	test_must_fail git update-ref --stdin <stdin 2>err &&
-	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin create ref works' '
@@ -880,7 +880,7 @@ test_expect_success 'stdin -z fails option with unknown name' '
 test_expect_success 'stdin -z fails with duplicate refs' '
 	printf $F "create $a" "$m" "create $b" "$m" "create $a" "$m" >stdin &&
 	test_must_fail git update-ref -z --stdin <stdin 2>err &&
-	grep "fatal: Multiple updates for ref '"'"'$a'"'"' not allowed." err
+	grep "fatal: multiple updates for ref '"'"'$a'"'"' not allowed." err
 '
 
 test_expect_success 'stdin -z create ref works' '
-- 
2.8.1
